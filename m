From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 12:01:46 +0200
Message-ID: <20070521100146.GJ942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
 <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
 <4650EA2E.7070204@midwinter.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon May 21 12:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq4i9-0001Rr-SV
	for gcvg-git@gmane.org; Mon, 21 May 2007 12:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbXEUKBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 06:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755664AbXEUKBs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 06:01:48 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:62587 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574AbXEUKBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 06:01:47 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JID00JEUYIYEV@smtp15.wxs.nl> for git@vger.kernel.org; Mon,
 21 May 2007 12:01:46 +0200 (CEST)
Received: (qmail 6853 invoked by uid 500); Mon, 21 May 2007 10:01:46 +0000
In-reply-to: <4650EA2E.7070204@midwinter.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48003>

On Sun, May 20, 2007 at 05:39:10PM -0700, Steven Grimm wrote:
> Sven Verdoolaege wrote:
> >It's pretty easy to add a "submodule.*.skip" or "submodule.*.ignore".
> >Since the subcloning only happens at checkout, you could set these
> >before doing a checkout.
> >  
> 
> Can I take this to mean that you intend the default behavior to be to 
> check out all subprojects, with individual ones suppressed via 
> configuration as needed?

Or we could have a tri-state variable, with "yes" meaning handle
the submodule, "no" don't, and undefined meaning do whatever is
specified by the global submodules option.
Explicitly checking out a submodule could then set the variable to "yes".

skimo
