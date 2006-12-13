X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT - releases workflow
Date: Wed, 13 Dec 2006 11:36:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131133160.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com> 
 <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <1166001019.19098.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 10:36:29 +0000 (UTC)
Cc: Sean Kelley <sean.v.kelley@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1166001019.19098.4.camel@localhost.localdomain>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34203>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuRTO-00066s-7t for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964827AbWLMKgP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 05:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWLMKgP
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:36:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:43905 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932653AbWLMKgO
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 05:36:14 -0500
Received: (qmail invoked by alias); 13 Dec 2006 10:36:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 13 Dec 2006 11:36:12 +0100
To: Matthias Kestenholz <lists@spinlock.ch>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Matthias Kestenholz wrote:

> On Tue, 2006-12-12 at 23:54 +0100, Johannes Schindelin wrote:
> > 
> > On Tue, 12 Dec 2006, Sean Kelley wrote:
> > 
> > > I was wondering if anyone could share ideas on how best to use GIT to 
> > > handle releases for those working with a remote GIT repository?  Do you 
> > > create a branch and push it to the remote?  Thus you have a new branch 
> > > referencing the particular release?
> > 
> > Why not just tag the release, and push the tag?
> 
> I am doing both in my web SDK project.
> 
> I currently have two branches, master and maint/v1. Over time, if
> necessary, I'll open new branches named maint/v2, maint/v3 etc.
> 
> New development happens on master, bugfixes go to maint/v1 and get
> merged into master. If I do bugfix releases (2.0.x), I tag the tip of
> the maint/v1 branch.
> 
> I need a full branch, because I need the ability to do bugfixes for the
> already-released version.

Ah, that's right. I always forget that there are maintenance releases 
(mostly in Cathedral-ish projects)... I am not a release engineer during 
my day job, and I am just as happy about that.

BTW, if the maintenance releases are sparse and long between, you can 
actually create the branch from the tag, fix, and tag with the new version 
number. No need to start the branches early.

Ciao,
Dscho
