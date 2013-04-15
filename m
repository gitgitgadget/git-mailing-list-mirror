From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 2/4] glossary: improve description of SHA-1 related
 topics
Date: Mon, 15 Apr 2013 19:47:50 +0200 (CEST)
Message-ID: <1848754258.996495.1366048070468.JavaMail.ngmail@webmail19.arcor-online.net>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 19:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnVW-0001Ne-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab3DORrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:47:52 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:52993 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756153Ab3DORrw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 13:47:52 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 91DCB3AE4AA;
	Mon, 15 Apr 2013 19:47:50 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 8152F18F03;
	Mon, 15 Apr 2013 19:47:50 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 7A5C75A753;
	Mon, 15 Apr 2013 19:47:50 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 7A5C75A753
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1366048070; bh=y9MZNLI48iO7+vjgrSAu/hSGQLdcYmk1AjpmDuEUOVc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=VB7M58YfSBQHy8HW2mqszsQj8s5BvHGvaUwwZ8KgTPP7GKIq9ktC+nyKCZgs19T19
	 Uj+Dzy1cMQZE/cRxL+jtzQOBmj5K5ikz+zaBD5OteTDvIbANvq8jx6W9qHA3QypjB0
	 VYX122pf+K+/jieav3IgES/7t+SJ7pakQ6sc9no4=
Received: from [188.105.109.185] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Mon, 15 Apr 2013 19:47:50 +0200 (CEST)
In-Reply-To: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.109.185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221270>


The name of the hash function is "SHA-1", not "SHA1".

Also to people who look up "object name" in the glossary,
the details of which hash function is applied on what to
compute "object name" is not important but the fact that the
name is meant to be an unique identifier for the contents
stored in the object is.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5a7a486..2734947 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -153,7 +153,7 @@ to point at the new commit.
 	created. Configured via the `.git/info/grafts` file.
 
 [[def_hash]]hash::
-	In Git's context, synonym to <<def_object_name,object name>>.
+	In Git's context, synonym for <<def_object_name,object name>>.
 
 [[def_head]]head::
 	A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of a
@@ -225,7 +225,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 
 [[def_object]]object::
 	The unit of storage in Git. It is uniquely identified by the
-	<<def_SHA1,SHA1>> of its contents. Consequently, an
+	<<def_SHA1,SHA-1>> of its contents. Consequently, an
 	object can not be changed.
 
 [[def_object_database]]object database::
@@ -237,10 +237,9 @@ This commit is referred to as a "merge commit", or sometimes just a
 	Synonym for <<def_object_name,object name>>.
 
 [[def_object_name]]object name::
-	The unique identifier of an <<def_object,object>>. The <<def_hash,hash>>
-	of the object's contents using the Secure Hash Algorithm
-	1 and usually represented by the 40 character hexadecimal encoding of
-	the <<def_hash,hash>> of the object.
+	The unique identifier of an <<def_object,object>>.  The
+	object name is usually represented by a 40 character
+	hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>.
 
 [[def_object_type]]object type::
 	One of the identifiers "<<def_commit_object,commit>>",
@@ -376,7 +375,7 @@ should not be combined with other pathspec.
 	to the result.
 
 [[def_ref]]ref::
-	A 40-byte hex representation of a <<def_SHA1,SHA1>> or a name that
+	A 40-byte hex representation of a <<def_SHA1,SHA-1>> or a name that
 	denotes a particular <<def_object,object>>. They may be stored in
 	a file under `$GIT_DIR/refs/` directory, or
 	in the `$GIT_DIR/packed-refs` file.
@@ -432,8 +431,9 @@ should not be combined with other pathspec.
 [[def_SCM]]SCM::
 	Source code management (tool).
 
-[[def_SHA1]]SHA1::
-	Synonym for <<def_object_name,object name>>.
+[[def_SHA1]]SHA-1::
+	"Secure Hash Algorithm 1"; a cryptographic hash function. 
+	In the context of Git used as a synonym for <<def_object_name,object name>>.
 
 [[def_shallow_repository]]shallow repository::
 	A shallow <<def_repository,repository>> has an incomplete
@@ -447,7 +447,7 @@ should not be combined with other pathspec.
 	its history can be later deepened with linkgit:git-fetch[1].
 
 [[def_symref]]symref::
-	Symbolic reference: instead of containing the <<def_SHA1,SHA1>>
+	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>>
 	id itself, it is of the format 'ref: refs/some/thing' and when
 	referenced, it recursively dereferences to this reference.
 	'<<def_HEAD,HEAD>>' is a prime example of a symref. Symbolic
-- 
1.8.1.msysgit.1


---
Thomas
