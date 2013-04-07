From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v2 2/3] glossary: improve description of SHA-1 related
 topics
Date: Sun, 7 Apr 2013 17:10:29 +0200 (CEST)
Message-ID: <824604721.1719644.1365347429662.JavaMail.ngmail@webmail09.arcor-online.net>
References: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de, gitster@pobox.com
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 17:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOrEp-00051y-VZ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 17:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933890Ab3DGPKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 11:10:32 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:48109 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933858Ab3DGPKb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 11:10:31 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id AEB81E3B68;
	Sun,  7 Apr 2013 17:10:29 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id A407C21202E;
	Sun,  7 Apr 2013 17:10:29 +0200 (CEST)
Received: from webmail09.arcor-online.net (webmail09.arcor-online.net [151.189.8.45])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 9AFD02120AA;
	Sun,  7 Apr 2013 17:10:29 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net 9AFD02120AA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1365347429; bh=TGP2xrPVjBVUCQxlEJpA+tr8ME6NNOsKR/cax4QBPOw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=DFpNUmOcRbAnOAsLo1nQgtq6NTjC3+7Ni07QU2TWNFIEIDnFfdzSCinCkkLTqiib/
	 Gys/dCgAjupORtoWrsLB7mp/ML+Cpkd7yCiLgXgeMJacA9kMYhx/oBnPpveKbLlEzj
	 0YJpWm4ZsEJaBp+/1RlbYUc8yJrFeHYAgshX9ACs=
Received: from [188.98.233.28] by webmail09.arcor-online.net (151.189.8.45) with HTTP (Arcor Webmail); Sun, 7 Apr 2013 17:10:29 +0200 (CEST)
In-Reply-To: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.233.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220314>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5a7a486..4dd0a52 100644
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
+	hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>
 
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
