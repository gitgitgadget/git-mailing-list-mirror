From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 18:26:08 -0700
Message-ID: <7vk62ujw7j.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	<Pine.LNX.4.64.0610201133260.3962@g5.osdl.org>
	<1161382416.9241.19.camel@localhost.localdomain>
	<Pine.LNX.4.64.0610201630000.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, bazaar-ng@lists.canonical.com,
	Jeff Licquia <jeff@licquia.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 03:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb5cz-0006t1-7x
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 03:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992772AbWJUB0M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 21:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992778AbWJUB0M
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 21:26:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:5629 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S2992772AbWJUB0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 21:26:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021012609.LFXL16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 21:26:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cpRu1V00N1kojtg0000000
	Fri, 20 Oct 2006 21:25:55 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610201630000.3962@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 20 Oct 2006 16:59:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29571>

Linus Torvalds <torvalds@osdl.org> writes:

> Both of these things that git can actually do. Admittedly it does not do 
> that in any _released_ version, so you'd have to work with the development 
> branch, and it's a fairly early thing, but currently it can actually 
> notice that our "revision.c" file largely came from the "rev-list.c" file 
> that still exists!
>
> And btw, that's not just some random feature that happened to get 
> implemented last week. Yes, it actually _did_ get implemented last week, 
> but this was something I outlined when I started git in April of last 
> year, and tried to explain to people WHY TRACKING FILE ID'S ARE WRONG!
>
> You can find me explaining these things to people in April-2005, which 
> should tell you something: the initial revision of "git" was on Thursday, 
> April 7. So the lack of file identity tracking has been controversial from 
> the very beginning, but I was right then, and I'm right now.

For people new to the list, the message is:

    http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217

I think I've quoted this link at least three times on this list;
I consider it is _the_ most important message in the whole list
archive.  If you haven't read it, read it now, print it out,
read it three more times, place it under the pillow before you
sleep tonight.  Repeat that until you can recite the whole
message.  It should not take more than a week.

To me, personally, achieving that ideal "drill down" dream was
one of the more important goals of my involvement in this
project.  I did diffcore-rename to fill some part of the dream,
and then diffcore-pickaxe to fill some other part.  Neither was
even close.  I think the recent round of pickaxe is getting much
closer.
