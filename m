From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] Managing projects - advanced Git tutorial/walkthrough
Date: Sat, 6 May 2006 17:54:50 -0400
Message-ID: <BAYC1-PASMTP10D8E6E33237EA0B422677AEAA0@CEZ.ICE>
References: <e3hnjg$k9f$1@sea.gmane.org>
	<7v64kisyow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 00:00:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcUoi-0006s2-Fk
	for gcvg-git@gmane.org; Sun, 07 May 2006 00:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWEFV7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 17:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWEFV7v
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 17:59:51 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:52765 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750857AbWEFV7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 17:59:50 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 15:01:41 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 9F3A7644C28;
	Sat,  6 May 2006 17:59:48 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060506175450.57b70ee2.seanlkml@sympatico.ca>
In-Reply-To: <7v64kisyow.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 May 2006 22:01:42.0265 (UTC) FILETIME=[A8615690:01C67158]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 06 May 2006 13:09:03 -0700
Junio C Hamano <junkio@cox.net> wrote:

[...]
> I think tutorial.txt is the right "your first experience with
> git with walkthru" document, and the materials it gives, and the
> order in which it introduces them, are very well thought out;
> kudos to JBF.  We might also want to show "git grep", but other
> than that I do not think of anything that a new user might want
> to use on the first day.

It doesn't mention git log, show or status which are important
for the first day.  Also an example of git commit --amend would
be a nice touch.

Part of the problem people new to git are having arise by reading
documentation in the wrong order and coming to the conclusion that
git is an ugly beast.   Also many people are still finding out-of-
date information before anything else (eg. git isn't an scm only an
object tracker).

Part of this will be solved by having a useful and inviting web page
(thanks Pasky!).  But it would also help to rename core-tutorial.txt
to something that doesn't sound inviting to newbies.  Something
along the line of core-internal-design.txt (or here-be-dragons.txt).

Turning the main man page into more of a reference than a tutorial
slash concepts page would be something worth doing too.  Removing
all of the plumbing commands from that page should at least be
considered.

[...]

> Then reorganize the initial part core-tutorial.txt to match the
> examples tutorial.txt gives, and demonstrate what is happening
> under the hood.  The tutorial says "git init-db" then "git
> add".  The core-tutorial would match that and explain what
> happens when "git init-db" is run (creates .git/objects etc.)
> and "git add" is run (populates the index).
> 

There really seems to be a lot of room for another intermediate user
level document between tutorial.txt and the current core-tutorial.txt.
There are lots of concepts that can be explained without having to get
into the low level design or tools of git.  For example, a user could
have long been productive with git before ever having to learn about
read-tree/write-tree etc.. all those commands are more for porcelain
writers and git guru/experts now.

Sean
