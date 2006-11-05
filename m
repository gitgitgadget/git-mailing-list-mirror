X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Bash completion Issue?
Date: Sun, 5 Nov 2006 06:31:15 -0500
Message-ID: <20061105113115.GC4843@spearce.org>
References: <200611041236.59989.alan@chandlerfamily.org.uk> <20061105042849.GA3840@spearce.org> <200611050930.23455.alan@chandlerfamily.org.uk> <200611051122.46971.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 11:31:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611051122.46971.alan@chandlerfamily.org.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30972>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GggDk-0000Y7-3h for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932692AbWKELbT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWKELbT
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:31:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:1666 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932692AbWKELbS
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:31:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GggDZ-0000by-Dn; Sun, 05 Nov 2006 06:31:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 79ECF20E491; Sun,  5 Nov 2006 06:31:15 -0500 (EST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Alan Chandler <alan@chandlerfamily.org.uk> wrote:
>  removing the git-completion package and copying the bash completion script 
> from /usr/share/doc/git-core/contrib/completion to /etc/bash_completion.d 
> solves the problem.  I am getting completion working fine now.

Good.  :-)

Let us know if there's anything you'd like to see in the bash
completion...  I just sent out two rounds of patches for it, but
certainly still have more work to do on it.

Completion of arguments to git aliases or commands like fetch and
push when --git-dir/--bare has been used is still a little buggy.

-- 
