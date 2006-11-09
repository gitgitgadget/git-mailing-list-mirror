X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 08 Nov 2006 16:02:56 -0800
Message-ID: <7virhpqyfj.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 00:03:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 07 Nov 2006 19:21:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31167>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhxNk-0004MV-TG for gcvg-git@gmane.org; Thu, 09 Nov
 2006 01:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161764AbWKIAC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 19:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161773AbWKIAC5
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 19:02:57 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12529 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1161764AbWKIAC5
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 19:02:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109000256.ZFKH20344.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 19:02:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kQ321V0071kojtg0000000; Wed, 08 Nov 2006
 19:03:02 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sorry, I made a mistake of pushing out git-pickaxe before making
it take over git-blame.  So I will fix it up by renaming it to
git-blame.

That is, unless there are too many people whose fingers have
already been trained to type "git-pickaxe" from 'next'
experience (you can obviously count me as one of these people).
In which case I will keep git-pickaxe as a backward compatible
synonym just like we still have git-annotate.

It might also make sense to eventually remove the other synonym
git-annotate but that would be a longer term issue and should be
handled separately.
