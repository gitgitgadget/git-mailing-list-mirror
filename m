X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetching from a big repository is slow
Date: Fri, 15 Dec 2006 01:07:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612150105450.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se>
 <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
 <20061214194636.GO1747@spearce.org> <Pine.LNX.4.63.0612150013390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061214232936.GH26202@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 15 Dec 2006 00:07:35 +0000 (UTC)
Cc: Geert Bosch <bosch@adacore.com>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214232936.GH26202@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34446>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0bq-0006Hs-ED for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752030AbWLOAH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbWLOAH1
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:07:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:55340 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752030AbWLOAH0
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 19:07:26 -0500
Received: (qmail invoked by alias); 15 Dec 2006 00:07:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp012) with SMTP; 15 Dec 2006 01:07:25 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> I'm OK with a small increase in packfile size as a result of slightly 
> less optimal delta base selection on the really large binary files due 
> to something like the above, but 10x is insane.

Not if it is a server having to do all the work. Along with all the work 
for all other clients. When you do a fetch, you really should be nice to 
the serving side.

Ciao,
Dscho
