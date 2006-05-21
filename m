From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add builtin "git rm" command
Date: Sun, 21 May 2006 01:20:08 -0700
Message-ID: <7vpsi7zt53.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605191607010.10823@g5.osdl.org>
	<Pine.LNX.4.64.0605191607580.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 10:20:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhjAc-0006lG-EP
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWEUIUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 04:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWEUIUL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:20:11 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48550 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751478AbWEUIUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 04:20:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521082009.LUDZ19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 04:20:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605191607580.10823@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 19 May 2006 16:19:34 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20437>

Linus Torvalds <torvalds@osdl.org> writes:

> I think the new behaviour is strictly an improvement, but perhaps more 
> importantly, it is _different_. As a special case, the semantics are 
> identical for the single-file case (which is the only one our test-suite 
> seems to test).
>
> The other question is what to do with leading directories. The old "git 
> rm" script didn't do anything, which is somewhat inconsistent. This one 
> will actually clean up directories that have become empty as a result of 
> removing the last file, but maybe we want to have a flag to decide the 
> behaviour?

I too think these are improvements.  Thanks for the patch.

BTW, this needed another "evil merge" into "next", so this time
I made a separate evil merge branch that I speculated as a
possibly better alternative approach in an earlier message.
