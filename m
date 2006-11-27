X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 4/10] Add current branch in PS1 support to git-completion.bash.
Date: Mon, 27 Nov 2006 11:51:23 -0500
Message-ID: <20061127165122.GB6616@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org> <20061127084128.GD19745@spearce.org> <20061127103111.4835bffc.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 16:51:52 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061127103111.4835bffc.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32428>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gojha-0004oS-Nd for gcvg-git@gmane.org; Mon, 27 Nov
 2006 17:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758248AbWK0Qv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 11:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758365AbWK0Qv2
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 11:51:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57572 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758248AbWK0Qv1
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 11:51:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GojhO-0003ei-8G; Mon, 27 Nov 2006 11:51:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1A7EF20FB7F; Mon, 27 Nov 2006 11:51:23 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Mon, 27 Nov 2006 03:41:28 -0500
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> 
> > Many users want to display the current branch name of the current git
> > repository as part of their PS1 prompt, much as their PS1 prompt might
> > also display the current working directory name.
> > 
> > We don't force our own PS1 onto the user.  Instead we let them craft
> > their own PS1 string and offer them the function __git_ps1 which they
> > can invoke to obtain either "" (when not in a git repository) or
> > "(%s)" where %s is the name of the current branch, as read from HEAD,
> > with the leading refs/heads/ removed.
> 
> Suppose it doesn't hurt to include support for this in git completion
> scripts.  It doesn't look like __git_ps1 is a proper name though,
> perhaps __git_branch or __git_current_branch would be better?

I actually started with the name __git_current_branch but changed
my mind on that and went with __git_ps1.

My rationale at the time was probably not correct (it was early this
morning) but I figured that the current branch name is "master"
while __git_ps1 prints " (master)".  Therefore __git_ps1 is not
really printing the current branch, its printing the current branch
and other stuff.  So I went with a name which implied its purpose.

-- 
