From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 09:36:52 +0200
Message-ID: <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 09:37:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7sb-0005Jo-R4
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758456AbXEXHg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757341AbXEXHg4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:36:56 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:55652 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758143AbXEXHgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:36:55 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIJ003OIBTGGZ@smtp15.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 09:36:53 +0200 (CEST)
Received: (qmail 10251 invoked by uid 500); Thu, 24 May 2007 07:36:52 +0000
In-reply-to: <20070524072945.GO28023@spearce.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48236>

On Thu, May 24, 2007 at 03:29:45AM -0400, Shawn O. Pearce wrote:
> Why?  Their configuration is their configuration.  Who knows what
> they have stored there.  Look at the recent cvsserver config options,
> there's now a lot of information about the SQL database that backs
> cvsserver.  That stuff shouldn't be public.

For http:// or rsync:// it's public already; for ssh://, if you are allowed
to access the git repo, you can read the config as well; for git://,
we can dump a predefined selection of configuration variables.

> If you want to publish something for a client to fetch, it should
> be done by publishing a Git object referenced by a proper ref:
> blob, tree, commit, tag, take your pick.

You mean like a tag "submodules" that points to a text file
describing the submodules?
That's a bit of a pain to set up since you would want that
to be independent of your project.

skimo
