From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 18:27:06 -0700
Message-ID: <7vfydijw5x.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<vpqirigqzpd.fsf@ecrins.imag.fr> <20061019123349.GE20017@pasky.or.cz>
	<200610201350.12273.jnareb@gmail.com>
	<7vlknalgne.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610201702580.3962@g5.osdl.org>
	<7vy7rajwyn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610201818210.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 03:27:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb5do-00070C-Km
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 03:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992768AbWJUB1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 21:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992781AbWJUB1J
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 21:27:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25264 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S2992768AbWJUB1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 21:27:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021012707.ZPGW12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 21:27:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cpSs1V00L1kojtg0000000
	Fri, 20 Oct 2006 21:26:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201818210.3962@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 20 Oct 2006 18:19:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29572>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 20 Oct 2006, Junio C Hamano wrote:
>> 
>> There is another one similar to the gitweb one you mentioned:
>> git-show --stat on a merge.  We deliberately chose to show the
>> difference from the first parent; it is called "showing the
>> changes the person who made this merge saw".
>
> Well, that one actually makes sense. It's just the stat from the previous 
> state, after all, and it actually is done _together_ with the operation 
> that causes the diffs.
>
> So that one I don't think you can really even claim.
>
> Also, it's not even the "first parent". Look closer. It's literally 
> "previous state", because it does so for a fast-forward too. It's from 
> ORIG_HEAD.

I was not talking about "git pull".  I was talking about "git
show".
