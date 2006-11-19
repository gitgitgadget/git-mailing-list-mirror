X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sun, 19 Nov 2006 16:17:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611191547460.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net> <7v1wo0bb4z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 15:17:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wo0bb4z.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31833>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GloQE-0004jW-Gd for gcvg-git@gmane.org; Sun, 19 Nov
 2006 16:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756713AbWKSPRV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 10:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756714AbWKSPRV
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 10:17:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:27085 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1756713AbWKSPRU (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 10:17:20 -0500
Received: (qmail invoked by alias); 19 Nov 2006 15:17:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 19 Nov 2006 16:17:18 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 18 Nov 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> >  - 'pu' has the shallow clone WIP and a half-finished rewrite of
> >    git branch in C, both by Johannes.  Both needs a bit more
> >    polishing and confidence building before going into 'next',
> >    and given the recent discussion of enhancing branch
> >    management for pulls/pushes, it might be easier to drop the
> >    latter for now.
> 
> OOPS; sorry but the latter half is entirely untrue.  What's
> there is half-done git-shortlog.  Scratch everything about
> branch management please.

IMHO -shortlog needs support to read .mailmap, and maybe nods to throw out 
the built-in mailmap which is totally specific to the Linux kernel 
development.

As for shallow clone support: I am a bit underwhelmed by the enthusiasm 
to test this thing by the people I thought would be most interested. It 
really could be the case that it is not needed at all.

Just for the record, though: AFAICT the shallow stuff is lacking support 
for at least pushing from/into shallow repos and it should avoid making a 
commit shallow unnecessarily. And quite likely there are a few thinkos in 
it, so it would not hurt having more test cases (notably of things I did 
not think of), and some bad-ass testing with huge amounts of commits and 
files which were added/modified identically in different commits.

Ciao,
Dscho

