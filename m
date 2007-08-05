From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix install-doc-quick target
Date: Sun, 05 Aug 2007 10:54:08 -0700
Message-ID: <7vzm15eukf.fsf@assigned-by-dhcp.cox.net>
References: <46B49617.3070402@gmail.com>
	<Pine.LNX.4.64.0708041637450.14781@racer.site>
	<46B4A2B0.9080208@gmail.com>
	<Pine.LNX.4.64.0708041704040.14781@racer.site>
	<46B4A5FD.3070107@gmail.com>
	<Pine.LNX.4.64.0708041719490.14781@racer.site>
	<46B4BDCF.9060809@gmail.com>
	<Pine.LNX.4.64.0708042229130.14781@racer.site>
	<46B4F91D.1070907@lsrfire.ath.cx>
	<7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708051344430.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 19:54:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHkIz-0006Mk-L2
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbXHERyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 13:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753824AbXHERyL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 13:54:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33883 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbXHERyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 13:54:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805175409.VRAT23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 13:54:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YHu91X0031kojtg0000000; Sun, 05 Aug 2007 13:54:09 -0400
In-Reply-To: <Pine.LNX.4.64.0708051344430.14781@racer.site> (Johannes
	Schindelin's message of "Sun, 5 Aug 2007 14:12:53 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55048>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I do not like the behaviour "be stupid and assume cwd to be the working 
> tree root, if GIT_DIR is set and GIT_WORK_TREE is not".
>
> It bears _all_ kind of stupid connotations.  Just imagine what would 
> happen with "git --git-dir=. add .".
>
> IMHO the new behaviour is _better_, since you can not shoot yourself in 
> the foot so easily.  Being able to safeguard against doing a work tree 
> operation inside the git directory is a direct and elegant consequence of 
> defaulting to $GIT_DIR/.. in case $GIT_DIR ends in "/.git", and no work 
> tree if $GIT_DIR does _not_ end in "/.git".
>
> The semantics "if GIT_DIR is set, just assume the cwd to be the work tree 
> root unilaterally" is _broken_ as far as I am concerned.

I am not disputing that.  I was just pointing out that this is a
change in semantics and we need to advertise it as such, and
more importantly, advise people how to adjust to the new (and
improved) world order.
