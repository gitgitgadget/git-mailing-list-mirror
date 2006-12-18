X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: 18 Dec 2006 14:26:36 -0800
Message-ID: <8664c896xv.fsf@blue.stonehenge.com>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 22:26:54 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.5; tzolkin = 6 Chicchan; haab = 18 Mac
In-Reply-To: <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
Original-Lines: 27
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34747>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQwS-0006Eg-HY for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754693AbWLRW0h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbWLRW0h
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:26:37 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:37162 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754693AbWLRW0h (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 17:26:37 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 97CEA8F563; Mon, 18 Dec 2006 14:26:36 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 17075-01-20; Mon, 18 Dec 2006 14:26:36 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 1BEF78F5BC;
 Mon, 18 Dec 2006 14:26:36 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

>> So that *was* a local delay.

Linus> Ok, interesting. Two questions:

Linus>  - what does "top" say (is it CPU-bound? Is it perhaps blowing out your 
Linus>    disk cache? Is it swapping?)

Not swapping, but CPU bound.

Linus>  - do you have "oprofile" (or even just pgprof) to see where the *hell* 
Linus>    that time is spent, if it's actually CPU?

I'm a "bear of very little brane" regarding code development on OSX.  I
can ask around to see if there's someway to profile this.

Linus> You're running this under OS X, aren't you? It's a pig of an OS, but 
Linus> "almost one hour" vs "25 seconds" is still unreasonable.

I agree!

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
