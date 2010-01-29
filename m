From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 21:35:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-592357544-1264797313=:3749"
Cc: Ron1 <ron1@flownet.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:35:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaxYp-0003v1-Nj
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab0A2UfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196Ab0A2UfQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:35:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:45529 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751857Ab0A2UfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:35:15 -0500
Received: (qmail invoked by alias); 29 Jan 2010 20:35:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 29 Jan 2010 21:35:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4fG4YFL34yGJl18wbCAoBJn7bbcSOhyutlmY292
	MIiO896hru2kjV
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138349>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-592357544-1264797313=:3749
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 29 Jan 2010, Jacob Helwig wrote:

> On Fri, Jan 29, 2010 at 12:20, Ron1 <ron1@flownet.com> wrote:
> > [ron@mickey]$ git checkout master
> > Already on 'master'
> > [ron@mickey]$ git checkout master^
> > Note: moving to 'master^' which isn't a local branch
> > If you want to create a new branch from this checkout, you may do so
> > (now or later) by using -b with the checkout command again. Example:
> >  git checkout -b <new_branch_name>
> > HEAD is now at 7be05e0... test
> > [ron@mickey]$ git branch
> > * (no branch)
> >  master
> > [ron@mickey]$
> >
> > Huh?!?
> >
> > This is a test repository which has never been pulled from nor pushed to
> > anywhere.  So how is it possible that I have a non-local branch?
> 
> master^ is a commit (the first parent of master), not a branch (local
> or otherwise).

Indeed.  Maybe you (Ron1) need to get a bit more acquainted to Git before 
complaining.

Git is not user-friendly (much to my chagrin, and I tried to change it, 
but it is not going to happen), so the only way out is to really read up 
on good tutorials/manuals before you complain about something that is not 
working as you expect it.

Just as a general hint, I think the best documentation about Git was 
written by J. Bruce Fields (the user manual) and Scott Chacon (everything 
that has GitHub written on it, and Git Pro, and much, much more).  If you 
happen to speak Japanese, Junio's book might help you understand the ideas 
behind the current Git user interface, too.

Hth,
Dscho

--8323329-592357544-1264797313=:3749--
