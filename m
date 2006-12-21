X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 17:13:05 -0800
Message-ID: <7vk60m3vby.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<Pine.LNX.4.64.0612201643520.3576@woody.osdl.org>
	<86ac1ixdic.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 21 Dec 2006 01:13:20 +0000 (UTC)
Cc: Terje Sten Bjerkseth <terje@bjerkseth.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86ac1ixdic.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 17:07:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34998>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxCUk-0006uk-80 for gcvg-git@gmane.org; Thu, 21 Dec
 2006 02:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161112AbWLUBNK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 20:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWLUBNK
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:13:10 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33439 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161112AbWLUBNJ (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 20:13:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061221011307.FARQ18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 20:13:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1DCQ1W00N1kojtg0000000; Wed, 20 Dec 2006
 20:12:25 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:
>
> Linus> Your patch is whitespace-damaged, btw.
>
> The version as an attachment shouldn't have been.
>
> The cut-n-paste might have been.

While I do not have a clue on what point you are trying to make,
I have a more important question for you.

Does Terje's patch fix it for you?


