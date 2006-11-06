X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git reset --soft a merged commit
Date: Sun, 5 Nov 2006 23:50:38 -0500
Message-ID: <20061106045038.GA22985@spearce.org>
References: <fcaeb9bf0611052048r11816e76p88d568e3478c354b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 04:50:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0611052048r11816e76p88d568e3478c354b@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30992>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgwRa-0003Rr-Fk for gcvg-git@gmane.org; Mon, 06 Nov
 2006 05:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423499AbWKFEun (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 23:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423502AbWKFEun
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 23:50:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53676 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1423499AbWKFEum
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 23:50:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgwRH-0000iT-Hm; Sun, 05 Nov 2006 23:50:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8C37A20E491; Sun,  5 Nov 2006 23:50:38 -0500 (EST)
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hi,
> I did "git reset --soft HEAD~1" where HEAD is a merged commit and
> committed again (nothing changed).  The new commit was not recorded as
> a merged commit. Is it intentional?

Yes, you undid the merge.  :-(

-- 
