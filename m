X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 17:44:21 -0500
Message-ID: <20061214224421.GD26202@spearce.org>
References: <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org> <20061214120518.GL1747@spearce.org> <Pine.LNX.4.64.0612141251520.18171@xanadu.home> <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net> <20061214200245.GP1747@spearce.org> <7v1wn243mu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 22:44:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v1wn243mu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34421>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzJV-0004MF-CB for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964985AbWLNWo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWLNWo0
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:44:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40006 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964985AbWLNWoZ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 17:44:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuzJG-00021Q-GT; Thu, 14 Dec 2006 17:44:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 67FF420FB65; Thu, 14 Dec 2006 17:44:22 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Maybe a check to say if $GIT_DIR is ".git" or ends with "/.git"
> then enable it and otherwise honor the configuration variable,
> without changing the default in the code (with your patch) nor
> in the default configuration ("enable for new repositories" as I
> suggested) might be a workable compromise.

See my latest patch.  Though that patch also sets the value in the
config file, much as core.filemode is also set in the config file,
based on the guess determined by init-db at the time it was executed.

-- 
