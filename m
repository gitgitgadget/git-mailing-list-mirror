X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make "git checkout <branch> <path>" work when <path> is a directory.
Date: Fri, 17 Nov 2006 00:15:30 -0800
Message-ID: <7vd57mtrod.fsf@assigned-by-dhcp.cox.net>
References: <f2b55d220611162149m719079f3ubdaeac43fe9798cb@mail.gmail.com>
	<7vlkmavcai.fsf@assigned-by-dhcp.cox.net>
	<f2b55d220611162218t3a752829hf922613c17fe326d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 08:15:38 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31673>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkysq-0001zx-8S for gcvg-git@gmane.org; Fri, 17 Nov
 2006 09:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755541AbWKQIPc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 03:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755542AbWKQIPc
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 03:15:32 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28643 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1755541AbWKQIPb
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 03:15:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117081531.KMNA5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 03:15:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nkFd1V00B1kojtg0000000; Fri, 17 Nov 2006
 03:15:37 -0500
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

"Michael K. Edwards" <medwards.linux@gmail.com> writes:

> Ah.  Missed that patch, which is indeed a superset of mine.  Looks
> like you committed it on branch "next"; is that a personal
> experimental branch, or the integration branch against which patches
> should be generated?

Actually it is not pushed out anywhere yet but will appear on
both 'maint' and 'master' along with other post 1.4.4 fixes and
will be contained in the 1.4.4.1 maintenance release.

The role of each branch at my public repository is desribed in
this message:

	Message-ID: <7vk62qhy4k.fsf@assigned-by-dhcp.cox.net>
	http://article.gmane.org/gmane.comp.version-control.git/29951

In general, if your changes and fixes are applicable in
isolation to "master", it is most appropriate to send patches
against "master".  If you are following up a topic that is
cooking in "next" (or "pu"), then basing your patch on "master"
is obviously a bad idea and a patch that applies on "next" (or
"pu") would be more appropriate.  If you can make the patch
against the tip of the specific topic that would be even better
but it generally is more work for you, so I usually do not ask
that to contributors.


