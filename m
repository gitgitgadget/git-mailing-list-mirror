X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/n] gitweb: Remove redundant "blob" links from git_difftree_body
Date: Thu, 02 Nov 2006 22:41:22 -0800
Message-ID: <7v3b91jalp.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200610311707.43054.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 06:41:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610311707.43054.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 31 Oct 2006 17:07:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30788>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfsk6-0003tr-CI for gcvg-git@gmane.org; Fri, 03 Nov
 2006 07:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753157AbWKCGlY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 01:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbWKCGlY
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 01:41:24 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33438 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1753157AbWKCGlX
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 01:41:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103064122.USXH16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 01:41:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id i6hT1V0091kojtg0000000 Fri, 03 Nov 2006
 01:41:27 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> ... First, it did that incompletely: it did not add "blob"
> link for added files, and added block used mixture of tabs and spaces
> for align. Second, in "difftree" view the "blob" link is not the most
> interesting, *contrary* to "blob"/"tree" link in "tree" view, so it
> should be enough to have hidden link in the form of file name entry.

I think these "blob" links are good thing to have, and if you
think the earlier work was incomplete and know some cases are
not covered I think it would be better to help completing it
rather than reverting.

I do not understand why you feel "blob" is not the most
interesting.  Often, when it is not obvious if a patch is
correct only with the context, it is useful to view the whole
postimage after applying the patch, and the "blob" link helps
that.
