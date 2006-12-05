X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Tue, 5 Dec 2006 19:36:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051926360.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 18:36:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4575B32F.5060108@ramsay1.demon.co.uk>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33362>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grf9p-00057R-Ta for gcvg-git@gmane.org; Tue, 05 Dec
 2006 19:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968586AbWLESgn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 13:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968587AbWLESgn
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 13:36:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:60160 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S968586AbWLESgm
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 13:36:42 -0500
Received: (qmail invoked by alias); 05 Dec 2006 18:36:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp044) with SMTP; 05 Dec 2006 19:36:36 +0100
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Ramsay Jones wrote:

> Have you had time to look at my test cases?

Not really. Besides, I did _not_ implement a full diff3, but _just_ the 
merge. I.e. my function does not output anything, but (in theory) fills a 
buffer with what merge would have written into the first file.

However, once I understand how your tests work, I'll try to concoct a test 
script for git-with-xdl_merge.

Ciao,
