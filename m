X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 14:35:12 -0800
Message-ID: <86ejquyz4v.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 22:35:32 +0000 (UTC)
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
Original-Lines: 31
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34974>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxA1y-0006Ai-2T for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030405AbWLTWfS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWLTWfS
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:35:18 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:22737 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030405AbWLTWfQ (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:35:16 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 4AA948F97F; Wed, 20 Dec 2006 14:35:15 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 20521-01-51; Wed, 20 Dec 2006 14:35:13 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 155898FA6E;
 Wed, 20 Dec 2006 14:35:13 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> Nope... can't compile:
>> ...
>> daemon.c:970: warning: implicit declaration of function 'initgroups'
>> make: *** [daemon.o] Error 1
>> 
>> This smells like we've seen this before.  Regression introduced with
>> some of the cleanup?

Junio> Most likely.  You were CC'ed on these messages:

Junio> 	<7v7iwnnzed.fsf@assigned-by-dhcp.cox.net>
Junio> 	<7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>

I see in 979e32fa1483a32faa4ec331e29b357e5eb5ef25 that I had to change
some things for OpenBSD... I bet those are generic BSD things.

Lemme see if it breaks on OpenBSD as well.

Oddly enough - it didn't. :)

running "git version 1.4.4.3.g5485" on my openbsd box, but I can't get
there on my OSX box.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
