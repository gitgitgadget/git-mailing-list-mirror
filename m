From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 15:09:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707251505420.14781@racer.site>
References: <46A5B5F5.6000202@trolltech.com> <46A6F21D.2010306@trolltech.com>
 <Pine.LNX.4.64.0707251024390.14781@racer.site> <200707251205.48235.andyparkins@gmail.com>
 <46A73DB6.4090007@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDhYx-0004SG-Dm
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 16:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760614AbXGYOJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 10:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbXGYOJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 10:09:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:37264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932336AbXGYOJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 10:09:25 -0400
Received: (qmail invoked by alias); 25 Jul 2007 14:09:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 25 Jul 2007 16:09:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jKkhwgy1jPoEESZifMNUeRPTHxUTwl43WV4FEMN
	pyfsM+EW6a6s4C
X-X-Sender: gene099@racer.site
In-Reply-To: <46A73DB6.4090007@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53692>

Hi,

On Wed, 25 Jul 2007, Marius Storm-Olsen wrote:

> Andy Parkins said the following on 25.07.2007 13:05:
> > On Wednesday 2007 July 25, Johannes Schindelin wrote:
> > 
> > > So this leaves me with the question: do Windows users really want
> > > a proper native Windows support for Git?  If the answer is yes,
> > > why don't they _do_ (as in "not talk") something about it?
> > 
> > I don't disagree with you at all - it is completely ridiculous for
> > Windows users to moan about lack of Windows support without
> > contributing any help. However, I think there is a good reason.
> > 
> > I think it's a chicken and egg problem.  The only reason I started
> > making (small) contributions to git was because I was using it
> > already.  I didn't set out with the goal "to improve git"; I set
> > out looking for a DVCS. Luckily for me, I use Linux so git worked
> > pretty well for me straight away.
> > 
> > The same is not true for Windows users.  Even if we ignore the fact
> > that Windows users are notoriously less open-source savvy; it's
> > unlikely that we'll get any Windows contributions until there are
> > some threshold number of developers using git on Windows.
> > 
> > Open-source is all about scratching an itch, I can't see how
> > Windows developers can get a gitch to scratch without being users
> > of git first.  On the positive side though, there surely must come
> > a point when the Windows port is "good enough" that it will start
> > to gather users and hence developers.  Until then, I suppose it's
> > just a matter of shouting "patch" every time a windows user asks
> > for a feature :-)
> 
> Hi Andy,
> 
> Your mail is refreshingly spot on. I agree fully with what you say.
> I will try to do my part to get Git to this 'threshold', so we can get a
> proper Windows community behind it too. (It's just a matter of time and
> resources, which I hope we clear up soon)
> My first roadmap item will be to get a fully native compile of the built-in
> code. If we at least have a Git built with native tools, I think we'll have a
> lot more people wanting(/able?) to contribute.

Well, why don't people come here then, say "I am willing to test whatever 
you throw at me, and contribute the installer"?  Huh?

I once (AGAIN!) extend this offer to _anybody_.  I'll make a zip of 
everything you need, I'll fix bugs as you report them,  I'll do plenty of 
stuff.

But you have to give me an INCENTIVE!

(I am usually not such a shouter, but underlining seems not to help here.  
As can be seen by the infamous "When can I expect" mail.)

> AFAIK the MinGW port is cross-compiled on Linux, and can be hard to set 
> up on Windows. The required MinGW packages are scattered all over the 
> place. So, it's not impossible at the moment, but I guess most Windows 
> users feel a bit unmotivated to work on the code mostly since they'll 
> have to develop using Cygwin. (I don't know if that's the reason, just a 
> hunch)

No, not even close.  It is written in README.MinGW how to go about 
compiling yourself.  Only Han-Wen cross-compiled the beast on Linux.

> So, IMO its not that Windows users don't _want_ to contribute. I think 
> they feel they can't. Let's see if we can fix that.

I beg to differ here, strongly.  On the two first points at least.  On the 
third point, I am already disap-point-ed.

Ciao,
Dscho
