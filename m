From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 10:41:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241039200.4648@racer.site>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org> <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 11:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr9p9-0003oI-3b
	for gcvg-git@gmane.org; Thu, 24 May 2007 11:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbXEXJld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 05:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbXEXJld
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 05:41:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:38241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754665AbXEXJlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 05:41:32 -0400
Received: (qmail invoked by alias); 24 May 2007 09:41:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 24 May 2007 11:41:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fBu8uZoxfXrTRvMqlhHgKb3T25Zw+KWIq1cJvzE
	YtZXFOCD88gd42
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48241>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 03:29:45AM -0400, Shawn O. Pearce wrote:
> > Why?  Their configuration is their configuration.  Who knows what
> > they have stored there.  Look at the recent cvsserver config options,
> > there's now a lot of information about the SQL database that backs
> > cvsserver.  That stuff shouldn't be public.
> 
> For http:// or rsync:// it's public already; for ssh://, if you are 
> allowed to access the git repo, you can read the config as well; for 
> git://, we can dump a predefined selection of configuration variables.

I sanitized a once-public repo, which was _not_ updated via http-push (in 
which case you'd not see a meaningful config anyway), where the 
permissions prevented the config from being read.

> > If you want to publish something for a client to fetch, it should be 
> > done by publishing a Git object referenced by a proper ref: blob, 
> > tree, commit, tag, take your pick.
> 
> You mean like a tag "submodules" that points to a text file
> describing the submodules?
> That's a bit of a pain to set up since you would want that
> to be independent of your project.

I could imagine this to be another extension of ls-remote.

Ciao,
Dscho
