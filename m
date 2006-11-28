X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Hyphens and hiding core commands
Date: Mon, 27 Nov 2006 18:18:54 -0800
Message-ID: <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 02:19:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <878xhwwdyj.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	27 Nov 2006 17:35:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32480>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GosYl-0000LC-PV for gcvg-git@gmane.org; Tue, 28 Nov
 2006 03:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934190AbWK1CS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 21:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934476AbWK1CS4
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 21:18:56 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39395 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S934190AbWK1CSz
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 21:18:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128021855.CEPO97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 21:18:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id s2JP1V0021kojtg0000000; Mon, 27 Nov 2006
 21:18:23 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> On Mon, 27 Nov 2006 16:42:14 -0800, Junio C Hamano wrote:
>> I think you are teaching backwards.  Couldn't you start like this?
>>
>> 	"git commit" takes the list of paths you want to commit.
> ...

> If the "commit the index" operation were moved to a non-default
> command-line option of git-commit, then the commit command could be
> explained without having to introduce the notion of the index at
> all.

Read what I wrote again.  You can explain it without talking
about index at all.  I really do not think you need to break
"git commit" nor rename "update-index" to "resolve" to explain
things to new people.

The tutorial might be better reworked not to start talking about
-a but start building small project from a newly created
hello.c, git add it, and "git commit" (the first commit), then
edit hello.c and "git commit hello.c" (the second commit).

Perhaps.

Enough about "git commit -a" for tonight.
