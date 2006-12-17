X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-diff: don't add trailing blanks (i.e., do what GNU diff -u now does)
Date: Sun, 17 Dec 2006 21:36:14 +0100
Message-ID: <87psainttt.fsf@rho.meyering.net>
References: <87y7p6nwsh.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0612171200290.3479@woody.osdl.org>
	<7vtzzu5lp1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 20:36:41 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vtzzu5lp1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 17 Dec 2006 12:09:14 -0800")
Original-Lines: 15
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34707>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw2kH-0001mO-Uf for gcvg-git@gmane.org; Sun, 17 Dec
 2006 21:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751686AbWLQUgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWLQUgQ
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 15:36:16 -0500
Received: from mx.meyering.net ([82.230.74.64]:56253 "EHLO mx.meyering.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751686AbWLQUgP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 15:36:15 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 96EF46B03; Sun, 17 Dec 2006 21:36:14 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
>> On Sun, 17 Dec 2006, Jim Meyering wrote:
>>> You may recall that GNU diff -u changed recently so that it no
>>> longer outputs any trailing space unless the input data has it.
>>
>> I still consider that to be a bug in GNU "diff -u".
>>
>> We work around that bug when applying patches, but I don't think we should
>> replicate it.
>
> Me neither.

I can't say I didn't expect this.
