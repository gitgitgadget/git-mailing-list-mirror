X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge: preserve and merge local changes when doing
 fast forward
Date: Thu, 30 Nov 2006 11:32:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611301129410.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wnlmyba.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 10:32:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wnlmyba.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32719>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpjDA-0006Z6-3o for gcvg-git@gmane.org; Thu, 30 Nov
 2006 11:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934527AbWK3KcI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 05:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934540AbWK3KcI
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 05:32:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:421 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S934527AbWK3KcF (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 05:32:05 -0500
Received: (qmail invoked by alias); 30 Nov 2006 10:32:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 30 Nov 2006 11:32:04 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Junio C Hamano wrote:

> Perhaps we would want a new option to git-merge to allow preserving the 
> local changes, but the obvious candidate -m is taken for something else 
> per recent popular request X-<...

How about "-k|--keep-changes" or "-l|--local-changes", or 
"-p|--preserve-changes"?

BTW from a user's perspective, this operation _is_ a merge, not a 
checkout. So, IMHO the compatibility with that rarely used option of 
git-checkout is neglectable.

Ciao,
