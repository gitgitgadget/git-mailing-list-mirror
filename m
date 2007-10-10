From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [msysGit] Re: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Wed, 10 Oct 2007 00:40:30 -0400
Message-ID: <20071010044030.GJ2137@spearce.org>
References: <11917925011987-git-send-email-prohaska@zib.de> <20071007233023.GE2137@spearce.org> <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de> <Pine.LNX.4.64.0710091240540.4174@racer.site> <4A4F8FC7-E0AB-4C07-B4C8-AFE2EBD9C3DD@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 06:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfTNF-0008KF-IC
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 06:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXJJEkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 00:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbXJJEkf
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 00:40:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60868 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbXJJEkf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 00:40:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IfTN2-0001wi-Ng; Wed, 10 Oct 2007 00:40:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB52520FBAE; Wed, 10 Oct 2007 00:40:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4A4F8FC7-E0AB-4C07-B4C8-AFE2EBD9C3DD@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60461>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Oct 9, 2007, at 1:43 PM, Johannes Schindelin wrote:
> >On Mon, 8 Oct 2007, Steffen Prohaska wrote:
> >
> >>commit a483fdd562d6c44d68a998224e0bbb17933b624a
> >>Author: Steffen Prohaska <prohaska@zib.de>
> >>Date:   Mon Oct 8 08:25:47 2007 +0200
> >>
> >>   git-gui: offer a list of recent repositories on startup
> >
> >May I suggest not putting this list into ~/.gitconfig, but rather
> >~/.gitguirc?  It is not really a user-specific git configuration...
> 
> git-gui already stores other options as global variables gui.*.
> (see git-gui/lib/option.tcl). I just added gui.recentrepo. The
> list of recent repos should go to wherever git-gui stores its options.
> 
> Right now this is in ~/.gitconfig, if I understand correctly. Shawn?

Yes, that's correct.

An item on my todo list (see todo branch in git-gui.git) is to move
this into a ~/.gitguiconfig or something like that, but I was going
to keep it as a git-config style file so git-config can be used to
process its contents.

Until that task is complete I'd rather keep all of the "gui" options
in ~/.gitconfig (global) or .git/config (per-repository).  When I
split stuff out to git-gui specific files I'll have to migrate the
entire "gui" section at once.

-- 
Shawn.
