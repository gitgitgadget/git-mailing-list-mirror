From: Jeff King <peff@peff.net>
Subject: Re: Bug/problem with 1.6.0 on UnixWare
Date: Thu, 21 Aug 2008 09:08:16 -0400
Message-ID: <20080821130816.GB22453@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com> <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com> <alpine.LNX.1.10.0808210610440.29396@xenau.zenez.com> <e2b179460808210541lfd7dcaeoea8554a2a76f8825@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Boyd Lynn Gerber <gerberb@zenez.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 15:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW9ur-0006V1-5i
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 15:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588AbYHUNIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 09:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756220AbYHUNIT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 09:08:19 -0400
Received: from peff.net ([208.65.91.99]:4539 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755722AbYHUNIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 09:08:19 -0400
Received: (qmail 5007 invoked by uid 111); 21 Aug 2008 13:08:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 09:08:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 09:08:16 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460808210541lfd7dcaeoea8554a2a76f8825@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93146>

On Thu, Aug 21, 2008 at 01:41:07PM +0100, Mike Ralphson wrote:

> If it's possible, you might want to look at automatically building and
> running the git testsuite on some or all of your SCO etc platforms.
> You're very welcome to push tags describing the state of the build and
> tests to http://repo.or.cz/w/git/gitbuild.git - there's a few scripts
> there in a side branch.

BTW, on my todo list is pushing my tags there. I am building FreeBSD
nightly, and I plan to add Solaris 2.8. I just haven't gotten around to
making the build work yet...:)

> Personally, I'd like it if Junio could check to see if the 'satellite'
> platforms are happily building and passing the last rc before he tags
> a final release (with no additional code changes in it!), but that may
> be too much of the tail wagging the dog.

I think his procedure is more reactive. He tags 1.6.0-rc*, and he
expects us to complain to him if it is broken. The real deficiency here
is that the broken platforms were not tested.

-Peff
