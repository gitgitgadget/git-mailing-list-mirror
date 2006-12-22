From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Fri, 22 Dec 2006 03:22:46 -0500
Message-ID: <20061222082246.GC15548@spearce.org>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org> <20061222004906.GC14789@spearce.org> <20061222005606.GA14773@spearce.org> <7vodpw5ors.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 09:22:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxfg4-0005vD-Uq
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945971AbWLVIWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 03:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945973AbWLVIWu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:22:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43436 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945971AbWLVIWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:22:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gxffz-0007LT-3P; Fri, 22 Dec 2006 03:22:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 90FEE20FB65; Fri, 22 Dec 2006 03:22:46 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodpw5ors.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35143>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Just because the commit has not been pruned does not mean that a blob
> > or tree referenced by that commit has not been pruned.
> 
> True.  How about this?

Yea, that's a good way to deal with it.  Ack'd.

-- 
Shawn.
