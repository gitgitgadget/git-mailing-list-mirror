X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so large)?
Date: Tue, 21 Nov 2006 11:32:06 -0500
Message-ID: <20061121163206.GA22006@spearce.org>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 16:34:18 +0000 (UTC)
Cc: Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45632957.5070205@freescale.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31998>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYZJ-0007Z2-R6 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031181AbWKUQcm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031176AbWKUQcS
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:32:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42943 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031181AbWKUQcO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:32:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmYXS-0006lt-8S; Tue, 21 Nov 2006 11:32:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6176420FB09; Tue, 21 Nov 2006 11:32:06 -0500 (EST)
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org

Timur Tabi <timur@freescale.com> wrote:
> Thomas Kolejka wrote:
> 
> >Is it possible to do this with shallow clone? 
> 
> Maybe.  How do you do a shallow clone?  I tried "git clone" followed by 
> "git-repack", and that helped a lot, but the result was still twice the 
> size of a normal tarball.  I don't see any "shallow" option to the clone 
> command, and git-shallow-pack doesn't exist on my installation.

Twice the size of a normal tarball isn't too bad, considering that
you have the _complete_ history in the pack and yet the normal
tarball has no history at all.

Shallow clone is a development feature still being working on in
Junio's 'pu' branch of git.git.  It has a few issues still to be
worked out so it hasn't been made part of one of the more stable
branches yet (like 'next', 'master', or 'maint').

-- 
