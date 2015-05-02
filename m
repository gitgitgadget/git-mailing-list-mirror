From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] standardize usage strings that were missed the first time
Date: Fri,  1 May 2015 21:12:21 -0600
Message-ID: <1430536341-21847-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: gitster@pobox.com, pclouds@gmail.com, artagnon@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 05:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNr9-0001ra-O1
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 05:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbbEBDM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 23:12:28 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35594 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbEBDM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 23:12:28 -0400
Received: by igbyr2 with SMTP id yr2so52012561igb.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wD+17LsAu8MSEWKag7l8bFg3ZeEDAbfEtxzZz7NPfFM=;
        b=yqpnq7n2tUyAstXjCQnTn4QFGey07X2qYhiOZsZVj+ds1PhcOVjZWJ0gNWX3cx7VBY
         Rsyq16VXXwhAGPPFmTM2s9uWj7yLmK0YuZ2EloNs5lX+EPIt9yL5qCQfLZA78reQXwT0
         LRAJdI21BreaAE8ENHV30Lt0ZRDfK8Tm2Dd7sElhzflUfyGbyqMHd6pLzrvRIylTaAfz
         4M+SIAFliwsnv3OfCxv8rgUncEBnlzdl6yMstOIZXmjbXpEnT84M7VTv/8UYaKc5UZKS
         SgW9X7F8tomzG7QNiNxk4NrXM5ALEeYa8h2N/Pr1Rx6AJ/XXeAVeohhzspdjqhihHRNS
         gYxQ==
X-Received: by 10.43.18.194 with SMTP id qh2mr17937654icb.36.1430536347638;
        Fri, 01 May 2015 20:12:27 -0700 (PDT)
Received: from localhost.localdomain (c-98-202-141-117.hsd1.ut.comcast.net. [98.202.141.117])
        by mx.google.com with ESMTPSA id d15sm352353igo.8.2015.05.01.20.12.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 May 2015 20:12:26 -0700 (PDT)
X-Mailer: git-send-email 2.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268213>

This is a follow-up to commit 9c9b4f2f8b7f27f3984e80d053106d5d41cbb03b.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/blame.c | 2 +-
 builtin/log.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 06484c2..0b2f4ed 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -27,7 +27,7 @@
 #include "line-range.h"
 #include "line-log.h"
 
-static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] file");
+static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
 static const char *blame_opt_usage[] = {
 	blame_usage,
diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..4c4e6be 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -38,7 +38,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
-	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
+	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
 	N_("git show [<options>] <object>..."),
 	NULL
 };
-- 
2.3.7
