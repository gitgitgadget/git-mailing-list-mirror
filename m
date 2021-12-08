Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CBAC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 06:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhLHGty (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 01:49:54 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:36013
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229700AbhLHGty (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Dec 2021 01:49:54 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwAHK8vYVLBh+gbRBg--.44525S2;
        Wed, 08 Dec 2021 14:46:48 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Wed, 8 Dec 2021 14:46:18 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Wed, 8 Dec 2021 14:46:18 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "=?UTF-8?Q?=22=22=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29=22_v?=
        =?UTF-8?Q?ia_GitGitGadget=22?=" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Elijah Newren" <newren@gmail.com>, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v18 3/3] am: support --allow-empty to record specific
 empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqmtlb4nvm.fsf@gitster.g>
References: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
 <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
 <4c3077f938435508850727e05ad514035f09bebb.1638939946.git.gitgitgadget@gmail.com>
 <xmqqmtlb4nvm.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <220a9954.252.17d98caf6ad.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgBHIP+6VLBh5QUAAA--.292W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcKCFGCdOTPHgAAsW
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFWfJw4xJFyfAF13GFW5GFg_yoW5AFWfpF
        45Wr9agr4kXF93Crnruw1xKF1ruw1rGr95XF1F934qvF1DWFyxArs5K345Cr47Cr1093ya
        va1YqryktF4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cj4gPiArCWluZGV4X2NoYW5nZWQgPSByZXBvX2luZGV4X2hhc19jaGFuZ2VzKHRoZV9yZXBvc2l0
b3J5LCBOVUxMLCBOVUxMKTsKPiA+ICsJaWYgKGFsbG93X2VtcHR5ICYmCj4gPiArCSAgICAhKCFp
bmRleF9jaGFuZ2VkICYmIGlzX2VtcHR5X29yX21pc3NpbmdfZmlsZShhbV9wYXRoKHN0YXRlLCAi
cGF0Y2giKSkpKQo+ID4gIAkJZGllX3VzZXJfcmVzb2x2ZShzdGF0ZSk7Cj4gCj4gV2h5IGRvIHdl
IG5lZWQgdGhpcz8gIAo+IAo+IEludHVpdGl2ZWx5LCBiZWNhdXNlICItLWFsbG93LVhZWiIgaXMg
IndlIG5vcm1hbGx5IGRpZSB3aGVuIHRoZQo+IGNvbmRpdGlvbiBYWVogaG9sZHMsIGJ1dCB3aXRo
IHRoZSBvcHRpb24sIHdlIGRvIG5vdCBkaWUgaW4gc3VjaCBhCj4gY2FzZSIsIGFueSBuZXcgY29u
ZGl0aW9uIHRoYXQgbGVhZHMgdG8gImRpZSIgdGhhdCBvbmx5IGtpY2tzIGluCj4gd2hlbiAiLS1h
bGxvdy1YWVoiIGlzIGdpdmVuIHNtZWxsIGxpa2UgYSBCVUcuCj4gCj4gVGhlIGNvbmRpdGlvbiBy
ZWFkczoKPiAKPiAgICAgdW5sZXNzIHdlIHNhdyBhbiBlbXB0eSBwYXRjaCAoaS5lLiAicGF0Y2gi
IGZpbGUgaXMgbWlzc2luZyBvcgo+ICAgICBlbXB0eSwgYW5kIGRpZCBub3QgcmVzdWx0IGluIGFu
eSBjaGFuZ2UgdG8gdGhlIGluZGV4KSwgaXQgaXMgYW4KPiAgICAgZXJyb3IgdG8gZ2l2ZSAiLS1h
bGxvdy1lbXB0eSIgdG8gdGhlIGNvbW1hbmQuCj4gCj4gVGhhdCBzb21laG93IGRvZXMgbm90IG1h
a2UgYW55IHNlbnNlIHRvIG1lLiAgV2hldGhlciBmYWlsZWQgcGF0Y2gKPiBhcHBsaWNhdGlvbiBh
bmQgbWFudWFsIHR3ZWFraW5nIHJlc3VsdGVkIGluIHRoZSBzYW1lIHRyZWUgYXMgSEVBRCwKPiBv
ciBhIHRyZWUgZGlmZmVyZW50IGZyb20gSEVBRCwgaWYgdGhlIHVzZXIgd2FudHMgdG8gc2F5ICJJ
IGFsbG93Cj4gR2l0IHRvIGNyZWF0ZSBhbiBlbXB0eSBjb21taXQgYXMgbmVjZXNzYXJ5LCBpbnN0
ZWFkIG9mIHN0b3BwaW5nIiwKPiBzaG91bGRuJ3QgdGhlIHVzZXIgYmUgYWxsb3dlZCB0bz8gIEFm
dGVyIGFsbCwgdGhlIG9wdGlvbiBpcyBub3QKPiAiY3JlYXRlIG5vdGhpbmcgYnV0IGFuIGVtcHR5
IGNvbW1pdCwgaXQgaXMgYW4gZXJyb3IgaWYgdGhlcmUgaXMKPiBzb21ldGhpbmcgdG8gY29tbWl0
LiIgIEl0IG1lcmVseSBhbGxvd3MgY3JlYXRpb24gb2YgYW4gZW1wdHkgb25lLgo+IAo+IFRoaXMg
c2VyaWVzIGhhcyBiZWVuIHRyeWluZyB0byBhZGQgY29kZSB0byBwdW5pc2ggdXNlcnMgd2hvIGdp
dmUKPiAiLS1hbGxvdy1lbXB0eSIgd2hlbiB0aGUgY29tbWFuZCB3b3VsZCBoYXZlIHdvcmtlZCB0
aGUgc2FtZSB3YXkKPiB3aXRob3V0IGl0IGF0IGxlYXN0IHNpbmNlIHRoZSBsYXN0IHJvdW5kLCBh
bmQgSSBhbSBub3Qgc3VyZSB3aGVyZQo+IHRoYXQgd2lzaCB0byBzdG9wIHVzZXJzIGNvbWVzIGZy
b20uICBQbGVhc2UgZXhwbGFpbi4gIEkgYW0gc3RhcnRpbmcKPiB0byB0aGluayBJIG1heSBiZSBt
aXNzaW5nIHNvbWV0aGluZyBhbmQgdGhpcyBleHRyYSByaWdpZGl0eSBtYXkgYmUKPiBoZWxwaW5n
IGEgdXNlciAoYnV0IGFnYWluLCBJIGRvIG5vdCBzZWUgaG93KS4KCklmIHRoZXJlIGlzIG5vIHN1
Y2ggY29kZSB0byBjaGVjaywgdGhlIHVzZXIgY2FuIHVzZSAiLS1hbGxvdy1lbXB0eSIgdG8gZG8g
dGhlIHNhbWUgdGhpbmcKYXMgIi0tY29udGludWUiIG9yICItLXJlc29sdmVkIiBhZnRlciByZXNv
bHZpbmcgY29uZmxpY3RzIGJlY2F1c2UgdGhleSBhbGwgZ28gaW50byBgYW1fcmVzb2x2ZSgpYC4K
SW4gbXkgb3BpbmlvbiwgIi0tYWxsb3ctZW1wdHkiIG9ubHkgbWFrZXMgc2Vuc2UgdG8gYWxsb3cg
dGhlIHVzZXIgdG8gY3JlYXRlIGVtcHR5IGNvbW1pdHMgd2hlbjoKCiAgICAxLiB0aGUgcmVzdWx0
IGlzIGFuIGVtcHR5IGNoYW5nZSAoYCFpbmRleF9jaGFuZ2VkYCkKICAgIDIuIHRoZSBpbnB1dCBp
cyBhbiBlbXB0eSBjaGFuZ2UgKGBpc19lbXB0eV9vcl9taXNzaW5nX2ZpbGUoYW1fcGF0aChzdGF0
ZSwgInBhdGNoIikpYCkKCj4gPiArCWlmICghaW5kZXhfY2hhbmdlZCkgewo+ID4gKwkJaWYgKGFs
bG93X2VtcHR5KSB7Cj4gCj4gVGhlIGluZGV4X2NoYW5nZWQgdmFyaWFibGUgYmVpbmcgZmFsc2Ug
aXMgInRoZSByZXN1bHQgaXMgYW4gZW1wdHkKPiBjaGFuZ2UiLCBhbmQgaXMtZW1wdHktb3ItbWlz
c2luZyBvbiAicGF0Y2giIGZpbGUgaXMgInRoZSBpbnB1dCBpcyBhbgo+IGVtcHR5IGNoYW5nZSIu
ICBJZGVhbGx5IHdlIHdvdWxkIHdhbnQgdG8gY3JlYXRlIGFuIGVtcHR5IGNvbW1pdCBvbmx5Cj4g
d2hlbiBib3RoIGlucHV0IGFuZCByZXN1bHQgYXJlIGVtcHR5LCBidXQgaW4gb3JkZXIgdG8gcHJl
dmVudCBtaXN0YWtlcywKPiB3ZSBtYXkgd2FudCB0byByZWFjdCB0byB0aGUgY2FzZSB3aGVyZSB0
aGUgcmVzdWx0IGlzIGVtcHR5IGJ1dCB0aGUKPiBpbnB1dCBpcyBub3QgZW1wdHkuCj4gCj4gSGVy
ZSBpcyB3aGVyZSB3ZSBjYW4gdXNlIGlzLWVtcHR5LW9yLW1pc3Npbmcgb24gInBhdGNoIiBhbmQg
Z2l2ZSBhCj4gZGlmZmVyZW50IG1lc3NhZ2UgKGkuZS4gImV2ZW4gdGhvdWdoIHRoZSBwYXRjaCBm
aWxlIGlzIG5vdCBlbXB0eSwKPiB0aGUgcmVzdWx0IG9mIHlvdXIgcGF0Y2ggYXBwbGljYXRpb24g
ZGlkIG5vdCBjaGFuZ2UgYW55dGhpbmciKSwgaWYKPiB3ZSB3YW50ZWQgdG8uICBPciB5b3UgY291
bGQgY2hvb3NlIHRvIHJlamVjdCBzdWNoIGFuIGF0dGVtcHQsIHdoaWNoCj4gbWlnaHQgYmUgc2lt
cGxlci4gIEkuZS4KPiAKPiAJCWlmIChhbGxvd19lbXB0eSAmJgo+IAkJICAgIGlzX2VtcHR5X29y
X21pc3NpbmdfZmlsZShhbV9wYXRoKHN0YXRlLCAicGF0Y2giKSkKPiAJCQkiTm8gY2hhbmdlcyAt
IHJlY29yZGVkIGFuIGVtcHR5IGNvbW1pdC4iCj4gCQllbHNlCj4gCQkJLi4uIHRoZSBvcmlnaW5h
bCBlcnJvciBmb3Igbm8gY2hhbmdlcyAuLi4KPiAKPiAKPiBIbW0/CgpCYXNlZCBvbiB0aGUgcHJl
dmlvdXMgY2hlY2tpbmcsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2hlY2sKYGlzX2VtcHR5X29yX21p
c3NpbmdfZmlsZShhbV9wYXRoKHN0YXRlLCAicGF0Y2giKSlgIGhlcmUgYmVjYXVzZSBpdCBpcyBw
ZXJtYW5lbnRseSB0cnVlLgo=

