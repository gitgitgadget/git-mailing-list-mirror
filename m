X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Planned new release of git
Date: Tue, 07 Nov 2006 15:36:25 -0800
Message-ID: <7v64dq25ja.fsf@assigned-by-dhcp.cox.net>
References: <454EAEDB.8020909@gmail.com>
	<7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com>
	<Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
	<45503553.3020605@gmail.com>
	<Pine.LNX.4.64.0611070729370.3667@g5.osdl.org>
	<7vhcxb2b15.fsf@assigned-by-dhcp.cox.net> <eiqvoh$ebd$1@sea.gmane.org>
	<Pine.LNX.4.64.0611071504200.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 23:36:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611071504200.3667@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 7 Nov 2006 15:06:29 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31101>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhaUY-0008Do-OU for gcvg-git@gmane.org; Wed, 08 Nov
 2006 00:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750732AbWKGXg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 18:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWKGXg1
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 18:36:27 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46580 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1750732AbWKGXg0
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 18:36:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107233626.UAFS16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 18:36:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jzc21V00r1kojtg0000000; Tue, 07 Nov 2006
 18:36:03 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 7 Nov 2006, Jakub Narebski wrote:
>>  
>> Do I understand correctly that the work on not exploding downloaded
>> pack on fetch, but making it non-thin, and related work on archival
>> packs (not to be considered for repacking) is not considered ready
>> (and tested)?
>
> I'd like to see a new version with both the packed refs and the 
> non-exploading download on by default. Maybe time for a git-1.5.0 release 
> from master?

Don't worry, packed refs is already part of 'master' so whatever
the next feature release is called it will be part of it ;-).
