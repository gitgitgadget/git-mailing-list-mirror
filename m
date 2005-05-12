From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 15:12:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505121449370.30848-100000@iabervon.org>
References: <7vll6kgu21.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 21:06:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWIzQ-0000nL-PD
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVELTMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVELTMj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:12:39 -0400
Received: from iabervon.org ([66.92.72.58]:59911 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261379AbVELTMh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 15:12:37 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWJ6R-0006ph-00; Thu, 12 May 2005 15:12:11 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll6kgu21.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 May 2005, Junio C Hamano wrote:

> I have to think about this a bit but let me understand the
> problem first.  Let's say it is a couple of weeks ago when there
> were not cg-status.  You write cg-status, by adding -t flag to
> ls-files.c  You commit the addition of -t flag to git-pb
> repository and note the commit id.  You then commit addition of
> cg-status to cogito repository and when you do so you want the
> party that pulls the latter commit to know it needs the former
> commit in the git-pb tree.  Is it what you are solving here?

Right; and I'm not Petr, so the place that has the -t flag in ls-files
isn't his git-pb repository, and I'm not going to remember to tell him
about two places to pull from or two heads to pull.

Probably my biggest concern here is that it has to not make anything more
difficult for Cogito hackers (or people working on similarly arranged
projects) to have the other project demarcated as separate, or they'd tend
to be lazy and the upstream core will suffer. I believe that this is why
people in practice tend not to bother making projects clean and modular
with current tools. Having it streamlined and automatic would mean that
people in the position that Petr was in when he started would do it by
default.

	-Daniel
*This .sig left intentionally blank*

