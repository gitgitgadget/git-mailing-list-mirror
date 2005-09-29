From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-head fetch proposal
Date: Wed, 28 Sep 2005 21:45:22 -0700
Message-ID: <7voe6co525.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509290149540.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 06:50:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKqJ8-0004pm-Qh
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVI2EpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVI2EpZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:45:25 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39614 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751184AbVI2EpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 00:45:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929044520.SCC29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 00:45:20 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509290149540.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 29 Sep 2005 02:25:37 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9458>

I was wondering why I always end up fetching 35 or so objects
when I ask master, maint and pu from my public repository, and
wanted to spend today digging on this one.  Instead I ended up
wasting the day on something else (I just sent it out), but I am
glad you were looking into it.

Of course, with your patch the problem does not happen anymore.
