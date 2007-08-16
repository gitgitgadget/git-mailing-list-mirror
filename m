From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Thu, 16 Aug 2007 12:21:51 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708161219340.16727@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <20070815053231.GJ27913@spearce.org>
 <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
 <20070815171152.GA15155@auto.tuwien.ac.at>
 <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com>
 <alpine.LFD.0.999.0708151453390.5415@xanadu.home>
 <86d4xn5287.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708161103080.16727@xanadu.home>
 <9e4733910708160913i29e18e80v107bcc3732e9db95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILi6q-0006tp-2p
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 18:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764815AbXHPQVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 12:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764971AbXHPQVy
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 12:21:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34927 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764692AbXHPQVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 12:21:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMV00D73K4FG270@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 16 Aug 2007 12:21:51 -0400 (EDT)
In-reply-to: <9e4733910708160913i29e18e80v107bcc3732e9db95@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56025>

On Thu, 16 Aug 2007, Jon Smirl wrote:

> On 8/16/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Thu, 16 Aug 2007, David Kastrup wrote:
> > > If I understand correctly, delta indices
> > > for the search window are kept, and the current file is compared
> > > against them.  Locality might be better if just one delta index gets
> > > calculated and then compared with all _upcoming_ delta candidates in
> > > one go.
> >
> > This appears so obvious that I attempted that a while ago already.
> >
> > The idea turned up to be so complex to implement correctly and produced
> > suboptimal results in practice that I abandoned it.
> 
> In practice it doesn't really matter what you do. Most developers have
> a decent amount of RAM. Disks run at 50MB/sec or more. The entire pack
> file ends up in the kernel disk cache within a few seconds.
> 
> Turning the twenty minute delta search into 6-7 minutes is a much more
> obvious win.

And your point in relation with what was just said is ?


Nicolas
