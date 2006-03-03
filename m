From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Add --temp and --stage=all options to checkout-index.
Date: Fri, 3 Mar 2006 10:13:31 -0500
Message-ID: <20060303151331.GA16369@spearce.org>
References: <20060303012032.GC6321@spearce.org> <7vmzg83xro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 16:13:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFByM-0008SN-F4
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 16:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWCCPNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 10:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWCCPNf
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 10:13:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46999 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751240AbWCCPNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 10:13:35 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FFByD-0008Io-59; Fri, 03 Mar 2006 10:13:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F60320FBBF; Fri,  3 Mar 2006 10:13:31 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzg83xro.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17155>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >  Unfortunately this change lead me down a path which changed the core
> >  checkout code also used by apply and read-tree.
> 
> ... which makes it much harder to swallow without careful
> inspection X-<.
> 
> I think the patch only appears much bigger than it actually is,
> because of reindentation effect coming from "if (to-temp-file)".
> However, I am too tired to carefully examine them tonight, so I
> hope you do not mind my postponing this for now.

Not at all.  I read over the diff before sending it and thought it
made the patch look much worse than it really is, simply because
of the reindentation.  :-|

Sometimes good 'ole diff ain't that great for conveying a change.

-- 
Shawn.
