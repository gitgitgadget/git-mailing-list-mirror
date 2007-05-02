From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 16:55:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705021653230.4015@racer.site>
References: <200705012346.14997.jnareb@gmail.com>  <Pine.LNX.4.64.0705020143460.4010@racer.site>
 <8fe92b430705020433v7ae5c117qdefccc791cd07fff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, dev@tools.openoffice.org,
	Jan Holesovsky <kendy@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 16:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjGEh-00031j-DK
	for gcvg-git@gmane.org; Wed, 02 May 2007 16:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993288AbXEBOzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 10:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993291AbXEBOzP
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 10:55:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:49309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2993288AbXEBOzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 10:55:14 -0400
Received: (qmail invoked by alias); 02 May 2007 14:55:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 02 May 2007 16:55:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EEL8qb35EHJzWAvqSAO87Dcg7GyWXVNv3AmuoWW
	nuzcxV3GelC3pY
X-X-Sender: gene099@racer.site
In-Reply-To: <8fe92b430705020433v7ae5c117qdefccc791cd07fff@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46026>

Hi,

On Wed, 2 May 2007, Jakub Narebski wrote:

> On 5/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 1 May 2007, Jakub Narebski wrote:
> > 
> > > 'Checkout time' (which should be renamed to 'Initial checkout time'),
> > > in which git also loses with 130 minutes (Linux, 2MBit DSL) [from
> > > go-oo.org], 100min (Linux, 2MBit DSL, Wireless, no proxy) [from
> > > go-oo.org] versus 117 minutes (Linux, 2MBit DSL), 26 minutes (Linux,
> > > 2MBit DSL, with compression (-z 6)) for CVS, and  60 Minutes (Windows,
> > > 34Mbit Line) for Subversion, would also be helped by the above.
> > 
> > FWIW I can confirm the number "100min".
> > 
> > Something I realized with pain is that the refs/ directory is 24MB big.
> > Yep. Really. They have 3464 heads and 2639 tags. I suspect that this is
> > the reason why.
> 
> Then packed refs would certainly help with speed and a bit with size.

Indeed for size: du -h reported 11 megabyte for the tags directory. After 
packing them, a 265 kilobyte file is left. Of course, git-show-ref now 
becomes a speed demon again.

Ciao,
Dscho
