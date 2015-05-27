From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] submodule documentation: Reorder introductory paragraphs
Date: Wed, 27 May 2015 12:48:01 -0700
Message-ID: <1432756081-31180-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, philipoakley@iee.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 27 21:48:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxhJG-0003Lb-R2
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbbE0TsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:48:10 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36804 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbE0TsH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:48:07 -0400
Received: by iepj10 with SMTP id j10so21968160iep.3
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H2NEHx4201JtSfwv8tOmWhzmfDRPDAORJ/XA3RypnUA=;
        b=Wxq+8kYUhFXhoNU0t/1eSa2RWLsLAfBJ2RQlakDp8plxrfSMRylfomZ9+rs0V/oZPA
         Lzhs9bxouRBJyG+THfK3LotcHzuwgXVD/LWvKPyUJcO2QT6YLwd/TVZRitj1o73IoSiX
         rR0JXvFGWe/UKAxdUQ15bk88OQ6TA5x/ZLYV55Rpgwf8MvOqVrOZKWLOw8SDpjeXE0Ny
         raZkk5iQvZ0asXKZjQh0fkZCLgM5E/OKZ7pzIHqtznnxkje2UWlnshDcjTKZqoc4Rldf
         MA8ShZgLqYKodv5eGfLdd3aqMyxuCI2mLbZr/Lm8ulOqt8Dxo4m74G6G4IzvuaAiuhhw
         o7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H2NEHx4201JtSfwv8tOmWhzmfDRPDAORJ/XA3RypnUA=;
        b=NDoL1ss/G/Hp80JZG1U7mYfbYsYR7pJ81Bd0/MVw65OJFC5Z3Ex2/dteZjIxgVkib+
         sGZ3B2XGHY/z5wRc+kMzZT0AHNS0K6JxElJIUBS8J7f3QGNt31CkUGAzwOmZu4Wxgdoa
         pwfAiYM/zvbWfxhJhjqTAw7SuVgf28cSfqhck9m1foTyLYb7PR1cdkZ3VGHg/XwYgFwp
         D9LpgqAFgOXJzZhz9Qt0Ri9wEExVTz8bkUYXe9rrFnqASNiVlMM8v7recPqiovI7+kIy
         AnHmB1+QObPcRVkhBux84X0RMvHtaEaCqbFOMpd5jnFuejg4F+G8abnlVSxROwNZR+oA
         Gclw==
X-Gm-Message-State: ALoCoQlb7jLAxXSxz+ev7xM+fZ9Ao07RDBcFO1kD8pE9bXiKAAMD1vxzJVo9orFN0Qssx3SoxCkW
X-Received: by 10.42.83.212 with SMTP id i20mr5428935icl.91.1432756086729;
        Wed, 27 May 2015 12:48:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1d5:6fe9:c696:4b29])
        by mx.google.com with ESMTPSA id fs5sm11369806igb.0.2015.05.27.12.48.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:48:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270073>

It's better to start the man page with a description of what submodules
actually are instead of saying what they are not.

Reorder the paragraphs such that
the first short paragraph introduces the submodule concept,
the second paragraph highlights the usage of the submodule command,
the third paragraph giving background information,
and finally the fourth paragraph discusing alternatives such
as subtrees and remotes, which we don't want to be confused with.

This ordering deepens the knowledge on submodules with each paragraph.
First the basic questions like "How/what" will be answered, while the
underlying concepts will be taught at a later time.

Making sure it is not confused with subtrees and remotes is not really
enhancing knowledge of submodules itself, but rather painting the big
picture of git concepts, so you could also argue to have it as the second
paragraph. Personally I think this may confuse readers, specially
newcomers though.

Additionally to reordering the paragraphs, they have been slightly
reworded.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I think this is the best I can come up with for now.
* It still mentions the remotes as a potential explanation mud-hole, but I feel
  it helps the reader understand submodules a little better.
* We also start with a typical git man page intro (Dropping "This command does ...")

 Documentation/git-submodule.txt | 50 ++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2c25916..2ca1391 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -25,22 +25,17 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Submodules allow foreign repositories to be embedded within
-a dedicated subdirectory of the source tree, always pointed
-at a particular commit.
+Inspects, updates and manages submodules.
 
-They are not to be confused with remotes, which are meant mainly
-for branches of the same project; submodules are meant for
-different projects you would like to make part of your source tree,
-while the history of the two projects still stays completely
-independent and you cannot modify the contents of the submodule
-from within the main project.
-If you want to merge the project histories and want to treat the
-aggregated whole as a single project from then on, you may want to
-add a remote for the other project and use the 'subtree' merge strategy,
-instead of treating the other project as a submodule. Directories
-that come from both projects can be cloned and checked out as a whole
-if you choose to go that route.
+A Submodule allows you to keep another Git repository in a subdirectory
+of your repository. The other repository has its own history, which does not
+interfere with the history of the current repository. This can be used to
+have external dependencies such as third party libraries for example.
+
+When cloning or pulling a repository containing submodules however,
+these will not be checked out by default; the 'init' and 'update'
+subcommands will maintain submodules checked out and at
+appropriate revision in your working tree.
 
 Submodules are composed from a so-called `gitlink` tree entry
 in the main repository that refers to a particular commit object
@@ -51,19 +46,18 @@ describes the default URL the submodule shall be cloned from.
 The logical name can be used for overriding this URL within your
 local repository configuration (see 'submodule init').
 
-This command will manage the tree entries and contents of the
-gitmodules file for you, as well as inspect the status of your
-submodules and update them.
-When adding a new submodule to the tree, the 'add' subcommand
-is to be used.  However, when pulling a tree containing submodules,
-these will not be checked out by default;
-the 'init' and 'update' subcommands will maintain submodules
-checked out and at appropriate revision in your working tree.
-You can briefly inspect the up-to-date status of your submodules
-using the 'status' subcommand and get a detailed overview of the
-difference between the index and checkouts using the 'summary'
-subcommand.
-
+Submodules are not to be confused with remotes, which are other
+repositories of the same project; submodules are meant for
+different projects you would like to make part of your source tree,
+while the history of the two projects still stays completely
+independent and you cannot modify the contents of the submodule
+from within the main project.
+If you want to merge the project histories and want to treat the
+aggregated whole as a single project from then on, you may want to
+add a remote for the other project and use the 'subtree' merge strategy,
+instead of treating the other project as a submodule. Directories
+that come from both projects can be cloned and checked out as a whole
+if you choose to go that route.
 
 COMMANDS
 --------
-- 
2.4.1.345.gab207b6.dirty
