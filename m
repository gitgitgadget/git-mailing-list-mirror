X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so large)?
Date: Tue, 21 Nov 2006 11:56:56 -0500
Message-ID: <20061121165656.GC22006@spearce.org>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org> <45632EC6.5030902@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 16:57:29 +0000 (UTC)
Cc: Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45632EC6.5030902@freescale.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32003>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYvk-0005KT-KO for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031054AbWKUQ5F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031057AbWKUQ5E
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:57:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40644 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031054AbWKUQ5C
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:57:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmYvU-0001Yf-LA; Tue, 21 Nov 2006 11:56:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B52D020FB09; Tue, 21 Nov 2006 11:56:56 -0500 (EST)
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org

Timur Tabi <timur@freescale.com> wrote:
> >Shallow clone is a development feature still being working on in
> >Junio's 'pu' branch of git.git.  It has a few issues still to be
> >worked out so it hasn't been made part of one of the more stable
> >branches yet (like 'next', 'master', or 'maint').
> 
> Well, until it's available on an official git release, it doesn't help me.

One of the reasons its hanging out in 'pu' still is that there is
a lack of people who are interested in the feature, and thus not
enough people are testing it.  Perhaps you might be able to lend
a hand in that regard?

-- 
