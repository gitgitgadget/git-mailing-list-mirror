From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix linking for not-so-clever linkers.
Date: Mon, 10 Jul 2006 14:25:05 -0700
Message-ID: <7v64i5b1am.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607101340080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 23:25:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03Fg-0004tm-Ia
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWGJVZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWGJVZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:25:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17585 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965237AbWGJVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 17:25:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710212506.LHVF19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 17:25:06 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607101340080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 10 Jul 2006 13:40:44 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23654>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On one of my systems, the linker is not intelligent enough to link with
> pager.o (in libgit.a) when only the variable pager_in_use is needed. The
> consequence is that the linker complains about an undefined
> variable.

I do not understand this quite yet -- which executable is your
linker building when it does this?

Maybe we need ranlib?
