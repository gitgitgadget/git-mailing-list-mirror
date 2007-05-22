From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Tue, 22 May 2007 08:54:27 +0200
Message-ID: <20070522065427.GS942MdfPADPa@greensroom.kotnet.org>
References: <20070520153908.GF5412@admingilde.org>
 <20070520181433.GA19668@steel.home>
 <20070521090339.GH942MdfPADPa@greensroom.kotnet.org>
 <20070521224828.GA10890@steel.home> <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
 <20070522060302.GH5412@admingilde.org>
 <7v646l9xkn.fsf@assigned-by-dhcp.cox.net> <20070522063821.GE11636@spearce.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 22 08:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqOGQ-0000mM-TQ
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbXEVGya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758040AbXEVGya
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:54:30 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:51081 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884AbXEVGy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:54:29 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIF00B5MKIRIE@psmtp12.wxs.nl> for git@vger.kernel.org; Tue,
 22 May 2007 08:54:28 +0200 (MEST)
Received: (qmail 18498 invoked by uid 500); Tue, 22 May 2007 06:54:27 +0000
In-reply-to: <20070522063821.GE11636@spearce.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48081>

On Tue, May 22, 2007 at 02:38:22AM -0400, Shawn O. Pearce wrote:
> I thought this thread all started because we wanted to run a
> command in a subproject, and did not want the parent's GIT_*
> environment variables to confuse the subproject process when
> it started.  That's a pretty simple concept: clear any GIT_*
> environment variable that can change behavior in the subproject.
> And almost everyone who is trying to use this API and alter the
> env wants exactly that - a subproject command.

This would work for me, I suppose.
Right now, I sometimes set GIT_DIR explicitly, but I could just chdir
(or use --git-dir=).

skimo
