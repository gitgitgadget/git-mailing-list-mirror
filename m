From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sun, 4 Nov 2007 13:13:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041313020.4362@racer.site>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
 <20071104045800.GB12359@segfault.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IofJQ-00058Z-DE
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 14:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbXKDNOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 08:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbXKDNOd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 08:14:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:46989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755150AbXKDNOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 08:14:32 -0500
Received: (qmail invoked by alias); 04 Nov 2007 13:14:30 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp045) with SMTP; 04 Nov 2007 14:14:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19w9e4XjZlwIQ+Lu2PkqntXJt79oVlaFru6qjgBGE
	HVZI5OvlU7gzlk
X-X-Sender: gene099@racer.site
In-Reply-To: <20071104045800.GB12359@segfault.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63397>

Hi,

On Sun, 4 Nov 2007, Jeff King wrote:

> On Sat, Nov 03, 2007 at 01:32:48AM -0400, Nicolas Pitre wrote:
> 
> > This makes the fetch output much more terse and prettier on a 80 column 
> > display, based on a consensus reached on the mailing list.  Here's an 
> > example output:
> 
> Thank you for this; it was at the end of a very long todo list for me.
> 
> > Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
> > Resolving deltas: 100% (4604/4604), done.
> > From git://git.kernel.org/pub/scm/git/git
> >  ! [rejected]        html -> origin/html  (non fast forward)
> >    136e631..f45e867  maint -> origin/maint  (fast forward)
> >    9850e2e..44dd7e0  man -> origin/man  (fast forward)
> >    3e4bb08..e3d6d56  master -> origin/master  (fast forward)
> >    fa3665c..536f64a  next -> origin/next  (fast forward)
> >  + 4f6d9d6...768326f pu -> origin/pu  (forced update)
> >  * [new branch]      todo -> origin/todo
> 
> One nice thing about this format is that it works equally well for
> "push" (changing "From" to "To" and reversing the order of the
> branches). Comments?

I would like that, too.

Ciao,
Dscho
