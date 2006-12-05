X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] git-svn: let libsvn_ls_fullurl return properties too
Date: Mon, 04 Dec 2006 16:12:28 -0800
Message-ID: <7v3b7vnqtv.fsf@assigned-by-dhcp.cox.net>
References: <20061204235724.46FD7139B0C@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 00:12:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061204235724.46FD7139B0C@magnus.utsl.gen.nz> (Sam Vilain's
	message of "Mon, 4 Dec 2006 20:33:03 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33271>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrNvF-0007My-7B for gcvg-git@gmane.org; Tue, 05 Dec
 2006 01:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967882AbWLEAMa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 19:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967873AbWLEAMa
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 19:12:30 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35228 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967882AbWLEAM3 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 19:12:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205001229.ZWQ20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 19:12:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uoCe1V0161kojtg0000000; Mon, 04 Dec 2006
 19:12:39 -0500
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Thanks.

Please CC people who are primarily working on the part of the
system you are improving.  In the case of git-svn that would be
Eric Wong.

As I almost never touch git-svn myself, I'll queue these four
changes in 'pu' while waiting Ack from Eric on them.



