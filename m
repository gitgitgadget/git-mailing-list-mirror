From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix daemon documentation: '--enable-service' is not valid
Date: Wed, 24 Jan 2007 15:30:06 -0800
Message-ID: <7vejpkdmv5.fsf@assigned-by-dhcp.cox.net>
References: <45B76385.5050009@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Franck <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 00:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9rZL-0007mP-5s
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 00:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbXAXXaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 18:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbXAXXaJ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 18:30:09 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:57883 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964782AbXAXXaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 18:30:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124233007.XBTZ7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 18:30:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FBWR1W00h1kojtg0000000; Wed, 24 Jan 2007 18:30:26 -0500
In-Reply-To: <45B76385.5050009@innova-card.com> (Franck Bui-Huu's message of
	"Wed, 24 Jan 2007 14:47:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37692>

Thanks.  But I think it was a typo that should have been fixed
like this, which I'll commit.

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 993adc7..9ddab71 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -131,14 +131,14 @@ Giving these options is an error when used with `--inetd`; use
 the facility of inet daemon to achieve the same before spawning
 `git-daemon` if needed.
 
---enable-service, --disable-service::
+--enable=service, --disable=service::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
 	repository enables the service with an configuration
 	item.
 
---allow-override, --forbid-override::
+--allow-override=service, --forbid-override=service::
 	Allow/forbid overriding the site-wide default with per
 	repository configuration.  By default, all the services
 	are overridable.
