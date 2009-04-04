From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/7] user-manual: use SHA-1 instead of SHA1 or sha1
Date: Sat,  4 Apr 2009 12:38:27 +0300
Message-ID: <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 11:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2N8-00020I-Ox
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 11:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759175AbZDDJjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 05:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755106AbZDDJjH
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 05:39:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49844 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520AbZDDJix (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 05:38:53 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so1259915fxm.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=whUuW7Zm4rMkGuHu/WpZFd2Y3EGsQMWRahZGWzklgBY=;
        b=rBnv7V3rgd58V/lWC9FocCn2cQLIODSA+rAH1Xn9xLLxkD3VO3Du72EhAiq1jA/9TC
         df+Ca91zjN7s3aLjO4rM7Num90yrT6Vqaud1V2ibnI9oyJUThUl4OF/lzY8Gsu6lcdWu
         yFvDXvOQRR5eVTacu5xKT+8a1uLn43hmIFX/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IxuTn2lbKSv2mMp9G3DlPGYxahX22eRkT5SfC4tQ/e0vteCF47fKGFYHlSKwaOLkii
         z+NY4FY9LHYbXE0o2tQrHn89naAZSoTpl//JTYu3uJjaIPUaEyWHTfEdMGpZRcf/GCaN
         VPPJXLUuNhdcpWbdB2oRlCMdEZl97BNW/MIAc=
Received: by 10.204.59.145 with SMTP id l17mr766572bkh.28.1238837931437;
        Sat, 04 Apr 2009 02:38:51 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 31sm660915fkt.2.2009.04.04.02.38.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 02:38:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
In-Reply-To: <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115578>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   54 ++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 118bbe2..3278aa7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -188,7 +188,7 @@ As you can see, a commit shows who made the latest change, what they
 did, and why.
 
 Every commit has a 40-hexdigit id, sometimes called the 'object name' or the
-`SHA1` id, shown on the first line of the `git show` output.  You can usually
+`SHA-1` id, shown on the first line of the `git show` output.  You can usually
 refer to a commit by a shorter name, such as a tag or a branch name, but this
 longer name can also be useful.  Most importantly, it is a globally unique
 name for this commit: so if you tell somebody else the object name (for
@@ -320,7 +320,7 @@ If you want to create a new branch from this checkout, you may do so
 HEAD is now at 427abfa... Linux v2.6.17
 ------------------------------------------------
 
-The `HEAD` then refers to the `SHA1` of the commit instead of to a branch,
+The `HEAD` then refers to the `SHA-1` of the commit instead of to a branch,
 and `git branch` shows that you are no longer on a branch:
 
 ------------------------------------------------
@@ -739,7 +739,7 @@ $ git log --pretty=oneline origin..mybranch | wc -l
 -------------------------------------------------
 
 Alternatively, you may often see this sort of thing done with the
-lower-level command linkgit:git-rev-list[1], which just lists the 'SHA1s'
+lower-level command linkgit:git-rev-list[1], which just lists the `SHA-1s`
 of all the given commits:
 
 -------------------------------------------------
@@ -2865,8 +2865,8 @@ The Object Database
 We already saw in <<understanding-commits>> that all commits are stored
 under a 40-digit 'object name'.  In fact, all the information needed to
 represent the history of a project is stored in objects with such names.
-In each case the name is calculated by taking the `SHA1` hash of the
-contents of the object.  The `SHA1` hash is a cryptographic hash function.
+In each case the name is calculated by taking the `SHA-1` hash of the
+contents of the object.  The `SHA-1` hash is a cryptographic hash function.
 What that means to us is that it is impossible to find two different
 objects with the same name.  This has a number of advantages; among
 others:
@@ -2877,10 +2877,10 @@ others:
   same content stored in two repositories will always be stored under
   the same name.
 - Git can detect errors when it reads an object, by checking that the
-  object's name is still the `SHA1` hash of its contents.
+  object's name is still the `SHA-1` hash of its contents.
 
 (See <<object-details>> for the details of the object formatting and
-`SHA1` calculation.)
+`SHA-1` calculation.)
 
 There are four different types of objects: 'blob', 'tree', 'commit', and
 'tag'.
@@ -2926,9 +2926,9 @@ committer Junio C Hamano <gitster@pobox.com> 1187591163 -0700
 
 As you can see, a commit is defined by:
 
-- a 'tree': The `SHA1` name of a tree object (as defined below), representing
+- a 'tree': The `SHA-1` name of a tree object (as defined below), representing
   the contents of a directory at a certain point in time.
-- 'parent(s)': The `SHA1` name of some number of commits which represent the
+- 'parent(s)': The `SHA-1` name of some number of commits which represent the
   immediately previous step(s) in the history of the project.  The
   example above has one parent; merge commits may have more than
   one.  A commit with no parents is called a 'root' commit, and
@@ -2977,13 +2977,13 @@ $ git ls-tree fb3a8bdd0ce
 ------------------------------------------------
 
 As you can see, a tree object contains a list of entries, each with a
-mode, object type, `SHA1` name, and name, sorted by name.  It represents
+mode, object type, `SHA-1` name, and name, sorted by name.  It represents
 the contents of a single directory tree.
 
 The object type may be a blob, representing the contents of a file, or
 another tree, representing the contents of a subdirectory.  Since trees
-and blobs, like all other objects, are named by the `SHA1` hash of their
-contents, two trees have the same `SHA1` name if and only if their
+and blobs, like all other objects, are named by the `SHA-1` hash of their
+contents, two trees have the same `SHA-1` name if and only if their
 contents (including, recursively, the contents of all subdirectories)
 are identical.  This allows git to quickly determine the differences
 between two related tree objects, since it can ignore any entries with
@@ -3029,15 +3029,15 @@ currently checked out.
 Trust
 ~~~~~
 
-If you receive the `SHA1` name of a blob from one source, and its contents
+If you receive the `SHA-1` name of a blob from one source, and its contents
 from another (possibly untrusted) source, you can still trust that those
-contents are correct as long as the SHA1 name agrees.  This is because
-the `SHA1` is designed so that it is infeasible to find different contents
+contents are correct as long as the `SHA-1` name agrees.  This is because
+the `SHA-1` is designed so that it is infeasible to find different contents
 that produce the same hash.
 
-Similarly, you need only trust the `SHA1` name of a top-level tree object
+Similarly, you need only trust the `SHA-1` name of a top-level tree object
 to trust the contents of the entire directory that it refers to, and if
-you receive the `SHA1` name of a commit from a trusted source, then you
+you receive the `SHA-1` name of a commit from a trusted source, then you
 can easily verify the entire history of commits reachable through
 parents of that commit, and all of those contents of the trees referred
 to by those commits.
@@ -3049,7 +3049,7 @@ that you trust that commit, and the immutability of the history of
 commits tells others that they can trust the whole history.
 
 In other words, you can easily validate a whole archive by just
-sending out a single email that tells the people the name (`SHA1` hash)
+sending out a single email that tells the people the name (`SHA-1` hash)
 of the top commit, and digitally sign that email using something
 like GPG/PGP.
 
@@ -3090,7 +3090,7 @@ How git stores objects efficiently: pack files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Newly created objects are initially created in a file named after the
-object's `SHA1` hash (stored in '.git/objects').
+object's `SHA-1` hash (stored in '.git/objects').
 
 Unfortunately this system becomes inefficient once a project has a
 lot of objects.  Try this on an old project:
@@ -3297,7 +3297,7 @@ $ git hash-object -w somedirectory/myfile
 ------------------------------------------------
 
 which will create and store a blob object with the contents of
-'somedirectory/myfile', and output the sha1 of that object.  if you're
+'somedirectory/myfile', and output the `SHA-1` of that object.  if you're
 extremely lucky it might be '4b9458b3786228369c63936db65827de3cc06200', in
 which case you've guessed right, and the corruption is fixed!
 
@@ -3359,7 +3359,7 @@ The index
 -----------
 
 The index is a binary file (generally kept in `.git/index'` containing a
-sorted list of path names, each with permissions and the `SHA1` of a blob
+sorted list of path names, each with permissions and the `SHA-1` of a blob
 object; linkgit:git-ls-files[1] can show you the contents of the index:
 
 -------------------------------------------------
@@ -3978,7 +3978,7 @@ $ git ls-files --unmerged
 ------------------------------------------------
 
 Each line of the `git ls-files --unmerged` output begins with
-the blob mode bits, blob `SHA1`, 'stage number', and the
+the blob mode bits, blob `SHA-1`, 'stage number', and the
 filename.  The 'stage number' is git's way to say which tree it
 came from: stage 1 corresponds to '$orig' tree, stage 2 'HEAD'
 tree, and stage3 '$target' tree.
@@ -4045,12 +4045,12 @@ objects).  There are currently four different object types: 'blob',
 Regardless of object type, all objects share the following
 characteristics: they are all deflated with zlib, and have a header
 that not only specifies their type, but also provides size information
-about the data in the object.  It's worth noting that the `SHA1` hash
+about the data in the object.  It's worth noting that the `SHA-1` hash
 that is used to name the object is the hash of the original data
 plus this header, so 'sha1sum file' does not match the object name
 for 'file'.
 (Historical note: in the dawn of the age of git the hash
-was the sha1 of the 'compressed' object.)
+was the `SHA-1` of the 'compressed' object.)
 
 As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
@@ -4206,7 +4206,7 @@ it does.
 Let's skip over the obvious details; the only really interesting part
 here is the call to 'get_sha1()'.  It tries to interpret 'argv[2]' as an
 object name, and if it refers to an object which is present in the current
-repository, it writes the resulting SHA-1 into the variable 'sha1'.
+repository, it writes the resulting `SHA-1` into the variable 'sha1'.
 
 Two things are interesting here:
 
@@ -4216,8 +4216,8 @@ Two things are interesting here:
 
 - the variable 'sha1' in the function signature of 'get_sha1()' is '"unsigned
   char \*"', but is actually expected to be a pointer to '"unsigned
-  char[20]"'.  This variable will contain the 160-bit SHA-1 of the given
-  commit.  Note that whenever a SHA-1 is passed as '"unsigned char \*"', it
+  char[20]"'.  This variable will contain the 160-bit `SHA-1` of the given
+  commit.  Note that whenever a `SHA-1` is passed as '"unsigned char \*"', it
   is the binary representation, as opposed to the ASCII representation in
   hex characters, which is passed as '"char *"'.
 
-- 
1.6.2.2.404.ge96f3
