From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 22:19:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711292218240.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net>
 <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
 <20071129211409.GA16625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 23:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixrjb-0007KS-NY
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 23:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbXK2WTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760971AbXK2WTb
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 17:19:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:35045 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760442AbXK2WTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 17:19:31 -0500
Received: (qmail invoked by alias); 29 Nov 2007 22:19:28 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp030) with SMTP; 29 Nov 2007 23:19:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BvBJljxOBCKcXK9JVAUjCb/PF34C+bjSl2gW3cb
	wgZuVEONxtAk7b
X-X-Sender: gene099@racer.site
In-Reply-To: <20071129211409.GA16625@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66566>

Hi,

On Thu, 29 Nov 2007, Jeff King wrote:

> On Fri, Nov 30, 2007 at 03:05:05AM +0700, Nguyen Thai Ngoc Duy wrote:
> 
> > > But I don't see a point to removing the links entirely. The annoyance
> > > factor for people who want git-* is much higher, and I don't see that it
> > > actually buys us any help for new users (who will no longer care after
> > > everything is hidden in $(libexecdir) anyway).
> > 
> > Maybe only not install hardlinks on systems that do not support it
> > like Windows? git.exe duplication takes a lot of space.
> 
> I think that is totally reasonable, as on those platforms there is
> actually something to be gained from removing those hardlinks (you could
> also of course make a very thin wrapper for "git-foo" that called "git
> foo"; it would still be wasteful, but not as much as copying the whole
> git.exe. But that is not worth doing unless people on Windows really
> want the dash forms).

Note that one big problem with a few platforms having dash forms and 
others not is that you _will_ get scripts and aliases that do not work 
everywhere.

Consistency is good.

Ciao,
Dscho
