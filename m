From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-checkout: disable guides how to switch branches with ui.guide
Date: Thu, 01 Feb 2007 12:42:34 -0800
Message-ID: <7vabzxpq2t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	<20070131231942.GB31145@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	<20070201030030.GA1979@coredump.intra.peff.net>
	<7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
	<7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
	<20070201184403.GA6326@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCilS-0003rC-U4
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422995AbXBAUmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423000AbXBAUmg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:42:36 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:46653 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422995AbXBAUmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:42:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070201204233.KIEY1343.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Feb 2007 15:42:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JLia1W0081kojtg0000000; Thu, 01 Feb 2007 15:42:34 -0500
In-Reply-To: <20070201184403.GA6326@moooo.ath.cx> (Matthias Lederhofer's
	message of "Thu, 1 Feb 2007 19:44:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38395>

Matthias Lederhofer <matled@gmx.net> writes:

>> * Coming back to an attached state can lose the detached HEAD, so
>>   I get warned and stopped.
>> 
>>     [git.git]$ git checkout master
>>     You are not on any branch and switching to branch 'master'
>>     may lose your changes.  At this point, you can do one of two things:
>>      (1) Decide it is Ok and say 'git checkout -f master';
>>      (2) Start a new branch from the current commit, by saying
>>          'git checkout -b <branch-name>'.
>>     Leaving your HEAD detached; not switching to branch 'master'.
>
> I think these two are too long, after a few times one knows exactly
> what to do and all this text is not necessary anymore.

I doubt adding a per-repo or per-user configuration would be
worth it.

The original hope was after a few times one would know to use
either -f or -b depending on what he wants, and would not run
plain vanilla branch switching "git checkout master".

Then one does not even have to see this message, not just the
last "instruction" lines but "You are not on any branch" part.
