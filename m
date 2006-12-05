X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: egit/jgit wishlist
Date: Tue, 5 Dec 2006 09:37:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612050922590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061204172836.GB6011@spearce.org> <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net>
 <20061204182902.GG6011@spearce.org> <457490EE.30606@midwinter.com>
 <Pine.LNX.4.63.0612042235270.14187@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 08:37:49 +0000 (UTC)
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0612042235270.14187@alpha.polcom.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33317>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrVo9-0003or-FJ for gcvg-git@gmane.org; Tue, 05 Dec
 2006 09:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968074AbWLEIhm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 03:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968076AbWLEIhm
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 03:37:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:50052 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S968074AbWLEIhl
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 03:37:41 -0500
Received: (qmail invoked by alias); 05 Dec 2006 08:37:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp004) with SMTP; 05 Dec 2006 09:37:37 +0100
To: Grzegorz Kulewski <kangur@polcom.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Grzegorz Kulewski wrote:

> But it will be working (== end user usable) after many months not days.

Not really. JNI is not that easy to get to work, you know? _Especially_ 
with cygwin, where you have to transform pathnames from native to posix 
format.

It is much work, for just a temporary solution.

> And please note that Java is not that portable as many people are 
> suggesting.

But it is.

There are more official Java engines than just those from Sun. For 
example, I worked on an SGI machine, where I did not have enough quota to 
install gcc and friends, but Java.

Also, now that it will be GPLed, you can be sure that even more platforms 
become supported.

And the most important aspect of portability: You really can run the 
compiled code anywhere. This is in stark contrast to C, C#, Perl, etc.

> Maybe it will change but currently I will bet C + bash + perl (+ 
> python?) is more portable than Java.

You lost.

> Java (J2SE) is officially supported mainly under Windows, Solaris, Linux 
> and maybe Mac. There are more ports but unfortunatelly way too many of 
> them are old, buggy, have not full library implementations or something 
> like that.

Aha. But you don't need them. For example, you do not need a full working 
CORBA library, or JDBC, or whatever. Java 1.1 should be sufficient (except 
for that stupid mmap bug).

> Eclipse also currently works only under Windows, Linux and Mac.

This a completely different beef. IBM, in its infinite wisdom, decided to 
scrap the platform independent Swing UI, and made its own (SWT). In C++. 
Yes, you need to compile it for _every_ platform you want to run Eclipse 
on. Brilliant.

> Can you name one system where Java (J2SE 1.4 or better 1.5) works 
> (fully, not sometimes) and where GIT does not work?

As has been said, Windows. Oh, and some mobile phones. And some embedded 
devices. Maybe even VMS.

Ciao,
Dscho
