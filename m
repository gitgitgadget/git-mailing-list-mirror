Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E3C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A4E60F6B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 08:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhG3Icq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 04:32:46 -0400
Received: from smtp31.hk.chengmail.me ([113.10.190.196]:45502 "EHLO
        smtp31.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhG3Icp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 04:32:45 -0400
X-CHENGMAILHOST: 113.10.190.196
X-CHENGMAIL-INSTANCEID: 634c.6103b915.508ba.0
Date:   Fri, 30 Jul 2021 16:32:21 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     git <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>
Subject: Should "git apply"'s option "--3way" imply "--index" in option
        description?
X-Priority: 3
X-GUID: F88B2002-5B73-4A7B-9C69-9DCCC19CEEC8
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <202107301631209389909@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <a9c2851af11011ebb8e40024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bGlrZSB0aGlzOgoKZGlmZiAtLWdpdCBhL2FwcGx5LmMgYi9hcHBseS5jCmluZGV4IDQ0YmMzMWQ2
ZWIuLjBiMzUzYWY5NmMgMTAwNjQ0Ci0tLSBhL2FwcGx5LmMKKysrIGIvYXBwbHkuYwpAQCAtNTAy
NCw3ICs1MDI0LDcgQEAgaW50IGFwcGx5X3BhcnNlX29wdGlvbnMoaW50IGFyZ2MsIGNvbnN0IGNo
YXIgKiphcmd2LArCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBPUFRfQk9PTCgwLCAiYXBwbHkiLCBm
b3JjZV9hcHBseSwKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTl8oImFsc28g
YXBwbHkgdGhlIHBhdGNoICh1c2Ugd2l0aCAtLXN0YXQvLS1zdW1tYXJ5Ly0tY2hlY2spIikpLArC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBPUFRfQk9PTCgnMycsICIzd2F5IiwgJnN0YXRlLT50aHJl
ZXdheSwKLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5fKCAiYXR0ZW1wdCB0
aHJlZS13YXkgbWVyZ2UsIGZhbGwgYmFjayBvbiBub3JtYWwgcGF0Y2ggaWYgdGhhdCBmYWlscyIp
KSwKKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5fKCAiYXR0ZW1wdCB0aHJl
ZS13YXkgbWVyZ2UsIGZhbGwgYmFjayBvbiBub3JtYWwgcGF0Y2ggaWYgdGhhdCBmYWlscyhpbXBs
aWVzIC0taW5kZXgpIikpLArCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBPUFRfRklMRU5BTUUoMCwg
ImJ1aWxkLWZha2UtYW5jZXN0b3IiLCAmc3RhdGUtPmZha2VfYW5jZXN0b3IsCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5fKCJidWlsZCBhIHRlbXBvcmFyeSBpbmRleCBiYXNl
ZCBvbiBlbWJlZGRlZCBpbmRleCBpbmZvcm1hdGlvbiIpKSwKwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgLyogVGhpbmsgdHdpY2UgYmVmb3JlIGFkZGluZyAiLS1udWwiIHN5bm9ueW0gdG8gdGhpcyAq
Lwo=

