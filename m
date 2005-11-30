From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bisect enhancements?
Date: Wed, 30 Nov 2005 14:04:46 -0800
Message-ID: <7vu0dtokqp.fsf@assigned-by-dhcp.cox.net>
References: <1133386585.30767.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:06:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eha4I-0004Nn-Jr
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVK3WEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVK3WEs
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:04:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42396 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750937AbVK3WEr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:04:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130220324.ILCX17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 17:03:24 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1133386585.30767.34.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Wed, 30 Nov 2005 15:36:26 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13020>

Jon Loeliger <jdl@freescale.com> writes:

> ...  I want to "bump" the bisect point
> up two commits and _then_ build.
>
> So, I'm proposing something like:
>
>     $ git bisect bump +<n>
>     $ git bisect bump -<n>
>
> To move the bisection point "up" or "down" a commit chain.

Hmph.  Doesn't "bisect good" or "bisect bad" let you explicitly
say which one is good or bad, instead of just taking what it
suggests as the next midpoint?
