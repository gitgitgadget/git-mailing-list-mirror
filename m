X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach receive-pack how to keep pack files based on object count.
Date: Tue, 31 Oct 2006 14:27:36 -0800
Message-ID: <7vslh4qfxj.fsf@assigned-by-dhcp.cox.net>
References: <20061031075704.GB7691@spearce.org>
	<Pine.LNX.4.64.0610311447250.11384@xanadu.home>
	<20061031201148.GD23671@spearce.org>
	<Pine.LNX.4.64.0610311559150.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 22:27:58 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610311559150.11384@xanadu.home> (Nicolas Pitre's
	message of "Tue, 31 Oct 2006 16:08:32 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30602>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf257-0003VX-U4 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 23:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423715AbWJaW1i (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 17:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWJaW1i
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 17:27:38 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:47263 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1423716AbWJaW1i
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 17:27:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031222737.LWYO22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Tue, 31
 Oct 2006 17:27:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hATh1V0161kojtg0000000 Tue, 31 Oct 2006
 17:27:42 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> I used "pack" <tab> <sha1> so it is easy to pick out of the list of refs 
> that usually comes over the stream in the fetch case (if I understood 
> that part right).

This sounds like a very sane thing to do.
