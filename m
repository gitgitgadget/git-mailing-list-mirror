X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-PS1 bash prompt setting
Date: Thu, 16 Nov 2006 10:35:50 -0800
Message-ID: <7vd57n9r3t.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 18:36:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 16 Nov 2006 13:01:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31615>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkm5b-0007TS-AL for gcvg-git@gmane.org; Thu, 16 Nov
 2006 19:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424125AbWKPSfw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 13:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162151AbWKPSfv
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 13:35:51 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:5812 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1162144AbWKPSfv
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 13:35:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116183551.BXOU21630.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 13:35:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nWbx1V00G1kojtg0000000; Thu, 16 Nov 2006
 13:35:57 -0500
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> Ted mentioned in the wart thread that having multiple branches per repo
> means that the standard bash prompt isn't as much help as it could be.

Yes, I think this is common issue for everybody not just people
who worked with BK or mercurial.  I find myself almost typing
"pwd" to find out what branch I am on (I do not go as far as
typing "git cd" to switch branches, though).
