X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 01:22:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612140116430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 00:22:27 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612132237.10051.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34270>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GueMh-0007ZT-Gp for gcvg-git@gmane.org; Thu, 14 Dec
 2006 01:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751780AbWLNAWU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 19:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWLNAWU
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 19:22:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:41516 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751780AbWLNAWT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 19:22:19 -0500
Received: (qmail invoked by alias); 14 Dec 2006 00:22:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 14 Dec 2006 01:22:18 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Andy Parkins wrote:

> On Wednesday 2006, December 13 21:35, Junio C Hamano wrote:
>
>  * git-revert should be called git-invert.  It doesn't remove a change
>    from history, it simply applies another commit that does the
>    opposite of whatever commit you are "revert"ing.  That's an inversion.

No. An inversion is the _opposite_. Not an undo.

Besides, The fact that revert _adds_ to history is a nice way to 
document that you reverted that change. And you can even explain in the 
commit message, why you did it.

>  * git-fetch output is confusing:
>     remote: Generating pack...
>     remote: Done counting 189146 objects.
>     remote: Result has 186566 objects.
>     remote: Deltifying 186566 objects.
>     remote:  100% (186566/186566) done
>     Unpacking 186566 objects
>     24% (44792/186566) done
>    Some questions from the point of view of a newbie: what is a pack?  what is 
>    an object? Why is the remote counting them?  Which remote am I reading 
>    from?  What am I fetching?  What is "Deltifying"?  How much data do I have 
>    to download (number of objects doesn't tell me).  How long has this taken?  
>    How long is left to go?

IMHO it is better for a newbie to see that _something_ is happening. A 
newbie cannot, and does not want to, understand exactly what is going on.

So, think of it as our response to Windows' non-progress-bar: when you 
start up Windows, there is a progress-bar, except that it does not show 
progress, but a Knight Rider like movement, only indicating that it does 
something.

Ciao,
Dscho
