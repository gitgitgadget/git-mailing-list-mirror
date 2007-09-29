From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 16:06:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709291606010.28395@racer.site>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org>
 <Pine.LNX.4.64.0709290144310.28395@racer.site> <4D958F04-D531-416A-9FB4-E4119BEC6905@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 17:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbdvX-0007GJ-8y
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 17:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbXI2PIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 11:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbXI2PIL
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 11:08:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:55182 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753967AbXI2PIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 11:08:10 -0400
Received: (qmail invoked by alias); 29 Sep 2007 15:08:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 29 Sep 2007 17:08:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1e6dsF/j1mzISx6SeHuSW2oSxQ6qZEOTVD4DHLR
	neTo8AQ8sO1bIp
X-X-Sender: gene099@racer.site
In-Reply-To: <4D958F04-D531-416A-9FB4-E4119BEC6905@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59472>

Hi,

On Sat, 29 Sep 2007, Steffen Prohaska wrote:

> On Sep 29, 2007, at 2:49 AM, Johannes Schindelin wrote:
> 
> > 
> > On Fri, 28 Sep 2007, Shawn O. Pearce wrote:
> > 
> > > On Cygwin we have man, so `git help init` (or `git init --help`) 
> > > work just fine to display the manual entry.  No idea about the MSYS 
> > > port.
> > 
> > We open the html pages.  That is, we don't yet, since we do not 
> > generate the html pages just yet; asciidoc is a Python program, and 
> > Python is not available as an MSys program as far as I know (and 
> > asciidoc insists on finding files in a Unix-like file structure, so we 
> > _do_ need an MSys Python).
> 
> I propose to clone the html pages from git.git's html branch and include 
> them in the installer. I continue to believe that this is the simplest 
> and fastest solution for providing html pages.

I'm hesitant... The html branch is synced with the master branch.  And we 
deviate from the master branch quite a lot ATM.

> I'll provide a patch (hopefully next week).

This will be a good temporary workaround.

Ciao,
Dscho
