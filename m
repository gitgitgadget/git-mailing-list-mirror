From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 11:39:29 -0700
Message-ID: <7vmzbvrela.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	<Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060627223249.GA8177@steel.home>
	<Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com>
	<Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 20:40:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1QX-0002KT-GB
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWF2Sjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWF2Sjc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:39:32 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50309 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751257AbWF2Sjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 14:39:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629183930.QAZW12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 14:39:30 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 29 Jun 2006 18:14:48 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22886>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My point being: it makes no sense to split off get_merge_bases() if nobody 
> uses it except for git-merge-base.

I do not think that is a good reasoning.  If something is
reusable (or you made it reusable) and you are planning to reuse
it later, splitting it out without changing anything else to
make sure the split is correct is a seemingly small but a very
important step.
