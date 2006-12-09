X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: builtin git-shortlog still broken
Date: Sun, 10 Dec 2006 00:34:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612100034010.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 23:34:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33848>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtBiS-0007rW-7w for gcvg-git@gmane.org; Sun, 10 Dec
 2006 00:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759781AbWLIXem (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 18:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759816AbWLIXel
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 18:34:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:38219 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759781AbWLIXel
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 18:34:41 -0500
Received: (qmail invoked by alias); 09 Dec 2006 23:34:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 10 Dec 2006 00:34:39 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 8 Dec 2006, Nicolas Pitre wrote:

> On the Linux kernel repository, doing "git shortlog v2.6.18.." works 
> fine. "git shortlog v2.6.17.." works fine. "git shortlog v2.6.16.." also 
> works fine.  But "git shortlog v2.6.15.." dies with a segmentation 
> fault.  Trying "git log v2.6.15.. | git shortlog" also produces the same 
> crash while "git log v2.6.16.. | git shortlog" works fine.
> 
> The old perl version doesn't have any such issue with those test cases, 
> not even with the whole kernel history.

Yeah, sorry. I assumed that there are enough sanity checks for the author 
format, but evidently that is/was not the case here.

Ciao,
Dscho
