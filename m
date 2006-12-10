X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core. Call with explicit path.
Date: Sat, 09 Dec 2006 16:50:02 -0800
Message-ID: <7vhcw48thh.fsf@assigned-by-dhcp.cox.net>
References: <elc6g3$v1m$1@sea.gmane.org> <20061208193718.GA11906@soma>
	<7v3b7qi0b4.fsf@assigned-by-dhcp.cox.net> <457AB54B.8070107@xs4all.nl>
	<7v1wn8ah2k.fsf@assigned-by-dhcp.cox.net> <457B4981.2030408@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 00:50:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457B4981.2030408@xs4all.nl> (Han-Wen Nienhuys's message of "Sun,
	10 Dec 2006 00:40:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33857>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtCtL-0005n3-R7 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 01:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757216AbWLJAuE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 19:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbWLJAuE
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 19:50:04 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58443 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1757216AbWLJAuD (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 19:50:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210005002.GLQI22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 19:50:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id woqD1V00F1kojtg0000000; Sat, 09 Dec 2006
 19:50:13 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> The real problem is that git is nonstandard to wrap around:
> scripts like git-sh-setup need special attention, because they don't work 
> with
>
>   exec /some/where/else/git-sh-setup "$@"

Of course.  Who would want to wrap git-sh-setup that way?

The only thing you would need to wrap around is "git" itself,
isn't it?
