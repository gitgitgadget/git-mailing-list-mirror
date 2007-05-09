From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 18:25:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091822590.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site>
 <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site>
 <Pine.LNX.4.64.0705091210570.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>, kha@treskal.com,
	junio@cox.net, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 09 18:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HloyN-00011b-VA
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbXEIQY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755744AbXEIQY7
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:24:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:47752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755425AbXEIQY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:24:58 -0400
Received: (qmail invoked by alias); 09 May 2007 16:24:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 09 May 2007 18:24:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+p9tUAl5mpzhoGvFmlTUq3MnWyMyBrJRtZ8GXQJq
	lTT/gLZkepxx3d
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0705091210570.18541@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46740>

Hi,

On Wed, 9 May 2007, Daniel Barkalow wrote:

> On Wed, 9 May 2007, Johannes Schindelin wrote:
> 
> > > To be honest, I wouldn't even be *thinking* about the endianity of SHA-1
> > > octet representation (you don't usually really deal with the hash as
> > > with a number, so expecting to have it in native endianity is not very
> > > natural; you just deal with it as with a data blob) and the
> > > "(big-endian)" would only confuse me and get me thinking about "huh, do
> > > they swap the bytes, or wait, they don't, ...?!".
> > > 
> > > But that's maybe just me.
> > 
> > But then, maybe it is just me? I got it completely wrong the first time, 
> > fully expecting the calculations to be carried out in host endianness for 
> > performance reasons.
> 
> I think the Mozilla implementation carries out calculations in host 
> endianness, and transfers data from the input to the internal state and 
> >from the internal state to the final hash with shifts and masks.
> 
> Which calculations are you seeing that involve byte order?

None. I only suspected them to be carried out in byte order. From what I 
know, there are some shifts involved, which might or might not be helped 
by 32-bit arithmetic.

I did not really look into it.

>From my prior debugging experiences on Intel, though, I automatically 
looked for the least significant bytes at the beginning of those "sha1" 
variables, and came up empty.

Ciao,
Dscho
