X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit
 hooks
Date: Wed, 20 Dec 2006 17:09:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612201708420.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612201309.02119.andyparkins@gmail.com>
 <200612201347.13805.andyparkins@gmail.com> <458949C4.1020207@dawes.za.net>
 <200612201440.41784.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 16:09:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612201440.41784.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34944>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx40r-00072q-QA for gcvg-git@gmane.org; Wed, 20 Dec
 2006 17:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030181AbWLTQJr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 11:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWLTQJr
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 11:09:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:41250 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030188AbWLTQJq
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 11:09:46 -0500
Received: (qmail invoked by alias); 20 Dec 2006 16:09:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 20 Dec 2006 17:09:44 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 20 Dec 2006, Andy Parkins wrote:

>  Before now, I've replaced files in C by doing
> 
>  fd_old = open( "someexistingfile" );
>  unlink( "someexistingfile" );
>  fd_new = open( "someexistingfile" );

Lucky you! Obiously you are not stuck in the 10th circle called Windows.

Ciao,
