X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix bad usage of mkpath in builtin-branch.sh
Date: Tue, 24 Oct 2006 21:00:14 -0700
Message-ID: <7vac3lf3jl.fsf@assigned-by-dhcp.cox.net>
References: <1161655176461-git-send-email-hjemli@gmail.com>
	<7vlkn6qkh2.fsf@assigned-by-dhcp.cox.net>
	<20061024113806.GB20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 04:00:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061024113806.GB20017@pasky.or.cz> (Petr Baudis's message of
	"Tue, 24 Oct 2006 13:38:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30028>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcZwD-0004C3-71 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 06:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422913AbWJYEAR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 00:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWJYEAR
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 00:00:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18099 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1161338AbWJYEAP
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 00:00:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025040015.SPIX12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 00:00:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eTzx1V06t1kojtg0000000 Tue, 24 Oct 2006
 23:59:58 -0400
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Tue, Oct 24, 2006 at 08:46:49AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Lars Hjemli <hjemli@gmail.com> writes:
>> 
>> > diff --git a/builtin-branch.c b/builtin-branch.c
>> > index ffc2db0..f86bf68 100755
>> 
>> I've already fixed up this perm-mode breakage (and other
>> breakages, possibly) so when I am done with these patches
>> tonight please resync with me.
>
> I have made my fair share of inadverent mode changes as well (I don't
> even know how that *happenned*), and I don't seem to be alone; since
> this is something you are doing only rarely anyway, perhaps we should
> try to make mode changes more visible?

Well we already do and that's how I noticed.
