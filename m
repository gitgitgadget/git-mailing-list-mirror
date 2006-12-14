X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "master" should be treated no differently from any other
   branch
Date: Thu, 14 Dec 2006 16:57:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141655400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612141519.44294.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <4581721B.4050102@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 15:58:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4581721B.4050102@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34357>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gusy2-0001t2-Oy for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932836AbWLNP5u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932839AbWLNP5u
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:57:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:36112 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932836AbWLNP5t
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 10:57:49 -0500
Received: (qmail invoked by alias); 14 Dec 2006 15:57:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 14 Dec 2006 16:57:48 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> > Hi,
> > 
> > On Thu, 14 Dec 2006, Andy Parkins wrote:
> > 
> >> "master" shouldn't get special treatment; making different log messages 
> >> based on the name of the branch is bad form.  What if a user likes 
> >> "my/master" or "my/head" as their master branch?
> > 
> > I do not agree. There is usually a principal branch, where you collect the 
> > topics, and you do want to treat that special. As for the name: better 
> > have a convention here than configurability. You would not want "git" to 
> > be called "guitar" for some users, just because they happen to like that 
> > name more, either, right?
> 
> Disagree: I have two principal branches, master and stable/2.10.  I 
> don't see why the latter should get different commit messages.

Well, in your case I would even more strongly argue that "Merging into 
master" bears no more information than "Merging", since "master" is too 
generic a name. Since "stable/2.10" is more specific, the same reasoning 
does not apply here.

Ciao,
Dscho
