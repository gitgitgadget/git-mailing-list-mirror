From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 6/6] Add rule for when to use 'git' and when to use 'Git'
Date: Mon, 21 Jan 2013 20:24:10 +0100 (CET)
Message-ID: <1147790618.632901.1358796250206.JavaMail.ngmail@webmail20.arcor-online.net>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net> <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net> <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 20:24:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMyv-0007Rr-MD
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048Ab3AUTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:24:12 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:47106 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755279Ab3AUTYL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:24:11 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 49515197760;
	Mon, 21 Jan 2013 20:24:10 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 4531A3481BE;
	Mon, 21 Jan 2013 20:24:10 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 37FA1212433;
	Mon, 21 Jan 2013 20:24:10 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net 37FA1212433
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358796250; bh=PpiwrOv66iGhk3zMzx79KzhWtGI1cxNgXxoYiYJBbwk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Qm6Wd4jj9b7in9aVnAdaTLXyn0nlUOJ8i1Tq/pAU4Sx2MiZr5y3dgvrJaRIbIt/XN
	 1UZDorLhYZLXO76RunfCJcI2+HzztSOs3eb1/rF2ii6lm1K46d3IbohhA2Q2RC0K8A
	 13t2L28klxBIWk0EVqL5JDWyFsySGz2OTS36cbww=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 20:24:10 +0100 (CET)
In-Reply-To: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214152>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 5e60daf..4f40b44 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -230,3 +230,9 @@ Writing Documentation:
    valid usage.  "*" has its own pair of brackets, because it can
    (optionally) be specified only when one or more of the letters is
    also provided.
+
+  A note on notation:
+   Use 'git' (all lowercase) when talking about commands i.e. something
+   the user would type into a shell and use 'Git' (uppercase first letter) 
+   when talking about the version control system and its properties.
+   
-- 
1.8.0.msysgit.0


---
Thomas
