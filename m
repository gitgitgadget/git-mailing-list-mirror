X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-reset [--mixed] <tree> [--] <paths>...
Date: Thu, 14 Dec 2006 02:02:17 -0800
Message-ID: <7virge94nq.fsf@assigned-by-dhcp.cox.net>
References: <7vwt4u96e8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 10:02:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vwt4u96e8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 14 Dec 2006 01:24:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34296>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GunQD-0002Wo-2R for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932304AbWLNKCT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWLNKCT
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:02:19 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59962 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932304AbWLNKCS (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 05:02:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214100218.BPBN22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 05:02:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ya1e1V00h1kojtg0000000; Thu, 14 Dec 2006
 05:01:39 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Sometimes it is asked on the list how to revert selected path in
> the index from a tree, most often HEAD, without affecting the
> files in the working tree...

The patch depends on another one that allows the command to work
from a subdirectory (and also has one bug).  Updated one will
appear in 'next'.
