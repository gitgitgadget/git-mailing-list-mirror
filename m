From: Junio C Hamano <junkio@cox.net>
Subject: Re: My Embarrasingly Stupid Git question....(*)
Date: Wed, 31 Aug 2005 12:58:47 -0700
Message-ID: <7vacixanew.fsf@assigned-by-dhcp.cox.net>
References: <1125506707.13577.29.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 22:02:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAYjU-000616-7S
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 21:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVHaT6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVHaT6t
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 15:58:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31136 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751027AbVHaT6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 15:58:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050831195847.GMVA6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 Aug 2005 15:58:47 -0400
To: Jon Loeliger <jdl@freescale.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7984>

Jon Loeliger <jdl@freescale.com> writes:

> (*) -- I knew I didn't need to bother the list with this
>     question.  And that as soon as I asked for external help,
>     the answer would become clear. Sorry to have bothered you.

That's OK.  As I stated before, the primary motivation that got
me involved in git was to help people who do Linux kernel, so
any question regarding the Linus kernel tree extracted from a
copy of his git repository is welcome here, at least to me.

I do not know Cogito very well.  I keep the latest Cogito source
around all the time so that I can figure things out whenever
need arises by reading it.  Most of the time, I would not
offhand know answers to questions like "what does cg-rm do and
what's the difference between it and 'cvs rm'".

Using the core GIT tools only, the sequence of what you did
would have been:

------------------------------------------------
$ git clone <url> <dir> && cd <dir>
$ git checkout -b jdl master
$ rm include/asm-ppc/sockios.h
$ rm include/asm-ppc/socket.h
$ rm include/asm-ppc64/sockios.h
$ rm include/asm-ppc64/socket.h
$ git add include/asm-powerpc/sockios.h
$ git add include/asm-powerpc/socket.h
$ git commit -a -s
------------------------------------------------
