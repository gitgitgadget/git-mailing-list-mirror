From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] glossary: clarify description of HEAD
Date: Thu, 23 Jun 2011 09:52:38 -0700
Message-ID: <1308847958-3429-6-git-send-email-gitster@pobox.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
 <1308847958-3429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 18:53:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZn9U-0007PP-5W
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 18:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759797Ab1FWQwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 12:52:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab1FWQww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 12:52:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CFB875B9A
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:55:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bVFv
	m0OT3zg96H+v0E3Wy7UoaUY=; b=X3taeS+1xC3R9+DMmcf4p5vkAzKa3sPW9qxS
	IuBeQLrqi89phf6bUZTROaQ8F4K9JlyW5NIlzMUm1ToTO0vH7RhwI33ttB9ArVk/
	o2OTKiYMQ7tNmb+EvEf6o7mI6tTyA1efWjj3MUxVcePVq5ZJ+btjb0hV93ZcIJ9Y
	Xqf0S0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=C1twSx
	b2XKAKzHOY8/vFWiEsG+o6JXLJ2M8klQT+K/SzV0WOEmpHK/TBawNWIzs+7cjHrl
	nPK/k2JYC5Ra3k6lZX8PceJr/eHJkhs45IIOOrYs1Qlxr4bX2AECBycNt2LTQjdP
	jaNlZaqZqxpssagINjMfFowEmpH3ENpWMEWKU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8FC65B99
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:55:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6A1B5B97 for
 <git@vger.kernel.org>; Thu, 23 Jun 2011 12:55:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc3
In-Reply-To: <1308847958-3429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 89E14494-9DB9-11E0-AD22-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176279>

HEAD on a branch does reference a commit via the branch ref it refers to.
The main difference of a detached HEAD is that it _directly_ refers to
a commit.  Clarify this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index dd690bd..f79da21 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -170,7 +170,7 @@ to point at the new commit.
 	working tree>> is normally derived from the state of the tree
 	referred to by HEAD.  HEAD is a reference to one of the
 	<<def_head,heads>> in your repository, except when using a
-	<<def_detached_HEAD,detached HEAD>>, in which case it may
+	<<def_detached_HEAD,detached HEAD>>, in which case it may directly
 	reference an arbitrary commit.
 
 [[def_head_ref]]head ref::
-- 
1.7.6.rc3
