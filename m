X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: pass --no-left-right to rev-list
Date: Tue, 19 Dec 2006 11:47:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612191147160.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061219100534.GA9206@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 10:48:15 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Paul Mackerras <paulus@samba.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061219100534.GA9206@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34820>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcVh-0004t9-Bf for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932740AbWLSKrq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWLSKrq
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:47:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:56907 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932740AbWLSKrp
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 05:47:45 -0500
Received: (qmail invoked by alias); 19 Dec 2006 10:47:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp003) with SMTP; 19 Dec 2006 11:47:44 +0100
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Jeff King wrote:

> I think there are three fixes:
>   1. this patch (avoid using left-right)
>   2. gitk can detect and parse the new format
>   3. revert automatic use of left-right
> The third makes the most sense to me.

IMHO 2. is the way to go.

Ciao,
