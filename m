From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 00:56:24 -0700
Message-ID: <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
	<20060625184757.f8273820.tihirvon@gmail.com>
	<E1FuX8l-0001H5-2z@moooo.ath.cx>
	<Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1FueYh-0004XE-Fg@moooo.ath.cx>
	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>
	<7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:56:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDra-0000BM-Vd
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWF3H40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWF3H40
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:56:26 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36841 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751392AbWF3H4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:56:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630075625.TLXP22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 03:56:25 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FwDiI-0007Xp-2s@moooo.ath.cx> (Matthias Lederhofer's message
	of "Fri, 30 Jun 2006 09:46:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22970>

Matthias Lederhofer <matled@gmx.net> writes:

> (Junio: please reply to this one, forgot the Cc in the first one :/)

Huh?

>> I personally feel FOO should not even exist.  An option that
>> covers the entire expression to make operator precedence in it
>> sounds quite evil.  
>> 
>> I would say make --and bind tighter than --or and use parentheses as
>> needed.
> Ok, perhaps changing operator precedence is a bit much. What do you
> think of that then:
> ...

I see you are trying hard to think of a way to justify your
original prefix "--and" (or --FOO) implementation, but I simply
do not see much point in that.  I doubt changing the default
operator from --or to --and is less confusing than changing the
precedence for the users, so you would hear the same "I
personally feel FOO should not even exist" objection from me.
