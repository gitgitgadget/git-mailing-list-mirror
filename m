X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 17:00:09 -0800
Message-ID: <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
	<caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 21 Dec 2006 01:00:21 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com>
	(Terje Sten Bjerkseth's message of "Thu, 21 Dec 2006 01:54:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34993>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxCIE-00058D-NX for gcvg-git@gmane.org; Thu, 21 Dec
 2006 02:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161092AbWLUBAP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 20:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWLUBAP
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:00:15 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46756 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161092AbWLUBAN (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 20:00:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061221010010.TCUO25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 20:00:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1CzU1W00i1kojtg0000000; Wed, 20 Dec 2006
 19:59:29 -0500
To: "Terje Sten Bjerkseth" <terje@bjerkseth.org>
Sender: git-owner@vger.kernel.org

"Terje Sten Bjerkseth" <terje@bjerkseth.org> writes:

> On 12/21/06, Junio C Hamano <junkio@cox.net> wrote:
>> Thanks.  While this is in a better direction than randomly
>> including the headers in the source, it is still sad.
>>
>> Does everybody use Apple CC on OSX?  Is the symbol defined even
>> with GCC?  Or Gcc fixes headers well enough and makes this a
>> non-issue?
>
> I'm not sure about everybody, but at least the Apple CC *is* GCC:

Thanks for clarifying this; will apply.
