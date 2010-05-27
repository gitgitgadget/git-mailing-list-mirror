Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_MSGID,MSGID_NOFQDN1,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 18146 invoked by uid 107); 27 May 2010 08:52:01 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 27 May 2010 04:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757665Ab0E0Ivw (ORCPT <rfc822;peff@peff.net>);
	Thu, 27 May 2010 04:51:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:41351 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757581Ab0E0Ivv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 04:51:51 -0400
Received: (qmail invoked by alias); 27 May 2010 08:51:49 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp014) with SMTP; 27 May 2010 10:51:49 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX1+AAYB0iCKASUFyDgMcBSeYMnRkCeSRBI6yR/lV/8
	rJb07oDq+Uhd4D
Date:	Thu, 27 May 2010 10:51:47 +0200
From:	Konrad Karl <kk_konrad@gmx.at>
To:	git@vger.kernel.org
Subject: Re: .gitignore: according to what rules does this work - SOLVED
Message-ID: <20100527085147.GB29598localhost>
References: <20100526162306.GA27815localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100526162306.GA27815localhost>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This was actually a non-issue... see below
Konrad

On Wed, May 26, 2010 at 06:23:06PM +0200, Konrad Karl wrote:
> I have the following directory layout and want to exclude
> dir2 .. dirN
> 
> The following arrangement of .gitignore seems to work ok
> but I was unable to find docs about the double asterisks.
> 
> ./.gitignore:
> 
> *
> */
> !.gitignore
> !/dir1/
> 
> 
> dir1/.gitignore:
> 
> !**
> !**/
> 

There was a trailing blank after the first
asterisk. When trying  with two asterisks in despair
I started with a fresh file with no trailing blank.

Somewhat difficult to diagnose (now I am knowing better :)
 
