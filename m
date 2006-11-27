X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 9/10] Allow completion of --committer and --author arguments to git log.
Date: Mon, 27 Nov 2006 12:20:51 -0800
Message-ID: <7vy7pwfxp8.fsf@assigned-by-dhcp.cox.net>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
	<20061127084228.GI19745@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 20:21:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061127084228.GI19745@spearce.org> (Shawn O. Pearce's message
	of "Mon, 27 Nov 2006 03:42:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32448>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GomyN-0002fV-KO for gcvg-git@gmane.org; Mon, 27 Nov
 2006 21:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758561AbWK0UUw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 15:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758562AbWK0UUw
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 15:20:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30113 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1758561AbWK0UUw
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 15:20:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127202051.LEMM5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 15:20:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rwLK1V00e1kojtg0000000; Mon, 27 Nov 2006
 15:20:20 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This is just a cute hack, but we can (easily) complete the parameter
> to --author or --committer in bash by asking for all possible authors
> or committers in this project from git log and offering them up as
> valid choices.

Easily but slowly ;-).  Try this in the kernel repository

	git log --author=Andre<TAB>

and watch the paint dry.  You might want to have an extra shell
to run top before you hit the TAB key.

It indeed is cute, but I think most people would wonder if the
terminal went dead, especially without any progress indicators.

