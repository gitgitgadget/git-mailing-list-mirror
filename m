Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C521F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 03:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfJIDwK (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 23:52:10 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:51908 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbfJIDwK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 23:52:10 -0400
Received: by ajax-webmail-APP-10 (Coremail) ; Wed, 9 Oct 2019 11:51:52 +0800
 (GMT+08:00)
X-Originating-IP: [106.120.127.15]
Date:   Wed, 9 Oct 2019 11:51:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     "junio c hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, cuifang@sugon.com
Subject: Re: Re: How to find the commit that erase a change
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.9a build 20190604(696d1518)
 Copyright (c) 2002-2019 www.mailtech.cn cnic.cn
In-Reply-To: <xmqqmuealiy3.fsf@gitster-ct.c.googlers.com>
References: <5e12e2d8.1ed16.16dae58d6ac.Coremail.wuzhouhui14@mails.ucas.ac.cn>
 <xmqqmuealiy3.fsf@gitster-ct.c.googlers.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6cfb13f7.1fa14.16daea502c2.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: tACowADHz59ZWZ1dwDcDAA--.31221W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiCwASAVz4isM9EQ
        ACsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiSnVuaW8gQyBIYW1hbm8iIDxn
aXRzdGVyQHBvYm94LmNvbT4KPiBTZW50IFRpbWU6IDIwMTktMTAtMDkgMTE6MDI6NDQgKFdlZG5l
c2RheSkKPiBUbzogd3V6aG91aHVpIDx3dXpob3VodWkxNEBtYWlscy51Y2FzLmFjLmNuPgo+IENj
OiBnaXRAdmdlci5rZXJuZWwub3JnLCBjdWlmYW5nQHN1Z29uLmNvbQo+IFN1YmplY3Q6IFJlOiBI
b3cgdG8gZmluZCB0aGUgY29tbWl0IHRoYXQgZXJhc2UgYSBjaGFuZ2UKPiAKPiB3dXpob3VodWkg
PHd1emhvdWh1aTE0QG1haWxzLnVjYXMuYWMuY24+IHdyaXRlczoKPiAKPiA+IEkgaGF2ZSBhIGZp
bGUgd2hpY2ggY29udGFpbnMgY29tcGxpY2F0ZWQgY2hhbmdlIGhpc3RvcnkuIFdoZW4gSSB1c2UK
PiA+ICAgICBnaXQgbG9nIC1wIGZpbGUKPiA+IHRvIHNlZSBhbGwgY2hhbmdlcyBtYWRlIGluIHRo
aXMgZmlsZSwgSSBmb3VuZCB0aGF0IGEgY2hhbmdlIGRpc2FwcGVhcmVkCj4gPiBmb3Igbm8gcmVh
c29uLgo+IAo+ICJnaXQgbG9nIFstcF0gPHBhdGhzcGVjPiIgaXMgbm90IGFib3V0IHNlZWluZyAq
YWxsKiBjaGFuZ2VzIG1hZGUgdG8KPiB0aGUgcGF0aChzKSB0aGF0IG1hdGNoIHRoZSBwYXRoc3Bl
Yy4gIEVzcGVjaWFsbHkgd2hlbiB5b3VyIGhpc3RvcnkKPiBoYXMgbWVyZ2VzLCB0aGUgY29tbWFu
ZCBpcyB0byBnaXZlIHlvdSBfb25lXyBzaW1wbGVzdCBleHBsYW5hdGlvbiBhcwo+IHRvIGhvdyB0
aGUgY29udGVudHMgb2YgdGhlIHBhdGgocykgY2FtZSB0byBiZSBpbiB0aGUgc2hhcGUgeW91IHNl
ZQo+IGluIEhFQUQuCj4gCj4gU28gZm9yIGV4YW1wbGUsIGlmIHlvdSBoYXZlIGEgaGlzdG9yeSBs
aWtlIHRoaXMgKHRpbWUgZmxvd3MgZnJvbQo+IGxlZnQgdG8gcmlnaHQpOgo+IAo+ICAgICBPLS0t
LS1BLS0tLS1CLS0tLU0tLS0tLU4KPiAgICAgICAgICAgIFwgICAgICAgIC8KPiAgICAgICAgICAg
ICBcICAgICAgLwo+ICAgICAgICAgICAgICBYLS0tLVkKPiAKPiB3aGVyZSBBIG9yIEIgZGlkICpu
b3QqIHRvdWNoICJmaWxlIiwgWCBhZGRlZCBhIGRlZmluaXRpb24gb2YgZnVuYygpCj4gdG8gImZp
bGUiLCBZIHJldmVydGVkIHRoZSBjaGFuZ2UgWCBtYWRlIHRvICJmaWxlIiwgTSBtYWRlIGEgbmF0
dXJhbAo+IG1lcmdlIGJldHdlZW4gQiBhbmQgWSBhbmQgTiBkaWQgbm90IHRvdWNoICJmaWxlIiwg
ImdpdCBsb2cgTiBmaWxlIgo+IHdvdWxkIG5vdCBldmVuIHNob3cgdGhlIGV4aXN0ZW5jZSBvZiBj
b21taXRzIFggb3IgWS4gIEluIHRoZSBsYXJnZXIKPiBwaWN0dXJlLCBhdCBhbmNpZW50IHRpbWUg
TywgdGhlIGZpbGUgc3RhcnRlZCB3aXRob3V0IGZ1bmMoKSwgYW5kCj4gbm9uZSBvZiB0aGUgY29t
bWl0cyBBLCBCLCBNIG9yIE4gZmVsdCB0aGUgbmVlZCB0byBhZGQgaXQgYW5kIGFzIHRoZQo+IHJl
c3VsdCwgTiBkb2VzIG5vdCBuZWVkIHRoZSB1bndhbnRlZCBmdW5jKCkuICBTbyAiZmlsZSdzIGNv
bnRlbnRzCj4gYXJlIHRoZSBzYW1lIHNpbmNlIE8gdGhyb3VnaG91dCB0aGUgaGlzdG9yeSByZWFj
aGluZyBOIiBpcyBnaXZlbiBhcwo+IF9vbmVfIHNpbXBsZXN0IGV4cGxhbmF0aW9uLgo+IAo+IFRo
ZSAiLS1mdWxsLWhpc3RvcnkiIG9wdGlvbiBtYXkgaGVscCwgdGhvdWdoLgoKIi0tZnVsbC1oaXN0
b3J5IiBkb2Vzbid0IHJlc29sdmUgbXkgcHJvYmxlbSwgYnV0CiAgICBnaXQgbG9nIC1wIC1jIGZp
bGUKZG9lcy4gSSBmb3VuZCB0aGF0IG15IGNoYW5nZSB3YXMgZXJhc2VkIGluIGEgbWVyZ2UgY29t
bWl0LgoKVGhhbmtzLg==
