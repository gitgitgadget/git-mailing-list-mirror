From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sun, 31 Dec 2006 01:48:39 -0500
Message-ID: <20061231064839.GF6106@spearce.org>
References: <20061231031305.GA5620@spearce.org> <7vy7ooip6y.fsf@assigned-by-dhcp.cox.net> <20061231061232.GC6106@spearce.org> <7vpsa0inwr.fsf@assigned-by-dhcp.cox.net> <20061231062618.GD6106@spearce.org> <7vlkkoinla.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 07:48:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0uV2-0006pH-E0
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 07:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039AbWLaGso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 01:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbWLaGso
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 01:48:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46435 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933039AbWLaGsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 01:48:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0uV3-00071e-V3; Sun, 31 Dec 2006 01:48:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 34E5720FB65; Sun, 31 Dec 2006 01:48:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkkoinla.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35684>

Junio C Hamano <junkio@cox.net> wrote:
> +test_expect_success numbers '
> +
> +	git-repo-config kilo.gram 1k &&
> +	git-repo-config mega.ton 1m &&
> +	k=$(git-repo-config --int --get kilo.gram) &&
> +	test z1024 = "z$k" &&
> +	m=$(git-repo-config --int --get mega.ton) &&
> +	test z1048576 = "z$m"
> +'
> +

I'm a moron.  I copied and pasted test_expect_failure here in my
own version.  Commit and push yours, its just as good as mine,
but is shorter.  :-)

-- 
Shawn.
