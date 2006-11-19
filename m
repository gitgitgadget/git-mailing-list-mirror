X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] do_for_each_ref: perform the same sanity check for leftovers.
Date: Sat, 18 Nov 2006 22:22:17 -0800
Message-ID: <7vmz6o7y7a.fsf@assigned-by-dhcp.cox.net>
References: <7vr6w07ylu.fsf@assigned-by-dhcp.cox.net>
	<20061119061905.GB26670@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 06:22:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061119061905.GB26670@spearce.org> (Shawn Pearce's message of
	"Sun, 19 Nov 2006 01:19:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31827>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glg4L-00005y-Cu for gcvg-git@gmane.org; Sun, 19 Nov
 2006 07:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756475AbWKSGWT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 01:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756477AbWKSGWS
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 01:22:18 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22932 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1756475AbWKSGWS
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 01:22:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061119062217.GVEC296.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Sun, 19
 Nov 2006 01:22:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oWMp1V00H1kojtg0000000; Sun, 19 Nov 2006
 01:21:49 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>>  * "pickaxe -L'/^static int do_for_each_ref/,+40' refs.c" turns
>
> What's this pickaxe you speak of?  Last I read you deleted it when
> you renamed git-pickaxe to git-blame.
>
> Have you reinvented git-pickaxe so soon?  Maybe we could try using
> git-longblade next time a new comamnd is being developed?  :-)

Oh, no, I meant "blame".
