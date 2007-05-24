From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 12:31:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241230410.4648@racer.site>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org> <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 13:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrBXg-0006Z5-PE
	for gcvg-git@gmane.org; Thu, 24 May 2007 13:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbXEXLbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 07:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755805AbXEXLbj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 07:31:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:39754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754888AbXEXLbh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 07:31:37 -0400
Received: (qmail invoked by alias); 24 May 2007 11:31:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 24 May 2007 13:31:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//oekpopn/CYEi3YeqgoXCKowRWkafukiUVMNOGd
	eNI7zo6Nj3Xp7l
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48246>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 12:02:41PM +0100, Johannes Schindelin wrote:
> > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > > On Thu, May 24, 2007 at 10:41:30AM +0100, Johannes Schindelin wrote:
> > > > I could imagine this to be another extension of ls-remote.
> > > 
> > > You mean extending upload-pack ?  Junio mentioned this possibility as well.
> > > This only solves the git:// and ssh:// case though.
> > > What to do with the other protocols?
> > 
> > As we do for the refs: put it into .git/info/refs. This file is already 
> > meant to "cache" the output of ls-remote for dumb protocols.
> 
> OK... so what should git-update-server-info put in this file for submodules?
> Or, equivalently, what should be the output of ls-remote?
> 
> Right now its a list of pairs of revs(sha1) and refs.
> For submodules we want a connection between a submodule name
> and one or more URLs where the submodule can be found.
> How are you going to squeeze that into info/refs without confusing
> older versions of git?

I wonder if the "ref^{blub}" syntax could be used for that: change "blub" 
to the URL, or "sub:URL" or something.

Ciao,
Dscho
