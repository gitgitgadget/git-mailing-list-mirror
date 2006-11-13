X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] FIX git pull failure with shallow clone changes
Date: Mon, 13 Nov 2006 13:26:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611131325110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4552A865.5000201@gmail.com> <45541503.4020604@gmail.com>
 <45541BBE.4070303@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 13 Nov 2006 12:28:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45541BBE.4070303@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31295>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjaut-0003Nu-L5 for gcvg-git@gmane.org; Mon, 13 Nov
 2006 13:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754560AbWKMM0V (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 07:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbWKMM0V
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 07:26:21 -0500
Received: from mail.gmx.de ([213.165.64.20]:30147 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1754560AbWKMM0T (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 07:26:19 -0500
Received: (qmail invoked by alias); 13 Nov 2006 12:26:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 13 Nov 2006 13:26:18 +0100
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

I overlooked that the http transport uses the variable "depth" already, 
which your patch fixes.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
