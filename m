X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 2 Nov 2006 11:59:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021158430.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>
 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>
 <4549CE2A.3010808@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 10:59:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4549CE2A.3010808@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30715>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaI2-0001VL-U9 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752828AbWKBK7O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbWKBK7O
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:59:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:33464 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752828AbWKBK7O (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:59:14 -0500
Received: (qmail invoked by alias); 02 Nov 2006 10:59:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 02 Nov 2006 11:59:12 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 2 Nov 2006, Han-Wen Nienhuys wrote:

> [lilydev@haring git]$ git describe
> v1.4.3.3-g1e1f76e
> [lilydev@haring git]$ git show g1e1f76e

You'd want to do

	git show v1.4.3.3-g1e1f76e

Hth,
