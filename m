X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 14:25:21 -0800
Message-ID: <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 22:26:20 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86irg6yzt1.fsf_-_@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 14:20:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34972>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9t1-0003t0-4t for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030401AbWLTWZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWLTWZY
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:25:24 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41454 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030401AbWLTWZX (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:25:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220222522.PFDZ20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 17:25:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1AQg1W0011kojtg0000000; Wed, 20 Dec 2006
 17:24:40 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Nope... can't compile:
> ...
>     daemon.c:970: warning: implicit declaration of function 'initgroups'
>     make: *** [daemon.o] Error 1
>
> This smells like we've seen this before.  Regression introduced with
> some of the cleanup?

Most likely.  You were CC'ed on these messages:

	<7v7iwnnzed.fsf@assigned-by-dhcp.cox.net>
	<7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>

