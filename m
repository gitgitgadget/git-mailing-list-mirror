X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Small optimizations to gitweb
Date: Mon, 18 Dec 2006 21:48:49 -0800
Message-ID: <7vtzzstozi.fsf@assigned-by-dhcp.cox.net>
References: <20061218224327.GG16029@localhost> <em77cg$obn$1@sea.gmane.org>
	<7vbqm0vkd6.fsf@assigned-by-dhcp.cox.net>
	<200612190159.24173.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 05:49:04 +0000 (UTC)
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612190159.24173.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 19 Dec 2006 01:59:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34786>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwXqQ-0006Ek-5s for gcvg-git@gmane.org; Tue, 19 Dec
 2006 06:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752609AbWLSFsv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 00:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWLSFsv
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 00:48:51 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42945 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752609AbWLSFsu (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 00:48:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219054850.ZOWG4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 00:48:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0Vp21W0031kojtg0000000; Tue, 19 Dec 2006
 00:49:02 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> ...
>> The counting code in git_*_body is seriously unusual to tempt
>> anybody who reviews the code to reduce that 17 to 16.
>
> Well, this should be then corrected perhaps to

Well, I did not say it was _wrong_, just unusual, so there is
nothing to fix.

>> By the way, I wonder how that $extra is omitted when $revlist is
>> longer than $to; it should be a trivial fix but it seems to me
>> that it is always spitted out with the current code.
>
> We should check if we want to omit $extra, either in caller or
> in callee, the *_body subroutine itself.

Check?
