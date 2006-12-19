X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --remotes option to show-branch
Date: Mon, 18 Dec 2006 21:50:33 -0800
Message-ID: <7vpsagtowm.fsf@assigned-by-dhcp.cox.net>
References: <20061218145053.GA5175@178.242.249.10.in-addr.arpa>
	<7vfybdvsq7.fsf@assigned-by-dhcp.cox.net>
	<5D50A3C0-4521-402B-ABD4-5698870A3BD2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 05:50:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <5D50A3C0-4521-402B-ABD4-5698870A3BD2@silverinsanity.com> (Brian
	Gernhardt's message of "Tue, 19 Dec 2006 00:17:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34787>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwXs6-0006TW-Ay for gcvg-git@gmane.org; Tue, 19 Dec
 2006 06:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752282AbWLSFug (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 00:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbWLSFuf
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 00:50:35 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59987 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752282AbWLSFuf (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 00:50:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219055034.UFPO29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 00:50:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0Vqm1W00Z1kojtg0000000; Tue, 19 Dec 2006
 00:50:47 -0500
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Brian Gernhardt <benji@silverinsanity.com> writes:

>> I actually was thinking about removing these flags, not adding
>> --remotes, because
>>
>> 	git show-branch remotes/origin/*
>
> ... but --remotes is significantly easier than "remotes/
> origin/* remotes/partner/*".  And sometimes I'd really like to know
> where all the branches are in relation to each other.

Actually, git show-branch origin/* would work equally well if
you do not have local "heads/origin/*" branches.

