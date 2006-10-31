X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Mon, 30 Oct 2006 17:27:39 -0800
Message-ID: <7vvem1s29g.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200610301959.05313.jnareb@gmail.com>
	<7vzmbds4pw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 01:28:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vzmbds4pw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 30 Oct 2006 16:34:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30557>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeiQE-0007ww-HV for gcvg-git@gmane.org; Tue, 31 Oct
 2006 02:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161566AbWJaB1l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 20:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161567AbWJaB1l
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 20:27:41 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:16006 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1161566AbWJaB1k
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 20:27:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031012740.QVSB28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 20:27:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gpTL1V00K1kojtg0000000 Mon, 30 Oct 2006
 20:27:21 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Use "&iquot;" Latin 1 entity ("&#191;" -- inverted question mark =
>> turned question mark, U+00BF ISOnum) instead '?' as replacements for
>> control characters and other undisplayable characters.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>
> Do you have something against our Spanish and Latin American
> friends?  ;-)
>
> I wonder if there is a more suitable replacement character that
> is accepted across scripts?

I have a suspicion that instead of finding an exotic character,
just showing the byte value in \octal, perhaps in different
color, might be more portable and easier.  For one thing, it
helps to show the exact byte value than just one substitution
character if you are troubleshooting gitweb.

