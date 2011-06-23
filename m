From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] glossary: update description of "tag"
Date: Thu, 23 Jun 2011 09:52:36 -0700
Message-ID: <1308847958-3429-4-git-send-email-gitster@pobox.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
 <1308847958-3429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 18:52:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZn9A-0007A5-R1
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 18:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759785Ab1FWQwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 12:52:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759775Ab1FWQwr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 12:52:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 297A75B92
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Rj7f
	QI5Eh2kkE0d1wSdpxzgoK74=; b=YUGBqbAcdF2NTrpc5GNiJpealmnK3qzUuZPN
	FX3lQMW4ZD+eeGQhwRksa8ZwzAHx9Im8jYRkDCAzgnZ9PCwiYEbWsEoOzt8HELN6
	DId03ttawjvdKMx0IKjH/T/OM+CkjW1r7Pb6TTNmT8Rlm8znzFkFbksxqrgQmibh
	LACtG2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JVqClC
	XCyW3jboowbDSFQBDCroeGBU1J3pBJCbmR49D05NxqlEv3eTpaLyRuDOnu1m+8Lq
	KxFqwSDFKxBKJ3K4Mh9dFUuVt95q0X/pr+Zen8s/7FjPyEXH0NNu07P/RQDNvSEC
	Zaz7MPOSybJXcRQkngQZtR4PzhoTODRGt14To=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 236245B91
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C84D5B90 for
 <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc3
In-Reply-To: <1308847958-3429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 873CA9E0-9DB9-11E0-A66F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176276>

It is an unimportant implementation detail that ref namespaces are
implemented as subdirectories of $GIT_DIR/refs. What is more important
is that tags are in refs/tags hierarchy in the ref namespace.

Also note that a tag can point at an object of arbitrary type, not limited
to commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 33716a3..c437f34 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -427,14 +427,14 @@ including Documentation/chapter_1/figure_1.jpg.
 	command.
 
 [[def_tag]]tag::
-	A <<def_ref,ref>> pointing to a <<def_tag_object,tag>> or
-	<<def_commit_object,commit object>>. In contrast to a <<def_head,head>>,
-	a tag is not changed by a <<def_commit,commit>>. Tags (not
-	<<def_tag_object,tag objects>>) are stored in `$GIT_DIR/refs/tags/`. A
-	git tag has nothing to do with a Lisp tag (which would be
-	called an <<def_object_type,object type>> in git's context). A
-	tag is most typically used to mark a particular point in the
-	commit ancestry <<def_chain,chain>>.
+	A <<def_ref,ref>> under `refs/tags/` namespace that points to an
+	object of an arbitrary type (typically a tag points to either a
+	<<def_tag_object,tag>> or a <<def_commit_object,commit object>>).
+	In contrast to a <<def_head,head>>, a tag is not updated by
+	 the `commit` command. A git tag has nothing to do with	a Lisp
+	tag (which would be called an <<def_object_type,object type>>
+	in git's context). A tag is most typically used to mark a particular
+	point in the commit ancestry <<def_chain,chain>>.
 
 [[def_tag_object]]tag object::
 	An <<def_object,object>> containing a <<def_ref,ref>> pointing to
-- 
1.7.6.rc3
