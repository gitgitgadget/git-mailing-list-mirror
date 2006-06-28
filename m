From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick merge status updates.
Date: Wed, 28 Jun 2006 03:14:29 -0700
Message-ID: <7v4py537ui.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<1151471040.4940.17.camel@dv>
	<7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
	<1151489103.28036.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 12:14:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvX46-0001qh-I0
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 12:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423257AbWF1KOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 06:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWF1KOb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 06:14:31 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:18309 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932538AbWF1KOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 06:14:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628101430.FMWO8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 06:14:30 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1151489103.28036.6.camel@dv> (Pavel Roskin's message of "Wed, 28
	Jun 2006 06:05:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22800>

Pavel Roskin <proski@gnu.org> writes:

> I think my Perl 5.8.8 is "too new".  "man perlfunc" says about "use":
> ...
> I think the BEGIN block has priority over other statements.  My solution
> was to put the @INC change in the BEGIN block as well.

Actually I do use 5.8.8 and everything you quoted makes perfect
sense, -- in fact now I do not know *why* it did _not_ break for
me without the BEGIN {} block, especially I do not have any
PERL* environment variable to point at anywhere under $HOME.

Thanks for the fix.
