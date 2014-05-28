From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3] wording fixes in the user manual and glossary
Date: Tue, 27 May 2014 19:23:32 -0700
Message-ID: <1401243812-29269-1-git-send-email-jmmahler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Aveling <bena.001@optusnet.com.au>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 04:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpTXp-0006CT-Iq
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 04:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbaE1CYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 22:24:40 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:50472 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbaE1CYj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 22:24:39 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so10272885pbb.21
        for <git@vger.kernel.org>; Tue, 27 May 2014 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GMUbaiMOuQSJd7J4dkUaAvyADbKexqg2SfnYCtkHjrE=;
        b=nRO7zhQ96kJJUseyBw/7KXgTdjMaQ3VruD8By4fl4nonMA+wFwEaImx/iofrML0x3a
         Hpi9dlvefPuoZ9rtbTABnBZA8zGlULBaWWDaXmGOZYy5oIcLVLFp5P9eDT0YeVI6RlOS
         jn05LOqjVrgu+sfwzKKjFAqtTchdxGkoExAlD+PqTS64ixD3tWi39+bkCqb+hcbbF8rV
         M6LCc3lhtNqyrR6725QhB9ria2gIm0s3+kp8MUulpWe1laM41ACImDfYmFCKgtNh1XqY
         j6aF4Qjq2RQEIP7FnRI7tpSZdjrQd9oi1HBPvehazzX5M6PetHfUvvIZ2Gi/lGyIYh93
         eLgA==
X-Received: by 10.69.26.103 with SMTP id ix7mr40617597pbd.41.1401243879456;
        Tue, 27 May 2014 19:24:39 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ei4sm25554566pbb.42.2014.05.27.19.24.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 19:24:38 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 19:24:34 -0700
X-Mailer: git-send-email 2.0.0.rc4.480.g058e066
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250256>

Re-worded the section on "Updating a repository with git fetch" in the
user manual.

Various other minor fixes in the manual and glossary.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---

Notes:
    This revision includes suggestions from Chris Packham, Ben Aveling
    and Junio C Hamano [1].
    
    [1]: http://marc.info/?l=git&m=140122033314094&w=2
    
      - The changes to the "git fetch" section have been reduced.
    
        - Kept the first sentence which Junio liked.
    
        - Kept the second sentence as Chris had it originally except for
          swapping 'command `git fetch` with '`git fetch` command' and
          using 'original repository' instead of 'her repository'.
    	  'original repository' agrees with the sentence before it.
    
     - Other minor edits are the same as the previous version.

 Documentation/glossary-content.txt |  2 +-
 Documentation/user-manual.txt      | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index be0858c..4e0b971 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -1,7 +1,7 @@
 [[def_alternate_object_database]]alternate object database::
 	Via the alternates mechanism, a <<def_repository,repository>>
 	can inherit part of its <<def_object_database,object database>>
-	from another object database, which is called "alternate".
+	from another object database, which is called an "alternate".
 
 [[def_bare_repository]]bare repository::
 	A bare repository is normally an appropriately
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d33f884..7330d88 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -416,12 +416,11 @@ REVISIONS" section of linkgit:gitrevisions[7].
 Updating a repository with git fetch
 ------------------------------------
 
-Eventually the developer cloned from will do additional work in her
-repository, creating new commits and advancing the branches to point
-at the new commits.
+After you clone a repository and commit a few changes of your own, you
+may wish to check the original repository for updates.
 
-The command `git fetch`, with no arguments, will update all of the
-remote-tracking branches to the latest version found in her
+The `git-fetch` command, with no arguments, will update all of the
+remote-tracking branches to the latest version found in the original
 repository.  It will not touch any of your own branches--not even the
 "master" branch that was created for you on clone.
 
@@ -1811,8 +1810,8 @@ manner.
 You can then import these into your mail client and send them by
 hand.  However, if you have a lot to send at once, you may prefer to
 use the linkgit:git-send-email[1] script to automate the process.
-Consult the mailing list for your project first to determine how they
-prefer such patches be handled.
+Consult the mailing list for your project first to determine
+their requirements for submitting patches.
 
 [[importing-patches]]
 Importing patches to a project
@@ -2255,7 +2254,7 @@ $ git checkout test && git merge speed-up-spinlocks
 It is unlikely that you would have any conflicts here ... but you might if you
 spent a while on this step and had also pulled new versions from upstream.
 
-Some time later when enough time has passed and testing done, you can pull the
+Sometime later when enough time has passed and testing done, you can pull the
 same branch into the `release` tree ready to go upstream.  This is where you
 see the value of keeping each patch (or patch series) in its own branch.  It
 means that the patches can be moved into the `release` tree in any order.
-- 
2.0.0.rc4.480.g058e066
