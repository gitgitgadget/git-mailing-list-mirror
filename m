From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 12:51:12 +0200
Message-ID: <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 12:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrAud-0007vN-Ju
	for gcvg-git@gmane.org; Thu, 24 May 2007 12:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbXEXKvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 06:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbXEXKvP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 06:51:15 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:50091 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936AbXEXKvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 06:51:15 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIJ0033CKTCWQ@psmtp13.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 12:51:13 +0200 (MEST)
Received: (qmail 12268 invoked by uid 500); Thu, 24 May 2007 10:51:12 +0000
In-reply-to: <Pine.LNX.4.64.0705241039200.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48242>

On Thu, May 24, 2007 at 10:41:30AM +0100, Johannes Schindelin wrote:
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > You mean like a tag "submodules" that points to a text file
> > describing the submodules?
> > That's a bit of a pain to set up since you would want that
> > to be independent of your project.
> 
> I could imagine this to be another extension of ls-remote.

You mean extending upload-pack ?  Junio mentioned this possibility as well.
This only solves the git:// and ssh:// case though.
What to do with the other protocols?

Also, I don't really understand why it would be less of a hack
to add it to ls-remote than to add it to git-config.
The latter seems more natural to me.

skimo
