X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 01:16:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612140113340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 00:17:04 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34269>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GueHN-0006zP-IB for gcvg-git@gmane.org; Thu, 14 Dec
 2006 01:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751826AbWLNAQj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 19:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWLNAQj
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 19:16:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:55741 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751822AbWLNAQh
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 19:16:37 -0500
Received: (qmail invoked by alias); 14 Dec 2006 00:16:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp011) with SMTP; 14 Dec 2006 01:16:36 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> >  * git-cat-file is badly named.  git-cat-object would be slightly
> >    better.
> 
> Not a Porcelain.
> 
> We might want to add a pair of built-in internal aliases though:
> 
> 	[alias]
>         	cat = cat-file -p
>                 less = -p cat-file -p
> 
> or have these as samples in template .git/config file.

I sent a patch which makes "git show" have that functionality, and 
frankly, I disagree "less" would be a good name for it. It uses the 
_pager_, which is not always "less", and besides, what it does is to show 
that particular blob. So obviously, I think my patch is the best approach.

BTW if you now say "git show master:README" it will show _nothing_, not 
even an error message.

Ciao,
