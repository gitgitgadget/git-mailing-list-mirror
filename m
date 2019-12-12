Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3397CC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CFB2173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfLLUrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:47:08 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:57425 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730784AbfLLUrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 15:47:08 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 01F692003F2;
        Thu, 12 Dec 2019 21:47:05 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 1/3] doc: reword -B option of diff into something sensible
Date:   Thu, 12 Dec 2019 21:46:53 +0100
Message-Id: <20191212204655.10425-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sentence seemed to miss a verb.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-options.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 09faee3b44..350d0a2fb0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -452,14 +452,14 @@ endif::git-format-patch[]
 	create. This serves two purposes:
 +
 It affects the way a change that amounts to a total rewrite of a file
-not as a series of deletion and insertion mixed together with a very
-few lines that happen to match textually as the context, but as a
-single deletion of everything old followed by a single insertion of
-everything new, and the number `m` controls this aspect of the -B
-option (defaults to 60%). `-B/70%` specifies that less than 30% of the
-original should remain in the result for Git to consider it a total
-rewrite (i.e. otherwise the resulting patch will be a series of
-deletion and insertion mixed together with context lines).
+does not appear as a series of deletion and insertion mixed together
+with a very few lines that happen to match textually as the context,
+but as a single deletion of everything old followed by a single
+insertion of everything new, and the number `m` controls this aspect
+of the -B option (defaults to 60%). `-B/70%` specifies that less than
+30% of the original should remain in the result for Git to consider it
+a total rewrite (i.e. otherwise the resulting patch will be a series
+of deletion and insertion mixed together with context lines).
 +
 When used with -M, a totally-rewritten file is also considered as the
 source of a rename (usually -M only considers a file that disappeared
-- 
2.24.0

