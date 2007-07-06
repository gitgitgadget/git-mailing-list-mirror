From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 13:49:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061348050.4093@racer.site>
References: <20070705232210.GR3492@stusta.de> <Pine.LNX.4.64.0707060217460.9789@racer.site>
 <20070706014222.GK3492@stusta.de> <Pine.LNX.4.64.0707060243110.4093@racer.site>
 <20070706022629.GL3492@stusta.de> <Pine.LNX.4.64.0707060413190.4093@racer.site>
 <alpine.LFD.0.98.0707052108070.9434@woody.linux-foundation.org>
 <7vd4z6gkbk.fsf@assigned-by-dhcp.cox.net> <20070706121441.GM3492@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:57:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6nMs-0004Ym-IN
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760891AbXGFM5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760738AbXGFM5A
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:57:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:42194 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760702AbXGFM47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:56:59 -0400
Received: (qmail invoked by alias); 06 Jul 2007 12:56:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 06 Jul 2007 14:56:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pOrNvQb5pVoVdHsS4/q7nCprPt7wjMLx5015nDb
	Xu5cUWxLU6IvIO
X-X-Sender: gene099@racer.site
In-Reply-To: <20070706121441.GM3492@stusta.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51749>

Hi,

On Fri, 6 Jul 2007, Adrian Bunk wrote:

> On Thu, Jul 05, 2007 at 10:41:51PM -0700, Junio C Hamano wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> >...
> > > Adrian has a point in that if there are lines to be deleted, that in 
> > > itself is context, and then the strict behaviour of "git-apply" is 
> > > arguably unnecessaily strict.
> > 
> > Not really.  That is true, unless you have two identical instances of 
> > the group of lines being deleted, in which case you cannot safely tell 
> > which instance is to be removed.
> >...
> 
> The interesting thing is that you can never safely tell it for any 
> amount of context - I've seen patches with three lines of context being 
> applied at the wrong place simply because there were several matching 
> contexts.

Yes, that is right. You can never safely tell. But now you want to allow 
even less context by default. In which you can even "more neverer" safely 
tell. That is why I am disagreeing with that change.

Ciao,
Dscho
