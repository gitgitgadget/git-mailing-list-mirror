From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvsimport "you may need to merge manually"
Date: Thu, 16 Mar 2006 20:16:14 -0800
Message-ID: <7vfylh7lkh.fsf@assigned-by-dhcp.cox.net>
References: <86veud23v0.fsf@blue.stonehenge.com>
	<7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
	<86r75122yj.fsf@blue.stonehenge.com>
	<7vk6at7o06.fsf@assigned-by-dhcp.cox.net>
	<86fylh20x6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 05:16:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK6OM-0000pw-F0
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 05:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWCQEQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 23:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWCQEQR
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 23:16:17 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60830 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750868AbWCQEQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 23:16:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317041621.RIGJ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 23:16:21 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86fylh20x6.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "16 Mar 2006 19:41:09 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17657>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Yeah, this doesn't make sense.  It used to "Just Work".  I can
> certainly add "git reset --hard" to my workflow, if that's the real
> work around.  And if so, the manpage should document that.

That should _not_ be the solution.

I think the behaviour we are seeing does not make much sense.
I'll take a deeper look at it tonight (or tomorrow if I am
unlucky), if nobody beats me to it.

Sorry about the breakage.
