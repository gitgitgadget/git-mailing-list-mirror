X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Thu, 2 Nov 2006 11:02:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021055550.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vk62ewtxd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 10:03:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk62ewtxd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30702>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZPd-0006W5-Bl for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752787AbWKBKDB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbWKBKDA
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:03:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:10726 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752787AbWKBKDA (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:03:00 -0500
Received: (qmail invoked by alias); 02 Nov 2006 10:02:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp028) with SMTP; 02 Nov 2006 11:02:58 +0100
To: Junio C Hamano <junkio@cox.net>, Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 1 Nov 2006, Junio C Hamano wrote:

> * The 'pu' branch, in addition, has these.
> 
>   Johannes's "shallow" was marked as "pu" material so I've based
>   the series on the tip of "next" (which means we cannot
>   directly merge that into "next" or "master" without rebasing
>   it to "master" first) and parked it in "pu".  I have given
>   only a cursory look to it but it looks promising.

Note that I have no use for shallow clones myself, since I really like to 
have the complete history around. It also makes for a nice distributed 
backup solution.

The reasons I did it:

- 'cause I could
- I think it is important for other people (this means you, Jon)
- I suggested lazy clones as an easy way out, but I am now convinced that 
they introduce more problems than they solve. Therefore I wanted to make 
good for the confusion I helped develop.

Since I do not have any use for shallow clones myself, I am waiting for 
people to jump on it, test it, and shout "Hooray" or "Nacknacknack".

Ciao,
Dscho
