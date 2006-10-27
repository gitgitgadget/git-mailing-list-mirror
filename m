X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 22:38:04 -0400
Message-ID: <BAYC1-PASMTP10C050A5FAA4C70AD57679AE040@CEZ.ICE>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610261105200.12418@xanadu.home>
	<45413209.2000905@tromer.org>
	<Pine.LNX.4.64.0610262038320.11384@xanadu.home>
	<20061027014229.GA28407@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 02:38:19 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Eran Tromer <git2eran@tromer.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061026223804.a2944bd1.seanlkml@sympatico.ca>
In-Reply-To: <20061027014229.GA28407@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Oct 2006 02:41:51.0250 (UTC) FILETIME=[74C7A720:01C6F971]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdHbo-0005fo-D2 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 04:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946126AbWJ0CiI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 22:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946133AbWJ0CiI
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 22:38:08 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:26931 "EHLO
 BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1946127AbWJ0CiG (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 22:38:06 -0400
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 19:41:50 -0700
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GdGfc-0004mT-4u; Thu, 26 Oct 2006 21:38:04 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006 21:42:29 -0400
Shawn Pearce <spearce@spearce.org> wrote:

> This is an issue for "central" repositories that people push into
> and which might be getting repacked according to a cronjob.
> 
> Unfortunately I don't have a solution.  I tried to come up with
> one but didn't.  :-)

What about creating a temporary ref before pushing, and then removing
it only after the HEAD has been updated?

