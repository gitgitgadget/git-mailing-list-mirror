From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 20:01:26 -0500
Message-ID: <20070112010126.GF23864@spearce.org>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home> <20070111080035.GA28222@spearce.org> <7v1wm16gyd.fsf@assigned-by-dhcp.cox.net> <20070111100800.GB28309@spearce.org> <7v64bd15lg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 02:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5AnV-0003bW-5z
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 02:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbXALBBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 20:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbXALBBb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 20:01:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42825 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbXALBBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 20:01:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5AnL-0008NF-BQ; Thu, 11 Jan 2007 20:01:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E8BE420FBAE; Thu, 11 Jan 2007 20:01:26 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64bd15lg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36649>

Junio C Hamano <junkio@cox.net> wrote:
> The reason why I would run the command with --tags is to cope
> with this kind of graph.
> 
>              o---o---o---x
>             /
>     ---o---o---o---o---o---y
>        b       A

Why isn't that the default?
 
> in order to use lightweight ones as a back-up.  Otherwise we
> would not have had the "prio" business there.
> 
> And I would prefer if the presense of lightweight 'c' tag did
> not change how 'y' is described:
> 
> 
>              o---o---o---x
>             /
>     ---o---o---o---o---o---y
>        b       A       c

If we just make '--tags' the default and fix the priority to always
pick an annotated tag over a lightweight one then things make sense.
We'd automatically pickup b above for x but always A for y.

-- 
Shawn.
