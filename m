X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Idea for rebase strategy
Date: Mon, 27 Nov 2006 01:15:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611270108160.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 00:15:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32372>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoU9b-0000x1-Mk for gcvg-git@gmane.org; Mon, 27 Nov
 2006 01:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755309AbWK0APS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 19:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755350AbWK0APS
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 19:15:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:41890 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755309AbWK0APQ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 19:15:16 -0500
Received: (qmail invoked by alias); 27 Nov 2006 00:15:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 27 Nov 2006 01:15:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

an idea hit me today: maybe we can make rebase work nicely with merges 
after all. We could record the original branch point and the new branch 
point for rebases.

If this information is somehow accessible when doing a merge, git could 
check if the old branch point is reachable from the current HEAD, but not 
the new branch point, and if both are the case, rebase the changes since 
the old branch point on top of the new branch point before trying to 
merge.

Does this sound too far-fetched?

Ciao,
Dscho
