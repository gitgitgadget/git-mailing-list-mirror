From: Jeff King <peff@peff.net>
Subject: Re: Bug/problem with 1.6.0 on UnixWare
Date: Thu, 21 Aug 2008 16:45:22 -0400
Message-ID: <20080821204522.GA29361@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com> <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com> <alpine.LNX.1.10.0808210610440.29396@xenau.zenez.com> <e2b179460808210541lfd7dcaeoea8554a2a76f8825@mail.gmail.com> <20080821130816.GB22453@coredump.intra.peff.net> <e2b179460808210738y9ca6e3fka113128fb1e6e024@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Boyd Lynn Gerber <gerberb@zenez.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWH3E-0006eo-CT
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbYHUUpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYHUUpZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:45:25 -0400
Received: from peff.net ([208.65.91.99]:2943 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbYHUUpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:45:25 -0400
Received: (qmail 9523 invoked by uid 111); 21 Aug 2008 20:45:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 16:45:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 16:45:22 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460808210738y9ca6e3fka113128fb1e6e024@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93203>

On Thu, Aug 21, 2008 at 03:38:32PM +0100, Mike Ralphson wrote:

> Great stuff. Though I think it might provoke some patches to improve
> the display of multiple long tag names for the same commit in gitweb!

Heh. Can you pass along the final version of your build script? I want
to make sure we are doing the same things.

> Granted, but Junio seems to do releases at the weekend, and sometimes
> they aren't the same content as the previous rc. Though I build and
> test 7 days a week, I'd rarely look at the test results over the
> weekend. And I was on vacation when the last minute AIX breakage went
> into 1.5.6 - not that I would necessarily have been able to fix that
> one.

Yes, in theory, last minute code changes could cause a portability
breakage. However, any changes from the last -rc to the release version
tend to be extremely conservative (as judged by Junio), so in practice
I don't think it happens. For example, I think this git-shell bug made
it into master over a month before release.

-Peff
