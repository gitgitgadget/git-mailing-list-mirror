From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 0/1] Makefile extensions for topic ta/doc-cleanup in pu
Date: Tue, 23 Oct 2012 19:55:13 +0200 (CEST)
Message-ID: <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, peff@peff.net, th.acker66@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 19:55:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQihP-0004Yd-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 19:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab2JWRzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 13:55:19 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:41500 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754731Ab2JWRzR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2012 13:55:17 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 0722E10C517;
	Tue, 23 Oct 2012 19:55:14 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 0172220800D;
	Tue, 23 Oct 2012 19:55:14 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id F27C2D80D9;
	Tue, 23 Oct 2012 19:55:13 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-03.arcor-online.net F27C2D80D9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351014914; bh=V63dRMu7COgJxeKdbeKBxPNpsMUb8No8aDjnYmlp9XI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Cf2fF0LCFt2NvcOH0zdqkiCMud6RrtEcUqDdVgySdxFEikrDxVoLGVdcfdV1n2V4X
	 UKTdt2aOR2yWpn6KFsF1B8SRBeAjuGrMdM7wSFhAdWxvi65a0BwPn/eVP5Fb5sf0kW
	 aSjtOEFdSrXFbNKLC1C5rBEvnlOOM8LpYlX5HYKw=
Received: from [188.99.42.120] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Tue, 23 Oct 2012 19:55:13 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.99.42.120
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208234>

This patch adds rules to the "html" taget in Documentation/Makefile to create html
also for the new asciidoc files in Documentation/technical and Documentation/howto
which were added in this topic.


---
Thomas
