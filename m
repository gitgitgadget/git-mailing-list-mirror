From: Christer Weinigel <christer@weinigel.se>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 01:17:34 +0200
Message-ID: <20071018011734.7b636141@localhost.localdomain>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<47148F72.1090602@users.sourceforge.net>
	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	<B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
	<3awb7zw6.fsf@blue.sea.net>
	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	<1192565900.6430.16.camel@athena>
	<alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	<20071017015109.303760cc@localhost.localdomain>
	<alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	<3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	<alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
	<1192645509.6640.21.camel@athena>
	<alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
	<1192649598.6640.44.camel@athena>
	<alpine.LFD.0.999.0710171246500.26902@woody.linux-foundation.org>
	<20071017232146.4b9e4097@localhost.localdomain>
	<Pine.LNX.4.64.0710172310270.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiI8z-0003in-At
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600AbXJQXR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbXJQXR3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:17:29 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:45800 "EHLO
	zoo.weinigel.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800AbXJQXR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 19:17:28 -0400
Received: from localhost.localdomain (grue.localnet [10.128.0.1])
	by zoo.weinigel.se (Postfix) with ESMTP id BE37F1240902;
	Thu, 18 Oct 2007 01:17:26 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0710172310270.25221@racer.site>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.13; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61437>

On Wed, 17 Oct 2007 23:11:37 +0100 (BST)
Johannes Schindelin <Johannes.w@gmx.de> wrote:

> Hi,
> 
> On Wed, 17 Oct 2007, Christer Weinigel wrote:
> 
> > I think you would get at lot less argument if you weren't so damn
> > self righteous about it.
> 
> Why is it that in this thread, people whom I have heard _nothing_ of 
> before seem to think this would be a good time to let their opinion
> be heard?  Now, _that_ is what I call righteous.  Show nothing but
> opinion.

I'm not that invisible am I?

    cd linux-2.6.22.7
    find . -type f | xargs egrep -il "weinigel" | wc -l
    17

Ahh, confirmation, I really do exist.  The earliest LSM entry I can find
for myself is from 1995:

http://www.ibiblio.org/pub/linux/kernel/patches/scanners/hpscan-0.1.1.5.lsm

Mmm, nostalgia. :-)

But yes, I haven't contributed anything to git so far, I mostly lurk
on the mailing list and try to keep up with what's happening to git.
In the beginning I sent a few ideas to the list (which quite sadly were
ignored), but unfortunately I've been busy with paying work to do much
with git after that.  And at work we use Perforce (yuk) or Subversion
(a lot nicer than Perforce) and privately I use CVS just because I
started using CVS ten years ago and haven't bothered to change.  And
when I'm free I prefer to hack on hardware or device drivers instead.

The reason I wrote my first mail in this thread is that I work in a
different environment than Linus does and wanted to share that
experience.  I usually work with embedded programming, where people use
lots of different editors and in mixed environments.  Some people use
Visual Studio on Windows because that's what they use for host
programming, a lot of embedded development is done in the (almost
invariably sucky) IDE that comes with the compilers for the embedded
CPU, such as Microchips MPLAB or IAR Workbench, Eclipse is becoming
quite popular for C development, Slickedit is also popular on Windows,
a colleague prefers nedit for some strange reason, and so on. In such a
heterogeneous environment the easiest way to make sure that people see
the same indentation in all editors is to just tell them to use spaces
for indentation, and I think that every editor I just mentioned has a
setting to do that automatically.  Microemacs is the odd one out in
that it doesn't support it.  And my employers haven't really been
paying me to go on a crusade for the holy TAB is 8 spaces cause, they
just want things done, so I've had to settle for a "good enough"
solution which works most of the time. 

So I just thought it was unfair of Linus to say that "use spaces"
doesn't solve any problems, in some environments it does.  For the
Linux kernel and Git, it's easier for the maintainer to enforce 
the coding standards and since Linus and Junio prefer to use hard tabs,
that are the rules that people who want to play with their toys
have to adhere to.

BTW, how serious is the problem with deltifying when there are a lot of
spaces that David Kastrup mentioned?  It does sound like a quite
serious problem if it has a big impact on the performance of Git.  Git
isn't only used for the Linux kernel, so there has to be some projects
that both use spaces for indentation and use Git out there.  Wouldn't
it be a problem when people put ASCII graphics in comments or just have 
comments like /*********************************/ in their code?

  /Christer
