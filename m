From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/8] bash: Classify more commends out of completion.
Date: Sun, 4 Feb 2007 03:16:55 -0500
Message-ID: <20070204081655.GF16766@spearce.org>
References: <20070204073830.GE17603@spearce.org> <7vmz3uxryj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 09:17:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDcYi-0006yW-0P
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 09:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbXBDIRG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 03:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbXBDIRG
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 03:17:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56346 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbXBDIRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 03:17:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDcYV-0001dp-Dx; Sun, 04 Feb 2007 03:16:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E929C20FBAE; Sun,  4 Feb 2007 03:16:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmz3uxryj.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38668>

Junio C Hamano <junkio@cox.net> wrote:
> At some point we might want to generate this part from the table
> defined in Documentation/cmd-list.perl (the latter might need to
> be extended for that, but I think matching "helper", "plumbing"
> and perhaps "foreign" would cover most of them).

Actually I'm thinking of going in the other direction.  The set of
commands which we expect people to use in an interactive setting
on the command line is smaller than the set of commands we actually
ship.

But yea, maybe we can build it from the existing sources...

-- 
Shawn.
