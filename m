From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 9 Feb 2009 23:30:44 +0100
Message-ID: <20090209223044.GB27232@m62s10.vlinux.de>
References: <20090205204436.GA6072@diku.dk> <20090209220750.GA27232@m62s10.vlinux.de> <20090209222236.GA4166@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeew-00046Z-9E
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbZBIW34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbZBIW3z
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:29:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:52762 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752643AbZBIW3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:29:55 -0500
Received: (qmail invoked by alias); 09 Feb 2009 22:29:53 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp060) with SMTP; 09 Feb 2009 23:29:53 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+77xF8dK67jwFKaSY2+P0FQBlWAzCqWY7YWKSBSy
	Bpp6P6SpyOZgKA
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 9F10119950; Mon,  9 Feb 2009 23:30:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090209222236.GA4166@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109151>

On Mon, Feb 09, 2009 at 05:22:36PM -0500, Jeff King wrote:
> On Mon, Feb 09, 2009 at 11:07:50PM +0100, Peter Baumann wrote:
> 
> > Now I have a little UI glitch, which might be solved already. If im
> > browsing through a lot of commits, I'd like to have a way to advance to
> > tne next/previous commit while also showing the diff like in the pictore
> > below. Right now I alwasy press 'q' to leave the diff view, select
> > commit C and press return to show me the diff. Wouldn't it be nice to
> > have a way to advance to the next diff without leaving the diff window?
> > 
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   |  commit A
> >   | >commit B
> >   |  commit C
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   | diff --git a/tig.c b/tig.c
> >   | index aec50bc..2dd0ef6 100644
> >   | --- a/tig.c
> >   | +++ b/tig.c
> 
> Don't the up and down arrows switch the commit (updating the diff pane
> as appropriate), and PgUp/PgDown scroll the diff window (I don't know
> the actual function names, but you should be able to even rebind these
> in your tigrc if you want).
> 

Damn. I'm so used to the vi keybindings pressing j/k to move down/up
that I didn't check the cursor keys.

Sorry for the noise,
Peter
