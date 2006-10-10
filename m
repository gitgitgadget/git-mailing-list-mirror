From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 13:52:38 -0700 (PDT)
Message-ID: <20061010205238.33892.qmail@web31803.mail.mud.yahoo.com>
References: <7vvemsymdx.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 22:53:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOag-0003XQ-MW
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 22:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWJJUwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 16:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWJJUwk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 16:52:40 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:60580 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030352AbWJJUwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 16:52:39 -0400
Received: (qmail 33894 invoked by uid 60001); 10 Oct 2006 20:52:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Fn9igK1dp7NYNTeKRLcf6EK/O3qBuaae/YLVj1m7oqn3utEOAp0UoZ6U9vzpy6QzQV/zuZI8bmAjaMqFqy2WHiLsa1oJIubEul/M5FsArsqI40yasCbyOwk5f6L3p0QNEUI7By0weQyA2YADIg1LvvaYBInk5AuRypT8FelPvbg=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 13:52:38 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvemsymdx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28665>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Or,
> >    "Click on the 'blob' link to get the ... Click on the 'tree' link to
> >     get the ... Oh you didn't know what a 'tree' or 'blob' object is?
> >     A 'blob' is ... A 'tree' is ..."
> >
> > At which point the engineer has lost 90% of his interest.
> >
> > It even gets even worse for the obnoxious "tree" link next to each commit
> > in shortlog view:
> >    "The tree link is the the tree object which is part of a commit object.
> >     Oh you don't know the internals of a commit object?  A commit object
> >     binds a tree object and a (parent) commit object, but blah, blah, blah..."
> 
> Isn't that a simple "labelling" question?  I do not think

Not quite.  You have to explain to the engineer that the "tree" link
next to each "comit title" "shows" the project _at the state of that
commit_.  Which is the WORST PR for git and gitweb.  Why?

Because now you have to explain internals of git and gitweb.

Instead of letting the engineer click on the commit to see the commit
and then the commit provides a _context_ where "tree" makes much more
intuitive sense.

OTOH, if one is an expert in git, then they have no problem
getting to the information: commit->tree.

> anybody minds to show clickable string "contents" (instead of
> "blob" or "tree") at the places you mention above and if we did

Well, "contents" of a commit is a tricky thing.  This is why I don't
like the "tree" link next to each commit in shortlog, but didn't mention
anything when the patch was posted a couple of days ago.

It is just an unnecessary "fast forward interpretation" of commit.

> so everybody would be happy, right?

I don't know anymore.

    Luben
P.S. Notice how there is a "snapshot" link on each line of
shortlog, but there is no "snapshot" link in the nav bar
of a=commit.  The "snapshot" link is next to "tree" down
in the commit data.  There is also a "tree" link which is also
in the navbar, but "shortlog" is missing.
