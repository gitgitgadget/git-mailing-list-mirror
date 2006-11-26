X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] grep: do not skip unmerged entries when grepping in the working tree.
Date: Sun, 26 Nov 2006 22:30:01 +0100
Message-ID: <200611262230.01948.johannes.sixt@telecom.at>
References: <ekc9q7$36e$1@sea.gmane.org> <7vvel2rl05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 21:30:25 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vvel2rl05.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32368>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoRZs-0006qv-Qc for gcvg-git@gmane.org; Sun, 26 Nov
 2006 22:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935577AbWKZVaL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 16:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757999AbWKZVaL
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 16:30:11 -0500
Received: from mail.nextra.at ([195.170.70.67]:42495 "EHLO mail.nextra.at")
 by vger.kernel.org with ESMTP id S1757998AbWKZVaK (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 16:30:10 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at
 [194.118.45.19]) by mail.nextra.at (8.13.7/8.13.6) with ESMTP id
 kAQLUNf6028189; Sun, 26 Nov 2006 22:30:24 +0100 (MET)
Received: from localhost (localhost [127.0.0.1]) by dx.sixt.local (Postfix)
 with ESMTP id 9561639341; Sun, 26 Nov 2006 22:30:02 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 26 November 2006 21:49, Junio C Hamano wrote:
> We used to skip unmerged entries, which made sense for grepping
> in the cached copies, but not for grepping in the files on the
> working tree.
>
> Noticed by Johannes Sixt.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>

This fixes my problem. Thanks!

