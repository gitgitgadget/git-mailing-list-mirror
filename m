X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 10:33:25 -0500
Message-ID: <BAYC1-PASMTP0422D580BE471BBCB1EFBDAEFD0@CEZ.ICE>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	<20061102224549.499610d1.seanlkml@sympatico.ca>
	<20061103203610.GB7585@spearce.org>
	<BAYC1-PASMTP01F45766D9195AAFD81789AEFE0@CEZ.ICE>
	<7vejsjxvtw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 4 Nov 2006 15:33:50 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>,
	Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061104103325.bfb5e33e.seanlkml@sympatico.ca>
In-Reply-To: <7vejsjxvtw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 04 Nov 2006 15:33:28.0186 (UTC) FILETIME=[933575A0:01C70026]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgNWf-0003pc-VH for gcvg-git@gmane.org; Sat, 04 Nov
 2006 16:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965511AbWKDPd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 10:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965513AbWKDPd3
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 10:33:29 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:12157 "EHLO
 BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S965511AbWKDPd2 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006
 10:33:28 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sat, 4 Nov 2006 07:33:27 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GgMaL-0007HN-JA; Sat, 04 Nov 2006 09:33:25 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, 04 Nov 2006 04:03:39 -0800
Junio C Hamano <junkio@cox.net> wrote:

> There is no "get it right most of the time" that would apply to
> every workflow.  We should just admit that no default layout and
> configuration would suit everybody's needs.  What we should do
> is to try to capture a handful useful patterns and make it easy
> for people to apply those canned patterns.

Consider it admitted ;o)  But there is no need to have just a single
configuration that suits everybody.  For instance, nobody is saying
to do away with the current default in favor of use-separate-remotes.
That is why someone saying "Nak" to a feature where all branches
are checked out locally on clone is "rash".  Because it _is_ valuable
to some workflows.  There is no reason Git could not support it.  If
it gets in the way of some workflows, then we just make it a
configuration option.  However, I don't feel strongly about this
particular option, if you notice in my email I merely suggested it
for discussion.

But by the same token, Git should _better_ support Shawn's example
workflow where currently Git makes him delete a bunch of branches
and edit the remotes/origin file every time after cloning.  It would
be rash of me to send out a Nak for such an improvement just because
I don't need that feature.

All that remains is coming to some consensus on which set of options
should be enabled for new Git users.  Once someone is up to speed, they
can enable whichever options support their workflow.  But once they've
enabled those options, Git should do it's best to support that workflow
without a lot of manual intervention most of the time.  That's what
the options I was suggesting would do for some workflows.

