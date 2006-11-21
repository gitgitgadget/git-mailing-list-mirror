X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so
 large)?
Date: Tue, 21 Nov 2006 23:06:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611212306060.26827@wbgn013.biozentrum.uni-wuerzburg.de>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net>
 <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org>
 <45632EC6.5030902@freescale.com> <20061121165656.GC22006@spearce.org>
 <456330CD.9080503@freescale.com> <20061121183941.GB22283@spearce.org>
 <45637457.1010505@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 22:07:47 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45637457.1010505@freescale.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32044>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmdm0-0003mh-QD for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031243AbWKUWHI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031294AbWKUWHI
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:07:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:37780 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031243AbWKUWHA (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:07:00 -0500
Received: (qmail invoked by alias); 21 Nov 2006 22:06:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 21 Nov 2006 23:06:58 +0100
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 21 Nov 2006, Timur Tabi wrote:

> Shawn Pearce wrote:
> 
> > finally you can either run from that directory (see INSTALL file)
> > or you can install the binary somewhere else.  We don't really
> > recommend using `pu` for production level work, so make sure you
> > have a backup of any repository you run it on.  :)
> 
> So how do I make a shallow clone?  I've set it all up, but there is no
> git-shallow-clone command, and git help clone doesn't have anything either.

Try "git clone --depth 1 <url>". This will cut each ancestor chain after 
one ancestor (IIRC).

Ciao,
Dscho
