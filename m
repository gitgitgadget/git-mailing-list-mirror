Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AAFC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 04:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiFXE6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiFXE6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 00:58:34 -0400
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BFC6D
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 21:58:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07266819|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0778228-0.000760131-0.921417;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.OBk52Qm_1656046679;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OBk52Qm_1656046679)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 12:58:00 +0800
Date:   Fri, 24 Jun 2022 12:57:59 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: [PATCH] ls-files: update test style
References: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>, 
        <220623.86wnd7k5un.gmgdl@evledraar.gmail.com>
X-Priority: 3
X-GUID: A32094DF-6D58-4D2F-8032-A199FB0E919F
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022062412565939884621@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pgo+T24gVGh1LCBKdW4gMjMgMjAyMiwgTGkgTGluY2hhbyB2aWEgR2l0R2l0R2FkZ2V0IHdyb3Rl
Ogo+Cj4+IEZyb206IExpIExpbmNoYW8gPGxpbGluY2hhb0Bvc2NoaW5hLmNuPgo+Pgo+PiBVcGRh
dGUgdGVzdCBzdHlsZSBpbiB0L3QzMFsqXS5zaCBmb3IgdW5pZm9ybWl0eSwgdGhhdCdzIHRvCj4+
IGtlZXAgdGVzdCB0aXRsZSB0aGUgc2FtZSBsaW5lIHdpdGggaGVscGVyIGZ1bmN0aW9uIGl0c2Vs
Zi4KPgo+V2UgaGF2ZSBhIGZldyBvZiB0aGVzZSBzb3J0cyBvZiBvbGQgc3R5bGUgdGVzdHMsIGFu
ZCBpdCdzIGdvb2QgdG8gdXBkYXRlCj50aGVtLiAKWWVzLiBDdXJyZW50bHkgdGhlcmUgYXJlIGF0
IGxlYXN0IDQwMCsgb2xkIHN0eWxlIHRlc3RzIDopLiBJdCBub3QgZWFzeSBmb3IgbWUKdG8gZml4
IHRoZW0gYWxsIGF0IG9uY2Ugd2l0aCBzb21lIG1hZ2ljIHJlZ2V4IGV4cHJlc3Npb25zLCBzbyBJ
J20gbm90IGdvaW5nCnRvIHVwZGF0ZSB0aGVtIGFsbCBpbiBvbmUgcGF0Y2guIEJ1dCBJIHRoaW5r
LCBmaXJzdCBvZiBhbGwsIHdlIGNhbiBleHBsaWNpdGx5CmRvY3VtZW50wqB3aGljaCB0ZXN0IHN0
eWxlIHdlIHByZWZlciBmaXJzdC4KPgo+PsKgwqDCoMKgIFdyaXRlIHRlc3QgY29kZSBsaWtlIHRo
aXM6Cj4+IGRpZmYgLS1naXQgYS90L3QzMDAxLWxzLWZpbGVzLW90aGVycy1leGNsdWRlLnNoIGIv
dC90MzAwMS1scy1maWxlcy1vdGhlcnMtZXhjbHVkZS5zaAo+PiBpbmRleCA0OGNlYzRlNWY4OC4u
NzYzNjFiOTIzMzYgMTAwNzU1Cj4+IC0tLSBhL3QvdDMwMDEtbHMtZmlsZXMtb3RoZXJzLWV4Y2x1
ZGUuc2gKPj4gKysrIGIvdC90MzAwMS1scy1maWxlcy1vdGhlcnMtZXhjbHVkZS5zaAo+PiBAQCAt
NjcsMjYgKzY3LDI2IEBAIGVjaG8gJyEqLjIKPj7CoAo+PsKgIGFsbGlnbm9yZXM9Jy5naXRpZ25v
cmUgb25lLy5naXRpZ25vcmUgb25lL3R3by8uZ2l0aWdub3JlJwo+PsKgCj4+IC10ZXN0X2V4cGVj
dF9zdWNjZXNzIFwKPj4gLcKgwqDCoCAnZ2l0IGxzLWZpbGVzIC0tb3RoZXJzIHdpdGggdmFyaW91
cyBleGNsdWRlIG9wdGlvbnMuJyBcCj4+IC3CoMKgwqAgJ2dpdCBscy1maWxlcyAtLW90aGVycyBc
Cj4+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgbHMtZmlsZXMgLS1vdGhlcnMgd2l0aCB2YXJp
b3VzIGV4Y2x1ZGUgb3B0aW9ucy4nICcKPj4gKwlnaXQgbHMtZmlsZXMgLS1vdGhlcnMgXAo+PsKg
wqDCoMKgwqDCoMKgwqAgLS1leGNsdWRlPVwqLjYgXAo+PsKgwqDCoMKgwqDCoMKgwqAgLS1leGNs
dWRlLXBlci1kaXJlY3Rvcnk9LmdpdGlnbm9yZSBcCj4+wqDCoMKgwqDCoMKgwqDCoCAtLWV4Y2x1
ZGUtZnJvbT0uZ2l0L2lnbm9yZSBcCj4+wqDCoMKgwqDCoMKgwqDCoCA+b3V0cHV0ICYmCj4KPlRo
aXMgdGhvdWdoIHJlYWxseSBzdG9wcyB0b28gc2hvcnQsIGhlcmUgd2UgZW5kIHVwIHdpdGg6Cj4K
Pgk8VEFCPmdpdC1scy1maWxlcyAtLW90aGVycyBcCj4JPDcgc3BhY2VzPi0tZXhjbHVkZSBbLi4u
XQo+IApPSy4KPj4gLcKgwqDCoMKgIHRlc3RfY21wIGV4cGVjdCBvdXRwdXQnCj4+ICvCoMKgwqDC
oCB0ZXN0X2NtcCBleHBlY3Qgb3V0cHV0Cj4KPkFuZCB5b3UndmUgc3BhY2UtaW5kZW50ZWQgdGhp
cyB0ZXN0X2NtcCwgcHJlc3VtYWJseSB0aGUgYmVsb3cgaGFzIHRoZQo+c2FtZSBpc3N1ZXMgKEkg
ZGlkbid0IGNoZWNrIGluIGRldGFpbCkgCj4KPkluc3RlYWQgdGhlIGFyZ3VtZW50IGxpc3RzIHNo
b3VsZCBiZSA8VEFCPjxUQUI+IGluZGVudGVkLCBhbmQgdGhlIHJlc3QKPnNob3VsZCBiZSBUQUIg
aW5kZW50ZWQuIApPSy4KPgo+PiArJwo+PsKgCj4+wqAgIyBUZXN0IFxyXG4gKE1TRE9TLWxpa2Ug
c3lzdGVtcykKPj7CoCBwcmludGYgJyouMVxyXG4vKi4zXHJcbiEqLjZcclxuJyA+LmdpdGlnbm9y
ZQo+PsKgCj4+IC10ZXN0X2V4cGVjdF9zdWNjZXNzIFwKPj4gLcKgwqDCoCAnZ2l0IGxzLWZpbGVz
IC0tb3RoZXJzIHdpdGggXHJcbiBsaW5lIGVuZGluZ3MuJyBcCj4+IC3CoMKgwqAgJ2dpdCBscy1m
aWxlcyAtLW90aGVycyBcCj4+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgbHMtZmlsZXMgLS1v
dGhlcnMgd2l0aCBcclxuIGxpbmUgZW5kaW5ncy4nICcKPj4gKwlnaXQgbHMtZmlsZXMgLS1vdGhl
cnMgXAo+PsKgwqDCoMKgwqDCoMKgwqAgLS1leGNsdWRlPVwqLjYgXAo+PsKgwqDCoMKgwqDCoMKg
wqAgLS1leGNsdWRlLXBlci1kaXJlY3Rvcnk9LmdpdGlnbm9yZSBcCj4+wqDCoMKgwqDCoMKgwqDC
oCAtLWV4Y2x1ZGUtZnJvbT0uZ2l0L2lnbm9yZSBcCj4+wqDCoMKgwqDCoMKgwqDCoCA+b3V0cHV0
ICYmCj4+IC3CoMKgwqDCoCB0ZXN0X2NtcCBleHBlY3Qgb3V0cHV0Jwo+PiArwqDCoMKgwqAgdGVz
dF9jbXAgZXhwZWN0IG91dHB1dAo+PiArJwo+Cj5Bc2lkZSBmcm9tIHRoZSBhYm92ZSBJIHRoaW5r
IGl0J3MgYWxzbyB3b3J0aCBpbmNvcnBvcmF0aW5nIGFsbCB0aGUKPiJwcmludGYiLCAiZWNobyIs
ICJjYXQiIGV0Yy4gdGhhdCB3ZSBkbyBpbnRvIHRoZSAidGVzdF9leHBlY3Rfc3VjY2VzcyIKPnRo
ZW1zZWx2ZXMsIGFuZCBpZiB0aGV5J3JlIG5lZWRlZCBieSBtb3JlIHRoYW4gb25lIHRlc3QgcGVy
aGFwcyBtYWtlCj50aGVtIGEgInNldHVwIiBoZWxwZXIgZnVuY3Rpb24gKHdoaWNoIHdvdWxkIHRl
c3Rfd2hlbl9maW5pc2hlZCAicm0gLWYKPi5naXRpZ25vcmUiIGNsZWFuIHVwIGFmdGVyIGl0c2Vs
ZikuIApZZXMsIG1ha2Ugc2Vuc2UuCj4KPlRoYXQncyBvYnZpb3VzbHkgYmlnZ2VyIHRoYW4gc29t
ZSB3aGl0ZXNwYWNlIGNoYW5nZXMsIHNvIHdlIGNvdWxkIHB1bnQKPm9uIGl0IGZvciBub3csIGJ1
dCBhcyB3ZSdyZSBsb29raW5nIGF0IHRoaXMgYW55d2F5IHdlIGNvdWxkIGNvbnZlcnQKPmZ1bGx5
IHRvIGEgbW9yZSBtb2Rlcm4gc3R5bGUgaW4gYSBmb2xsb3ctdXAgY29tbWl0Li4uCj4KPj4gLXRl
c3RfZXhwZWN0X3N1Y2Nlc3MgXAo+PiAtwqDCoMKgICdnaXQgbHMtZmlsZXMgd2l0aCBwYXRoIHJl
c3RyaWN0aW9uIHdpdGggLS0uJyBcCj4+IC3CoMKgwqAgJ2dpdCBscy1maWxlcyAtLW90aGVycyAt
LSBwYXRoMCA+b3V0cHV0ICYmCj4+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgbHMtZmlsZXMg
d2l0aCBwYXRoIHJlc3RyaWN0aW9uIHdpdGggLS0uJyAnCj4+ICvCoMKgwqAgZ2l0IGxzLWZpbGVz
IC0tb3RoZXJzIC0tIHBhdGgwID5vdXRwdXQgJiYKPj7CoCB0ZXN0X2NtcCBvdXRwdXQgLSA8PEVP
Rgo+PsKgIHBhdGgwCj4+wqAgRU9GCj4+wqAgJwo+Cj5PbiB0aGUgdG9waWMgb2YgbGVhdmluZyB0
aGluZ3Mgb24gdGhlIHRhYmxlOiBoZXJlIHdlIGNvdWxkIHVzZSAiPDwtRU9GIgo+KG9yIGFjdHVh
bGx5IGJldHRlciAiPDwtXEVPRiIpIGluc3RlYWQsIGFuZCBpbmRlbnQgdGhlIGhlcmUtZG9jLCBh
cyB3ZQo+dXN1YWxseSBkby4gCk9LLCB3aWxsIGRvLgo=

