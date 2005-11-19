From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 16:37:21 -0800
Message-ID: <7vek5deam6.fsf@assigned-by-dhcp.cox.net>
References: <200511181833.40048.ismail@uludag.org.tr>
	<200511182127.06958.ismail@uludag.org.tr>
	<20051118200217.GA2831@vrfy.org>
	<200511182208.24248.ismail@uludag.org.tr>
	<Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
	<20051118205513.GA3168@vrfy.org>
	<Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
	<Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
	<437E51EB.7050100@zytor.com>
	<Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:39:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdGjO-0002Fs-Mi
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVKSAhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVKSAhY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:37:24 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17034 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751157AbVKSAhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 19:37:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119003626.ETWY17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 19:36:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 18 Nov 2005 15:25:05 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12310>

Linus Torvalds <torvalds@osdl.org> writes:

> Of course, you could equally easily (more so?) make it just a commit 
> trigger instead, which might well be the right thing.

I think it is the right approach.  As I repeatedly said (not
that repeating things makes them right) on this list, I think
that the interpretation of what is in commit log is a policy
issue that is local to each project.

> (And that still leaves the question open what to do about patches and 
> pulls, but if people mainly worry about newly written commit messages 
> itself, then at least that part is unambiguous).

Pulls are "too late, sorry you have to live with it"; for
patches, mailinfo and am have -u (I do not remember if I added
it to applymbox -- I do not use applymbox anymore myself).
Maybe we should make -u the default and countermand with -U to
encourage the use of utf8 further?
