Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B5C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 10:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiCBKqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiCBKqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 05:46:36 -0500
Received: from out29-75.mail.aliyun.com (out29-75.mail.aliyun.com [115.124.29.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ABDB54E4
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 02:45:52 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07593075|-1;BR=01201311R211S07rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.011968-0.000812171-0.98722;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.MyOt0MY_1646217949;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.MyOt0MY_1646217949)
          by smtp.aliyun-inc.com(33.37.75.176);
          Wed, 02 Mar 2022 18:45:50 +0800
Date:   Wed, 2 Mar 2022 18:45:50 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Derrick Stolee" <stolee@gmail.com>, git <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>
Subject: [BUG] fetch/pull -h ABORT out of a git repo
X-Priority: 3
X-GUID: 20399C3F-182B-4FD2-AC58-13BA133B4D83
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022030218445028804916@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCgpXaGVuIEkgcnVuIGdpdCBmZXRjaCAtaCBvciBnaXQgcHVsbCAtaCBvdXQgc2lkZSBvZiBh
IGdpdCByZXBvLCBJIGNhbid0IGdldCBhbnkgaGVscCBtZXNzYWdlCmJ1dCBzb21lIGJ1ZyBtZXNz
YWdlczoKCiIkIGdpdCBwdWxsIC1oIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgCkJVRzogcmVwby1zZXR0aW5ncy5j
OjIxOiBDYW5ub3QgYWRkIHNldHRpbmdzIGZvciB1bmluaXRpYWxpemVkIHJlcG9zaXRvcnkKWzFd
IMKgIMKgMTc1ODkgYWJvcnQgwqAgwqAgwqBnaXQgcHVsbCAtaAoKJCBnaXQgcHVsbCAtaApCVUc6
IHJlcG8tc2V0dGluZ3MuYzoyMTogQ2Fubm90IGFkZCBzZXR0aW5ncyBmb3IgdW5pbml0aWFsaXpl
ZCByZXBvc2l0b3J5ClsxXSDCoCDCoDE3NzM3IGFib3J0IMKgIMKgIMKgZ2l0IHB1bGwgLWgKIgoK
QXBwYXJlbnRseSwgdGhlIHByb2Nlc3MgYWJvcnRlZCB1bmV4cGVjdGVkbHkuwqBJIHRoaW5rIHRo
aXMgaXMgYSBCVUcuCgpUaGlzIHdhcyBpbnRyb2R1Y2VkIGFmdGVyIHYyLjM0LjEsIHRoZSByZWxh
dGVkIGNvbW1pdHMgYXJlOgoKNWE0ZTA1NDdlMjM4NmY5YmYwNTY1MzE2ZDdiNzUxZmU5NDU5ODk4
Ygo0NGM3ZTYyZTUxZTUwNGMwNjA4NDQzNjBmYzU2YjYxM2NmYzFiZWVhCgoKLS0tLS0tLS0tLS0t
LS0KbGlsaW5jaGFvQG9zY2hpbmEuY24=

