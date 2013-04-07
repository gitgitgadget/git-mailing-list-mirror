From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v2 1/3] glossary: remove outdated/misleading/irrelevant
 entries
Date: Sun, 7 Apr 2013 17:09:37 +0200 (CEST)
Message-ID: <2094586774.1719611.1365347377194.JavaMail.ngmail@webmail09.arcor-online.net>
References: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 17:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrDz-0003m9-UC
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933902Ab3DGPJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:09:39 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:50392 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933858Ab3DGPJi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 11:09:38 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id 3FB7AA9CE5;
	Sun,  7 Apr 2013 17:09:37 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 303F971947D;
	Sun,  7 Apr 2013 17:09:37 +0200 (CEST)
Received: from webmail09.arcor-online.net (webmail09.arcor-online.net [151.189.8.45])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 2CE0959FC2;
	Sun,  7 Apr 2013 17:09:37 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 2CE0959FC2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1365347377; bh=3+G1ppXDmopV7PT77uEcbnVif9iWGJJKwgn88p1UF70=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=k30NqglOF5kFwN7faKbHJAq2imBqwvKtHd29Pc7i80xTkJKU7JEaN2KPjO0o4hUCI
	 DTIIlFY6RcDExAe8KkSp08UYZAqC+epuQB4mxInohKauGuF2qWu7cpFbCSp+qsXaBq
	 ya+NAy5Cd8zySmkFyTeLNQYov+gIeFhOTVKiJark=
Received: from [188.98.233.28] by webmail09.arcor-online.net (151.189.8.45) with HTTP (Arcor Webmail); Sun, 7 Apr 2013 17:09:37 +0200 (CEST)
In-Reply-To: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.233.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220313>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index eb7ba84..5a7a486 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -104,9 +104,6 @@ to point at the new commit.
 	an arbitrary <<def_commit,commit>> that isn't necessarily the tip of any
 	particular branch.  In this case HEAD is said to be "detached".
 
-[[def_dircache]]dircache::
-	You are *waaaaay* behind. See <<def_index,index>>.
-
 [[def_directory]]directory::
 	The list you get with "ls" :-)
 
@@ -115,11 +112,6 @@ to point at the new commit.
 	it contains modifications which have not been <<def_commit,committed>> to the current
 	<<def_branch,branch>>.
 
-[[def_ent]]ent::
-	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geeks. See
-	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
-	explanation. Avoid this term, not to confuse people.
-
 [[def_evil_merge]]evil merge::
 	An evil merge is a <<def_merge,merge>> that introduces changes that
 	do not appear in any <<def_parent,parent>>.
@@ -257,8 +249,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	<<def_object,object>>.
 
 [[def_octopus]]octopus::
-	To <<def_merge,merge>> more than two <<def_branch,branches>>. Also denotes an
-	intelligent predator.
+	To <<def_merge,merge>> more than two <<def_branch,branches>>.
 
 [[def_origin]]origin::
 	The default upstream <<def_repository,repository>>. Most projects have
-- 
1.8.1.msysgit.1


---
Thomas
