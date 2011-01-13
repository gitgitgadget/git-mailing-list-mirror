From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] RelNotes/1.7.4: remove helper script traces
Date: Thu, 13 Jan 2011 10:35:35 +0100
Message-ID: <a385867f72eb019e3629eacfabe8b6546a5604da.1294911294.git.git@drmicha.warpmail.net>
References: <be158c63c44562e87488d742148f54d1c71107df.1294911294.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 10:38:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdJdS-0004HA-AK
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 10:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885Ab1AMJiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 04:38:17 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37845 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932827Ab1AMJiQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jan 2011 04:38:16 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0F9C42093D;
	Thu, 13 Jan 2011 04:38:16 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 13 Jan 2011 04:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=NT3aAFIBUNMM0EJIB+AjGtujZm4=; b=pKh9NiwD6FLk+zSZ6+snDv2bhogkiIA0XL8D4tPWSBaz7vYaYDAk6TDLnT2qqHbSGBsUYkmXise7VT1QpIm7/0uUbHnCxw/44IqCAITMmL/x5bGelIF4cG6ugXAtRvwoS8PzC7Z56t7rYxieAOuXhXCDbyV74RwQONKcVEV/7lU=
X-Sasl-enc: tSbvMRtkrPwlveH4rbwWVOqK7XdkOkitofS8+tLHB2oQ 1294911495
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8543E400E5D;
	Thu, 13 Jan 2011 04:38:15 -0500 (EST)
X-Mailer: git-send-email 1.7.4.rc1.253.gb7420
In-Reply-To: <be158c63c44562e87488d742148f54d1c71107df.1294911294.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165045>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Dunno whether you do this automatically on release.

 Documentation/RelNotes/1.7.4.txt |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/1.7.4.txt b/Documentation/RelNotes/1.7.4.txt
index 48dd964..21e1e3f 100644
--- a/Documentation/RelNotes/1.7.4.txt
+++ b/Documentation/RelNotes/1.7.4.txt
@@ -144,8 +144,3 @@ release, unless otherwise noted.
  * "git submodule update --recursive --other-flags" passes flags down
    to its subinvocations.
 
----
-exec >/var/tmp/1
-O=v1.7.4-rc1
-echo O=$(git describe master)
-git shortlog --no-merges ^maint ^$O master
-- 
1.7.4.rc1.253.gb7420
