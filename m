X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 7 Dec 2006 00:42:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 23:42:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33538>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs6Pc-0005Zo-De for gcvg-git@gmane.org; Thu, 07 Dec
 2006 00:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937813AbWLFXmq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 18:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937812AbWLFXmq
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 18:42:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:60683 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937813AbWLFXmp
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 18:42:45 -0500
Received: (qmail invoked by alias); 06 Dec 2006 23:42:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp012) with SMTP; 07 Dec 2006 00:42:44 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Junio C Hamano wrote:

> Here is a list of topics that are cooking; the commits marked
> with '+' are in 'next', '-' are in 'pu'.  Dates are when the
> topic was last touched [*1*].

I like the combined pu/next "What's new".

> * ap/clone-origin (Wed Dec 6 12:07:23 2006 +0000)
> [...]
>  I think it is sensible to merge to 'master' after that change.

Me, too. I really would like this to go in.

> * jc/3way (Wed Nov 29 18:53:13 2006 -0800)
>  + git-merge: preserve and merge local changes when doing fast forward
> [...]
>  It has been in next for some time and unless we hear somebody scream I 
>  think it is Ok to merge to 'master'.

This is something I am looking forward to to test. Maybe in "next" for 
while before putting it into "master"?

> * jc/explain (Mon Dec 4 19:35:04 2006 -0800)
>  - git-explain

I vote for putting this into "next" for a wider audience. It also would 
help people to submit patches (it is kind of a hassle to branch "pu", so I 
rarely do it myself, whereas my git is based on "next" at all times).

> * js/merge (Wed Dec 6 16:45:42 2006 +0100)
>
>  merge-recursive that does not rely on RCS "merge".  I use this
>  exclusively these days.  Perhaps cook a little further and
>  merge to 'master'.

Yes, definitely cook it for at least a week; maybe I find the time to 
check the conflicted merges in git.git at least.

> * js/shallow (Fri Nov 24 16:00:13 2006 +0100)
> 
>  Probably with a better documentation of its limitations and caveats, 
>  this should be mergeable to 'master'.

The more I see the missing reaction, the less sure I am this is a sensible 
thing to do.

And it would need more safety valves, not just documentation. For example, 
I am not sure if a push from/to a shalow repo is safe.

Ciao,
Dscho
