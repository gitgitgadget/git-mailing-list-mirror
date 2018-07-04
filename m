Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B801F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 15:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeGDPo0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 11:44:26 -0400
Received: from mail.vm.ouaza.com ([212.83.178.2]:55730 "EHLO mail.vm.ouaza.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752573AbeGDPoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 11:44:25 -0400
Received: from x260-buxy.home.ouaza.com (133-218-190-109.isp.overthebox.ovh [109.190.218.133])
        by mail.vm.ouaza.com (Postfix) with ESMTPSA id 8ABDC20081;
        Wed,  4 Jul 2018 17:43:03 +0200 (CEST)
Received: by x260-buxy.home.ouaza.com (Postfix, from userid 1000)
        id B2B4A8A2FF2; Wed,  4 Jul 2018 17:44:23 +0200 (CEST)
From:   =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
To:     git@vger.kernel.org
Cc:     jn.avila@free.fr, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
Subject: [PATCH 1/2] l10n: fr: fix a message seen in git bisect
Date:   Wed,  4 Jul 2018 17:43:56 +0200
Message-Id: <20180704154357.26964-2-hertzog@debian.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704154357.26964-1-hertzog@debian.org>
References: <20180704154357.26964-1-hertzog@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.4 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"cette" can be only be used before a word (like in "cette bouteille" for
"this bottle"), but here "this" refers to the current step and we have
to use "ceci" in French.

Signed-off-by: Raphaël Hertzog <hertzog@debian.org>
---
 po/fr.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index 2bae75360..eb760686a 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -1062,8 +1062,8 @@ msgstr[1] "(à peu près %d étapes)"
 #, c-format
 msgid "Bisecting: %d revision left to test after this %s\n"
 msgid_plural "Bisecting: %d revisions left to test after this %s\n"
-msgstr[0] "Bissection : %d révision à tester après cette %s\n"
-msgstr[1] "Bissection : %d révisions à tester après cette %s\n"
+msgstr[0] "Bissection : %d révision à tester après ceci %s\n"
+msgstr[1] "Bissection : %d révisions à tester après ceci %s\n"
 
 #: blame.c:1756
 msgid "--contents and --reverse do not blend well."
-- 
2.18.0

