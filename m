X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [BUG] git shortlog: need a range!
Date: Tue, 28 Nov 2006 12:20:02 -0800
Message-ID: <7v8xhv2uj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 20:20:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32573>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp9R6-0003Ac-NY for gcvg-git@gmane.org; Tue, 28 Nov
 2006 21:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936098AbWK1UUH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 15:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936102AbWK1UUH
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 15:20:07 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15864 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S936098AbWK1UUF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 15:20:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128202003.MGTV27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 15:20:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id sLLB1V0141kojtg0000000; Tue, 28 Nov 2006
 15:20:12 -0500
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

I just got this:

        $ git shortlog --since=Oct.20 --until=Nov.20 master
        fatal: Need a range!

Why isn't this a range?
