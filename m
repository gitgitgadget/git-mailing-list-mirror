From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 14:07:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606161406260.16002@localhost.localdomain>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
 <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
 <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
 <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
 <1150478968.6983.7.camel@neko.keithp.com>
 <9e4733910606161044h736c9675kc91ff77904c5a1d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Keith Packard <keithp@keithp.com>,
	Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 20:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIiy-00007O-26
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 20:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWFPSHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 14:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWFPSHL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 14:07:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31269 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750878AbWFPSHK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 14:07:10 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0Y000PZSZWQV50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Jun 2006 14:07:08 -0400 (EDT)
In-reply-to: <9e4733910606161044h736c9675kc91ff77904c5a1d0@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21960>

On Fri, 16 Jun 2006, Jon Smirl wrote:

> On 6/16/06, Keith Packard <keithp@keithp.com> wrote:
> > On Fri, 2006-06-16 at 13:00 -0400, Jon Smirl wrote:
> > > Is it a crazy idea to read the cvs files, compute an sha1 on each
> > > expanded delta and then write the delta straight into a pack file? Are
> > > the cvs and git delta formats the same? What about CVS's forward and
> > > reverse delta use?
> > 
> > At this point, merging blobs into packs isn't a significant part of the
> > computational cost. parsecvs is spending all of its time in the
> > quadratic traversal of the diff chains; fixing that to emit all of the
> > versions in a single pass should speed up that part of the conversion
> > process dramatically.
> 
> That's not true for the state I am in. cvsps can compute the changeset
> tree in 15 minutes, cvs2svn can compute their version in a couple of
> hours. cvs2svn builds a much better tree.

Did you try parsecvs recently?


Nicolas
