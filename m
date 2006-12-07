X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Avoid miscounting bytes in Perl v5.8.x
Date: Wed, 06 Dec 2006 21:48:07 -0800
Message-ID: <7v1wncw92g.fsf@assigned-by-dhcp.cox.net>
References: <11654627303222-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 05:48:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11654627303222-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Thu, 7 Dec 2006 16:38:50 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33551>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsC7C-0004zi-7n for gcvg-git@gmane.org; Thu, 07 Dec
 2006 06:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031279AbWLGFsL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 00:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031326AbWLGFsL
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 00:48:11 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40816 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031279AbWLGFsJ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 00:48:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207054808.NSYV20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Thu, 7
 Dec 2006 00:48:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vhnY1V0011kojtg0000000; Thu, 07 Dec 2006
 00:47:32 -0500
To: Martin Langhoff <martin@catalyst.net.nz>
Sender: git-owner@vger.kernel.org

Martin Langhoff <martin@catalyst.net.nz> writes:

> At some point between v5.6 and 5.8 Perl started to assume its input,
> output and filehandles are UTF-8. This breaks the counting of bytes
> for the CVS protocol, resulting in the client expecting less data
> than we actually send, and storing truncated files.

Thanks.  Will queue for both maint and master.
