X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-explain
Date: Wed, 6 Dec 2006 00:37:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612060033540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> <7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
 <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net> <el3ibq$9kn$2@sea.gmane.org>
 <46a038f90612051500w44438f70y3c7d1c99998d16bb@mail.gmail.com>
 <7vslfudjsa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 23:38:06 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslfudjsa.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33389>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrjrM-0007lL-J0 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 00:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752629AbWLEXh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 18:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756677AbWLEXh5
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 18:37:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:45233 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752629AbWLEXh4
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 18:37:56 -0500
Received: (qmail invoked by alias); 05 Dec 2006 23:37:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 06 Dec 2006 00:37:54 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Junio C Hamano wrote:

> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> 
> > I like what it does too... but why not as part of git-status?
> 
> The biggest reason was that it is a demonstration of concepts,
> not replacement of anything.  Maybe "git status" can be replaced
> with something like that if people worked on it enough.

Okay, so what do people need? This is evidently a question for people who 
are not intimately familiar with the core of Git. So, where are you 
newbies when we need you? Speak up!

Surely, you hit a wall on the road, where you really wanted to ask "git 
wtf"?

> The current use of "git status" inside "git commit" needs to be revamped 
> if we pursue this further, though.  Because one of the points the "what 
> state is this repository in" check "explain" does is to define what 
> operations are sensible in each state, and most likely in many state it 
> would not make _any_ sense to run "git commit" (say, in the middle of 
> "bisect").

That is right, but it is only a matter of having a command line switch to 
suppress what you do not need for the commit message. After all, "status" 
really should tell you about the status of the working directory. The fact 
that we have the _same_ script for "commit" and "status" is no excuse!

Ciao,
Dscho
