Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63389C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA2061164
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhEGG7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 02:59:08 -0400
Received: from smtp33.hk.chengmail.me ([210.209.93.249]:53159 "EHLO
        smtp33.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhEGG7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 02:59:01 -0400
X-Greylist: delayed 1221 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 02:59:01 EDT
X-CHENGMAILHOST: 210.209.93.249
X-CHENGMAIL-INSTANCEID: 7c3f.6094e02f.5f9b5.0
Date:   Fri, 7 May 2021 14:37:35 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     lilinchao <lilinchao@oschina.cn>, git <git@vger.kernel.org>
Subject: Re: [PATCH] Fix type in Documentation/RelNotes/2.31.0.txt
References: <93f1d430aefc11ebb63c0024e87935e7@oschina.cn>
X-Priority: 3
X-GUID: 05F43FD8-0B44-4BA6-BFB5-7F3360CBF991
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <202105071434493869547@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <b65f866eaefe11eb93550026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBvbmUuIEkndmUgYWxyZWFkeSBzZW50IGFub3RoZXIg
ZW1haWwuCgotLS0KPkZyb206IExpIExpbmNoYW8gPGxpbGluY2hhb0Bvc2NoaW5hLmNuPgo+Cj5y
ZXBsYWNlICd3aGV5JyB3aXRoIGB3aGVuYAo+Cj5TaWduZWQtb2ZmLWJ5OiBMaSBMaW5jaGFvIDxs
aWxpbmNoYW9Ab3NjaGluYS5jbj4KPi0tLQo+IERvY3VtZW50YXRpb24vUmVsTm90ZXMvMi4zMS4w
LnR4dCB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPgo+ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vUmVsTm90ZXMvMi4zMS4wLnR4dCBiL0Rv
Y3VtZW50YXRpb24vUmVsTm90ZXMvMi4zMS4wLnR4dAo+aW5kZXggY2YwYzdkOGQ0MC4uNjE3ZDIx
MWYzZiAxMDA2NDQKPi0tLSBhL0RvY3VtZW50YXRpb24vUmVsTm90ZXMvMi4zMS4wLnR4dAo+Kysr
IGIvRG9jdW1lbnRhdGlvbi9SZWxOb3Rlcy8yLjMxLjAudHh0Cj5AQCAtNDksNyArNDksNyBAQCBV
SSwgV29ya2Zsb3dzICYgRmVhdHVyZXMKPsKgwqDCoCBAezF9LCBidXQgd2UgZmFpbGVkIHRvIGFu
c3dlciAid2hhdCBjb21taXQgd2VyZSB3ZSBvbj8iLCBpLmUuIEB7MX0KPgo+wqAgKiAiZ2l0IGJ1
bmRsZSIgbGVhcm5zICItLXN0ZGluIiBvcHRpb24gdG8gcmVhZCBpdHMgcmVmcyBmcm9tIHRoZQo+
LcKgwqAgc3RhbmRhcmQgaW5wdXQuwqAgQWxzbywgaXQgbm93IGRvZXMgbm90IGxvc2UgcmVmcyB3
aGV5IHRoZXkgcG9pbnQKPivCoMKgIHN0YW5kYXJkIGlucHV0LsKgIEFsc28sIGl0IG5vdyBkb2Vz
IG5vdCBsb3NlIHJlZnMgd2hlbiB0aGV5IHBvaW50Cj7CoMKgwqAgYXQgdGhlIHNhbWUgb2JqZWN0
Lgo+Cj7CoCAqICJnaXQgbG9nIiBsZWFybmVkIGEgbmV3ICItLWRpZmYtbWVyZ2VzPTxob3c+IiBv
cHRpb24uCj4tLQo+Mi4zMS4xLjQ0Mi5nN2UzOTE5ODk3OAo+

