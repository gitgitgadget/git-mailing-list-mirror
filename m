From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 7/7] git-clean: update document for interactive git-clean
Date: Tue,  7 May 2013 03:18:56 +0800
Message-ID: <b35aa5d0de820e5e13da32d23a70a82d3df83521.1367867498.git.worldhello.net@gmail.com>
References: <cover.1367867498.git.worldhello.net@gmail.com>
 <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
 <6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
 <c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
 <217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
 <c81cef0983760c76c2a6b92c1fcc2c49a80a8747.1367867498.git.worldhello.net@gmail.com>
 <5353bf3a49c83ca27ad4be221b1b4856d119f8c1.1367867498.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 21:19:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwx-0002PF-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab3EFTTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:43 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:64825 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab3EFTTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:43 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so2175865pab.21
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=/io1MH4JBrazhFYKzG4LNUpC1tSt/KKKtkbXfYf/N/Y=;
        b=Z6WBNbTsxPBLKWEqQvZKD10O4RORk9rTwGxcpmQfvCPxa/LdAO/QLILin04O26vHel
         P72PSh5xYDS+p4Q3A/tGkXC5ORgcQsvXta8bojpTUeDKXP9/+YtzNW7v1ER40LPHOnJ8
         gXdF+nvMSWzoWtH+Io589qq4oozDmh7csyVkaCdii7EtXWQgv0U+b2JYc/lJQWNPbljK
         Tk6bWW9mMF07SM8KLw7GvOq4cadYwT3diAZCrfa+H8UNy7LfkOUsGV9kjYMXGBdZwd38
         azc8grP+DVBdoYd/A6zXibr/r+xcCd5N7iumASDYAN8xLKgE0tyWzUQm+MqhApXHEI6w
         Ckaw==
X-Received: by 10.68.107.164 with SMTP id hd4mr9055561pbb.161.1367867982550;
        Mon, 06 May 2013 12:19:42 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id z8sm24951256pbt.23.2013.05.06.12.19.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 12:19:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.338.gb35aa5d
In-Reply-To: <5353bf3a49c83ca27ad4be221b1b4856d119f8c1.1367867498.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367867498.git.worldhello.net@gmail.com>
References: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com> <cover.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223498>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/git-clean.txt | 70 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index f5572..56d60 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -39,13 +39,8 @@ OPTIONS
 
 -i::
 --interactive::
-	Show what would be done and the user must confirm before actually
-	cleaning. In the confirmation dialog, the user can choose to abort
-	the cleaning, or enter into an edit mode. In the edit mode, the
-	user can input space-separated patterns (the same syntax as
-	gitignore), and each clean candidate that matches with one of the
-	patterns will be excluded from cleaning. When the user feels it's
-	OK, presses ENTER and back to the confirmation dialog.
+	Show what would be done and clean files interactively. See
+	``Interactive mode`` for details.
 
 -n::
 --dry-run::
@@ -74,6 +69,67 @@ OPTIONS
 	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+Interactive mode
+----------------
+When the command enters the interactive mode, it shows the
+files and directories to be cleaned, and goes into its
+interactive command loop.
+
+The command loop shows the list of subcommands available, and
+gives a prompt "What now> ".  In general, when the prompt ends
+with a single '>', you can pick only one of the choices given
+and type return, like this:
+
+------------
+    *** Commands ***
+      1: clean             2: edit by patterns   3: edit by numbers
+      4. rm -i             5. quit               6. help
+    What now> 2
+------------
+
+You also could say `c` or `clean` above as long as the choice is unique.
+
+The main command loop has 6 subcommands.
+
+clean::
+
+   Start cleaning files and directories, and then quit.
+
+edit by patterns::
+
+   This shows the files and directories to be deleted and issues an
+   "Input ignore patterns>>" prompt. You can input a space-seperated
+   patterns to exclude files and directories from deletion.
+   E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
+   deletion. When you are satisfied with the filtered result, press
+   ENTER (empty) back to the main menu.
+
+edit by numbers::
+
+   This shows the files and directories to be deleted and issues an
+   "Select items to delete>>" prompt. When the prompt ends with double
+   '>>' like this, you can make more than one selection, concatenated
+   with whitespace or comma.  Also you can say ranges.  E.g. "2-5 7,9"
+   to choose 2,3,4,5,7,9 from the list.  If the second number in a
+   range is omitted, all remaining patches are taken.  E.g. "7-" to
+   choose 7,8,9 from the list.  You can say '*' to choose everything.
+   Also when you are satisfied with the filtered result, press ENTER
+   (empty) back to the main menu.
+
+rm -i::
+
+  This will show a "rm -i" style cleaning, that you must confirm one
+  by one in order to delete items. This action is not as efficient
+  as the above two actions.
+
+quit::
+
+  This lets you quit without do cleaning.
+
+help::
+
+  Show brief usage of interactive git-clean.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
-- 
1.8.3.rc1.338.gb35aa5d
