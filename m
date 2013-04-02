From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 0/3] Some small fixes to glossary-content.txt
Date: Tue, 2 Apr 2013 11:24:23 +0200 (CEST)
Message-ID: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 11:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMxSb-000851-9F
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 11:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760131Ab3DBJY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 05:24:29 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:38111 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760318Ab3DBJYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 05:24:25 -0400
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id 4DE2B2D62A9
	for <git@vger.kernel.org>; Tue,  2 Apr 2013 11:24:23 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 49CC610C06F;
	Tue,  2 Apr 2013 11:24:23 +0200 (CEST)
Received: from webmail14.arcor-online.net (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 40B1535A2AD;
	Tue,  2 Apr 2013 11:24:23 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net 40B1535A2AD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1364894663; bh=EcCzy/AWxw2vuv7rnuzVfy6DBqiT/B7H/tn/IFp81o8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=TfSOtbO5pbYxf77Tf9TOx17ZPfSDaQF78GtHTKjOuZyQAPEkhiVq8lLiAIFOcVpos
	 D039DrnHI+5bgb6FPB4+LdlTuyE+BKSS4j3J8GnYxaimvRIuZ+0/jhFAcxkmEdvEYc
	 jAQPnc+zWnNL9Rz+2lpl7Ws8C+HhuK+89zVScRXY=
Received: from [94.217.19.243] by webmail14.arcor-online.net (151.189.8.67) with HTTP (Arcor Webmail); Tue, 2 Apr 2013 11:24:23 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.19.243
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219756>


While proof-reading the user-manual I noticed some issues with glossary-content.txt:

- There is some outdated, misleading or irrelevant information which might only confuse
new Git users and should therefore be removed.
- The entries for object, object name and SHA1 lacked a little bit of consistency.
- The glossary contains partial definitions for refspec and pathspec. The refspec
definition was replaced by a link to the git-push man-page. I also removed the
definition for pathspec but didn't find a single place where pathspecs are defined. 
The glossary surely is the wrong place for a complete definition, but is there something 
missing here or is it sufficient to spread the definition of pathspecs to the relevant man-pages?

[PATCH 1/3] Remove outdated/missleading/irrelevant entries from glossary-content.txt
[PATCH 2/3] Improve description of SHA1 related topics in glossary-content.txt
[PATCH 3/3] Remove definition of refspec and pathspec from glossary-content.txt


---
Thomas
