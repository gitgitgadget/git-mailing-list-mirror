From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 2/3] Improve description of SHA1 related topics in
 glossary-content.txt
Date: Tue, 2 Apr 2013 11:27:46 +0200 (CEST)
Message-ID: <638015718.727691.1364894866964.JavaMail.ngmail@webmail14.arcor-online.net>
References: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 11:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMxVq-0002C8-AL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 11:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322Ab3DBJ1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 05:27:49 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:44643 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932318Ab3DBJ1s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 05:27:48 -0400
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id 020DD30114
	for <git@vger.kernel.org>; Tue,  2 Apr 2013 11:27:47 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id F1FA910C048;
	Tue,  2 Apr 2013 11:27:46 +0200 (CEST)
Received: from webmail14.arcor-online.net (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id EB4183AE437;
	Tue,  2 Apr 2013 11:27:46 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net EB4183AE437
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1364894866; bh=ydkNGqo0aETDRgL2eNXM7XpRPT1gg7PcMOTUfja94Zk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=EiIHPrltZIePX2sWejDRouP5KkOjbKsR+Ja0aawW1F+FryepNcS+oRdcQC4yM1Pk+
	 UYanNs2tJgVCT5oZmi2cgePFvsR2wgGwsx1giJx4hh7b+CojGw0abuJ5yG46yOdk7v
	 /ZoG53etZr7VKSDgaZD/9ThwhQ/c41egBCvluBfA=
Received: from [94.217.19.243] by webmail14.arcor-online.net (151.189.8.67) with HTTP (Arcor Webmail); Tue, 2 Apr 2013 11:27:46 +0200 (CEST)
In-Reply-To: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.19.243
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219758>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index ab02238..05bfebc 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -146,7 +146,7 @@ to point at the new commit.
 	created. Configured via the `.git/info/grafts` file.
 
 [[def_hash]]hash::
-	In Git's context, synonym to <<def_object_name,object name>>.
+	In Git's context, synonym for <<def_object_name,object name>>.
 
 [[def_head]]head::
 	A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of a
@@ -230,10 +230,9 @@ This commit is referred to as a "merge commit", or sometimes just a
 	Synonym for <<def_object_name,object name>>.
 
 [[def_object_name]]object name::
-	The unique identifier of an <<def_object,object>>. The <<def_hash,hash>>
-	of the object's contents using the Secure Hash Algorithm
-	1 and usually represented by the 40 character hexadecimal encoding of
-	the <<def_hash,hash>> of the object.
+	The unique identifier of an <<def_object,object>>: The <<def_SHA1,SHA1>> hash
+	of the object's contents. The object name is usually represented by the 
+	40 character hexadecimal encoding of the hash value.
 
 [[def_object_type]]object type::
 	One of the identifiers "<<def_commit_object,commit>>",
@@ -426,7 +425,8 @@ should not be combined with other pathspec.
 	Source code management (tool).
 
 [[def_SHA1]]SHA1::
-	Synonym for <<def_object_name,object name>>.
+	"Secure Hash Algorithm 1"; a cryptographic hash function. 
+	In the context of Git used as a synonym for <<def_object_name,object name>>.
 
 [[def_shallow_repository]]shallow repository::
 	A shallow <<def_repository,repository>> has an incomplete
-- 
1.8.1.msysgit.1


---
Thomas
