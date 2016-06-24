Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C23C1FF40
	for <e@80x24.org>; Fri, 24 Jun 2016 05:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbcFXFbm (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 01:31:42 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34106 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcFXFbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 01:31:41 -0400
Received: by mail-pa0-f68.google.com with SMTP id us13so8091066pab.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 22:31:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MeGDm0ddAAC4ehGIONJfMhLNJFyws0BrMwgsfkCOw7c=;
        b=o3hXEb5oxqL9XkCReKeAZaXdCbkW/Atc6Tu6S+8wibod/2zSW8By5BSMRW42IrgIKR
         3oGQCGxJ8e5AG47gQpSa1TvBH7W+G8hx1lbXVC3m7NmQtFuH8qaBgHK/HiV9HEH3cqgO
         Heqfd0FltFZpSyDsu5lJJcT7vdBxU4I33UeOXUHa6kqElf7jwovIb0QmUncJRcxRWmcI
         qWma0BAvj9I4b7qfnj3wytoKTJFUWdKMJk/whh44sW8u6/JFE2rkJWF6vlNxD+OYsFzc
         /nPQ+7SSxRKi8iXjg1pHTxlHOQgorWhQLx2JqjSJgqmicFP3AhF8rvew9wRxqXFffJNG
         i/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MeGDm0ddAAC4ehGIONJfMhLNJFyws0BrMwgsfkCOw7c=;
        b=D5ScvvVP7GUzrd/UcHker6iG13AUK0xnVXfIvBtMhzs5vFPvM/Q/AYM5T9PCfpWn/H
         wLn2nsSRXGE/O/ZJGITTaWT4csfZoVyfRKuy2kmXB59DCMbd45oahD+4cxZ5kxrdTSUQ
         9S7TAkGaX8VC9MMbU7fWmEXxxaXGGtXPMpBhqedg3letXFm6tyxv3dB9aYqXbl5wb4Sw
         9FOedxTdxzhA5qF1CEJ7dIEBH554n7n0h8RWImzQCJJuYIqGe6yX6JjM3J4p53lm6rb7
         cNwfjbt0oUXp7r9luVUZQ0V59uBo0ySccf/DI+nFwvs3cEcMGf0PfywXyxCNsEOKv9Kg
         P5YA==
X-Gm-Message-State: ALyK8tLlR7U3WgfXw2Zdd5/NfBV+d0g1i5lCKTM4VyS4zraSnlGHQY1oKxCFqbFQPjDKDA==
X-Received: by 10.66.42.102 with SMTP id n6mr4392587pal.60.1466746300656;
        Thu, 23 Jun 2016 22:31:40 -0700 (PDT)
Received: from wolverine.localdomain ([2601:681:4100:c710:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id x67sm4068915pff.47.2016.06.23.22.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2016 22:31:39 -0700 (PDT)
From:	Alex Henrie <alexhenrie24@gmail.com>
To:	gitster@pobox.com, diane.gasselin@ensimag.imag.fr,
	Matthieu.Moy@imag.fr, vascomalmeida@sapo.pt, git@vger.kernel.org
Cc:	Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] unpack-trees: fix English grammar in do-this-before-that messages
Date:	Thu, 23 Jun 2016 23:31:35 -0600
Message-Id: <20160624053135.7848-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 unpack-trees.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6bc9512..11c37fb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -62,17 +62,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
-			  "Please commit your changes or stash them before you can switch branches.")
+			  "Please commit your changes or stash them before you switch branches.")
 		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
-			  "Please commit your changes or stash them before you can merge.")
+			  "Please commit your changes or stash them before you merge.")
 		      : _("Your local changes to the following files would be overwritten by merge:\n%%s");
 	else
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by %s:\n%%s"
-			  "Please commit your changes or stash them before you can %s.")
+			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
 		xstrfmt(msg, cmd, cmd);
@@ -83,34 +83,34 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
-			  "Please move or remove them before you can switch branches.")
+			  "Please move or remove them before you switch branches.")
 		      : _("The following untracked working tree files would be removed by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be removed by merge:\n%%s"
-			  "Please move or remove them before you can merge.")
+			  "Please move or remove them before you merge.")
 		      : _("The following untracked working tree files would be removed by merge:\n%%s");
 	else
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
-			  "Please move or remove them before you can %s.")
+			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, cmd, cmd);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
-			  "Please move or remove them before you can switch branches.")
+			  "Please move or remove them before you switch branches.")
 		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
-			  "Please move or remove them before you can merge.")
+			  "Please move or remove them before you merge.")
 		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
 	else
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
-			  "Please move or remove them before you can %s.")
+			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, cmd, cmd);
 
-- 
2.9.0

