X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: esc_html() author in blame
Date: Mon, 30 Oct 2006 14:16:28 -0800
Message-ID: <7vu01lv48z.fsf@assigned-by-dhcp.cox.net>
References: <20061030203755.5021.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:23:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030203755.5021.qmail@web31810.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 30 Oct 2006 12:37:54 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30535>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GefQq-0007Tn-Mx for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422697AbWJ3WQb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWJ3WQa
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:16:30 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:8851 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1422697AbWJ3WQa
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:16:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030221629.OTVP16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 17:16:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gmG91V00T1kojtg0000000 Mon, 30 Oct 2006
 17:16:10 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> Blame fails for example on
> block/ll_rw_blk.c at v2.6.19-rc3.
>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

Some quoting may be needed there, but is esc_html the right quoting?
Ack, somebody?
