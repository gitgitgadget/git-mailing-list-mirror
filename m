X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 23:27:40 -0400
Message-ID: <BAYC1-PASMTP03EEA2550392E1AF2851AEAE040@CEZ.ICE>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610261105200.12418@xanadu.home>
	<45413209.2000905@tromer.org>
	<Pine.LNX.4.64.0610262038320.11384@xanadu.home>
	<20061027014229.GA28407@spearce.org>
	<45417205.6020805@tromer.org>
	<20061027030054.GB28407@spearce.org>
	<BAYC1-PASMTP03992F75428088AF83AE39AE040@CEZ.ICE>
	<ehrtt8$rm3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 03:28:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061026232740.b6ea9e5b.seanlkml@sympatico.ca>
In-Reply-To: <ehrtt8$rm3$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Oct 2006 03:27:42.0154 (UTC) FILETIME=[DC724AA0:01C6F977]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdINn-0006aw-Lb for gcvg-git@gmane.org; Fri, 27 Oct
 2006 05:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161483AbWJ0D1n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 23:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWJ0D1n
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 23:27:43 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:50580 "EHLO
 BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1161483AbWJ0D1n (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 23:27:43 -0400
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 20:27:41 -0700
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GdHRc-0004qY-Pa; Thu, 26 Oct 2006 22:27:40 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, 27 Oct 2006 05:20:53 +0200
Jakub Narebski <jnareb@gmail.com> wrote:

> You meant I think: half ignored. Taken into account when finding
> which parts are referenced to delete (-d part), but not complain
> if they don't point to anything (validation).

Yes, ignored by repack, not ignored by prune.

