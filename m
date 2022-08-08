Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A6C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 09:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiHHJhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 05:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHHJht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 05:37:49 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1713CF6
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 02:37:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09274515|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00814504-0.00107657-0.990778;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Ook-q-B_1659951446;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.Ook-q-B_1659951446)
          by smtp.aliyun-inc.com;
          Mon, 08 Aug 2022 17:37:27 +0800
Date:   Mon, 8 Aug 2022 17:37:27 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Cc:     "Jeff King" <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] rev-list: support human-readable output for `--disk-usage`
References: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>, 
        <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>
X-Priority: 3
X-GUID: 0EEC641B-22CD-4A21-AF81-BC92E6E4BA4C
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <202208081735108064497@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PsKgwqDCoMKgwqDCoCBzdGF0aWMgaW50IHNob3dfZGlza191c2FnZTsKPsKgwqDCoMKgIEBAIGJ1
aWx0aW4vcmV2LWxpc3QuYzogc3RhdGljIGludCB0cnlfYml0bWFwX2Rpc2tfdXNhZ2Uoc3RydWN0
IHJldl9pbmZvICpyZXZzLAo+wqDCoMKgwqDCoMKgIGludCBmaWx0ZXJfcHJvdmlkZWRfb2JqZWN0
cykKPsKgwqDCoMKgwqDCoCB7Cj7CoMKgwqDCoMKgwqAgc3RydWN0IGJpdG1hcF9pbmRleCAqYml0
bWFwX2dpdDsKPsKgwqDCoMKgIC0rCXN0cnVjdCBzdHJidWYgYml0bWFwX3NpemVfYnVmID0gU1RS
QlVGX0lOSVQ7Cj7CoMKgwqDCoCArKwlzdHJ1Y3Qgc3RyYnVmIGRpc2tfYnVmID0gU1RSQlVGX0lO
SVQ7Cj7CoMKgwqDCoMKgICsJb2ZmX3Qgc2l6ZV9mcm9tX2JpdG1hcDsKSW4gbmV4dCBpdGVyYXRp
b24sIHdpbGwgbW92ZSB0aGVzZSB0d28gbGluZXMgdG8gbW9yZSBjbG9zZSB0byB0aGVpciBjYWxs
ZXIgcGxhY2UgdG8KYXZvaWQgZWFybHkgcmV0dXJuLgo+wqDCoMKgwqDCoMKgCj7CoMKgwqDCoMKg
wqAgaWYgKCFzaG93X2Rpc2tfdXNhZ2UpCj7CoMKgwqDCoCBAQCBidWlsdGluL3Jldi1saXN0LmM6
IHN0YXRpYyBpbnQgdHJ5X2JpdG1hcF9kaXNrX3VzYWdlKHN0cnVjdCByZXZfaW5mbyAqcmV2cywK
PsKgwqDCoMKgwqAgLQlwcmludGYoIiUiUFJJdU1BWCJcbiIsCj7CoMKgwqDCoMKgIC0JwqDCoMKg
wqDCoMKgICh1aW50bWF4X3QpZ2V0X2Rpc2tfdXNhZ2VfZnJvbV9iaXRtYXAoYml0bWFwX2dpdCwg
cmV2cykpOwo+wqDCoMKgwqDCoCArCXNpemVfZnJvbV9iaXRtYXAgPSBnZXRfZGlza191c2FnZV9m
cm9tX2JpdG1hcChiaXRtYXBfZ2l0LCByZXZzKTsKPsKgwqDCoMKgIC0rCWlmIChodW1hbl9yZWFk
YWJsZSkgewo+wqDCoMKgwqAgLSsJc3RyYnVmX2h1bWFuaXNlX2J5dGVzKCZiaXRtYXBfc2l6ZV9i
dWYsIHNpemVfZnJvbV9iaXRtYXApOwo+wqDCoMKgwqAgLSsJcHJpbnRmKCIlc1xuIiwgYml0bWFw
X3NpemVfYnVmLmJ1Zik7Cj7CoMKgwqDCoCAtKwl9IGVsc2UKPsKgwqDCoMKgIC0rCXByaW50Zigi
JSJQUkl1TUFYIlxuIiwgKHVpbnRtYXhfdClzaXplX2Zyb21fYml0bWFwKTsKPsKgwqDCoMKgIC0r
CXN0cmJ1Zl9yZWxlYXNlKCZiaXRtYXBfc2l6ZV9idWYpOwo+wqDCoMKgwqAgKysJaWYgKGh1bWFu
X3JlYWRhYmxlKQo+wqDCoMKgwqAgKysJc3RyYnVmX2h1bWFuaXNlX2J5dGVzKCZkaXNrX2J1Ziwg
c2l6ZV9mcm9tX2JpdG1hcCk7Cj7CoMKgwqDCoCArKwllbHNlCj7CoMKgwqDCoCArKwlzdHJidWZf
YWRkZigmZGlza19idWYsICIlIlBSSXVNQVgiIiwgKHVpbnRtYXhfdClzaXplX2Zyb21fYml0bWFw
KTsKPsKgwqDCoMKgICsrCXB1dHMoZGlza19idWYuYnVmKTsKPsKgwqDCoMKgICsrCXN0cmJ1Zl9y
ZWxlYXNlKCZkaXNrX2J1Zik7Cj7CoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj7CoMKgwqDCoMKgwqAg
fQoK

