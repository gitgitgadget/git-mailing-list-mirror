From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Some git performance measurements..
Date: Fri, 7 Dec 2007 18:37:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712071816100.27959@racer.site>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
  <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> 
 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org> 
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>  <finmvm$da8$1@ger.gmane.org>
  <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org> 
 <alpine.LFD.0.99999.0711292131350.9605@xanadu.home> 
 <B161871F-E812-44B4-A699-44341B5783D3@zib.de> 
 <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com> 
 <Pine.LNX.4.64.0712071348100.27959@racer.site>
 <e2b179460712070809r4127dc0br8dc20f55b1076501@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 19:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0i63-00009A-2Q
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 19:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbXLGSiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 13:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbXLGSiI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 13:38:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:33577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754129AbXLGSiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 13:38:06 -0500
Received: (qmail invoked by alias); 07 Dec 2007 18:38:03 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp006) with SMTP; 07 Dec 2007 19:38:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0ETQXpjK0LWEfaFNq5BkVqiY0fbGuHTUo63Z89c
	hAj9mP+xXHomdI
X-X-Sender: gene099@racer.site
In-Reply-To: <e2b179460712070809r4127dc0br8dc20f55b1076501@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67439>

Hi,

On Fri, 7 Dec 2007, Mike Ralphson wrote:

> On Dec 7, 2007 1:49 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 7 Dec 2007, Mike Ralphson wrote:
> >
> > > I benchmarked 3 alternative qsorts, qsortG [2] was the fastest on my 
> > > system but has funky licensing, the NetBSD qsort was middle-range 
> > > and the glibc one the slowest of the three (but that could be due to 
> > > it being tuned for a "Sun 4/260"). All of them show over 100x speed 
> > > improvements on a git-status of my main repo (104s -> ~0.7s)
> >
> > How is "You may use it in anything you like;" funky licensing?  It is 
> > effectively public domain.
> 
> I did ask what the git licensing policy was (GPL2 or GPL2-compatible) 
> but got no response. The author's wishes state:
> 
>  * This code may be reproduced freely provided
> [long list]

Okay, sorry, I did not bother reading further when I read "You may use it 
in anything you like;".

But if the author did not respond, it might be a better idea to just 
reimplement it.

Ciao,
Dscho
