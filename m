X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: branch rebase and push
Date: Tue, 19 Dec 2006 13:13:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612191311060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45875EFC.5090408@gmail.com> <em8cti$nff$1@sea.gmane.org>
 <4587BD31.9030804@gmail.com> <200612191258.55226.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 12:13:53 +0000 (UTC)
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612191258.55226.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34826>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwdqx-0005iE-4A for gcvg-git@gmane.org; Tue, 19 Dec
 2006 13:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932804AbWLSMNs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 07:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbWLSMNs
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 07:13:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:45165 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932804AbWLSMNr
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 07:13:47 -0500
Received: (qmail invoked by alias); 19 Dec 2006 12:13:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 19 Dec 2006 13:13:46 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Jakub Narebski wrote:

> SungHyun Nam wrote:
> 
> > I'm sorry... but could you teach me how I publish the rebased branch?
> > I think Junio does it for 'pu' branch.
> > Is there recommended workflow? I cannot find.
> 
> Either have "Push:+refs/heads/br:refs/heads/br" in your
> .git/remotes/<name> file, or it's equivalent config file
> version, with '+' denoting that this branch sometimes does
> not fast-forward.
> 
> Or use git push with --force option when you had rebased.
> 
> And of course the server you push to has to not have config variable 
> receive.denyNonFastForwards set to true.

If that is the case, there is a work-around, which happens to be also nice 
to tracking parties:

	$ git pull -s ours <remote> <branch>
	$ git push <remote> <branch>

The disadvantage (which I'd argue is actually an advantage) is that you do 
not lose history. After all: "those who do not learn from history are 
doomed to repeat it".

Ciao,
Dscho
