X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [checkout-index] Give names to stages
Date: Mon, 4 Dec 2006 12:39:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612041237490.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <505428.75434.qm@web31808.mail.mud.yahoo.com>
 <Pine.LNX.4.63.0612041149410.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el113s$25v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 11:39:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el113s$25v$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33192>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrCAT-00072O-RU for gcvg-git@gmane.org; Mon, 04 Dec
 2006 12:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936089AbWLDLj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 06:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936051AbWLDLj1
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 06:39:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:3528 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936089AbWLDLj0 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 06:39:26 -0500
Received: (qmail invoked by alias); 04 Dec 2006 11:39:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp013) with SMTP; 04 Dec 2006 12:39:24 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Sun, 3 Dec 2006, Luben Tuikov wrote:
> > 
> >> This patch merely allows the user to say
> >>    git-checkout-index --stage=ours their_broken_file.c
> >> instead of
> >>    git-checkout-index --stage=2 their_broken_file.c
> >> and similarly for "theirs", etc.
> > 
> > Dunno. When this problem hits me, I usually do
> > 
> >       git diff --theirs their_broken_file.c
> > 
> > anyway, to see what it is doing (colour and all). When I am satisfied, 
> > that "theirs" is really what I want, I just go back one in history, and 
> > append a call to git-apply like this:
> > 
> >       git diff --theirs their_broken_file.c | git apply --index
> 
> Then
> 
>         git checkout --theirs their_broken_file.c
> 
> is obvious simplification.

Obvious maybe. But simplification, not to me. Especially since the way I 
call it, there is less possibility to shoot myself into the foot.

But then, I do not really care.

Ciao,
Dscho
