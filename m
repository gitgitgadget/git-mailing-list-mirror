From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 22:12:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703152211050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net> 
 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>  <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
  <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net> 
 <81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com> 
 <Pine.LNX.4.63.0703151136470.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0703150655y3d2a71d3t8db6e334ecf23ca1@mail.gmail.com> 
 <Pine.LNX.4.63.0703151841180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0703151408v5e6245f4l95fb7cc801e1b568@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 22:12:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRxFK-0001VY-48
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 22:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbXCOVMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 17:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbXCOVMW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 17:12:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:51755 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753373AbXCOVMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 17:12:21 -0400
Received: (qmail invoked by alias); 15 Mar 2007 21:12:20 -0000
X-Provags-ID: V01U2FsdGVkX1+iYFRDI4WiuJpTEaVCgxk2m7RWu1Wn+xDQECd06B
	HZxu3cbZmq85gr
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703151408v5e6245f4l95fb7cc801e1b568@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42300>

Hi,

On Thu, 15 Mar 2007, Alex Riesen wrote:

> On 3/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > (That, however, works only if you do not want something like "git diff
> > > > -w"...)
> > >
> > > Why? Can't "git diff -w" quit early?
> > 
> > No, but "-w" means "ignore white space", which means that blobs can be

> > deemed equal, even if they differ at the byte-per-byte level.
> 
> So it can leave early as soon as it found a difference on byte level
> and the difference is not white space, can't it?

Yes.

The point I tried to make: without "-w" or "-b", you can compare at the 
tree level. No need for a --quiet option. (Of course, you showed me that 
you'd need it for index-tree comparisons anyway.)

Ciao,
Dscho
