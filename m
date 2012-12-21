From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 2/3] Add new-command.txt to ./Documentation/Makefile
Date: Fri, 21 Dec 2012 19:06:31 +0100 (CET)
Message-ID: <1639182573.286712.1356113191647.JavaMail.ngmail@webmail14.arcor-online.net>
References: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 19:06:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm6zi-0008Q5-VS
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab2LUSGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:06:33 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:53868 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab2LUSGd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 13:06:33 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id B7F755A10A
	for <git@vger.kernel.org>; Fri, 21 Dec 2012 19:06:31 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id ABBAC21202B;
	Fri, 21 Dec 2012 19:06:31 +0100 (CET)
Received: from webmail14.arcor-online.net (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 9F75DAAA33;
	Fri, 21 Dec 2012 19:06:31 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 9F75DAAA33
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356113191; bh=BSRZDjx9UcE4uw0pFQtFEbx1feq595uubS5MMUCT1aM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=PqzjrMucXrjZdeTEYXxNhzxhmffgJ1s01yN3cUHg8Hlxue9MfQleaxZztWdXY2EwL
	 XYNpbQhFYtgbnONc46kj06yDUOKidty+KGse5VJ7Wdzgli4Wt3cuV5xngMhzF8GXs9
	 zjrcexC7TMZ9/w6g/ypk9LuiJgT50KbejA1C8PjI=
Received: from [178.7.24.61] by webmail14.arcor-online.net (151.189.8.67) with HTTP (Arcor Webmail); Fri, 21 Dec 2012 19:06:31 +0100 (CET)
In-Reply-To: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.24.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211995>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7df75d0..f3afcb6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -21,6 +21,7 @@ ARTICLES += git-tools
 ARTICLES += git-bisect-lk2009
 # with their own formatting rules.
 SP_ARTICLES = user-manual
+SP_ARTICLES += howto/new-command
 SP_ARTICLES += howto/revert-branch-rebase
 SP_ARTICLES += howto/using-merge-subtree
 SP_ARTICLES += howto/using-signed-tag-in-pull-request
-- 
1.8.0.msysgit.0


---
Thomas
