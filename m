X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 14:43:21 -0800
Message-ID: <7v7ixp20za.fsf@assigned-by-dhcp.cox.net>
References: <20061120215116.GA20736@admingilde.org>
	<ejt9dh$kfm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 22:43:36 +0000 (UTC)
Cc: jnareb@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-cc: git@vger.kernel.org
In-Reply-To: <ejt9dh$kfm$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	20 Nov 2006 23:16:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31947>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmHrQ-0000EE-J5 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966591AbWKTWnX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966644AbWKTWnX
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:43:23 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:19082 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S966591AbWKTWnW
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:43:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120224321.ZWHT5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 17:43:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pAis1V00Q1kojtg0000000; Mon, 20 Nov 2006
 17:42:53 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, in todo branch, in Subpro.txt, there is talk about adding
> link to submodule trees in _commit object_... well link to submodule tree
> or commit, with the "mount point".

That was shot down by Linus and I agree with him.  "bind" was a
bad idea because binding of a particular subproject commit into
a tree is a property of the tree, not one of the commits that
happen to have that tree.
