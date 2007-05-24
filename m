From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 20:25:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705242023240.4648@racer.site>
References: <Pine.LNX.4.64.0705241039200.4648@racer.site> 
 <Pine.LNX.4.64.0705241230410.4648@racer.site>  <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
  <Pine.LNX.4.64.0705241315290.4648@racer.site> 
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com> 
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net> 
 <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org> 
 <20070524175519.GU942MdfPADPa@greensroom.kotnet.org> 
 <alpine.LFD.0.98.0705241105210.26602@woody.linux-foundation.org> 
 <7v7iqyxdp6.fsf@assigned-by-dhcp.cox.net> <8c5c35580705241213y64f8ec5eg1f1afbdf25413769@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 21:25:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIwC-0002ry-NZ
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbXEXTZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbXEXTZZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:25:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:35332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806AbXEXTZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:25:24 -0400
Received: (qmail invoked by alias); 24 May 2007 19:25:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 24 May 2007 21:25:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+27Ls+Hu22lLThLTY3zE5xgRBrbACww95jK6S5a/
	VTk92fPOxw+7GB
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580705241213y64f8ec5eg1f1afbdf25413769@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48296>

Hi,

On Thu, 24 May 2007, Lars Hjemli wrote:

> On 5/24/07, Junio C Hamano <junkio@cox.net> wrote:
> > While I disagree with some design decisions Sven's series made,
> > I am happy that the series is there for people to comment on.
> > It helps us identify the design issues by making the differences
> > of opinion people have on them stand out.
> > 
> 
> Possibly offtopic: I'm not so sure there should be any --submodules or
> similar options to clone/fetch/checkout/merge/diff etc.
> 
> What I think would be nice is some porcelain support to manually init,
> update and see the checked out version of selected subprojects, but as
> standalone commands.

Yes, a la git-remote. I'd be much happier with that, too, especially since 
I think that this can be a relatively small and easy-to-review script. I 
really was intimidated by the long patch series, also because I thought 
that it shouldn't be that much work on top of what Linus did.

Ciao,
Dscho

P.S.: Linus paid for his Caps Lock key, so he might as well use it.
