From: Junio C Hamano <junkio@cox.net>
Subject: Re: bisect help
Date: Tue, 27 Jun 2006 15:41:16 -0700
Message-ID: <7vu0666x2r.fsf@assigned-by-dhcp.cox.net>
References: <20060627201302.GA16658@bork.org>
	<7vy7vi70bm.fsf@assigned-by-dhcp.cox.net>
	<20060627220421.GA7234@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Hicks <mort@bork.org>
X-From: git-owner@vger.kernel.org Wed Jun 28 00:41:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvMFH-0006Dt-TT
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWF0WlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWF0WlU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:41:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8579 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422694AbWF0WlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 18:41:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627224117.BRJR554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 18:41:17 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060627220421.GA7234@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 27 Jun 2006 18:04:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22759>

Jeff King <peff@peff.net> writes:

> Since 'test' is a throwaway branch anyway, might it not make sense to
> clone master to test and then rebase satadev onto it? Thus you would end
> up with the linear history:
>   o---o---o---o---o---o---o test (satadev')
>   |           |
> 2.6.17      master
>
> You know that master works and satadev' doesn't, and the bisection is
> simple. After you find that bug, you can throw away the test branch.

I've considered suggesting it before looking at what is in
satadev.  It is merged up in the Linus head right now, so you
are talking about really _huge_ changes that are not yours and
with a lot of merges.

It usually is much easier to rebase your own code than other's.

BTW, I really hate MUA's that does Mail-Followup-To to somebody
else.  This message for example would not help Martin more than
it would help you, but your MUA somehow redirected it to him.
