X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Seek back to current filepos when mmap()ing with NO_MMAP
Date: Wed, 15 Nov 2006 19:32:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611151932230.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0611151727000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <118833cc0611151026q25fb6eeeid3a74e20498f00d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 18:33:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <118833cc0611151026q25fb6eeeid3a74e20498f00d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31463>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPZe-0006kS-JH for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030824AbWKOScv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030826AbWKOScv
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:32:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:38357 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030824AbWKOScu (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:32:50 -0500
Received: (qmail invoked by alias); 15 Nov 2006 18:32:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 15 Nov 2006 19:32:49 +0100
To: Morten Welinder <mwelinder@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 15 Nov 2006, Morten Welinder wrote:

> Using xmalloc in there seems wrong.  A plain malloc would do and the
> error would be returned back to the mmap caller.

I did not touch that code at all in this patch.

Ciao,
Dscho
