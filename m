From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Tue, 15 Nov 2005 16:17:44 -0800
Message-ID: <7vmzk5e993.fsf@assigned-by-dhcp.cox.net>
References: <20051115233125.3153B5BF76@nox.op5.se>
	<7vwtj9eaqm.fsf@assigned-by-dhcp.cox.net> <437A78FC.10608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 01:17:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAzl-0000t7-Of
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 01:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVKPARr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 19:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVKPARr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 19:17:47 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58870 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965099AbVKPARq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 19:17:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116001653.VVQR17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 19:16:53 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437A78FC.10608@op5.se> (Andreas Ericsson's message of "Wed, 16
	Nov 2005 01:10:36 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11976>

Andreas Ericsson <ae@op5.se> writes:

> Dunno, really. I suppose it does as it bypasses the shell with the 
> execve() call, unless windows or the cygwin stuff does some trickery to 
> find an .exe regardless.
>
> Is it ok if I send a separate patch for it, or would you rather have me 
> redo this one?

I'll take this as is and have Cygwin folks holler if it breaks
things for them ;-).  Thanks.
