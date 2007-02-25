From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problems installing as root
Date: Sun, 25 Feb 2007 02:08:11 -0500
Message-ID: <20070225070811.GA1676@spearce.org>
References: <erpljl$ln9$1@sea.gmane.org> <20070225061258.GA1415@spearce.org> <7vabz2wxi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 08:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLDUi-00043K-Ge
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 08:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933669AbXBYHIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 02:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933671AbXBYHIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 02:08:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33543 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933669AbXBYHIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 02:08:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLDUT-00025H-JS; Sun, 25 Feb 2007 02:08:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 27A1420FBAE; Sun, 25 Feb 2007 02:08:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vabz2wxi4.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40539>

Junio C Hamano <junkio@cox.net> wrote:
> How about doing something like this (you would need -p2 to apply
> to your tree)?
> 
> diff --git a/git-gui/CREDITS-GEN b/git-gui/CREDITS-GEN

No dice:

	$ git apply -p2 e
	error: git-gui/CREDITS-GEN: Not a directory

	$ git version
	git version 1.5.0.1.641.g3d8a

Anyway - I'm applying that now (hand editing the patch), and will
do the same in GIT-VERSION-GEN for git-gui.

What about the top level GIT-VERSION-GEN in git.git?

-- 
Shawn.
