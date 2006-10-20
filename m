From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Fri, 20 Oct 2006 00:52:34 -0700
Message-ID: <7vhcxzpgot.fsf@assigned-by-dhcp.cox.net>
References: <87vemgn1s2.fsf@rho.meyering.net>
	<7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
	<878xjckw7x.fsf@rho.meyering.net>
	<7vk62wruum.fsf@assigned-by-dhcp.cox.net>
	<87fydkj8q1.fsf@penguin.cs.ucla.edu>
	<7vr6x4q9b6.fsf@assigned-by-dhcp.cox.net>
	<87pscnj29t.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 09:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GapBH-0000Hx-Qk
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 09:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992553AbWJTHwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 03:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992556AbWJTHwg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 03:52:36 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30354 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S2992553AbWJTHwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 03:52:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020075235.VSTJ22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 03:52:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cXsL1V0081kojtg0000000
	Fri, 20 Oct 2006 03:52:21 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29413>

Paul Eggert <eggert@CS.UCLA.EDU> writes:

> Since git uses diff -u format, it would make sense to git to work with
> the upcoming POSIX spec for diff -u, either by adjusting the spec or
> by adjusting git.

It is not quite fair to talk as if I still have a choice.

Apparently a version of GNU diff that generates new format is
already in the wild (I've received such a patch which was where
this thread started).  Whether I like your change or not, the
damage is already done and its output needs to be dealt with, so
that we do not break users.

Coding a workaround is not a big deal; the change is simple and
trivial.  It's just I am somewhat unhappy, having to do a .1
release immediately after v1.4.3 which took about two months to
stabilize, although that's not your fault.  Sorry for venting.
