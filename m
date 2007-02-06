From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-push: allow globbing wildcard refspec.
Date: Tue, 6 Feb 2007 02:53:05 -0500
Message-ID: <20070206075305.GC10508@spearce.org>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net> <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net> <7v3b5jka3t.fsf_-_@assigned-by-dhcp.cox.net> <7vtzxziv5y.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 08:53:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEL8j-0006lJ-Cc
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbXBFHxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbXBFHxK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:53:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53616 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbXBFHxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:53:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEL8T-00033R-RO; Tue, 06 Feb 2007 02:53:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7260020FBAE; Tue,  6 Feb 2007 02:53:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vtzxziv5y.fsf_-_@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38821>

Junio C Hamano <junkio@cox.net> wrote:
>     [remote "mothership"]
>         url = mothership:project.git
>         pull = refs/heads/*:refs/remotes/mothership/*

Don't you mean `fetch = ...` here?

-- 
Shawn.
