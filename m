From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Fri, 12 Oct 2007 13:51:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710121351200.25221@racer.site>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>
 <470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz>
 <470DCC76.7070809@viscovery.net> <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv>
 <470DD3B8.1080809@viscovery.net> <85k5pts796.fsf@lola.goethe.zz>
 <E43846E3-4F42-4B3A-BA5F-1A21FE70C3FB@wincent.com> <Pine.LNX.4.64.0710121235230.25221@racer.site>
 <A7970E82-92E0-4267-AF79-D4ABDB21F0D0@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 14:58:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgJzx-0004J8-Ol
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 14:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbXJLMwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 08:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbXJLMwB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 08:52:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:47955 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbXJLMwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 08:52:00 -0400
Received: (qmail invoked by alias); 12 Oct 2007 12:51:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 12 Oct 2007 14:51:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dtkcSJand5g6Ss/e9wRWcd0vyayPU74f3kmIIAf
	TdqystUV68omv3
X-X-Sender: gene099@racer.site
In-Reply-To: <A7970E82-92E0-4267-AF79-D4ABDB21F0D0@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60686>

Hi,

On Fri, 12 Oct 2007, Wincent Colaiuta wrote:

> El 12/10/2007, a las 13:37, Johannes Schindelin escribi?:
> 
> > On Fri, 12 Oct 2007, Wincent Colaiuta wrote:
> > 
> > > El 11/10/2007, a las 22:53, David Kastrup escribi?:
> > > 
> > > > Johannes Sixt <j.sixt@viscovery.net> writes:
> > > > 
> > > > > Jonathan del Strother schrieb:
> > > > > > How are you going to test that git works on paths with spaces if
> > > > > > the
> > > > > > test suite doesn't run there?
> > > > > 
> > > > > By writing a specific test?
> > > > 
> > > > This is going to be much less thorough.  And it does no harm if the
> > > > test scripts demonstrate defensive programming.
> > > 
> > > +1: especially in this case, where it really is "defensive" and not
> > > "paranoiac".
> > 
> > I am all for it, _iff_ the guilty parties (and by that, I mean _you_) do
> > it and keep maintaining it.  See?  Discussion closed already.
> 
> How am *I* the guilty party? I'm merely endorsing David's comment that a 
> modicum of defensive programming isn't a bad thing; an eminently 
> reasonable position which is somewhat difficult to argue against.

All I'm saying: let patches speak.  Talk is cheap.

Ciao,
Dscho
