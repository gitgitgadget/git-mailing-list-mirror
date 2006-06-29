From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 13:58:02 -0700
Message-ID: <7vr717ptlx.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	<Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060627223249.GA8177@steel.home>
	<Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com>
	<Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzbvrela.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606292050380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 22:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw3aY-0001dz-1y
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWF2U6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWF2U6H
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:58:07 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39122 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932543AbWF2U6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:58:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629205803.VZGV16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 16:58:03 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606292050380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 29 Jun 2006 21:06:56 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22904>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So, a few tests later, I am pretty sure that my patches do not break 
> git-merge-base. I'll prepare another patch series which builds-in 
> merge-base.

I'll take your two patches to refactor merge-base and to move
the bulk of the code to commit.c for now.  Updated "next" coming
shortly.
