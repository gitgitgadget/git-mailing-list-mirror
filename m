From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Fri, 23 Mar 2007 23:28:03 -0400
Message-ID: <20070324032802.GA25863@spearce.org>
References: <200703231022.00189.andyparkins@gmail.com> <7v648ro3a3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 04:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUwvM-0003QA-42
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 04:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbXCXD2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 23:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbXCXD2J
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 23:28:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60778 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbXCXD2H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 23:28:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HUwv3-0003jU-HV; Fri, 23 Mar 2007 23:27:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8D31F20FBAE; Fri, 23 Mar 2007 23:28:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v648ro3a3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42974>

Junio C Hamano <junkio@cox.net> wrote:
> I think I'd better let fancier hooks live in contrib/examples
> hierarchy for people to pick and choose, and keep the default
> templates/ directory lean and clean.

I agree.  Which is why I submitted my little continuous integration
server as contrib/continuous and not as a hook in templates.

;-)

-- 
Shawn.
