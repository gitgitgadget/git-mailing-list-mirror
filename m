From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem merging
Date: Tue, 22 Nov 2005 19:06:03 -0800
Message-ID: <7v4q6483ms.fsf@assigned-by-dhcp.cox.net>
References: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 23 04:08:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EekxX-0005CE-2V
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 04:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVKWDGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 22:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVKWDGG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 22:06:06 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:31475 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932489AbVKWDGF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 22:06:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123030537.JYME3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 22:05:37 -0500
To: git@vger.kernel.org
In-Reply-To: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 22 Nov 2005 18:50:01 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12598>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Trying to merge 4b4a27dff4e2d4cc2eac1cde31aede834a966a48 into
> e1ef47b54d7e7e477f7f1eb3251a9d37f38e0469 using 989e4d6cbc69191c41ddf4b1c492457410376b43.
> Simple merge failed, trying Automatic merge
> Removing include/asm-um/ldt.h
> fatal: merge program failed
> Automatic merge failed, fix up by hand
>
> This is with git HEAD: 
> 2392ee98eb76aa821de53c93c9e36acb18d27fc0 -- latest as
> of now.
>
> Is this a bug in git?  Since this process has always worked
> before.

As "Merging two branches" section in Documentation/tutorial.txt
shows, it is one of the valid outcome from merge to leave
conflicts and have you manually resolve.  So this process
probably is working correctly for you this time as well.

Sorry, but I am not a good enough cryptoanalyst to reverse SHA1
hashes, and I cannot tell if the merge you did *should* have
resulted in the conflict or not, just by looking at the three
commit object IDs.

What does "git diff" and "git diff HEAD" tell you after the
merge procedure leaves conflict in the working tree (branchB
directory, I mean)?
