X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 18:07:22 -0500
Message-ID: <BAYC1-PASMTP0196D3AFDB259DEF356AF8AEEA0@CEZ.ICE>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<200611151858.51833.andyparkins@gmail.com>
	<Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
	<f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	<87velgs9hx.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
	<87psbos4pb.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 23:07:32 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061115180722.83ff8990.seanlkml@sympatico.ca>
In-Reply-To: <87psbos4pb.wl%cworth@cworth.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Nov 2006 23:07:23.0984 (UTC) FILETIME=[CF8DAD00:01C7090A]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTqq-0004u4-Cs for gcvg-git@gmane.org; Thu, 16 Nov
 2006 00:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162030AbWKOXHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 18:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162032AbWKOXHZ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 18:07:25 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:2587 "EHLO
 bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1162030AbWKOXHY (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006
 18:07:24 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Wed, 15 Nov 2006 15:07:23 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GkSuf-00054o-Ht; Wed, 15 Nov 2006 17:07:21 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006 14:52:32 -0800
Carl Worth <cworth@cworth.org> wrote:

> The real fix is to stop glossing over git-merge and just give it a
> usable syntax.

Agreed 100%   There's just no good reason to hide the user level
merge command inside of pull.

