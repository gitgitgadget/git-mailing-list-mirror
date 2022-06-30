Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2EAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 06:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiF3GOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiF3GOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 02:14:17 -0400
Received: from out29-217.mail.aliyun.com (out29-217.mail.aliyun.com [115.124.29.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8963A8
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:14:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3638135|-1;BR=01201311R411S96rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0176319-0.000829185-0.981539;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.OG8DzTy_1656569643;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OG8DzTy_1656569643)
          by smtp.aliyun-inc.com;
          Thu, 30 Jun 2022 14:14:05 +0800
Date:   Thu, 30 Jun 2022 14:14:04 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     git <git@vger.kernel.org>
Subject: let git-ls-files suppress the expanding of all files in sub directory
X-Priority: 3
X-GUID: AEEAB924-831C-417D-8FDE-A832ED3E8F53
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <202206281608475079493@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QXMgc3ViamVjdCBzYWlkLCBpcyB0aGlzIHBvc3NpYmxlIGZvciBnaXQtbHMtZmlsZXMgdG8gd29y
ayBsaWtlIHRoaXM/OgoiICQgZ2l0IGxzLWZpbGVzIC0tbm8tcmVjdXJzaW9uCsKgIMKgIGEudHh0
CsKgIMKgIGIudHh0CsKgIMKgIGRpci8KIgppbnN0ZWFkIG9mOgoiICQgZ2l0IGxzLWZpbGVzwqAK
wqAgwqAgYS50eHQKwqAgwqAgYi50eHQKwqAgwqAgZGlyL29uZS90d28vMS50eHQKwqAgwqAgZGly
L29uZS90d28vMi50eHQKwqAgwqAgZGlyL29uZS8zLnR4dArCoCDCoCBkaXIvNC50eHQKIgoKRG9l
cyBpdCBtYWtlIHNlbnNlPw==

