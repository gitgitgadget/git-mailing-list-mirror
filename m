From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 28 Nov 2007 12:22:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281221090.27959@racer.site>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071127020842.GN14735@spearce.org> <Pine.LNX.4.64.0711271127440.27959@racer.site>
 <fii9ta$b2j$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxLwo-0005VZ-7E
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbXK1MXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbXK1MXB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:23:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:35778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751907AbXK1MXA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:23:00 -0500
Received: (qmail invoked by alias); 28 Nov 2007 12:22:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 28 Nov 2007 13:22:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UuUU8aVOUmaugl5g04Alzh8T8//88ve7SgQTdET
	NDWQPjrBJwqXqB
X-X-Sender: gene099@racer.site
In-Reply-To: <fii9ta$b2j$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66301>

Hi,

On Wed, 28 Nov 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
> 
> >> I think this should be prefixed by fast-import patch to teach it 
> >> something like "encoding N" as a subcommand of commit, so that you 
> >> can feed data in a non UTF-8 encoding and get it to include the 
> >> proper encoding header in the commit object it creates.  That way a 
> >> pipeline like the above really does create a duplicate repository, 
> >> with the same commit SHA-1s, even if the commits weren't in UTF-8.
> > 
> > IMHO it's not worth that hassle.  People who want to use fast-import 
> > usually want something fast which works, and not bother with 
> > specifying encodings.
> 
> Well, when I am converting some repository which uses legacy encoding 
> (not utf-8), I'd like to use this git feature of specifying encoding; 
> actually, to be generic, it could be any header which would be added to 
> all created commit objects.
> 
> Yes, I could reencode commit messages...

Right.

> P.S. One nice use of proposed (at one time) 'note' header would be to 
> save revision identifier from the version control system you import (CVS 
> revision number, Subversion sequential revision number, etc.).

Why not put it into the commit message?  It is not information that git 
uses, so it does not belong into the commit header IMO.  (IIRC I made the 
same point already at the time 'note' was discussed.)

Ciao,
Dscho
