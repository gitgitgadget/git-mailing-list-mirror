Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A98C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 06:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbhLFGr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 01:47:59 -0500
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:41582 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S237710AbhLFGr5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Dec 2021 01:47:57 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwCXwtJksa1hrR+kBg--.8297S2;
        Mon, 06 Dec 2021 14:44:52 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 6 Dec 2021 14:44:22 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 6 Dec 2021 14:44:22 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Elijah Newren" <newren@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqilw2i6w1.fsf@gitster.g>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
 <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
 <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
 <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
 <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
 <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
 <xmqqilw2i6w1.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6fa17536.18b.17d8e7c7a09.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgCXNQBGsa1hwgUAAA--.273W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcICFGCdOSm8AAAsT
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw48JrykKrW8tw4fJFWUJwb_yoW8Xr45pr
        W5XayxKw1kGFs2gFn3C3WxX3yF9a93JF9rJwnrtF13ur90kFy8WrZayFyFk3W7JrnrX3ya
        9w48Zr97JFWFy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGNvbmZ1c2luZyBwb2ludCBzZWVtcyB3aHkgImdpdCBhbSIgc3RvcHMgaW50byB0aGUgbWlk
ZGxlIGFuZCBnaXZlcwpjb250cm9sIGJhY2sgdG8gdGhlIHVzZXIgd2hlbiBwYXNzaW5nICJkaWUi
LiBJbiBjb21tb24gY2FzZXMsICJkaWUiCnNob3VsZCBzdG9wIHRoZSB3aG9sZSBwcm9jZXNzLCBh
bmQgaXMgaXQgYmV0dGVyIHRvIGRpc3Rpbmd1aXNoIHRoZSBjYXNlCndoZW4gcGFzc2luZyAiZGll
IiBmcm9tIHRoZSBkZWZhdWx0IGJlaGF2aW91cj8gTGlrZSB3aGF0IHRoZSBmb2xsb3dpbmcKc25p
cHBldCBpcyBpbXBsZW1lbnRlZDoKCiAgICBjYXNlIEVSUl9FTVBUWV9DT01NSVQ6CiAgICAgICAg
cHJpbnRmX2xuKF8oIlBhdGNoIGlzIGVtcHR5LlxuIgogICAgICAgICAgICAgICAgICAgICJJZiB5
b3Ugd2FudCB0byByZWNvcmQgaXQgYXMgYW4gZW1wdHkgY29tbWl0LCBydW4gXCJnaXQgYW0gLS1h
bGxvdy1lbXB0eVwiLiIpKTsKCWRpZV91c2VyX3Jlc29sdmUoc3RhdGUpOwogICAgY2FzZSBESUVf
RU1QVFlfQ09NTUlUOgogICAgICAgIGFtX2Rlc3Ryb3koc3RhdGUpOwogICAgICAgIGRpZShfKCJQ
YXRjaCBpcyBlbXB0eS4iKSk7CiAgICAgICAgYnJlYWs7CgoKPiA+IERlYXJzIEhhbWFubywKPiA+
Cj4gPiAgICAgSW4gbXkgb3BpbmlvbiwgdGhlICctLWVtcHR5JyBzaG91bGQgYWN0IGFzIGEgc3Ry
YXRlZ3kgb3B0aW9uIGxpa2UgdGhlCj4gPiAgICAgJ1gnIG9wdGlvbiB0byAnZ2l0LXJlYmFzZScu
IFNpbmNlIHRoYXQgdGhlIGRlZmF1bHQgYmVoYXZpb3VyIG9mIG5vdCBwYXNzaW5nCj4gPiAgICAg
dGhlIG9wdGlvbiBpcyBzdG9wcGVkIGluIHRoZSBtaWRkbGUgb2YgYW4gYW0gc2Vzc2lvbiwgc2hv
dWxkIHRoZSAnZGllJyB2YWx1ZQo+ID4gICAgIGRpZXMgdGhlIHdob2xlIHByb2Nlc3MgYnV0IG5v
dCB0aGUgbWlkZGxlIHN0YXRlPyBJdCBtYXkgYWxzbyBtYWtlIGl0IG5vdAo+ID4gICAgIGNvbmZ1
c2luZy4KPiAKPiBIbXBoLCB1bmxpa2UgImdpdCByZWJhc2UiIG9yICJnaXQgbWVyZ2UiLCAiZ2l0
IGFtIiBkb2VzIG5vdCBlbXBsb3kKPiBkaWZmZXJlbnQgc3RyYXRlZ3kgYmFja2VuZHMsIHNvICIt
WDxvcHRpb24+IiB3b3VsZCBiZSBvdXQgb2YgcGxhY2UsCj4gSSB3b3VsZCB0aGluay4KPiAKPiBB
bW9uZyB3aGF0IHdlIGFscmVhZHkgaGF2ZSwgd2hhdCBraWxscyB0aGUgZW50aXJlIHNlc3Npb24g
aXMgY2FsbGVkCj4gImdpdCBhbSAtLWFib3J0Ii4gIFNpbmNlIEkgZG8gbm90IGZpbmQgaXQgdW5u
YXR1cmFsIHRvIHNheSAiJ2dpdCBhbScKPiBkaWVzIiB3aGVuIGl0IHN0b3BzIGFuZCBnaXZlcyBj
b250cm9sIGJhY2sgdG8gdGhlIHVzZXIsIHNvIHRoYXQgdGhlCj4gdXNlciBjYW4gZGVjaWRlIHdo
YXQgdG8gZG8gbmV4dCwgSSBhbSBub3Qgc3VyZSB3aGVyZSB0aGUgYXZlcnNpb24gdG8KPiB0aGUg
d29yZCBjb21lcyBmcm9tIChvbiB0aGUgb3RoZXIgaGFuZCwgSSBmaW5kICdhc2snIGhpZ2hseQo+
IHVubmF0dXJhbCBzaW5jZSB3ZSBkbyBub3QgYXNrIGFueXRoaW5nLS0td2UganVzdCB0aHJvdyB0
aGUgY29udHJvbAo+IGJhY2sgdGhlIHVzZXIpLg==

