From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Remove duplicate entry in ./Documentation/Makefile
Date: Wed, 19 Dec 2012 19:15:25 +0100 (CET)
Message-ID: <1674037566.22743.1355940925216.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 19:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlOBE-00015u-S7
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 19:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab2LSSP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 13:15:28 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:55092 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342Ab2LSSP0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2012 13:15:26 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 3E3EC107BCE
	for <git@vger.kernel.org>; Wed, 19 Dec 2012 19:15:25 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 3D32933B14F;
	Wed, 19 Dec 2012 19:15:25 +0100 (CET)
Received: from webmail07.arcor-online.net (webmail07.arcor-online.net [151.189.8.8])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 35A1210C4A7;
	Wed, 19 Dec 2012 19:15:25 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 35A1210C4A7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1355940925; bh=reE1ytUVxOvp34camgz7UKDT44Gnyayyzu7p43TD83g=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=fB3yGzTGQ5AFOkBbRk9EkXFxdjS6r2NsPE2M8oBPydHpoK741507CnZhaZe9g6SFv
	 du8PiELUVAWO4xxD27QSbTj2A3QMbsLzx3eIWcbBgya5ck1TCEqqAQr78MlwH09h43
	 VWpu4anaMGfrZL4HxLJ+bqQMJy2sDQoGtX/AFiNQ=
Received: from [94.217.21.164] by webmail07.arcor-online.net (151.189.8.8) with HTTP (Arcor Webmail); Wed, 19 Dec 2012 19:15:24 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.21.164
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211838>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3615504..7df75d0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -31,7 +31,6 @@ SP_ARTICLES += howto/separating-topic-branches
 SP_ARTICLES += howto/revert-a-faulty-merge
 SP_ARTICLES += howto/recover-corrupted-blob-object
 SP_ARTICLES += howto/rebuild-from-update-hook
-SP_ARTICLES += howto/rebuild-from-update-hook
 SP_ARTICLES += howto/rebase-from-internal-branch
 SP_ARTICLES += howto/maintain-git
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
-- 
1.8.0.msysgit.0


---
Thomas
