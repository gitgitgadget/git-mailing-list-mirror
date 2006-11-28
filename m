X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Workflow example for remote repository use of GIT
Date: Tue, 28 Nov 2006 16:15:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611281613330.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <89b129c60611280708x10a9c42fia23e6b7770971838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 15:16:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <89b129c60611280708x10a9c42fia23e6b7770971838@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32534>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4fw-0003Pj-Ra for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934629AbWK1PPK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbWK1PPJ
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:15:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:21185 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758686AbWK1PPI (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:15:08 -0500
Received: (qmail invoked by alias); 28 Nov 2006 15:15:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 28 Nov 2006 16:15:06 +0100
To: Sean Kelley <sean.v.kelley@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

all in all, a good quick start.

On Tue, 28 Nov 2006, Sean Kelley wrote:

> Getting The Latest Upstream Code into master
> 
>  git pull origin master

This gives the impression that the 2nd argument of pull specifies which 
_local_ branch stuff gets merged to. But it means that you pull into the 
_current_ branch from the _remote_ master.

Ciao,
Dscho

