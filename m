X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Sat, 28 Oct 2006 12:22:59 -0700
Message-ID: <7v7iyk8cto.fsf@assigned-by-dhcp.cox.net>
References: <20061027154433.da9b29d7.seanlkml@sympatico.ca>
	<200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
	<BAYC1-PASMTP04E0376BEE45F9A676DB03AE050@CEZ.ICE>
	<7vr6wt9enk.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP060BC6AED24731185AD6E5AE050@CEZ.ICE>
	<7vmz7g8don.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP11A0267A1CE74A17EDE925AE050@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 19:23:13 +0000 (UTC)
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP11A0267A1CE74A17EDE925AE050@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 28 Oct 2006 15:13:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30392>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdtlp-0007h4-F7 for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964857AbWJ1TXC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 15:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWJ1TXB
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:23:01 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6393 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S964857AbWJ1TXA
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 15:23:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028192300.LSCD12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 15:23:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fvP31V00N1kojtg0000000 Sat, 28 Oct 2006
 15:23:04 -0400
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

>> So the difference between me and Horst that can be bisected is
>> not what are listed above.  I wonder what other things come into
>> the picture.
>
> The thing is, Horst implied everything worked before a recent pull.

Ah, Ok.

I explicitly asked about things that would help to narrow down
and Horst did not answer to any, so I took that "no info" as (0)
this is the first doc generation so it is unknown if older git
sources would generate docs correctly in the environment, (1)
not just git-daemon.1 but generating git-anything.1 is broken,
(2) not just git-daemon.1 but generating git-daemon.html is also
broken.

You interpreted the "no info" differently, which is valid.

> It's worth at least going back to see if that's true.  Quite likely
> that older version will no longer work anymore either, but maybe it
> will.  Of course, if an older version no longer works, there's no
> need to bisect further, something in the environment has changed.
> Either way, it'll help narrow things down a bit.

Very true.


