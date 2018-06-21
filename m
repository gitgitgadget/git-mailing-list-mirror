Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC531F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeFUOgH (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:36:07 -0400
Received: from mail.vm.ouaza.com ([212.83.178.2]:55240 "EHLO mail.vm.ouaza.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932892AbeFUOgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:36:07 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2018 10:36:06 EDT
Received: from x260-buxy.home.ouaza.com (133-218-190-109.isp.overthebox.ovh [109.190.218.133])
        by mail.vm.ouaza.com (Postfix) with ESMTPSA id 1828D20DB3;
        Thu, 21 Jun 2018 16:27:12 +0200 (CEST)
Received: by x260-buxy.home.ouaza.com (Postfix, from userid 1000)
        id 0FB998A2BD8; Thu, 21 Jun 2018 16:28:10 +0200 (CEST)
From:   =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
Subject: [PATCH 1/2] l10n: fr: fix a message seen in git bisect
Date:   Thu, 21 Jun 2018 16:27:41 +0200
Message-Id: <20180621142742.28575-2-hertzog@debian.org>
X-Mailer: git-send-email 2.18.0.rc2
In-Reply-To: <20180621142742.28575-1-hertzog@debian.org>
References: <20180621142742.28575-1-hertzog@debian.org>
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
2.18.0.rc2

