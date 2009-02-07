From: Jeff King <peff@peff.net>
Subject: Re: How to find out which gitignore blocks my git-add
Date: Sat, 7 Feb 2009 08:31:08 -0500
Message-ID: <20090207133108.GA20253@coredump.intra.peff.net>
References: <498C0525.5040100@gonsolo.de> <20090206193359.GF19494@coredump.intra.peff.net> <slrngopp7n.his.sitaramc@sitaramc.homelinux.net> <20090207064221.GA14856@coredump.intra.peff.net> <slrngor0hb.cq.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 14:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVnIk-0005Za-IQ
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 14:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbZBGNbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 08:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbZBGNbL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 08:31:11 -0500
Received: from peff.net ([208.65.91.99]:60166 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902AbZBGNbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 08:31:10 -0500
Received: (qmail 21049 invoked by uid 107); 7 Feb 2009 13:31:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 08:31:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 08:31:08 -0500
Content-Disposition: inline
In-Reply-To: <slrngor0hb.cq.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108849>

On Sat, Feb 07, 2009 at 12:44:27PM +0000, Sitaram Chamarty wrote:

> On 2009-02-07, Jeff King <peff@peff.net> wrote:
> > A toy patch series follows; see 2/2 for a description of why it doesn't
> > work like you might hope. I'm not too interested in trying to deal with
> > the refactoring that would be required to do it right. But maybe
> > somebody else is.
> 
> I was thinking it could simply be a separate utility in
> contrib for starters, perhaps not even written in C.  I
> don't mind volunteering to write one in shell+the usual
> toolchain (and I'll test it on msysgit too, because I have
> Windows users).  My C days are a bit behind me, sadly...

Sure, that might be an easy way to start. But in the long term,
having a separate implementation handling .gitignore parsing and
rules may diverge from what git is doing. OTOH, in theory those
rules are pretty well set in stone since users are depending on
them.

-Peff
