From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Mon, 12 Nov 2007 12:23:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121222310.4362@racer.site>
References: <20071111235819.GB7392@thunk.org> <1194829077-14320-1-git-send-email-tytso@mit.edu>
 <7vzlxk8apz.fsf@gitster.siamese.dyndns.org> <20071112062222.GA17462@thunk.org>
 <7vhcjr53hp.fsf@gitster.siamese.dyndns.org> <20071112102412.GA24803@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrYKn-00038n-Q3
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbXKLMXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 07:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758202AbXKLMXy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:23:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:41325 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753144AbXKLMXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 07:23:53 -0500
Received: (qmail invoked by alias); 12 Nov 2007 12:23:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 12 Nov 2007 13:23:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Qk9pUlymQb//w9b4IZmz+DyBtVVf/1bc4eYdYMx
	IdWqiFRjur7tYc
X-X-Sender: gene099@racer.site
In-Reply-To: <20071112102412.GA24803@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64609>

Hi,

On Mon, 12 Nov 2007, Mike Hommey wrote:

> On Sun, Nov 11, 2007 at 11:26:10PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > > My mental model for git newbies is that they would probably be pulling
> > > from upstream repositories (so I was tempted to remove git-init from
> > > the common commands list), but they would rarely be cherry-picking or
> > > reverting other people's changes.
> > 
> > I'd agree with that, but reverting and cherry-picking would also
> > be done on the commits the user builds on top of other people's
> > changes.
> 
> On the other hand, cherry-picking and reverting are just the same thing, 
> except one applies a reversed patch. Wouldn't it make sense to merge 
> these two in one command ?

Technically, they are.  That's why both of them live in builtin-revert.c.  
But conceptually, they are not.  At least _I_ found it hard at first, to 
accept that reverting a patch really was a reverse cherry-picking.

Ciao,
Dscho
