From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sun, 28 Jan 2007 14:18:04 -0800
Message-ID: <7vlkjmdcdf.fsf@assigned-by-dhcp.cox.net>
References: <20070127062826.GE14205@fieldses.org>
	<20070128002246.GA10179@moooo.ath.cx>
	<Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
	<20070128013452.GA11244@moooo.ath.cx>
	<Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
	<20070128024009.GB6545@socrates.priv>
	<7vk5z7h9y5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 23:18:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBILs-0003Lg-MM
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 23:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbXA1WSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932921AbXA1WSH
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 17:18:07 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51376 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbXA1WSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 17:18:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128221805.XJWS9717.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 17:18:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GmH61W00F1kojtg0000000; Sun, 28 Jan 2007 17:17:06 -0500
In-Reply-To: <7vk5z7h9y5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 27 Jan 2007 23:44:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38051>

Junio C Hamano <junkio@cox.net> writes:

> Please, do not break people's scripts that still use
> repo-config.

Sorry for being terse.  What I would prefer is no change to C
files except what is minimally needed to adding 'git-config' as
an alias to 'git-repo-config', plus s/repo-config/config/g in
the Documentation.

For Porcelains and test scripts shipped with git, replace
'repo-config' to 'config' only for actual strings used as
command names to be invoked, to play it safe (renaming a
variable 'repo_config' to 'config' needs to be done and verified
carefully as there may already be an existing variable 'config',
for example).
