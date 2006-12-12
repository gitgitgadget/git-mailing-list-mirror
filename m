X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 20:24:46 -0500
Message-ID: <BAYC1-PASMTP092A9E80667F373BF69AA6AED70@CEZ.ICE>
References: <200612112210.08327.andyparkins@gmail.com>
	<BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE>
	<7v7iwx2a0z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 01:24:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061211202446.3c263c4f.seanlkml@sympatico.ca>
In-Reply-To: <7v7iwx2a0z.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 12 Dec 2006 01:25:47.0687 (UTC) FILETIME=[73AFB370:01C71D8C]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtwO3-0006ZJ-QQ for gcvg-git@gmane.org; Tue, 12 Dec
 2006 02:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750771AbWLLBYt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 20:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWLLBYt
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 20:24:49 -0500
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:38232 "EHLO
 BAYC1-PASMTP09.bayc1.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1750771AbWLLBYs (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11
 Dec 2006 20:24:48 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP09.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 11 Dec 2006 17:25:47 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GtvRs-00037F-Gy; Mon, 11 Dec 2006 19:24:44 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, 11 Dec 2006 17:11:24 -0800
Junio C Hamano <junkio@cox.net> wrote:


> > As Junio already highlighted, the "branch.*" namespace is for actual
> > branch names.  This config option should go into "color.branch" or some
> > other spot.
> 
> I didn't.  And "branch.color = auto" is actually fine.
> 
> The problematic case is "branch.color.remote = purple".

Technically it is workable.. but why even start down the road of having
anything but branch names after a "branch."?   There has to be a better
spot for this variable, and it makes it more future proof, as you
highlighted.

