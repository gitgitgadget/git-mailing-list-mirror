From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 02:31:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706230222330.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com>
 <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz>
 <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 03:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1uTW-0005bU-1a
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 03:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXFWBbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 21:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbXFWBbg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 21:31:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:35512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750771AbXFWBbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 21:31:35 -0400
Received: (qmail invoked by alias); 23 Jun 2007 01:31:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 23 Jun 2007 03:31:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187/ApdzaA7eHSitHUKkPLpWOeq+c0Uwp5e/h6vDU
	P2DX6s6LVYrY4+
X-X-Sender: gene099@racer.site
In-Reply-To: <86abusi1fw.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50716>

Hi,

On Fri, 22 Jun 2007, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 22 Jun 2007, David Kastrup wrote:
> >
> >> As a note aside: would it be possible to always round downwards when 
> >> computing similarities or converting between them?
> >
> > I'd rather not. This would be counterintuitive. People expect rounded 
> > values.
> 
> Which people?

Me, for one. Thank you very much.

> The people I know will expect "100% identical" or even "100.0% 
> identical" to mean identical, period.  They will be quite surprised to 
> hear that "99.95%" is supposed to be included.

Granted, 100.0% means as close as you can get to "completely" with 4 
digits. But if you have an integer, you better use the complete range, 
rather than arbitrarily make one number more important than others.

For if you see an integer, you usually assume a rounded value. If you 
don't, you're hopeless.

> Also, for any kind of decision made upon percentages, it is much more 
> relevant to be able to draw a line at 50% rather than at 49.5%.

I do see too many people in my day job who take the numbers they see for 
absolute truths, so I cannot take that statement seriously, sorry.

> Could you name a _single_ use case where rounding down could cause an 
> actual problem or even inconvenience for people?

Could you name a _single_ use case where it does not?

I mean, honestly, really. Really, really, really. A number is only a weak 
_indicator_, and an integer even more so, for what is _really_ going on.

> >> I very much would like to see the 100% figure reserved for identity.  
> >> This is particularly relevant when interpreting the output of 
> >> git-diff --name-status with regard to R100, C100 and similar flags.
> >
> > You should never depend on the output of --name-status if you're 
> > interested in identifying identical files, but on the object names.
> 
> Which is rather inconvenient.

Frankly, I am getting bored.

This argument crops up ever so often. "If you did that, _I_ could be more 
lazy, and the _hell_ with other people who expect otherwise!".

No, really.

> I _know_ that one can't rely on the output of --name-status right now.

And I _know_ that you can't rely on integer numbers. Or _any_ number which 
is not _completely_ precise.

Really, I am getting bored with this discussion.

Ciao,
Dscho
