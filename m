X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Thu, 02 Nov 2006 22:18:07 -0800
Message-ID: <7vhcxhjbog.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200611010140.56834.jnareb@gmail.com>
	<7vac3awtj4.fsf@assigned-by-dhcp.cox.net>
	<200611020949.34276.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 06:18:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611020949.34276.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 2 Nov 2006 09:49:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30786>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfsNl-00083C-9k for gcvg-git@gmane.org; Fri, 03 Nov
 2006 07:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753120AbWKCGSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 01:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbWKCGSJ
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 01:18:09 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:4086 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1753120AbWKCGSI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 01:18:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103061808.LIXI6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 01:18:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id i6JC1V00J1kojtg0000000 Fri, 03 Nov 2006
 01:18:13 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> I'll be pushing out a "master" update
>> sometime today, and do not expect to be able to get to your "n
>> turned out to be ten" series, so it might be worthwhile to
>> reroll the remaining bits that you still care about on top of
>> what I push out tonight to make sure we are on the same page.
>
> I'll wait a while if there are any comments (for example on formatting
> used), and resend cleaned-up series.
> ...
> I've send series early to get some comments, but I see while I got
> some comments on "take 1" and "take 2" on _single_ "new commitdiff"
> RFC patch, I got comments only about half-baked '&iquot;' idea.

Well, I think some of the major reasons you did not get any
response were:

 (1) it was unclear where it started, where it was heading to,
     and where it ended until you sent out "by the way n=10"
     message at the end;

 (2) the first major oand interesting one in the series (5/n)
     were linewrapped and could not be applied;

and it is rather hard to comment on gitweb changes unless you
view two instances of gitweb output side-by-side for before and
after each patch.

I'd see if I can add some constructive comments on patches 5-10
tonight, but I'm in the middle of other things so don't hold
your breath ;-).
