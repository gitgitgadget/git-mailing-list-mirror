From: Junio C Hamano <junkio@cox.net>
Subject: Re: There you have it. Git.pm breaks pull.
Date: Sun, 02 Jul 2006 21:59:05 -0700
Message-ID: <7v1wt3uvvq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607030633120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64ifuwo7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 03 06:59:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxGWe-0008TJ-Eb
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 06:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWGCE7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 00:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWGCE7J
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 00:59:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9460 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751299AbWGCE7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 00:59:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703045906.NNMK12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 00:59:06 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7v64ifuwo7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 02 Jul 2006 21:42:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23155>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Can't locate Git.pm in @INC (@INC contains: 
>> /home/gene099/lib/perl5/site_perl/5.8.0/i586-linux-thread-multi 
>>...
> You need to set up your PERL5LIB appropriately, in addition to
> what you used to set: PATH and GIT_EXEC_PATH.  Something like
> this, perhaps:
>
>         PERL5LIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
>         GIT_EXEC_PATH=`pwd`
>         PATH=`pwd`:/usr/bin:/bin
>
>         export GIT_EXEC_PATH PATH PERL5LIB

... and I tested the above -- it works fine.

As we repeatedly discussed ever since we introduced
GIT_EXEC_PATH, running without installation is something
nonstandard and one would need to work a bit harder, like the
above, to make it work, but the good thing is it can be made to
work.
