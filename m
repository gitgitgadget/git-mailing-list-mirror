X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Mon, 30 Oct 2006 22:52:21 -0800
Message-ID: <7vwt6hq8nu.fsf@assigned-by-dhcp.cox.net>
References: <20061030223615.GH5775@spearce.org>
	<7vlkmxtmln.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610302258400.11384@xanadu.home>
	<7v7iyhrsoi.fsf@assigned-by-dhcp.cox.net>
	<20061031063941.GB7375@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 06:52:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061031063941.GB7375@spearce.org> (Shawn Pearce's message of
	"Tue, 31 Oct 2006 01:39:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30571>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GenU3-0006GE-EQ for gcvg-git@gmane.org; Tue, 31 Oct
 2006 07:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422674AbWJaGwY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 01:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWJaGwY
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 01:52:24 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4760 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1422674AbWJaGwX
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 01:52:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031065223.QMFS16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Tue, 31
 Oct 2006 01:52:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gus21V00D1kojtg0000000 Tue, 31 Oct 2006
 01:52:03 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

>> Because that approach assumes recieve-pack and unpack-objects
>> and index-pack are from the same vintage (otherwise your
>> receive-pack would need to have a way to see if unpack-objects
>> and index-pack would grok --pack_header argument), we could even
>> get away without passing the pack version if we wanted to.
>...
> BTW I think we do need to pass the pack version in the option.

We are in agreement; I mentioned "we could ... if we wanted to"
because I wanted to see if you are paying attention ;-).

