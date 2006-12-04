X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Seeing added and removed files between two tree states
Date: Mon, 4 Dec 2006 12:33:20 -0500
Message-ID: <20061204173320.GD6011@spearce.org>
References: <1165253146.32764.3.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 17:33:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1165253146.32764.3.camel@okra.transitives.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33207>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrHh6-0004Wk-K8 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 18:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758514AbWLDRd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 12:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758497AbWLDRd0
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 12:33:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37702 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758514AbWLDRdY (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 12:33:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GrHhh-00037F-Fy; Mon, 04 Dec 2006 12:34:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C595220FB7F; Mon,  4 Dec 2006 12:33:20 -0500 (EST)
To: Alex Bennee <kernel-hacker@bennee.com>
Sender: git-owner@vger.kernel.org

Alex Bennee <kernel-hacker@bennee.com> wrote:
> In there a way to see just what files where added between two points in
> the tree? I want something better than parsing the diffstat.

[spearce@pb15 git]$ git diff-tree -r --abbrev --diff-filter=A next build
:000000 100644 0000000... 3d53d17... A  shallow.c
:000000 100644 0000000... 1fe7a1b... A  xdiff/xmerge.c

?

-- 
