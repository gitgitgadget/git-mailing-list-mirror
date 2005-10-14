From: Junio C Hamano <junkio@cox.net>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Fri, 14 Oct 2005 08:42:02 -0700
Message-ID: <7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 17:43:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQRhe-0000T2-6Q
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 17:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJNPmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 11:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJNPmF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 11:42:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15844 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750762AbVJNPmE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 11:42:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014154154.SBUN19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 11:41:54 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <864q7kqsa4.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "14 Oct 2005 03:58:27 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10110>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Even after updating git this morning, git-pull still seems to be broken
> with respect to http://www.kernel.org/.
> Is http pulling broken for good now?  Or is someone looking at this?

Sorry, but this is not a description of your problem helpful
enough for someone who is willing to look at it, I am afraid.
http://www.kernel.org/ has 80 or so repos (I counted about a
month ago so it may probably have more by now) --- which ones?

I have local repositories used only to test pulling into them,
and I pull from Linus 2.6 kernel, and my own git repository,
every other day or so, but haven't seen breakage, so I do not
think it is http://www.kernel.org/. in general.  If some
particular repository is not set up HTTP friendly I would
understand.

Also how does it fail?  Does cloning from scratch succeed but
updating a repo that was in sync a few days ago fail?  Does it
die silently and you find the breakage by running fsck-object,
or does it fail loudly with error messages?  If the latter what
does it say?
