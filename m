From: Junio C Hamano <junkio@cox.net>
Subject: Re: Perl version support
Date: Wed, 23 Nov 2005 11:47:20 -0800
Message-ID: <7vwtiz4053.fsf@assigned-by-dhcp.cox.net>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
	<867jazre78.fsf@blue.stonehenge.com>
	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
	<20051123135604.GB16995@mythryan2.michonline.com>
	<86mzjvphhj.fsf_-_@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 20:48:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef0ab-0003qp-Pl
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 20:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVKWTrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 14:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVKWTrX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 14:47:23 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36022 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932252AbVKWTrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 14:47:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123194722.WBGC25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 14:47:22 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86mzjvphhj.fsf_-_@blue.stonehenge.com> (Randal L. Schwartz's
	message of "23 Nov 2005 06:27:04 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12645>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> I'd say that 50% of the Perl-using population is at 5.6, with 25% each
> at 5.5 and 5.8.  Those on 5.5 are generally unable to upgrade Perl
> for corporate reasons.

I think the target market is people who use whatever POSIXy
systems for their own work.  To them, git and its dependencies
are merely tools to get their job done, and while they might be
capable and even willing to match the version requirements if it
is absolutely necessary, they'd rather spend their time on what
they do best (i.e. write software or documentation or whatever,
whose changes are to be managed by git), than installing or
upgrading base software just to satisfy git.  And I'd like to
see their time spent on what they do best, instead of caring and
feeding of git, too.

So in that sense, excluding 75% of people with "5.8 only" is not
acceptable at all, and covering 75% with "5.6 or better" might
be good enough, at least as a starter.

> If you'd like, I can review all the Perl code with a tool that
> determines the minimum Perl version, and provide patches to bring the
> code to 5.5 level.

If it is not too much trouble, I'd appreciate it, at least the
first half that can be done without taking too much of your time.
Is it a mechanical "lint" like thing, that says "line 47 you
have list form of pipe open -- that's 5.8 and better"?
