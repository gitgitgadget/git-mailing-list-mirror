X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Diffs from CVS keyword expansion
Date: Tue, 5 Dec 2006 20:48:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612052048230.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
 <20061205121443.GB2428@cepheus> <86k616m8i9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 19:49:14 +0000 (UTC)
Cc: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <86k616m8i9.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33368>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrgHq-0007u2-58 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 20:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030618AbWLETs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 14:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWLETs4
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 14:48:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:35934 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030618AbWLETsz
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 14:48:55 -0500
Received: (qmail invoked by alias); 05 Dec 2006 19:48:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 05 Dec 2006 20:48:52 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Uwe" == Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de> writes:
> 
> Uwe> 	#! /bin/sh
> Uwe> 	exec perl -i -p -e 's/\$(Id|Revision):.*?\$/\$$1: \$/' "$@";
> 
> Ow.  My eyes hurt from that.  How about we rewrite that as a native Perl
> script:
> 
>     #!/usr/bin/perl
>     $^I = ""; # this is -i
>     while (<>) {
>       s/\$(Id|Revision):.*?\$/\$$1: \$/;
>       print;
>     }

Hey, that's better! All of a sudden, I understand everything!

Not,
Dscho
