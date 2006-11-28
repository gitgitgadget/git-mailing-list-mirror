X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 12/10] Teach bash about git-repo-config.
Date: Mon, 27 Nov 2006 17:17:29 -0800
Message-ID: <7vodqscqty.fsf@assigned-by-dhcp.cox.net>
References: <20061127094447.GA19273@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 01:17:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061127094447.GA19273@spearce.org> (Shawn O. Pearce's message
	of "Mon, 27 Nov 2006 04:44:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32476>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GorbS-0005Tj-Lg for gcvg-git@gmane.org; Tue, 28 Nov
 2006 02:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758016AbWK1BRb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 20:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757736AbWK1BRb
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 20:17:31 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31898 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1757224AbWK1BRa
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 20:17:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128011730.YNRE97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 20:17:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id s1Gy1V00L1kojtg0000000; Mon, 27 Nov 2006
 20:16:58 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  Yes, that's it.  I'm finally done tinkering with bash
>  completion support for this week.  Total of 12 patches.

Thanks.  I saw a funky behaviour when I tried this:

	$ git pull . ap<TAB>

==>
	$ git pull . apfatal: Not a git repository: '.'

