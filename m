From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/3] revisions.txt: language improvements
Date: Mon,  4 Apr 2011 17:27:05 +0200
Message-ID: <948c323701bf21e699c3348c777bce6e0442dd8e.1301930700.git.git@drmicha.warpmail.net>
References: <cover.1301649867.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 17:30:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6ljx-0007w7-3f
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 17:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab1DDPat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 11:30:49 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44166 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754823Ab1DDPap (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 11:30:45 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 64C9E20A6A;
	Mon,  4 Apr 2011 11:30:45 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 04 Apr 2011 11:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=0NbswKs9WBkJRS5J3jkKu8qHxi8=; b=ceNOePBXLa+FLpwH+7f1P96pXBTLOe3sa/l2cD9DOIo7zIhWbBK0Uzz1UATsf7jgqWqqDiSC57ZClWVB8d6v8K/SDJG9NXBPJBbkbvmykP6voPUIEYrZKAdjkKHR9auyvBbUj4IfHODsAFHwrr320/no/ysujoCYz70Rknk9NmA=
X-Sasl-enc: SEqOdbE84WndiX/c77ubETZVnX6t1rI9I59u9L4wGfzf 1301931044
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A5B5F40EAF0;
	Mon,  4 Apr 2011 11:30:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <cover.1301649867.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1301930700.git.git@drmicha.warpmail.net>
References: <cover.1301930700.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170821>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
    Diff to v2:
    
     '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
       The full SHA1 object name (40-byte hexadecimal string), or
    -  a substring that is unique within the repository.
    +  a leading substring that is unique within the repository.
       E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
       name the same commit object if there is no other object in
       your repository whose object name starts with dae86e.
    @@ -79,11 +79,11 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
    
     '@\{<n>\}', e.g. '@\{1\}'::
       You can use the '@' construct with an empty ref part to get at a
    -  reflog of the current branch. For example, if you are on
    +  reflog entry of the current branch. For example, if you are on
       branch 'blabla' then '@\{1\}' means the same as 'blabla@\{1\}'.
    
     '@\{-<n>\}', e.g. '@\{-1\}'::
    -  The special construct '@\{-<n>\}' means the <n>th branch checked out
    +  The construct '@\{-<n>\}' means the <n>th branch checked out
       before the current one.
    
     '<refname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::

 Documentation/revisions.txt |   70 +++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 92bc662..b290b61 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -2,20 +2,20 @@ SPECIFYING REVISIONS
 --------------------
 
 A revision parameter '<rev>' typically, but not necessarily, names a
-commit object.  They use what is called an 'extended SHA1'
+commit object.  It uses what is called an 'extended SHA1'
 syntax.  Here are various ways to spell object names.  The
-ones listed near the end of this list are to name trees and
+ones listed near the end of this list name trees and
 blobs contained in a commit.
 
 '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
   The full SHA1 object name (40-byte hexadecimal string), or
-  a substring of such that is unique within the repository.
+  a leading substring that is unique within the repository.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
-  name the same commit object if there are no other object in
+  name the same commit object if there is no other object in
   your repository whose object name starts with dae86e.
 
 '<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
-  An output from `git describe`; i.e. a closest tag, optionally
+  Output from `git describe`; i.e. a closest tag, optionally
   followed by a dash and a number of commits, followed by a dash, a
   'g', and an abbreviated object name.
 
@@ -27,30 +27,30 @@ blobs contained in a commit.
   When ambiguous, a '<name>' is disambiguated by taking the
   first match in the following rules:
 
-  . if '$GIT_DIR/<name>' exists, that is what you mean (this is usually
+  . If '$GIT_DIR/<name>' exists, that is what you mean (this is usually
     useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'
     and 'CHERRY_PICK_HEAD');
 
-  . otherwise, 'refs/<name>' if exists;
+  . otherwise, 'refs/<name>' if it exists;
 
-  . otherwise, 'refs/tags/<refname>' if exists;
+  . otherwise, 'refs/tags/<refname>' if it exists;
 
-  . otherwise, 'refs/heads/<name>' if exists;
+  . otherwise, 'refs/heads/<name>' if it exists;
 
-  . otherwise, 'refs/remotes/<name>' if exists;
+  . otherwise, 'refs/remotes/<name>' if it exists;
 
-  . otherwise, 'refs/remotes/<name>/HEAD' if exists.
+  . otherwise, 'refs/remotes/<name>/HEAD' if it exists.
 +
-'HEAD' names the commit your changes in the working tree is based on.
-'FETCH_HEAD' records the branch you fetched from a remote repository
+'HEAD' names the commit on which you based the changes in the working tree.
+'FETCH_HEAD' records the branch which you fetched from a remote repository
 with your last `git fetch` invocation.
-'ORIG_HEAD' is created by commands that moves your 'HEAD' in a drastic
+'ORIG_HEAD' is created by commands that move your 'HEAD' in a drastic
 way, to record the position of the 'HEAD' before their operation, so that
-you can change the tip of the branch back to the state before you ran
-them easily.
-'MERGE_HEAD' records the commit(s) you are merging into your branch
+you can easily change the tip of the branch back to the state before you ran
+them.
+'MERGE_HEAD' records the commit(s) which you are merging into your branch
 when you run `git merge`.
-'CHERRY_PICK_HEAD' records the commit you are cherry-picking
+'CHERRY_PICK_HEAD' records the commit which you are cherry-picking
 when you run `git cherry-pick`.
 +
 Note that any of the 'refs/*' cases above may come either from
@@ -60,7 +60,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
-  second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
+  second ago\}' or '\{1979-02-26 18:30:00\}') specifies the value
   of the ref at a prior point in time.  This suffix may only be
   used immediately following a ref name and the ref must have an
   existing log ('$GIT_DIR/logs/<ref>'). Note that this looks up the state
@@ -70,7 +70,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 
 '<refname>@\{<n>\}', e.g. 'master@\{1\}'::
   A ref followed by the suffix '@' with an ordinal specification
-  enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
+  enclosed in a brace pair (e.g. '\{1\}', '\{15\}') specifies
   the n-th prior value of that ref.  For example 'master@\{1\}'
   is the immediate prior value of 'master' while 'master@\{5\}'
   is the 5th prior value of 'master'. This suffix may only be used
@@ -79,16 +79,16 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 
 '@\{<n>\}', e.g. '@\{1\}'::
   You can use the '@' construct with an empty ref part to get at a
-  reflog of the current branch. For example, if you are on the
-  branch 'blabla', then '@\{1\}' means the same as 'blabla@\{1\}'.
+  reflog entry of the current branch. For example, if you are on
+  branch 'blabla' then '@\{1\}' means the same as 'blabla@\{1\}'.
 
 '@\{-<n>\}', e.g. '@\{-1\}'::
-  The special construct '@\{-<n>\}' means the <n>th branch checked out
+  The construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
 '<refname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
   The suffix '@\{upstream\}' to a ref (short form '<refname>@\{u\}') refers to
-  the branch the ref is set to build on top of.  Missing ref defaults
+  the branch the ref is set to build on top of.  A missing ref defaults
   to the current branch.
 
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
@@ -102,9 +102,9 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
   A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
-  commit object, following only the first parent.  I.e. '<rev>{tilde}3' is
+  commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
   equivalent to '<rev>{caret}{caret}{caret}' which is equivalent to
-  '<rev>{caret}1{caret}1{caret}1'.  See below for a illustration of
+  '<rev>{caret}1{caret}1{caret}1'.  See below for an illustration of
   the usage of this form.
 
 '<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
@@ -113,7 +113,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   could be a tag, and dereference the tag recursively until an
   object of that type is found or the object cannot be
   dereferenced anymore (in which case, barf).  '<rev>{caret}0'
-  introduced earlier is a short-hand for '<rev>{caret}\{commit\}'.
+  is a short-hand for '<rev>{caret}\{commit\}'.
 
 '<rev>{caret}\{\}', e.g. 'v0.99.8{caret}\{\}'::
   A suffix '{caret}' followed by an empty brace pair
@@ -124,7 +124,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 '<rev>{caret}\{/<text>\}', e.g. 'HEAD^{/fix nasty bug}'::
   A suffix '{caret}' to a revision parameter, followed by a brace
   pair that contains a text led by a slash,
-  is the same as ':/fix nasty bug' syntax below except that
+  is the same as the ':/fix nasty bug' syntax below except that
   it returns the youngest matching commit which is reachable from
   the '<rev>' before '{caret}'.
 
@@ -133,8 +133,8 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
-  '!', you have to repeat that;  the special sequence ':/!',
-  followed by something else than '!' is reserved for now.
+  '!' you have to repeat that;  the special sequence ':/!',
+  followed by something else than '!', is reserved for now.
   The regular expression can match any part of the commit message. To
   match messages starting with a string, one can use e.g. ':/^foo'.
 
@@ -145,19 +145,19 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
   ':path' (with an empty part before the colon)
   is a special case of the syntax described next: content
   recorded in the index at the given path.
-  A path starting with './' or '../' is relative to current working directory.
-  The given path will be converted to be relative to working tree's root directory.
+  A path starting with './' or '../' is relative to the current working directory.
+  The given path will be converted to be relative to the working tree's root directory.
   This is most useful to address a blob or tree from a commit or tree that has
-  the same tree structure with the working tree.
+  the same tree structure as the working tree.
 
 ':<n>:<path>', e.g. ':0:README', ':README'::
   A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path, names a blob object in the
-  index at the given path. Missing stage number (and the colon
+  index at the given path. A missing stage number (and the colon
   that follows it) names a stage 0 entry. During a merge, stage
   1 is the common ancestor, stage 2 is the target branch's version
   (typically the current branch), and stage 3 is the version from
-  the branch being merged.
+  the branch which is being merged.
 
 Here is an illustration, by Jon Loeliger.  Both commit nodes B
 and C are parents of commit node A.  Parent commits are ordered
-- 
1.7.4.2.668.gba03a4
