From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Thu, 21 Dec 2006 20:00:18 -0500
Message-ID: <20061222010018.GB14773@spearce.org>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org> <20061222004906.GC14789@spearce.org> <7vmz5g92h7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 02:00:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYm1-0004PK-Vw
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423147AbWLVBAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423174AbWLVBAa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:00:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58194 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423147AbWLVBAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 20:00:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxYlm-0005rU-B7; Thu, 21 Dec 2006 20:00:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C236120FB65; Thu, 21 Dec 2006 20:00:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz5g92h7.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35108>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > If the user has been using reflog for a long time (e.g. since its
> > introduction) then it is very likely that an existing branch's
> > reflog may still mention commits which have long since been pruned
> > out of the repository.
> 
> I've thought about this issue when I did the repack/prune; my
> take on this was you should prune reflog first then repack.

OK, but we should suggest that to the user rather than just
cryptically saying 'fatal: bad object refs/heads/build'.

-- 
Shawn.
