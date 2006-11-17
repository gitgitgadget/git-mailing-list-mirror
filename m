X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make "git checkout <branch> <path>" work when <path> is a directory.
Date: Thu, 16 Nov 2006 22:04:53 -0800
Message-ID: <7vlkmavcai.fsf@assigned-by-dhcp.cox.net>
References: <f2b55d220611162149m719079f3ubdaeac43fe9798cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 06:05:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <f2b55d220611162149m719079f3ubdaeac43fe9798cb@mail.gmail.com>
	(Michael K. Edwards's message of "Thu, 16 Nov 2006 21:49:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31668>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkwqS-0003Uf-PL for gcvg-git@gmane.org; Fri, 17 Nov
 2006 07:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754934AbWKQGEz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 01:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbWKQGEz
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 01:04:55 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:5097 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1754934AbWKQGEy
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 01:04:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117060454.XHXX296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 01:04:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ni501V00Y1kojtg0000000; Fri, 17 Nov 2006
 01:05:01 -0500
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

Thanks.

I think I sent out the same yesterday morning, though.

	Message-ID: <7vbqn8msuw.fsf@assigned-by-dhcp.cox.net>

The difference is that the one tries to catch misspelled <path>.

