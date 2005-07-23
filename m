From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 17:20:53 -0700
Message-ID: <7vhdeme5ju.fsf@assigned-by-dhcp.cox.net>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
	<20050722181800.GU20369@mythryan2.michonline.com>
	<7vsly6vd2b.fsf@assigned-by-dhcp.cox.net> <42E1571B.8070108@gmail.com>
	<Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
	<7vhdempmgg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
	<7vfyu6jvrm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507221619450.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 02:21:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7li-0007go-A2
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 02:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVGWAVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 20:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVGWAVD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 20:21:03 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:22001 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262246AbVGWAU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 20:20:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723002055.ICMY7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 20:20:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> In other words, if it's per-project, then that implies that every single 
> developer has to agree on the same thing. Which just not possible - it 
> makes no sense.

I agree 75%.  See the bottom for the rest 25%.

> In contrast, if you have a separate local _branch_ that maintains a
> ".gitinfo"  totally separately (no common commits at all), then you can
> choose to propagate/participate in that branch or not, as you wish, on a
> per-developer basis.

Ah, finally the lightbulb moment.  And I think what you outlined
using "git switch" in another message is a clean way to do it if
somebody wanted to.


> For example, what if I tried to dig out even _more_ information than what 
> is in the BK CVS archives? Or if I wanted to have just the 2.6.0-> 
> history?

Good examples; I stand corrected.  That is also per "group of
people who share the same view", i.e. per-developer thing that
may be propagated among consenting branch participants.


> What you're saying is that people can be happy if they just
> don't use a stupid decision. That's a sure sign that the
> decision shouldn't have been made in the first place.

I am not saying it that strongly.  Rather, people can be happy
if they do not have to use a decision that they feel stupid.

In circles you are part of, especially in a project like the
kernel where hundreds of people participate worldwode, I can see
that having project-wide preference (or policy) and maintaining
it may not make _any_ sense.  

But on the other hand, it is my understanding that it is a
common practice to enforce some centralized policy (I am
thinking about pre-commit hooks in particular) in a corporate
settings, and for people wanting to have that kind of thing, it
is not even a stupid decision.
