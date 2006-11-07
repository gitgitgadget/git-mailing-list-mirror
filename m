X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: If merging that is really fast forwarding creates new commit
Date: Tue, 07 Nov 2006 13:37:42 -0800
Message-ID: <7vhcxb2b15.fsf@assigned-by-dhcp.cox.net>
References: <454EAEDB.8020909@gmail.com>
	<7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com>
	<Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
	<45503553.3020605@gmail.com>
	<Pine.LNX.4.64.0611070729370.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 21:38:13 +0000 (UTC)
Cc: git@vger.kernel.org, Liu Yubao <yubao.liu@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611070729370.3667@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 7 Nov 2006 08:05:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31091>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhYdg-0000CJ-Gm for gcvg-git@gmane.org; Tue, 07 Nov
 2006 22:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753400AbWKGVho (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 16:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbWKGVho
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 16:37:44 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7556 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1753400AbWKGVhn
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 16:37:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107213743.HBQK22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 16:37:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jxdK1V00Q1kojtg0000000; Tue, 07 Nov 2006
 16:37:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Git doesn't even have that concept. There is the concept of a _default_ 
> branch ("master"), and yes, the git repository has it. But at the same 
> time, it really is just a default. There are three "main" branches that 
> Junio maintains, and they only really differ in the degree of development. 
> And "master" isn't even the most stable one - it's just the default one, 
> because it's smack dab in the middle: recent enough to be interesting, but 
> still stable enough to be worth tracking for just about anybody.
>
> But really, "maint" is the stable branch, and in many ways you could say 
> that "maint" is the trunk branch, since that's what Junio still cuts 
> releases from.

The branch 'maint' is meant to be the moral equivalent of the
efforts of your -stable team, so it shouldn't be "the trunk",
but you caught me.

We haven't seen a new release from 'master' for about a month.
I think the dust has settled already after two big topics
(packed-refs, delta-offset-base) were merged into 'master' since
v1.4.3, and it is now time to decide which topics that have been
cooking in 'next' are the ones I want in v1.4.4.  Perhaps by the
end of the week, I'll cut a v1.4.4-rc1 to start the pre-release
stabilization process.  No new features nor enhancements on
'master' after that until v1.4.4 final.
