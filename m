X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Sat, 28 Oct 2006 15:13:54 -0400
Message-ID: <BAYC1-PASMTP11A0267A1CE74A17EDE925AE050@CEZ.ICE>
References: <20061027154433.da9b29d7.seanlkml@sympatico.ca>
	<200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
	<BAYC1-PASMTP04E0376BEE45F9A676DB03AE050@CEZ.ICE>
	<7vr6wt9enk.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP060BC6AED24731185AD6E5AE050@CEZ.ICE>
	<7vmz7g8don.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 19:14:22 +0000 (UTC)
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061028151354.3c5b2fa7.seanlkml@sympatico.ca>
In-Reply-To: <7vmz7g8don.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Oct 2006 19:22:57.0609 (UTC) FILETIME=[79886B90:01C6FAC6]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdtd6-00064f-Mg for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932073AbWJ1TN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 15:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWJ1TN5
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:13:57 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:40046 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S932073AbWJ1TN4
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 15:13:56 -0400
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Sat, 28 Oct
 2006 12:22:57 -0700
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gdsgs-0008R1-GR; Sat, 28 Oct 2006 14:13:54 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, 28 Oct 2006 12:04:24 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Horst has a non-working combination that is:
> 
>  - tip of "master" of the day
>  - Fedora rawhide i386 (whatever that is -- sorry I am new to RPM world)
>  - asciidoc 7.0.2 3.fc6
>  - xmlto 0.0.18 13.1
> 
> I have a working combination:
> 
>  - tip of "master" of the day
>  - FC6 i386 (freshly installed)
>  - asciidoc 7.0.2 3.fc6
>  - xmlto 0.0.18 13.1
> 
> So the difference between me and Horst that can be bisected is
> not what are listed above.  I wonder what other things come into
> the picture.

The thing is, Horst implied everything worked before a recent pull.
It's worth at least going back to see if that's true.  Quite likely
that older version will no longer work anymore either, but maybe it
will.  Of course, if an older version no longer works, there's no
need to bisect further, something in the environment has changed.
Either way, it'll help narrow things down a bit.

