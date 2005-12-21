From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 14:10:48 -0800
Message-ID: <7vek465cev.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 23:14:23 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpCAg-0000Q4-SP
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 23:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVLUWKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVLUWKv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 17:10:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64668 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932294AbVLUWKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 17:10:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221220950.VBD20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 17:09:50 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13904>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you don't use git-shell, because the same machine is used for other 
> purposes, it makes sense to introduce
>
> 	[core]
> 		umask = 0002

I agree the setting should not be limited to git-shell, but I do
not think setting "umask" from git configuration is the right
way either.  For files and directories under $GIT_DIR, maybe
imposing the policy git configuration file has is OK, but I
think honoring the user's umask is the right thing for working
tree files.
