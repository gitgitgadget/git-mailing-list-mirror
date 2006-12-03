X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Convert author and comment on demand.
Date: Sat, 2 Dec 2006 21:16:55 -0500
Message-ID: <20061203021655.GA26668@spearce.org>
References: <200612030145.09576.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 02:17:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612030145.09576.robin.rosenberg@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33084>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqguc-0000iX-O0 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 03:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759494AbWLCCRA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 21:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759495AbWLCCRA
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 21:17:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49047 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1759494AbWLCCQ7
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 21:16:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GqguM-0000Hf-FS; Sat, 02 Dec 2006 21:16:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CCEF520FB7F; Sat,  2 Dec 2006 21:16:55 -0500 (EST)
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This sppeds up reading commits a lot by only store the byte
> array data when reading commits.

Thanks.  I was working on something similar but did not have
a chance to finish it.  I've applied your patch instead.

> +	    try {
> +        	BufferedReader br=new BufferedReader(new InputStreamReader(new 
> ByteArrayInputStream(raw)));
> +        	String n=br.readLine();

Something's wrong with your mail client... the patch was mangled.

-- 
