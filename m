X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 15:40:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611281536230.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ekh2uh$nk2$1@sea.gmane.org> <200611281146.56201.andyparkins@gmail.com>
 <Pine.LNX.4.63.0611281426311.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <200611281403.36370.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 14:41:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200611281403.36370.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32528>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp48m-0003Up-9c for gcvg-git@gmane.org; Tue, 28 Nov
 2006 15:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935306AbWK1Okx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 09:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935320AbWK1Okx
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 09:40:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:51403 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935306AbWK1Okw (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 09:40:52 -0500
Received: (qmail invoked by alias); 28 Nov 2006 14:40:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 28 Nov 2006 15:40:50 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 28 Nov 2006, Andy Parkins wrote:

> On Tuesday 2006 November 28 13:28, Johannes Schindelin wrote:
> 
> > No. As has been often said, a signoff _has_ to be a conscious act, or else
> > it will lose its meaning.
> 
> I'm not suggesting that a project integrator would have that switch on, 
> but for me, in my own repository, where I am the only person writing 
> patches, what possible case is there that I won't sign off?

You are probably different than me. What with my track record, I _trust_ 
my patches to be not perfect at all. Nevertheless, I commit here and now, 
and usually I regroup the commits into a nice patch (series) (AKA poor 
man's StGit).

So I will never need something like you suggest. Having said that, if you 
think it is best for you to mark every commit as signed-off-by you, just 
add an alias:

	git repo-config --global alias.c "commit -s"

and you're done. I highly doubt that it makes sense for the average 
developer, though.
