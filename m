From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 1/4] glossary: remove outdated/misleading/irrelevant
 entries
Date: Mon, 15 Apr 2013 19:46:56 +0200 (CEST)
Message-ID: <1456791522.996464.1366048016249.JavaMail.ngmail@webmail19.arcor-online.net>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 19:47:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnUc-000099-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab3DORq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:46:58 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:44042 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755983Ab3DORq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 13:46:57 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 4C257108518;
	Mon, 15 Apr 2013 19:46:56 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 48359112021;
	Mon, 15 Apr 2013 19:46:56 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 4084019805A;
	Mon, 15 Apr 2013 19:46:56 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 4084019805A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1366048016; bh=3+G1ppXDmopV7PT77uEcbnVif9iWGJJKwgn88p1UF70=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=VVmp3gRJqtGSNkX36JxfAtbXzu6qgPAF/0Zqn0XpjISyTy4WmxKjo/bkp/2RWt2EB
	 WO3YnXwTzLg3+Zfppg35cJ6NUtFkszB+C1ol7/tmuMwpdEXzrYtIC24oZuUakkX0m7
	 F6FUZl0LB9uxaF+SiSSPqNNmXncWZjP48Mct9tsE=
Received: from [188.105.109.185] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Mon, 15 Apr 2013 19:46:56 +0200 (CEST)
In-Reply-To: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.109.185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221269>


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
