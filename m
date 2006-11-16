X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 00:01:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611170000420.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org>
 <20061115180722.83ff8990.seanlkml@sympatico.ca> <20061115231542.GB25270@spearce.org>
 <20061116075153.GA29363@tigerwolf.bri.st.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 23:02:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061116075153.GA29363@tigerwolf.bri.st.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31633>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkqF7-0004AD-3y for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755498AbWKPXBj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbWKPXBj
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:01:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:3712 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755499AbWKPXBi (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:01:38 -0500
Received: (qmail invoked by alias); 16 Nov 2006 23:01:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 17 Nov 2006 00:01:36 +0100
To: Richard CURNOW <richard.curnow@st.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 16 Nov 2006, Richard CURNOW wrote:

> In contrast to Linus's case of wanting to record where the remote merge
> came from, I expressly don't want to record that - I want the merge
> commit to describe conceptually what was being merged with what.
> 
> OK, I could use probably use pull with --no-commit, but I've already
> trained my fingers to type out the merge syntax.  They'd be happier with
> 'git merge -m "Merge feature foo with fixes for bar" bar" though.

For the moment, if you forget --no-commit, you can always do a "git-commit 
--amend" -- even with merges.

Hth,
Dscho
