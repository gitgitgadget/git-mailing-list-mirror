X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Uninstall rule for top level Makefile
Date: Tue, 12 Dec 2006 15:15:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121512060.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612112214.09735.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612121325000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612121251.33051.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 14:15:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612121251.33051.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34100>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu8Pw-0007DS-5F for gcvg-git@gmane.org; Tue, 12 Dec
 2006 15:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751306AbWLLOPd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 09:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWLLOPd
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 09:15:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:33166 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751306AbWLLOPc
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 09:15:32 -0500
Received: (qmail invoked by alias); 12 Dec 2006 14:15:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 12 Dec 2006 15:15:29 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Andy Parkins wrote:

> I assume I've missed something in the linked thread - what was it you 
> wanted me to pick up from it?

The uninstall target _only_ solves the case you mentioned: when you 
installed Git in the wrong place. But then it is fragile: if you put the 
new path into config.mak, or you provided the PREFIX on the command line, 
and possibly do not remember what it was, the uninstall goes wrong.

But then, I do not care at all about that target being in the Makefile or 
not. I'll just ignore it, just as almost everybody else.

Ciao,
Dscho
