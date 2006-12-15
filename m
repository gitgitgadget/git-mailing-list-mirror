X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 10:14:55 -0800
Message-ID: <7vvekdvxeo.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
	<7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612141343200.18171@xanadu.home>
	<Pine.LNX.4.64.0612142307160.18171@xanadu.home>
	<20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se>
	<20061215150909.GE17860@spearce.org>
	<Pine.LNX.4.64.0612151032240.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 18:15:12 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34537>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvHaP-0001WJ-3E for gcvg-git@gmane.org; Fri, 15 Dec
 2006 19:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753123AbWLOSO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 13:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbWLOSO7
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 13:14:59 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55005 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753124AbWLOSO6 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 13:14:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215181456.GPYF4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 13:14:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z6F71V0141kojtg0000000; Fri, 15 Dec 2006
 13:15:08 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> So in short I do think there should be something shown after a 
> successful commit, and including the commit sha1 doesn't hurt.
> ...
> And it is true that diffstat can be quite large.  I wouldn't mind the 
> diffstat to be added to the commit message summary in the text editor 
> though.  And displaying it when -v is used makes also a lot of sense.  
> But not by default please.

I agree with everything you said in your message, including that
commit object name might help as a learning aid.

We could give something like this, though, if we wanted to:

	$ git commit
        4 files changed, 17 insertions(+), 10 deletions(-)
        mode change 100755 => 100644 test.sh

