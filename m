From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 14:02:25 -0700 (PDT)
Message-ID: <20061010210226.47626.qmail@web31809.mail.mud.yahoo.com>
References: <200610102231.37136.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 23:03:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOke-00061Y-8k
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 23:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWJJVC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 17:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWJJVC3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 17:02:29 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:30056 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030378AbWJJVC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 17:02:27 -0400
Received: (qmail 47628 invoked by uid 60001); 10 Oct 2006 21:02:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MoxLPavzeL1f76y4VqD+Vx5kDvAUmKR4tCfuVrhcx5EnvP7iSdrvWbywffJ8MC4EwOBCfmWJ1avaNpCcWrzwp7+oqeHMW5+uCV1o3Yi8kPC6x9tu4cf6oerhmBYV8QCieDOwECm8k7pcy4Eu/Y/BrqTYISqH08ouGW/qxulPkGA=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 14:02:25 PDT
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <200610102231.37136.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28670>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> > 
> > > Or,
> > >    "Click on the 'blob' link to get the ... Click on the 'tree' link to
> > >     get the ... Oh you didn't know what a 'tree' or 'blob' object is?
> > >     A 'blob' is ... A 'tree' is ..."
> > >
> > > At which point the engineer has lost 90% of his interest.
> > >
> > > It even gets even worse for the obnoxious "tree" link next to each commit
> > > in shortlog view:
> > >    "The tree link is the the tree object which is part of a commit object.
> > >     Oh you don't know the internals of a commit object?  A commit object
> > >     binds a tree object and a (parent) commit object, but blah, blah, blah..."
> > 
> > Isn't that a simple "labelling" question?  I do not think
> > anybody minds to show clickable string "contents" (instead of
> > "blob" or "tree") at the places you mention above and if we did
> > so everybody would be happy, right?
> 
> Not, IMHO it is not a good idea. Clicking on file name leads to it
> contents, but it is not obvoius what kind of view is it. "blob" link

It is pretty obvious to me: the contents of the object, whether it be
"blob" or "tree".  The contents of "blob" and the contents of "tree"
as shown by gitweb.

   Luben


> leads to blob view, "tree" link leads to tree view, which are known
> what they mean to any git user.
> -- 
> Jakub Narebski
> Poland
> 
