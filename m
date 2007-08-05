From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Some ideas for StGIT
Date: Sun, 5 Aug 2007 15:15:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051513310.14781@racer.site>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com>
 <1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org>
 <f934ve$3oi$1@sea.gmane.org> <20070805023130.GV20052@spearce.org>
 <20070805133940.GA18835@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.64.0708051452280.14781@racer.site>
 <20070805140658.GA4570@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:16:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHgu9-0005jU-Ux
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbXHEOQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbXHEOQH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:16:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:46021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751662AbXHEOQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:16:04 -0400
Received: (qmail invoked by alias); 05 Aug 2007 14:16:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 05 Aug 2007 16:16:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1975cZ2HiZ78c7Z9WiKr13NdtgBSb6VRzI3z+oqd4
	SiCmFSeAWS51Ve
X-X-Sender: gene099@racer.site
In-Reply-To: <20070805140658.GA4570@filer.fsl.cs.sunysb.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55023>

Hi,

On Sun, 5 Aug 2007, Josef Sipek wrote:

> On Sun, Aug 05, 2007 at 02:56:23PM +0100, Johannes Schindelin wrote:
> > 
> > On Sun, 5 Aug 2007, Josef Sipek wrote:
> > 
> > > Sure, if you can take 2 commits and collapse them into one you could 
> > > fake it by creating a dummy commit with the new changes, and then 
> > > collapsing, but that's nasty - and reflog might not like that much 
> > > :)
> > 
> > IIUC you want to edit/amend a patch in the middle of a series?  Two ways 
> > to go about it:
> > 
> > 	1) (preferred)
> > 
> > 		* start rebase -i
> > 		* mark the commit as "edit"
> > 		* wait until rebase stops to let you edit it
> > 		* edit, test, commit --amend
> > 		* rebase --continue
> 
> Ewww...that doesn't seem to scale (read: far too much to type) :) Here's a
> quilt/guilt/stgit equivalent:
> 
> 	$APP push <patchname>
> 
> or (depending on where you are in the patch stack)
> 
> 	$APP pop <patchname>
> 
> 	<edit>
> 
> 	$APP refresh # this is the commit --amend part

Yeah.  Sounds like you'd just need a "--edit-this $commit" flag to rebase 
-i.

Out of curiousity, what happens if you say "push" several times, 
_without_ popping the patch?  And what happens if you "push" several times 
with the _same_ patchname?

Ciao,
Dscho
