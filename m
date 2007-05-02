From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 18:24:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705021822100.4015@racer.site>
References: <200705012346.14997.jnareb@gmail.com> <Pine.LNX.4.64.0705020143460.4010@racer.site>
 <200705021641.53199.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	releases@openoffice.org
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 02 18:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjHcj-0006pg-Cz
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993484AbXEBQYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993483AbXEBQYH
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:24:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:47451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2993484AbXEBQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:24:04 -0400
Received: (qmail invoked by alias); 02 May 2007 16:24:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 02 May 2007 18:24:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n3oRX6W4nVr5XYBFqxGsZ2uitmenySBFo1js7e3
	ko7mxvR2O1FqcU
X-X-Sender: gene099@racer.site
In-Reply-To: <200705021641.53199.kendy@suse.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46032>

Hi,

On Wed, 2 May 2007, Jan Holesovsky wrote:

> On Wednesday 02 May 2007 12:24, Johannes Schindelin wrote:
> 
> > On Tue, 1 May 2007, Jakub Narebski wrote:
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
> I should probably produce even a tree where would be the merged branches 
> deleted, right...

FWIW, I just deleted all branches except for one, packed the tags, and did 
a local clone (via NFS, urgh) _without_ checking the files out.

Now it takes 25 minutes vs 50 minutes before (in an _extremely_ 
unscientific test, mind you).

So, this issue is worth looking at, probably.

Ciao,
Dscho
