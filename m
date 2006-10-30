X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 14:07:01 -0800
Message-ID: <7vy7qxv4oq.fsf@assigned-by-dhcp.cox.net>
References: <20061029093754.GD3847@spearce.org>
	<Pine.LNX.4.64.0610301332440.11384@xanadu.home>
	<20061030202611.GA5775@spearce.org>
	<7v7iyhwk47.fsf@assigned-by-dhcp.cox.net>
	<20061030215529.GC5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:14:24 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030215529.GC5775@spearce.org> (Shawn Pearce's message of
	"Mon, 30 Oct 2006 16:55:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30534>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GefHt-0004s7-Jn for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422678AbWJ3WHF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWJ3WHF
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:07:05 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:26358 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1422680AbWJ3WHC
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:07:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030220701.EUOK28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 17:07:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gm6h1V00f1kojtg0000000 Mon, 30 Oct 2006
 17:06:42 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Did you see Jan Harkes' patch that changes the behavior to be what
> it should have been?
>  
>> So --unpacked=pretend-this-is-loose was wrong to begin with; it
>> probably should have been --incremental=pretend-this-is-loose.
>
> I don't care about what the option name is.

It is not about name, but what --unpacked means.  See my other
mail.
