From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Tue, 6 Mar 2007 02:16:30 -0500
Message-ID: <20070306071630.GB24004@spearce.org>
References: <20070306063501.GA24355@spearce.org> <7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOTuY-00014U-2P
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbXCFHQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbXCFHQg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:16:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45484 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbXCFHQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:16:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOTuS-00077S-3s; Tue, 06 Mar 2007 02:16:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 222DD20FBAE; Tue,  6 Mar 2007 02:16:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41549>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I find it difficult to see compiler warnings amongst the massive
> > spewing produced by GNU make as it works through our productions.
> 
> I agree, and suspect it might even be a better idea to make this
> the default, with "make V=1" to make chattier.

See my other patch.  ;-)
 
> Now we should do the same to git-gui, shouldn't we?  Time for me
> to subtree-merge git-gui to my master?

Done.  gitgui-0.6.3 is tagged and ready to be pulled into maint.
There's a few small fixes in there that have been accumlating too.
Be nice to get them into your next release, whatever that winds
up being.  ;-)

-- 
Shawn.
