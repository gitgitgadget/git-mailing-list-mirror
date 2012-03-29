From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Thu, 29 Mar 2012 16:04:56 -0700
Message-ID: <1333062296-27823-1-git-send-email-haircut@gmail.com>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com>
Cc: Ivan Heffner <iheffner@gmail.com>, Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 01:05:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDOPQ-00018D-0N
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 01:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760198Ab2C2XF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 19:05:26 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39836 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760310Ab2C2XFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 19:05:24 -0400
Received: by qcqw6 with SMTP id w6so31327qcq.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hgDsFM36DZPdabmaCDGHX2PNlFX5vpK48ycsb8PIeg0=;
        b=Lz7YlmGKVFJBX8TxmUyM1DJvRsVyqH+cy8qsrcce1hWygaHTJj5QD5f1dkb0ffagAJ
         hgDQt/0g25LZ+SCElo1U+a+RoI6Kcomwb2Oi3qPMvbWrcXBnR6RJMI5AkX9QrKW0fuuN
         n6MTeGNAOPhA0dFro0iBS5Zv5RS0S/kYw/ttL+hd4uJ/h010Q70ijmtWkVgXkLJ37S58
         VoGvJmjqRZ8GrQGwGGTsTMXXKNCC3D4I8P4jw18dF89i+cw26BjCW0T6ZkbefgX5aHb4
         PCeD7vm9wK5hFL1CXlIwy9rXifRLIQw0B75kPttzesLgagrvmQ6pFzIpeBHQ180GwynA
         A/6Q==
Received: by 10.224.58.205 with SMTP id i13mr2567973qah.97.1333062323605;
        Thu, 29 Mar 2012 16:05:23 -0700 (PDT)
Received: from localhost.localdomain (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id j17sm14949491qaj.9.2012.03.29.16.05.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 16:05:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194303>

Make it clear that, when using a commit template, the message *must* be
changed or the commit will be aborted "due to empty commit message".

Helped-by: Ivan Heffner <iheffner@gmail.com>
Signed-off-by: Adam Monsen <haircut@gmail.com>
---
Incorporate feedback from Ivan Heffner.

Anyone else agree/disagree with this patch? I would like to see the
manpage improved because I found the behavior of "git commit -t"
confusing as documented.

I wrapped the text at 77 characters because that was the longest
line in the file (according to wc -L).

I used ":set noet nosta ts=8 sw=8 tw=77" in Vim.

 Documentation/git-commit.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 5cc84a1..c6df120 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -133,10 +133,12 @@ OPTIONS
 -t <file>::
 --template=<file>::
 	Use the contents of the given file as the initial version
-	of the commit message. The editor is invoked and you can
-	make subsequent changes. If a message is specified using
-	the `-m` or `-F` options, this option has no effect. This
-	overrides the `commit.template` configuration variable.
+	of the commit message. The editor is invoked so you can
+	make subsequent changes. If you make no changes, the message
+	is considered empty and the commit is aborted. If a message
+	is specified using the `-m` or `-F` options, this option has
+	no effect. This overrides the `commit.template`
+	configuration variable.
 
 -s::
 --signoff::
-- 
1.7.5.4
