From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Don't die in git-http-fetch when fetching packs.
Date: Tue, 9 Jan 2007 20:28:01 -0500
Message-ID: <20070110012801.GA30703@spearce.org>
References: <20070110010452.GA30610@spearce.org> <7v1wm3hekz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4SGA-0007LW-Ua
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbXAJB2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbXAJB2H
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:28:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38577 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbXAJB2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:28:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4SFt-0001Zr-JZ; Tue, 09 Jan 2007 20:27:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 814E120FBAE; Tue,  9 Jan 2007 20:28:02 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wm3hekz.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36464>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >  For the tip of my sp/mmap topic.  Without it HTTP fetch and push
> >  support is severely broken as it cannot deal with packs.
> 
> Ah, thanks.  I've seen this today and a repeated fetch after
> that fixed it and thought it was a mirroring lag.

Me too.  I have actually been fighting with it on and off since we
got sp/mmap reasonably stable.  I just always kept attributing it
to kernel.org mirroring lag until I realized it was just happening
way too often.

-- 
Shawn.
