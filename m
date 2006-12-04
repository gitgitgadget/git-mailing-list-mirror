X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH]: Pass -M to diff in request-pull
Date: Mon, 04 Dec 2006 00:35:16 -0800
Message-ID: <7v3b7wrrcr.fsf@assigned-by-dhcp.cox.net>
References: <20061203.231700.55509531.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 08:35:29 +0000 (UTC)
Cc: junkio@cox.net, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061203.231700.55509531.davem@davemloft.net> (David Miller's
	message of "Sun, 03 Dec 2006 23:17:00 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33171>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr9IM-0004o9-Qv for gcvg-git@gmane.org; Mon, 04 Dec
 2006 09:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759496AbWLDIfV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 03:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759268AbWLDIfV
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 03:35:21 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30422 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1759255AbWLDIfT
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 03:35:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204083517.KBLS5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 4
 Dec 2006 03:35:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uYai1V0041kojtg0000000; Mon, 04 Dec 2006
 03:34:42 -0500
To: David Miller <davem@davemloft.net>
Sender: git-owner@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> Linus recommended this, otherwise any renames cause the
> diffstate output to be rediculious in some circumstances :)

Thanks, but "rediculious"?

I think this makes sense, especially as it matches what we
show after a git-pull that ought to match the request.
