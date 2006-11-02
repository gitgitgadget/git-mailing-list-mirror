X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor documentation problems [RFC PATCH]
Date: Thu, 2 Nov 2006 14:54:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021448100.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <vpqmz7a1694.fsf@ecrins.imag.fr> <BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 13:55:15 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30751>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfd1t-0007ek-5K for gcvg-git@gmane.org; Thu, 02 Nov
 2006 14:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752875AbWKBNy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 08:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbWKBNy1
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 08:54:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:59102 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752875AbWKBNy0 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 08:54:26 -0500
Received: (qmail invoked by alias); 02 Nov 2006 13:54:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp001) with SMTP; 02 Nov 2006 14:54:25 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 2 Nov 2006, Sean wrote:

> The patch below always updates ~/.gitconfig but perhaps it
> should respect GIT_CONFIG and/or GIT_CONFIG_LOCAL
> environment variables.

Your patch would be loads shorter and easier to read if you'd just 
override the GIT_CONFIG environment variable (like --git-dir sets 
GIT_DIR).

Ciao,
Dscho
