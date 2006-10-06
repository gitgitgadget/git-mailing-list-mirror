From: Junio C Hamano <junkio@cox.net>
Subject: Re: Could we please make "cherry-pick" not add the message by default?
Date: Thu, 05 Oct 2006 17:35:34 -0700
Message-ID: <7v1wpm5lih.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610051711310.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 02:39:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVdgh-0007ji-Df
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 02:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWJFAfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 20:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWJFAfg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 20:35:36 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:25534 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751543AbWJFAff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 20:35:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006003535.HMZR18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 20:35:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wobd1V00T1kojtg0000000
	Thu, 05 Oct 2006 20:35:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051711310.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 5 Oct 2006 17:14:29 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28380>

Linus Torvalds <torvalds@osdl.org> writes:

> It appears that more and more people are finding "git cherry-pick", and we 
> now have a number of totally inane
>
> 	cherry picked from 1b16e7ac850969f38b375e511e3fa2f474a33867 commit
>
> messages in the kernel logs, because I don't want to just re-cherry-pick 
> them and edit peoples logs.
>
> Those messages not only make no grammatical sense (you'd say "commit X" 
> rather than "X commit"), but they have no point. The original commit is 
> not reachable and makes no sense any more, and that's actually likely to 
> always be the common case.
>
> So could we just (a) fix the message word order to make sense and (b) make 
> it only happen if people explicitly ask for it, rather than by default?

Let's do (c) never show it and make -r a no-op.
