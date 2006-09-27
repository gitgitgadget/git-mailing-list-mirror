From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] update a few Porcelain-ish for ref lock safety.
Date: Wed, 27 Sep 2006 00:25:45 -0700
Message-ID: <7vbqp1g492.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<200609231322.30214.chriscool@tuxfamily.org>
	<7veju2nthl.fsf@assigned-by-dhcp.cox.net>
	<200609240645.54467.chriscool@tuxfamily.org>
	<7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
	<7vu02uqzaj.fsf@assigned-by-dhcp.cox.net>
	<45196CAB.6030903@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 09:26:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSTni-0007id-Nq
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 09:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965423AbWI0HZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 03:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965422AbWI0HZs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 03:25:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:63630 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965421AbWI0HZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 03:25:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927072546.YYUN6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 03:25:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TKRi1V00H1kojtg0000000
	Wed, 27 Sep 2006 03:25:43 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45196CAB.6030903@shadowen.org> (Andy Whitcroft's message of
	"Tue, 26 Sep 2006 19:08:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27885>

Andy Whitcroft <apw@shadowen.org> writes:

>> +prev=0000000000000000000000000000000000000000
>
> It seems a little odd to need to use such a large 'none' thing.  Will
> linus' updates start returning this when there is no tag?  If so then it
> makes sense.  Else perhaps it would be nice to have a short cut for it.
>  Such as 'none'.

True.  It probably is better to accept something shorter, like
an empty string, or token "none".  But this is a plumbing
command, and I was not too concerned about having to say 40 "0"
in the Porcelain scripts.
