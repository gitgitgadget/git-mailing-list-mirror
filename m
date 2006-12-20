X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 14:44:14 -0800
Message-ID: <7vhcvq6vcx.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 22:44:32 +0000 (UTC)
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86ejquyz4v.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 14:35:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34976>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxAAl-00081f-A4 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030408AbWLTWoY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWLTWoY
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:44:24 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60362 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030408AbWLTWoX (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:44:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220224415.HAFU19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 17:44:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1AjZ1W00L1kojtg0000000; Wed, 20 Dec 2006
 17:43:34 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Lemme see if it breaks on OpenBSD as well.
>
> Oddly enough - it didn't. :)

Of course it didn't.  I was a bit more careful than usual with
this and fired up an OpenBSD bochs on my wife's machine to test
it before pushing out.

> running "git version 1.4.4.3.g5485" on my openbsd box, but I can't get
> there on my OSX box.

Sorry, I cannot be of immediate help -- I do not have one.

