From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 12:02:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241201270.4648@racer.site>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org> <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 13:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrB5n-0001Qh-Aq
	for gcvg-git@gmane.org; Thu, 24 May 2007 13:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbXEXLCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 07:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754922AbXEXLCq
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 07:02:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:48323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754305AbXEXLCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 07:02:45 -0400
Received: (qmail invoked by alias); 24 May 2007 11:02:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 24 May 2007 13:02:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OMzkPDuFOt/PlgBHbfFRYwFtRxydE5sK07bfdUp
	FX/oArG/c4hAXW
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48244>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 10:41:30AM +0100, Johannes Schindelin wrote:
> > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > > You mean like a tag "submodules" that points to a text file
> > > describing the submodules?
> > > That's a bit of a pain to set up since you would want that
> > > to be independent of your project.
> > 
> > I could imagine this to be another extension of ls-remote.
> 
> You mean extending upload-pack ?  Junio mentioned this possibility as well.
> This only solves the git:// and ssh:// case though.
> What to do with the other protocols?

As we do for the refs: put it into .git/info/refs. This file is already 
meant to "cache" the output of ls-remote for dumb protocols.

> Also, I don't really understand why it would be less of a hack
> to add it to ls-remote than to add it to git-config.
> The latter seems more natural to me.

No, not at all. git-config is about the local data. It is _meant_ to be 
private. Things you can receive by ls-remote are _meant_ to be public.

Ciao,
Dscho
