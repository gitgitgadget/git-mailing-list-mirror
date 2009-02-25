From: Jeff King <peff@peff.net>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Wed, 25 Feb 2009 04:03:48 -0500
Message-ID: <20090225090347.GB15919@coredump.intra.peff.net>
References: <20090223000840.GA20392@coredump.intra.peff.net> <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl> <20090223065615.GA24807@coredump.intra.peff.net> <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl> <20090223071056.GA29241@coredump.intra.peff.net> <59288.77.61.241.211.1235374197.squirrel@hupie.xs4all.nl> <20090224061134.GF4615@coredump.intra.peff.net> <14283.77.61.241.211.1235467512.squirrel@hupie.xs4all.nl> <20090225065624.GA1678@sigill.intra.peff.net> <45197.77.61.241.211.1235548980.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFhj-0001Ho-2H
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbZBYJD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756713AbZBYJDz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:03:55 -0500
Received: from peff.net ([208.65.91.99]:41896 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbZBYJDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:03:52 -0500
Received: (qmail 24854 invoked by uid 107); 25 Feb 2009 09:04:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Feb 2009 04:04:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2009 04:03:48 -0500
Content-Disposition: inline
In-Reply-To: <45197.77.61.241.211.1235548980.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111416>

On Wed, Feb 25, 2009 at 09:03:00AM +0100, Ferry Huberts (Pelagic) wrote:

> > Also, are settings going to be unset after the first import? If so, then
> > further incremental imports will fail as described in your second case.
> > But if not, then safecrlf is turned off for that repo, even for
> > non-cvsimport commands, overriding anything in the user's ~/.gitconfig.
> > For somebody doing a one-shot import, they are paying that price without
> > any benefit.
> >
> this actually makes sense to me. I was only thinking about the continuous
> import use-case. In that light it would be better to just complain and die
> in the script. I guess I'll just implement that in the patch then.

OK, that sounds reasonable to me.

-Peff
