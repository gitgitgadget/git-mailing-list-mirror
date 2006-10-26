X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 26 Oct 2006 02:24:25 -0700
Message-ID: <7v7iynpgza.fsf@assigned-by-dhcp.cox.net>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
	<ehpu4t$ch2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 09:24:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ehpu4t$ch2$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	26 Oct 2006 11:12:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30163>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1TU-00014R-Rn for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422879AbWJZJY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422891AbWJZJY3
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:24:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:61569 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1422879AbWJZJY3
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:24:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026092427.ONOJ16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 05:24:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id exQ81V00w1kojtg0000000 Thu, 26 Oct 2006
 05:24:09 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>>   I've flushed all the 'gitweb/' changes from "next" and core
>>   support that some of them needed; notably "for-each-ref" and
>>   "blame --porcelain" is now in "master".  Oh, and "annotate"
>>   is now a mere synonym for "blame -c".
>>       gitweb: prepare for repositories with packed refs.
>>       gitweb: use for-each-ref to show the latest activity across branches
>
> This unfortunately means that I cannot test gitweb based on 'master'
> branch using _released_ git core, git version 1.4.3.3, as it doesn't have
> git-for-each-ref nor git-show-ref.

As long as "master" version of gitweb goes with "master" version
of the core, I do not see it as a problem.  Otherwise how would
you make any progress?

> ... Should
> we try to wait for core feature to mature to released version before using
> it in gitweb?

That's both insulting and inconsistent.

Insulting in that somehow you seem to feel "master" is lessor
quality than "maint", and inconsistent in that you seem to find
"gitweb" is somehow more special than other scripts we ship as
part of the git.git project sources.

Anyhow, I have done my fair share of git hacking for the week,
so I'll stop venting and go to bed.
