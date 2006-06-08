From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2]: amendment
Date: Thu, 08 Jun 2006 09:52:57 -0700
Message-ID: <7vzmgntwra.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606081719400.27335@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 18:53:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoNkm-0007LZ-3l
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 18:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWFHQw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 12:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWFHQw7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 12:52:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12960 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964907AbWFHQw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 12:52:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608165258.BDNC19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Jun 2006 12:52:58 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21501>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I completely forgot that with a global config, it makes sense to have 
> aliases even if we are not in a git repository.
>
> So, in git.c, handle_alias() the "if (nongit)" makes no sense any longer. 
> If I have to revise the patch anyway, I will include the change, but if 
> you decide to take it, please change that.
>
> Ciao,
> Dscho
>
> P.S.: There might be other users (such as git-peek-remote) who want that 
> change, too.

Well, this is pretty late in the 1.4.0 game and honestly I am
pretty reluctant to merge this in, push 1.4.0 out in 48 hours
and leave for nearly a week.

So either we would reschedule 1.4.0 and shoot for June 24th, or
do 1.4.0 this weekend as planned, and leave this as the first
item (perhaps the second, after applying many small clean-ups
I've privately received, which I haven't acted on other than
quickly reviewing and asking the submitter to rebase and resend
cc'ing the list) in the post-1.4.0 development cycle.  This
potentially is a candidate to backport to 1.4.X series.

My preference is to cook this in "next" for a while and merge it
post 1.4.0.
