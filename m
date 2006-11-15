X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 15:01:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611151454250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
 <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
 <7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 14:02:08 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31440>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkLKx-0003tO-6R for gcvg-git@gmane.org; Wed, 15 Nov
 2006 15:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966866AbWKOOBw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 09:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966864AbWKOOBw
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 09:01:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:14232 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S966866AbWKOOBv (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 09:01:51 -0500
Received: (qmail invoked by alias); 15 Nov 2006 14:01:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 15 Nov 2006 15:01:50 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 14 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > 1) make "git init" an alias for "git init-db".
> 
> Or even better, have "gh init".

Please no. It only makes things even more confusing. "git init" is perfect 
as it is. We can always have internal aliases from "init-db" to "init" to 
account for older usages.

> > 2) "pull" and "push" should be symmetrical operations
> 
> I think that makes a lot of sense to have "gh pull" and "gh
> push" as symmetric operations, and make "gh merge" do the
> fast-forward and 3-way merge magic done in the current "git
> pull".  These three words would have a lot saner meaning.

I am really opposed to do "gh pull". Not only because of "gh" being 
completely confusing (we already _have_ "git", and for porcelains 
different TLAs), but "pull" _really_ is confusing by now. And Mercurial 
did not help one wit by insisting on their own interpretation.

Why not do something like "get/put" instead? It is

- easier to remember
- not bogus (AFAICT the meaning is not used in diametrical senses)
- shorter to type than download/upload

As for "git merge": Just by the number of arguments you can discern 
between the original usage and the new usage, so I am all in favour of 
replacing "git pull <blabla>" by "git merge <blabla>". Where "<blabla>" 
can be a branch or a remote or a URL (with cogito style #branchname).

Ciao,
Dscho
