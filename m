From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git.xs merge status
Date: Fri, 30 Jun 2006 00:18:21 -0700
Message-ID: <7vlkrfkt6q.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<7vmzbvmny4.fsf_-_@assigned-by-dhcp.cox.net>
	<1151644101.10496.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hpa@kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:18:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDGz-0002ZQ-1P
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWF3HS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWF3HS1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:18:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31708 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751225AbWF3HSW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:18:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630071822.XDPU554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 03:18:22 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1151644101.10496.22.camel@dv> (Pavel Roskin's message of "Fri,
	30 Jun 2006 01:08:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22961>

Pavel Roskin <proski@gnu.org> writes:

> I guess all this perl stuff should be in a separate module perl-Git to
> comply with Red Hat conventions.  This would make git-core depend on
> perl-Git, but it's OK.
>
> Error.pm is already provided by perl-Error.  If we require perl(Error)
> for building, it won't be installed.  Actually, probing for Error.pm is
> incorrect, so I'm fixing it.
>
> Git.bs, .packlist and perllocal.pod should be removed - that's what
> other Perl packages do.  Red Hat packages use INSTALLDIRS=vendor so that
> "site_perl" becomes "vendor_perl".
>
> While hacking that, I have wound that "--without doc" is broken in pu,
> so I'm fixing it as well.  The patches will be sent shortly.

Thanks.

The kernel.org machine I am using for testing does not seem to
have perl-Error installed, and I suspect Pasky arranged to ship
our own Error.pm for people building git from source because the
package is not so widely installed.  I guess I should ask the
admins there before I can build perl-Git RPMs for release. 

I am doing this preparation not for the upcoming 1.4.1 but later
than that -- perhaps way later than that -- so there is no rush.
