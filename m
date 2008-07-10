From: "Ian Katz" <ifreecarve@gmail.com>
Subject: [PATCH] tutorial: prefix the prompts with names alice or bob, to make it clear who is doing what
Date: Thu, 10 Jul 2008 12:12:09 -0400
Message-ID: <dc5b80bf0807100912rac7b730ga1ac035057d71d64@mail.gmail.com>
References: <dc5b80bf0807100652y394e655lfcdd819cc4506afa@mail.gmail.com>
	 <alpine.DEB.1.00.0807101524440.18205@racer>
	 <dc5b80bf0807100729h3e247f68qc48dafc9d0bb154f@mail.gmail.com>
	 <alpine.DEB.1.00.0807101654080.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 18:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyle-00061E-TD
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 18:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYGJQMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 12:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYGJQMM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 12:12:12 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:58617 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYGJQML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 12:12:11 -0400
Received: by py-out-1112.google.com with SMTP id p76so1878791pyb.10
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XASTyEFiMOlV1IVU/2xYAJRSwfMEccJnjUzEj7MXUAM=;
        b=Y8dHEFhaZdNzxdbAjXrTKwdr5zQamMExWZ2BhjZB8nbSZhq+8yXSl/R5uQvzkZUHBM
         M65cnJ9HBE4ZqR8U3A1u8hP4aoU4Umi3f0EnyzD3XhL+TUQQSeZwHnxl2+N8SgS41u0c
         Y0+g4V069PpOsedTjuh8NCbUS9uYSPaXH5d90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZpsE8fa/OEbGEyFjUcUEGXAPFLoTGOT42tQOIviAiWvCu3UdpoP42a+3HckawtuzZU
         G+PB+AptUnM45BqW01VUg28ZpK7icxvV/jAvwmz82Bq98e+zVNbXGMoKKtgfJc8SF7e6
         eEkUS1E4H3dWiNPa8FY767HvOY5oaDencNkw4=
Received: by 10.140.140.3 with SMTP id n3mr4843619rvd.299.1215706329736;
        Thu, 10 Jul 2008 09:12:09 -0700 (PDT)
Received: by 10.141.78.12 with HTTP; Thu, 10 Jul 2008 09:12:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807101654080.18205@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87989>

---
 Documentation/gittutorial.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index e71b561..e4248b6 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -274,7 +274,7 @@ same machine, wants to contribute.
 Bob begins with:

 ------------------------------------------------
-$ git clone /home/alice/project myrepo
+bob$ git clone /home/alice/project myrepo
 ------------------------------------------------

 This creates a new directory "myrepo" containing a clone of Alice's
@@ -285,7 +285,7 @@ Bob then makes some changes and commits them:

 ------------------------------------------------
 (edit files)
-$ git commit -a
+bob$ git commit -a
 (repeat as necessary)
 ------------------------------------------------

@@ -293,8 +293,8 @@ When he's ready, he tells Alice to pull changes from the rep
ository
 at /home/bob/myrepo.  She does this with:

 ------------------------------------------------
-$ cd /home/alice/project
-$ git pull /home/bob/myrepo master
+alice$ cd /home/alice/project
+alice$ git pull /home/bob/myrepo master
 ------------------------------------------------

 This merges the changes from Bob's "master" branch into Alice's
@@ -312,7 +312,7 @@ again.  By defining 'remote' repository shorthand, you can m
ake
 it easier:

 ------------------------------------------------
-$ git remote add bob /home/bob/myrepo
+alice$ git remote add bob /home/bob/myrepo
 ------------------------------------------------

 With this, Alice can perform the first operation alone using the
@@ -320,7 +320,7 @@ With this, Alice can perform the first operation alone using
 the
 using:

 -------------------------------------
-$ git fetch bob
+alice$ git fetch bob
 -------------------------------------

 Unlike the longhand form, when Alice fetches from Bob using a
@@ -329,7 +329,7 @@ fetched is stored in a remote tracking branch, in this case
 `bob/master`.  So after this:

 -------------------------------------
-$ git log -p master..bob/master
+alice$ git log -p master..bob/master
 -------------------------------------

 shows a list of all the changes that Bob made since he branched from
@@ -339,14 +339,14 @@ After examining those changes, Alice
 could merge the changes into her master branch:

 -------------------------------------
-$ git merge bob/master
+alice$ git merge bob/master
 -------------------------------------

 This `merge` can also be done by 'pulling from her own remote
 tracking branch', like this:

 -------------------------------------
-$ git pull . remotes/bob/master
+alice$ git pull . remotes/bob/master
 -------------------------------------

 Note that git pull always merges into the current branch,
@@ -355,7 +355,7 @@ regardless of what else is given on the command line.
 Later, Bob can update his repo with Alice's latest changes using

 -------------------------------------
-$ git pull
+bob$ git pull
 -------------------------------------

 Note that he doesn't need to give the path to Alice's repository;
@@ -364,7 +364,7 @@ repository in the repository configuration, and that locatio
n is
 used for pulls:

 -------------------------------------
-$ git config --get remote.origin.url
+bob$ git config --get remote.origin.url
 /home/alice/project
 -------------------------------------

@@ -376,7 +376,7 @@ Git also keeps a pristine copy of Alice's master branch unde
r the
 name "origin/master":

 -------------------------------------
-$ git branch -r
+bob$ git branch -r
  origin/master
 -------------------------------------

@@ -384,7 +384,7 @@ If Bob later decides to work from a different host, he can s
till
 perform clones and pulls using the ssh protocol:

 -------------------------------------
-$ git clone alice.org:/home/alice/project myrepo
+bob$ git clone alice.org:/home/alice/project myrepo
 -------------------------------------

 Alternatively, git has a native protocol, or can use rsync or http;
--
1.5.3.7
