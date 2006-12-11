X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file
 permission bits)
Date: Mon, 11 Dec 2006 14:33:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612111432520.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
 <19476830-E30A-42B7-AD9B-4C417D830C8E@mac.com> <457D3573.2010001@op5.se>
 <200612111313.34292.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 13:33:53 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Kyle Moffett <mrmacman_g4@mac.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612111313.34292.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34002>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtlHz-0003PC-1g for gcvg-git@gmane.org; Mon, 11 Dec
 2006 14:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762910AbWLKNdr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 08:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762912AbWLKNdq
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 08:33:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:59104 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1762910AbWLKNdq
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 08:33:46 -0500
Received: (qmail invoked by alias); 11 Dec 2006 13:33:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 11 Dec 2006 14:33:44 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 11 Dec 2006, Josef Weidendorfer wrote:

> On Monday 11 December 2006 11:39, Andreas Ericsson wrote:
> > > Import/export scripts literally require wrapping every single GIT 
> > > command with a script that changes directory a few times, reads from a 
> > > different checked-out tree, and permutes some extended-attribute data 
> > > slightly before storing it in the underlying GIT tree.  Even without 
> > > adding any new functionality whatsoever that doubles the amount of code 
> > > just for finding your repository and checking command-line arguments, 
> > > and that's a crazy trade-off to make in any situation.
> > > 
> > 
> > GIT_DIR=/some/where/else/.git git log -p
> 
> Doing this everytime you want to run a git command *is* a lot of time
> wasted for typing.
> 
> The .gitlink proposal would come in handy here: you have a simple
> file instead of .git/, which links to the real repository.

I beg your pardon; I'm just joining in. Why is a symbolic link for .git 
inacceptable?

Ciao,
Dscho
