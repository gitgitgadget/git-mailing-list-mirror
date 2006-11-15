X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 10:03:59 -0500
Message-ID: <BAYC1-PASMTP1131061C6974A86FF033D3AEEA0@CEZ.ICE>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
	<7virhhy76h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142048350.2591@xanadu.home>
	<7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611151454250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 15:04:37 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061115100359.5bfbe5c9.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0611151454250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Nov 2006 15:13:31.0937 (UTC) FILETIME=[9CBB9910:01C708C8]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkMJN-0001oY-PU for gcvg-git@gmane.org; Wed, 15 Nov
 2006 16:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030535AbWKOPEG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 10:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030538AbWKOPEF
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 10:04:05 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:58002 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1030535AbWKOPEC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 10:04:02 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Wed, 15 Nov
 2006 07:13:31 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GkLMs-0003ir-Vv; Wed, 15 Nov 2006 09:03:59 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006 15:01:47 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I am really opposed to do "gh pull". Not only because of "gh" being 
> completely confusing (we already _have_ "git", and for porcelains 
> different TLAs), but "pull" _really_ is confusing by now. And Mercurial 
> did not help one wit by insisting on their own interpretation.

This makes a lot of sense.  The "git" command isn't damaged so bad
that it can't be saved in a backward compatible way, at least for
a transition period.  Adding a new command name seems like a step
backward.
 
> Why not do something like "get/put" instead? It is
> 
> - easier to remember
> - not bogus (AFAICT the meaning is not used in diametrical senses)
> - shorter to type than download/upload
> 
> As for "git merge": Just by the number of arguments you can discern 
> between the original usage and the new usage, so I am all in favour of 
> replacing "git pull <blabla>" by "git merge <blabla>". Where "<blabla>" 
> can be a branch or a remote or a URL (with cogito style #branchname).

Both these ideas sound like a step in the right direction too.

