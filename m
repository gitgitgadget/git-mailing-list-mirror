From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git stash apply segfaulting when called in subdir
Date: Thu, 26 Jul 2007 06:40:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260635060.14781@racer.site>
References: <20070725212311.GA13325@cassiopeia> <7v1wewdsoz.fsf@assigned-by-dhcp.cox.net>
 <20070726050726.GC32617@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:41:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDw68-0008Pr-Dc
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762436AbXGZFku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762412AbXGZFku
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:40:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:60863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762392AbXGZFks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:40:48 -0400
Received: (qmail invoked by alias); 26 Jul 2007 05:40:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 26 Jul 2007 07:40:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rrWwuipjr9RSMRoGpEcvr0+SnTKWude0A8bvqq9
	XDvb9zjOrcKJEn
X-X-Sender: gene099@racer.site
In-Reply-To: <20070726050726.GC32617@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53770>

Hi,

On Thu, 26 Jul 2007, Jeff King wrote:

> On Wed, Jul 25, 2007 at 03:28:12PM -0700, Junio C Hamano wrote:
> 
> > > zeisberg@cassiopeia:/tmp/repo$ cd dir; git stash apply
> > > error: missing object referenced by '696146c2a44d7fc4d5ae4a71589c4c0d84f59789'
> > > /home/zeisberg/usr/bin/git-stash: line 111: 13618 Segmentation fault      git-merge-recursive $b_tree -- $c_tree $w_tree
> > 
> > This probably is a merge-recursive bug, but in the meantime,
> > I think this should fix it.
> 
> The merge-recursive bug is simply a failure to check for invalid input.

No it is not.

The objects are there.  But the objects cannot be found, since 
merge-recursive cannot go to top level.

Ciao,
Dscho
