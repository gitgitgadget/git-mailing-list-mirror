X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 13:55:09 -0800
Message-ID: <7vhcvwomde.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
	<20061214230307.GE26202@spearce.org> <eluhk3$pv7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:55:28 +0000 (UTC)
Cc: jnareb@gmail.com, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34558>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL1a-0006WE-Cr for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965209AbWLOVzU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWLOVzS
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44903 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965203AbWLOVzL (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215510.KNRF29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vM1V00k1kojtg0000000; Fri, 15 Dec 2006
 16:55:22 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Shawn Pearce wrote:
>
>> Andy Parkins <andyparkins@gmail.com> wrote:
>>>  * git-show-branch output is cryptic.
>> 
>> Agreed.  I still don't know how to read its output.  So I just
>> don't use it.  Ever.  :-)
>
> And the way it uses it's options is even more cryptic, and differs from
> other similar commands.

(Jakub, please do not drop people from cc: list; you were asked
more than once).

Ok, so what's the action you guys are proposing?

 (1) show-branch output is cryptic and it does not do anything
     useful.  Drop it.

 (2) show-branch output is cryptic and I do not understand what
     it is trying to do.  Document it better.

 (3) While I agree what show-branch is trying to do is useful,
     its output is useless.  Instead of showing an example
     situation like this:

	[ picture here ]

     It should show the same situation like this:

	[ improved picture here ]

 (4) None of the above.

The same question goes for its input branch specification.

Personally, I find its input branch globbing very handy, and
often wish that 'git branch' had a '--list' option that lists
branches that match the glob pattern given on the command line,
not just listing everything when no parameter is given.
