X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 12:44:14 -0500
Message-ID: <BAYC1-PASMTP082D56B2460EFED9DA6D3BAEE90@CEZ.ICE>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<200611151858.51833.andyparkins@gmail.com>
	<Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
	<f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	<20061116042639.GA23026@thunk.org>
	<455C5079.3010701@op5.se>
	<Pine.LNX.4.64.0611160824040.3349@woody.osdl.org>
	<87ejs3s4vn.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611160924250.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 17:44:32 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061116124414.a1fdd6dd.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0611160924250.3349@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 16 Nov 2006 17:53:39.0390 (UTC) FILETIME=[25A255E0:01C709A8]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GklHh-0003sb-8w for gcvg-git@gmane.org; Thu, 16 Nov
 2006 18:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162065AbWKPRoS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162067AbWKPRoS
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 12:44:18 -0500
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:10654 "EHLO
 BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP id S1162065AbWKPRoR
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 12:44:17 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Thu, 16 Nov
 2006 09:53:39 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GkkLW-0006xy-36; Thu, 16 Nov 2006 11:44:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Thu, 16 Nov 2006 09:30:47 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Yeah. Each branch should
> 
>  (a) have a "default source" initialized on the initial "clone"
>
> (b) have a way to set the source afterwards
>
> (c) error out if you do just a "git pull" or "git pull remotename" if 
>     there is no default branch for the current local branch for that 
>     remote.

This would be _great_.  You just shouldn't have to hack at the
.git/config file to get reasonable default sources after a clone.
Or even for that matter after fetching a new branch into an
existing repo.

