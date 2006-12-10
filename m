X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remove "[PATCH]" prefix from shortlog output
Date: Mon, 11 Dec 2006 00:41:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612110040260.1471@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0612091954010.2630@xanadu.home>
 <Pine.LNX.4.63.0612102337090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac1v2uom.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 23:41:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vac1v2uom.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33963>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYIn-00012D-3C for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756986AbWLJXlo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762540AbWLJXln
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:41:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:42174 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1756986AbWLJXln
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 18:41:43 -0500
Received: (qmail invoked by alias); 10 Dec 2006 23:41:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 11 Dec 2006 00:41:41 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 10 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It tries not only to strip "[PATCH]", but also "[PATCH 0/n]" and basically 
> > every prefix beginning with "[PATCH" and ending in "]". I do not remember 
> > if I really tested that code, but it should work.
> 
> The problem is that you forgot that the lines are indented when
> acting as a filter.

Of course!

And your patch looks correct to me.
Ciao,
