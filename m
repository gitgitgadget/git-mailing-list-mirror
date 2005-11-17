From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add git-config-set, a simple helper for scripts to set config variables
Date: Thu, 17 Nov 2005 14:57:54 -0800
Message-ID: <7vveyqswzx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511172244230.18285@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:01:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecshd-0001a4-Oe
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 23:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVKQW57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 17:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVKQW56
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 17:57:58 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54199 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964885AbVKQW56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 17:57:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117225728.GYVZ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 17:57:28 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511172244230.18285@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 17 Nov 2005 22:44:55 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12167>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is meant for the end user, who cannot be expected to edit
> .git/config by hand.
>
> Example:
>
> 	git-config-set core.filemode true
>
> will set filemode in the section [core] to true,
>
> 	git-config-set --unset core.filemode
>
> will remove the entry (failing if it is not there), and
>
> 	git-config-set --unset diff.twohead ^recar
>
> will remove the unique entry whose value matches the regex "^recar"
> (failing if there is no unique such entry).

It's kinda funny that your users cannot edit a plain text file
with an editor, but know how to do regex ;-).

I think the true value of this is that Porcelain scripts can
muck with configuration files.
