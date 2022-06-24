Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72171C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 05:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiFXFFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFXFFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 01:05:16 -0400
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7BD506D4
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 22:05:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1474256|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.136353-0.000795937-0.862851;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.OBk7o0S_1656047099;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OBk7o0S_1656047099)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 13:05:00 +0800
Date:   Fri, 24 Jun 2022 13:05:00 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: [PATCH] ls-files: update test style
References: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>, 
        <xmqq5ykr1f37.fsf@gitster.g>
X-Priority: 3
X-GUID: A301FACF-5AFD-42F5-AD9C-BE2A59A0A2F9
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022062413010539388025@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cj4iTGkgTGluY2hhbyB2aWEgR2l0R2l0R2FkZ2V0IiA8Z2l0Z2l0Z2FkZ2V0QGdtYWlsLmNvbT4g
d3JpdGVzOgo+Cj4+IGRpZmYgLS1naXQgYS90L1JFQURNRSBiL3QvUkVBRE1FCj4+IGluZGV4IDMw
OWEzMTEzM2M2Li43MDIwNWZiYTQxYiAxMDA2NDQKPj4gLS0tIGEvdC9SRUFETUUKPj4gKysrIGIv
dC9SRUFETUUKPj4gQEAgLTU2MCw2ICs1NjAsMjEgQEAgSGVyZSBhcmUgdGhlICJkbydzOiIKPj7C
oMKgwqDCoCBFdmVuIGNvZGUgdGhhdCBpc24ndCBhIHRlc3QgcGVyIHNlLCBidXQgbWVyZWx5IHNv
bWUgc2V0dXAgY29kZQo+PsKgwqDCoMKgIHNob3VsZCBiZSBpbnNpZGUgYSB0ZXN0IGFzc2VydGlv
bi4KPj7CoAo+PiArIC0gS2VlcCB0ZXN0IHRpdGxlIHRoZSBzYW1lIGxpbmUgd2l0aCB0ZXN0IGhl
bHBlciBmdW5jdGlvbiBpdHNlbGYsCj4+ICvCoMKgIGFuZCBlbmQgdGhlIGxpbmUgd2l0aCBhIHNp
bmdsZSBxdW90ZS4KPj4gKwo+PiArwqDCoCBUYWtlIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgaGVscGVy
IGZvciBleGFtcGxlLCB3cml0ZSBpdCBsaWtlOgo+PiArCj4+ICvCoCB0ZXN0X2V4cGVjdF9zdWNj
ZXNzICd0ZXN0IHRpdGxlIHRvIGRlc2NyaWJlIHRoaXMgdGVzdCBjYXNlJyAnCj4+ICvCoCAjIHRl
c3QgYm9keQo+PiArwqAgJwo+Cj5JZiB5b3Ugd2FudCB0byBzaG93IHRoZSBwcmV0dHkgbGF5b3V0
LCB0aGVuIHRoZSB0ZXN0IGJvZHkgc2hvdWxkCj5iZSBzaG93biBpbmRlbnRlZCwgaS5lLgo+Cj4J
dGVzdF9leHBlY3Rfc3VjY2VzcyAndGl0bGUnICcKPgkuLi4gdGVzdCBib2R5IC4uLgo+CScKT0su
Cj4KPkJ1dCBJIGFtIG5vdCBzdXJlIGlmIHRoaXMgYmVsb25ncyB0byB0aGUgZXhpc3RpbmcgIkRv
J3MgYW5kIGRvbid0cyIKPnNlY3Rpb24sIHdoaWNoIGxpc3RzIHRpcHMgdGhhdCBtYXR0ZXIgZm9y
IGNvcnJlY3RuZXNzLgo+Cj5UaGlzIG5ldyBvbmUgY2VydGFpbmx5IGVuY291cmFnZWQgYXMgYSBt
b3JlIG1vZGVybiBzdHlsZSwgYnV0IGlzIG5vdAo+YWJvdXQgY29ycmVjdG5lc3MgYXQgYWxsLgpP
SywgSSB3aWxsIHJlbW92ZSBpdCBmcm9tICJEbydzIGFuZCBkb24ndHMiIHNlY3Rpb24uCj4KPkEg
c2VwYXJhdGUgInJlY29tbWVuZGVkIHN0eWxlIiBzZWN0aW9uIG1pZ2h0IG1ha2Ugc2Vuc2UsIGJ1
dCB0aGVyZQo+d2lsbCBiZSBhIGxvdCBtb3JlIGVudHJpZXMsIGxpa2Ugd2hlbiB0byBxdW90ZSBh
bmQgbm90IHRvIHF1b3RlIEVPRgo+bWFya2VyIGZvciBoZXJlLWRvY3VtZW50LCBpbmRlbnRpbmcg
dGhlIGJvZHkgb2YgaGVyZS1kb2N1bWVudCwgZXRjLgpZZXMsIGEgInJlY29tbWVuZGVkIHN0eWxl
IiBzZWN0aW9uIG5lZWRlZC4KCg==

