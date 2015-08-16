From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3] po/README: Update directions for l10n contributors
Date: Sun, 16 Aug 2015 15:56:56 +0800
Message-ID: <30198223977cc51444ce3c3a61833fa9d7619dc7.1439704077.git.worldhello.net@gmail.com>
References: <CANYiYbEKoF6GhezPmR1fGxRqTvZAE4L2xguvvwFEWqWBkOp9tw@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Aug 16 09:58:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQspV-0008Ei-H8
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 09:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbbHPH5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 03:57:48 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36172 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbHPH5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 03:57:47 -0400
Received: by pacum4 with SMTP id um4so1375800pac.3
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B2e9wPe7gRQ2IrxhYphLP5S8SkNMvbLEpKalw0fTZkA=;
        b=rSlKz7vZdpE/KFwY/HK3XK2d2YxTuh23tGF2YuTij9vh0e5krQz7hTNM+GlFvwc20q
         avD4TJ7U6Cty+4i4KOnKVu0YEMB1GVrmr9TcfeQtZ3NDfrT30WTVZ2GNPoXUtsjQiWQC
         FrouPkkAUUqEM+df7dZzEFOeTNlOd5sJv+VscFBqZWPlSqxc/GnlCPpBCp5lDdiWg8K7
         9sSS7m9Xo86BBbJ+Grgbo6tUIcwvJp3fAh5P/EC8pPtv9TI2mM0PX3tRiz6IFN6bK35n
         XUdHhu1UNGw4UJTybwU9nooVZeG2KMRU7I5L/GjUWPFToP3kqe40OOt+xAa5mbaeAFVA
         YDYw==
X-Received: by 10.68.233.228 with SMTP id tz4mr104603456pbc.152.1439711866897;
        Sun, 16 Aug 2015 00:57:46 -0700 (PDT)
Received: from localhost.localdomain (ec2-54-65-199-240.ap-northeast-1.compute.amazonaws.com. [54.65.199.240])
        by smtp.googlemail.com with ESMTPSA id si1sm10696693pbc.72.2015.08.16.00.57.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Aug 2015 00:57:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.34.gfbdeabf.dirty
In-Reply-To: <CANYiYbEKoF6GhezPmR1fGxRqTvZAE4L2xguvvwFEWqWBkOp9tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276015>

From: Philip Oakley <philipoakley@iee.org>

Some Linux distributions (such as Ubuntu) have their own l10n workflows,
and their translations may be different.  Add notes for this case for
l10n translators.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/README | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/po/README b/po/README
index d8c9111..fef4c0f 100644
--- a/po/README
+++ b/po/README
@@ -10,10 +10,26 @@ coordinates our localization effort in the l10 coordinator repository:
 
         https://github.com/git-l10n/git-po/
 
+The two character language translation codes are defined by ISO_639-1, as
+stated in the gettext(1) full manual, appendix A.1, Usual Language Codes.
+
+
+Contributing to an existing translation
+---------------------------------------
 As a contributor for a language XX, you should first check TEAMS file in
 this directory to see whether a dedicated repository for your language XX
 exists. Fork the dedicated repository and start to work if it exists.
 
+Sometime, contributors may find that the translations of their Git
+distributions are quite different with the translations of the
+corresponding version from Git official. This is because some Git
+distributions (such as from Ubuntu, etc.) have their own l10n workflow.
+For this case, wrong translations should be reported and fixed through
+their workflows.
+
+
+Creating a new language translation
+-----------------------------------
 If you are the first contributor for the language XX, please fork this
 repository, prepare and/or update the translated message file po/XX.po
 (described later), and ask the l10n coordinator to pull your work.
@@ -23,6 +39,9 @@ coordinate among yourselves and nominate the team leader for your
 language, so that the l10n coordinator only needs to interact with one
 person per language.
 
+
+Translation Process Flow
+------------------------
 The overall data-flow looks like this:
 
     +-------------------+            +------------------+
-- 
2.5.0.rc2.34.gfbdeabf.dirty
