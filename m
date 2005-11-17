From: Junio C Hamano <junkio@cox.net>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 03:03:24 -0800
Message-ID: <7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:03:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EchY9-0000B3-N7
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKQLD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKQLD0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:03:26 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38872 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750747AbVKQLD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 06:03:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117110209.XTPY20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 06:02:09 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
	(Alex Riesen's message of "Thu, 17 Nov 2005 11:36:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12098>

Alex Riesen <raa.lkml@gmail.com> writes:

> As it turned out, not the git.c is guilty, but the missing
> NO_MMAP=YesPlease in Cygwin section. I had it for a long time and
> accidentally removed by the recent pull. BTW, I couldn't find nowhere
> on original branch. Was it never submitted?

Neither 'git-whatchanged Makefile' nor 'git-whatchanged
-SNO_MMAP Makefile' reports such on my end.  Do we need one?

Johannes said he tests on Cygwin as well, and I am sure there
are others with Cygin on the list.  Help us out here please?
