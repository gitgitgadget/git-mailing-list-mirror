X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch little gripe
Date: Fri, 03 Nov 2006 14:26:29 -0800
Message-ID: <7v3b905fqi.fsf@assigned-by-dhcp.cox.net>
References: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net>
	<20061103195253.9244.qmail@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 22:26:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061103195253.9244.qmail@web31814.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 3 Nov 2006 11:52:53 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30889>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg7Ui-0004jz-I3 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 23:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932122AbWKCW0c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWKCW0c
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 17:26:32 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21204 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S932122AbWKCW0b
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 17:26:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103222630.RTUL16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 17:26:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iNS81V00i1kojtg0000000 Fri, 03 Nov 2006
 17:26:09 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> Also I doubt how many people actually have coded in their scripts
> "git-format-patch <sha-1>" to mead by default "<sha-1>..HEAD" -- I'd think
> that maintainers always want to know the "end point" and would always
> use the <a>..<b> format, instead of presuming where/what their HEAD is.

Well, the answer would be "do not script around Porcelain".

> Sorry it's my rant.  I know it's not your fault.

I do not even think there is any "fault" there, to be honest, so
there is no need to apologize.  The format-patch command does
what it was designed to do and does it well -- format a sequence
of patches for upstream submission.

If you want a single patch, you can always say "git show", by
the way.

