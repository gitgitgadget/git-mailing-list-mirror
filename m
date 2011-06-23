From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] glossary: update description of head and ref
Date: Thu, 23 Jun 2011 09:52:37 -0700
Message-ID: <1308847958-3429-5-git-send-email-gitster@pobox.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
 <1308847958-3429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 18:53:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZn9T-0007PP-LW
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 18:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759791Ab1FWQwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 12:52:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab1FWQwu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 12:52:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 807F05B96
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:55:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sVeG
	WccIF2v/SvcEQaDGiF74RZ4=; b=c3aM1pOTXMIoMMb0+naYYpWvMpHa8WV9lajY
	ER93thXH8cYWIQbhXb5VHu/pxZ91mR6xBsO6P4+mYB8fQZzZ+xZgifP/9rQsW87b
	83lBzrgOIiE75+wsHpmeXjLmKOfwuVDEMRBhPSAq2s4zDNXxPqSITttxuvpoF2S5
	/l7NC2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Z+bTo6
	yaHJmhs8e2VVxtv15+lvTYh8KHZgSlTSqx7jPQPZqoOENYKkBtItARDWeDoMccbX
	XSAisxmVBqiNVayC5WfeOTsjfAJYGPCEa+NdGtjTj2UarVSvDj2eSPYtiC/tNJGy
	wF/Z0mroO6UiyarqPSq0ZNNSZQ4OutPK6dNCI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 649425B95
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:55:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98AE45B94 for
 <git@vger.kernel.org>; Thu, 23 Jun 2011 12:55:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc3
In-Reply-To: <1308847958-3429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8889B766-9DB9-11E0-969F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176278>

Reword them to avoid sounding as if loose refs are the only ones in the world.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index c437f34..dd690bd 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -161,8 +161,8 @@ to point at the new commit.
 
 [[def_head]]head::
 	A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of a
-	<<def_branch,branch>>.  Heads are stored in
-	`$GIT_DIR/refs/heads/`, except when using packed refs. (See
+	<<def_branch,branch>>.  Heads are stored in a file in
+	`$GIT_DIR/refs/heads/` directory, except when using packed refs. (See
 	linkgit:git-pack-refs[1].)
 
 [[def_HEAD]]HEAD::
@@ -350,8 +350,9 @@ including Documentation/chapter_1/figure_1.jpg.
 
 [[def_ref]]ref::
 	A 40-byte hex representation of a <<def_SHA1,SHA1>> or a name that
-	denotes a particular <<def_object,object>>. These may be stored in
-	`$GIT_DIR/refs/`.
+	denotes a particular <<def_object,object>>. They may be stored in
+	a file under `$GIT_DIR/refs/` directory, or
+	in the `$GIT_DIR/packed-refs` file.
 
 [[def_reflog]]reflog::
 	A reflog shows the local "history" of a ref.  In other words,
-- 
1.7.6.rc3
