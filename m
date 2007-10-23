From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Howto request: going home in the middle of something?
Date: Tue, 23 Oct 2007 20:38:20 +0200
Message-ID: <200710232038.21206.wielemak@science.uva.nl>
References: <200710181144.22655.wielemak@science.uva.nl> <200710221044.24191.wielemak@science.uva.nl> <20071023135655.x6g6mln1j4880wog@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 20:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkOeG-0005SC-Uu
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 20:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXJWSi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 14:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXJWSi2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 14:38:28 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:2325 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbXJWSi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 14:38:28 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9NIcMOj048311;
	Tue, 23 Oct 2007 20:38:23 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20071023135655.x6g6mln1j4880wog@intranet.digizenstudio.com>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62146>

On Tuesday 23 October 2007 19:56:55 Jing Xue wrote:
> Quoting Jan Wielemaker <wielemak@science.uva.nl>:
> > Thanks for the replies.	 I think I can live with something like this
> >
> > 	<work, in the middle of something>
> > 	$ git checkout -b home
> > 	$ git commit
> > 	$ git checkout master
> > 	<arriving at home>
> > 	$ git jan@work:repo fetch home:home	(using ssh)
> > 	$ git checkout home
> > 	<continue editing>
> > 	$ git commit --amend
> > 	$ git checkout master
> > 	$ git merge home
> > 	$ git -d home
> > 	$ git commit
> > 	$ git push
> > 	<arriving at work>
> > 	$ git -d home
> > 	$ git pull
> >
> > Its still a bit many commands and you have to be aware what you are
> > doing for quite a while, but it does provide one single clean commit
> > message, doesn't change the shared repo until all is finished and allows
> > to abandon all work without leaving traces.
>
> What does the extra branch gain for us here? That's not a rhetorical
> question, I'm actually curious to learn, because I always just commit,
> switch to another computer, pull, and reset HEAD^.

I'm just trying to learn. Sofar I like the idea to stash and use
git-fetch to get the stash from the other side. As stash is about
handling current work, it feels as the most appropriate solution
and is a lot shorter.

	Cheers --- Jan
