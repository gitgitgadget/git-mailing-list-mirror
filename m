From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix linking for not-so-clever linkers.
Date: Mon, 10 Jul 2006 14:48:44 -0700
Message-ID: <7vlkr19lmr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607101340080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64i5b1am.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607101429460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 10 23:48:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03cX-0000Z3-TR
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWGJVsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWGJVsr
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:48:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36029 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965048AbWGJVsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 17:48:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710214845.USTR8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 17:48:45 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607101429460.5623@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 10 Jul 2006 14:34:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23660>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 10 Jul 2006, Junio C Hamano wrote:
>>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On one of my systems, the linker is not intelligent enough to link with
>> > pager.o (in libgit.a) when only the variable pager_in_use is needed. The
>> > consequence is that the linker complains about an undefined
>> > variable.
>> 
>> I do not understand this quite yet -- which executable is your
>> linker building when it does this?

>> Maybe we need ranlib?
>
> Shouldn't be needed, since we use "$(AR) rcs",...
> ... After all, that was the 
> whole reason environment.c ended up existing in the first place..

Understood and agreed to everything you said.

But I still wonder why/how it happens in Johannes's
environment...
