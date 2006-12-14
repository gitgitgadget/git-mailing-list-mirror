X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 17:38:13 -0500
Message-ID: <20061214223813.GC26202@spearce.org>
References: <20061214194636.GO1747@spearce.org> <200612142212.kBEMCVeu032626@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 22:38:30 +0000 (UTC)
Cc: Geert Bosch <bosch@adacore.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612142212.kBEMCVeu032626@laptop13.inf.utfsm.cl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34419>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzDd-0003YD-Nt for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964929AbWLNWiW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWLNWiW
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:38:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39775 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964942AbWLNWiV (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 17:38:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuzDJ-0001Ti-Ia; Thu, 14 Dec 2006 17:38:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5D7B320FB65; Thu, 14 Dec 2006 17:38:13 -0500 (EST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> [...]
> 
> > And yet I get good delta compression on a number of ZIP formatted
> > files which don't get good additional zlib compression (<3%).
> 
> .zip is something like a tar of the compressed files, if the files inside
> the archive don't change, the deltas will be small.

Yes, especially when the new zip is made using the exact same
software with the same parameters, so the resulting compressed file
stream is identical for files whose content has not changed.  :-)

Since this is actually a JAR full of Java classes which have
been recompiled, its even more interesting that javac produced an
identical class file given the same input.  I've seen times where
it doesn't thanks to the automatic serialVersionUID field being
somewhat randomly generated.

-- 
