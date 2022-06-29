Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49685CCA47C
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 07:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiF2HMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiF2HMY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 03:12:24 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E2EDFE0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 00:12:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07576645|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0910211-0.00384816-0.905131;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.OFJiLNq_1656486732;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OFJiLNq_1656486732)
          by smtp.aliyun-inc.com;
          Wed, 29 Jun 2022 15:12:13 +0800
Date:   Wed, 29 Jun 2022 15:12:13 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Re: [PATCH v3] ls-files: update test style
References: <pull.1269.v2.git.1656407664694.gitgitgadget@gmail.com>, 
        <pull.1269.v3.git.1656409884091.gitgitgadget@gmail.com>, 
        <xmqqzghwim3m.fsf@gitster.g>
X-Priority: 3
X-GUID: 6F3ED98C-35B8-4458-A364-A86F7E6E7F11
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022062915111229306214@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cj4iTGkgTGluY2hhbyB2aWEgR2l0R2l0R2FkZ2V0IiA8Z2l0Z2l0Z2FkZ2V0QGdtYWlsLmNvbT4g
d3JpdGVzOgo+Cj4+IGRpZmYgLS1naXQgYS90L1JFQURNRSBiL3QvUkVBRE1FCj4+IGluZGV4IDMw
OWEzMTEzM2M2Li41ZTA1Mzk0MTJiNCAxMDA2NDQKPj4gLS0tIGEvdC9SRUFETUUKPj4gKysrIGIv
dC9SRUFETUUKPj4gQEAgLTU0Nyw2ICs1NDcsNTIgQEAgVGhpcyB0ZXN0IGhhcm5lc3MgbGlicmFy
eSBkb2VzIHRoZSBmb2xsb3dpbmcgdGhpbmdzOgo+PsKgwqDCoMKgIGNvbnNpc3RlbnRseSB3aGVu
IGNvbW1hbmQgbGluZSBhcmd1bWVudHMgLS12ZXJib3NlIChvciAtdiksCj4+wqDCoMKgwqAgLS1k
ZWJ1ZyAob3IgLWQpLCBhbmQgLS1pbW1lZGlhdGUgKG9yIC1pKSBpcyBnaXZlbi4KPj7CoAo+PiAr
UmVjb21tZW5kZWQgc3R5bGUKPj4gKy0tLS0tLS0tLS0tLS0tLS0tCj4+ICtIZXJlIGFyZSBzb21l
IHJlY29tbWVudGVkIHN0eWxlcyB3aGVuIHdyaXRpbmcgdGVzdCBjYXNlLgo+PiArCj4+ICsgLSBL
ZWVwIHRlc3QgdGl0bGUgdGhlIHNhbWUgbGluZSB3aXRoIHRlc3QgaGVscGVyIGZ1bmN0aW9uIGl0
c2VsZi4KPj4gKwo+PiArwqDCoCBUYWtlIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgaGVscGVyIGZvciBl
eGFtcGxlLCB3cml0ZSBpdCBsaWtlOgo+PiArCj4+ICvCoCB0ZXN0X2V4cGVjdF9zdWNjZXNzICd0
ZXN0IHRpdGxlJyAnCj4+ICvCoCAuLi4gdGVzdCBib2R5IC4uLgo+PiArwqAgJwo+Cj5JbmRlbnQg
dGhlIGJvZHkgZnVydGhlciB0byB0aGUgcmlnaHQ/Cj4KPj4gKyAtIEluZGVudCB0aGUgYm9keSBv
ZiBoZXJlLWRvY3VtZW50LCBhbmQgdXNlICI8PCAtIiBpbnN0ZWFkIG9mICI8PCIgdG8gc3RyaXAg
cHJlZml4IFRBQjoKPgo+T3Zlcmx5IGxvbmcgbGluZS4KPgo+RGlkIHlvdSBtZWFuIHRvIGhhdmUg
YSBzcGFjZSBiZXR3ZWVuICI8PCIgYW5kICItIj8gCk9wcywgSSdsbCBmaXggaXQuIFRoaXMgY2Ft
ZSBmcm9tIGFuIGV4dGVuc2lvbiBpbiBWUyBjb2RlIHdoaWNoIGlzIHRvIHByZXZpZXcgQXNjaWlE
b2MsCml0IG1pc3Rha2VubHkgcmVuZGVyICI8PC0iIGludG8gIjzihpAiLCBzbyBJIHB1dCBhIHNw
YWNlIGJldHdlZW4gIjw8IiBhbmQgIi0iLgo+Cj4icHJlZml4IFRBQiIgLT4gImxlYWRpbmcgVEFC
cyB1c2VkIGZvciBpbmRlbnRhdGlvbiIgKHBsdXJhbCBpcyB0aGUKPmltcG9ydGFudCBwYXJ0KT/C
oCAKPgo+TWVudGlvbiBlbmQgb2YgaGVyZS1kb2N1bWVudCBtYXJrZXIgc2hvdWxkIGJ5IGRlZmF1
bHQgYmUgcXVvdGVkLAo+dW5sZXNzIHRoZSBib2R5IG5lZWRzICR2YXJpYWJsZV9pbnRlcnBvbGF0
aW9uPyAKU29ycnksIEkgZG9uJ3QgZ2V0IGl0LiBJIGRvbid0IHNlZSBtYW55IG9mIGVuZGluZyAi
RU9GIiBhcmUgcXVvdGVkIGluIG91ciB0ZXN0cy4KPgo+PiArwqAgdGVzdF9leHBlY3Rfc3VjY2Vz
cyAndGVzdCBzb21ldGhpbmcnICcKPj4gK8KgwqDCoMKgwqAgY2F0ID5leHBlY3QgPDwtXEVPRiAm
Jgo+PiArwqDCoMKgwqDCoCBvbmUKPj4gK8KgwqDCoMKgwqAgdHdvCj4+ICvCoMKgwqDCoMKgIHRo
cmVlCj4+ICvCoMKgwqDCoMKgIEVPRgo+PiArwqDCoMKgwqDCoCB0ZXN0X3NvbWV0aGluZyA+IGFj
dHVhbCAmJgo+PiArwqDCoMKgwqDCoCB0ZXN0X2NtcCBleHBlY3QgYWN0dWFsCj4+ICvCoCAnCj4+
ICsKPj4gK8KgwqAgSW5zdGVhZCBvZjoKPj4gKwo+PiArwqAgdGVzdF9leHBlY3Rfc3VjY2VzcyAn
dGVzdCBzb21ldGhpbmcnICcKPj4gK8KgwqDCoMKgwqAgY2F0ID5leHBlY3QgPDxcRU9GICYmCj4+
ICvCoCBvbmUKPj4gK8KgIHR3bwo+PiArwqAgdGhyZWUKPj4gK8KgIEVPRgo+PiArwqDCoMKgwqDC
oCB0ZXN0X3NvbWV0aGluZyA+IGFjdHVhbCAmJgo+PiArwqDCoMKgwqDCoCB0ZXN0X2NtcCBleHBl
Y3QgYWN0dWFsCj4+ICvCoCAnCj4KPgo+VGhhbmtzLg==

