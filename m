X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Remote 'master' not updated, but works somehow
Date: Thu, 7 Dec 2006 06:49:22 -0500
Message-ID: <20061207114922.GC10781@spearce.org>
References: <4577FBAB.4070802@op5.se> <4577FC6A.9050707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 11:49:41 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4577FC6A.9050707@op5.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33572>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsHko-0001jP-Rf for gcvg-git@gmane.org; Thu, 07 Dec
 2006 12:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032077AbWLGLt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 06:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032080AbWLGLt1
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 06:49:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38408 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1032077AbWLGLt0 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 06:49:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsHkf-0008WT-DQ; Thu, 07 Dec 2006 06:49:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 968C120FB6E; Thu,  7 Dec 2006 06:49:22 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> wrote:
> scratch this. I just noticed I had somehow managed to get the directory 
> setup like this:
> 
> devel:softpub/mkpub.git       <-- a real repo
> devel:softpub/mkpub.git/.git  <-- the repo that got pushed to

One's gotta wonder how that's ever a valid directory setup...

Although I'm running a configuration of:

  root/proj.git                        <-- a real repo
  root/proj.git/info/new-commit-check  <-- a fake repo

where new-commit-check has root/proj.git not only as an alternate
ODB but also has root/proj.git/refs symlinked into its own refs
directory.

-- 
