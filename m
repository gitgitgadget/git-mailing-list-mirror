X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adjust t5510 to put remotes in config
Date: Mon, 18 Dec 2006 14:58:15 -0800
Message-ID: <7vr6uwvmk8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612171545390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7iwox59i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612182325550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvek8vnb8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612182346500.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612182349070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 22:59:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612182349070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 18 Dec 2006 23:49:40 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34755>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwRR6-0005XL-Ls for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754735AbWLRW6R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbWLRW6R
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:58:17 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63637 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754735AbWLRW6Q (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 17:58:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218225815.BBWL97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Mon, 18
 Dec 2006 17:58:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0Nxa1W00i1kojtg0000000; Mon, 18 Dec 2006
 17:57:35 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 18 Dec 2006, Johannes Schindelin wrote:
>
>> I don't install templates. Ever. I want to be sure that nothing slips in 
>> by mistake, and so I install hooks manually.
>
> Side note: prior to installing the tests would fail anyway, no?

They shouldn't.  At least the intent was to make the tests read
from $SRCDIR/templates/blt/ as the source of templates.

But maybe you spotted a bug in t/test-lib.sh; I don't know
without digging.

