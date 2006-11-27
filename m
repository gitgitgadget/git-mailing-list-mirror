X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 4/10] Add current branch in PS1 support to git-completion.bash.
Date: Mon, 27 Nov 2006 12:31:36 -0500
Message-ID: <20061127173136.GD6616@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org> <20061127084128.GD19745@spearce.org> <20061127103111.4835bffc.seanlkml@sympatico.ca> <20061127165122.GB6616@spearce.org> <20061127122653.3e801d7a.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 17:32:18 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061127122653.3e801d7a.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32432>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GokKb-0004tq-3y for gcvg-git@gmane.org; Mon, 27 Nov
 2006 18:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754447AbWK0Rbp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758337AbWK0Rbp
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 12:31:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:7149 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754447AbWK0Rbo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 12:31:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GokKM-0001eR-80; Mon, 27 Nov 2006 12:31:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 462F820FB7F; Mon, 27 Nov 2006 12:31:36 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Mon, 27 Nov 2006 11:51:23 -0500
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > I actually started with the name __git_current_branch but changed
> > my mind on that and went with __git_ps1.
> > 
> > My rationale at the time was probably not correct (it was early this
> > morning) but I figured that the current branch name is "master"
> > while __git_ps1 prints " (master)".  Therefore __git_ps1 is not
> > really printing the current branch, its printing the current branch
> > and other stuff.  So I went with a name which implied its purpose.
> 
> Ahh, I had missed that, it makes some sense.  Although it goes a bit
> against the commit message that the user is free to construct whatever
> PS1 format they like (ie. they're stuck with parenthesis around the
> branch name).
> 
> Just thinking out loud, what about allowing __git_ps1 to take a
> format string of its own?  It could parse options like  "(\b)"
> to mean git branch surrounded by parenthesis.  But you could
> also do "[\b]" or "!\b" if you preferred.

I did that.  :-)

If you read the implementation of __git_ps1 the default format is
" (%s)" but you can pass anything you want as the first parameter.
 
-- 
