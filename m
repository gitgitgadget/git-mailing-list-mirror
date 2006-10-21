From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 18:09:52 -0700
Message-ID: <7vy7rajwyn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<vpqirigqzpd.fsf@ecrins.imag.fr> <20061019123349.GE20017@pasky.or.cz>
	<200610201350.12273.jnareb@gmail.com>
	<7vlknalgne.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610201702580.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 03:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb5NH-0004uS-T7
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 03:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWJUBJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 21:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWJUBJy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 21:09:54 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55245 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030376AbWJUBJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 21:09:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021010953.TTFH13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 21:09:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cp9e1V0061kojtg0000000
	Fri, 20 Oct 2006 21:09:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201702580.3962@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 20 Oct 2006 17:07:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29569>

Linus Torvalds <torvalds@osdl.org> writes:

> And "gitweb" does consider the first one special, since it shows diffs 
> against that one (although I've argued that it probably shouldn't, and 
> that there should be some way to show branches against arbitrary parents)
>
> So we're a bit confused. Not that it probably really ever matters.

There is another one similar to the gitweb one you mentioned:
git-show --stat on a merge.  We deliberately chose to show the
difference from the first parent; it is called "showing the
changes the person who made this merge saw".
