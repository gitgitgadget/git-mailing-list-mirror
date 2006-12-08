X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] rerere: avoid misrecording on a skipped or aborted rebase/am
Date: Fri, 08 Dec 2006 11:33:06 -0800
Message-ID: <7vbqmei3nx.fsf@assigned-by-dhcp.cox.net>
References: <20061205092126.GE27236@soma>
	<11655749724034-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 19:33:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11655749724034-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 8 Dec 2006 02:49:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33727>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslT6-0000uF-Pb for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426156AbWLHTdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426157AbWLHTdJ
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:33:09 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45479 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1426156AbWLHTdH (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 14:33:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208193307.NCE2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 14:33:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wKYW1V00D1kojtg0000000; Fri, 08 Dec 2006
 14:32:30 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

This is good, but Documentation/git-rerere.txt should talk about
this new option you added.

