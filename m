X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitk with arguments fails on OSX
Date: Wed, 29 Nov 2006 16:10:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291609370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <864psixpj6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 15:10:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <864psixpj6.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32644>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpR4f-00067b-3z for gcvg-git@gmane.org; Wed, 29 Nov
 2006 16:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967401AbWK2PKI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 10:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967400AbWK2PKI
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 10:10:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:49358 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967402AbWK2PKG (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 10:10:06 -0500
Received: (qmail invoked by alias); 29 Nov 2006 15:10:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp035) with SMTP; 29 Nov 2006 16:10:05 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Randal L. Schwartz wrote:

> 
> Using the native "wish", gitk fails on OSX 10.4 if given any arguments.
> For example, the failure for "gitk --all" is:
> 
>     localhost.local:~/MIRROR/git-GIT % gitk --all
>     Error in startup script: unknown option "-state"
>         while executing

Known problem:

http://thread.gmane.org/gmane.comp.version-control.git/31266/focus=31266

Hth,
Dscho
