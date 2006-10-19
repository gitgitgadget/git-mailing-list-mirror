From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 12:16:33 -0700
Message-ID: <7vac3sru9a.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
	<20061019161319.GA75501@over-yonder.net>
	<Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610191110290.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 21:16:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GadNe-0008PU-1T
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 21:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946385AbWJSTQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 15:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946389AbWJSTQe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 15:16:34 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8618 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1946385AbWJSTQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 15:16:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061019191633.RTPE2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Oct 2006 15:16:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cKGc1V01H1kojtg0000000
	Thu, 19 Oct 2006 15:16:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610191110290.3962@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 19 Oct 2006 11:30:15 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29380>

Linus Torvalds <torvalds@osdl.org> writes:

> The other big difference is being able to do merges in seconds. The 
> biggest cost of doing a big merge these days seems to literally be 
> generating the diffstat of the changes at the end (which is purely a UI 
> issue, but one that I find so important that I'll happily take the extra 
> few seconds for that, even if it sometimes effectively doubles the 
> overhead).

An interesting effect on this is when people have a column for
merge performance in a SCM comparison table, they would include
time to run the diffstat as part of the time spent for merging
when they fill in the number for git, but not for any other SCM.

I know you won't misunderstand me but for the sake of others, I
should add this: I am not saying diffstat should be optional.
