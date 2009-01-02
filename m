From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] rebase: learn to rebase root commit
Date: Fri, 2 Jan 2009 19:58:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021957400.30769@pacific.mpi-cbg.de>
References: <200812301323.30550.trast@student.ethz.ch> <7b2902d36a4790670f20f786d4ea2e26052a6e71.1230639970.git.trast@student.ethz.ch> <7v4p0iivwh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 20:00:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIpFV-000237-SD
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602AbZABS6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758537AbZABS6e
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:58:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:40913 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758523AbZABS6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:58:33 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:58:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 02 Jan 2009 19:58:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PN/RRLeaPl2Krr5oOAye6Me2FPnDIC35j9CrbK9
	Rpyl2FvTl/5sim
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v4p0iivwh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104405>

Hi,

On Thu, 1 Jan 2009, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Teach git-rebase a new option --root, which instructs it to rebase the
> > entire history leading up to <branch>.
> >
> > The main use-case is with git-svn: suppose you start hacking (perhaps
> > offline) on a new project, but later notice you want to commit this
> > work to SVN.  You will have to rebase the entire history, including
> > the root commit, on a (possibly empty) commit coming from git-svn, to
> > establish a history connection.  This previously had to be done by
> > cherry-picking the root commit manually.
> 
> I like what this series tries to do.  Using the --root option is probably
> a more natural way to do what people often do with the "add graft and
> filter-branch the whole history once" procedure.
> 
> But it somewhat feels sad if the "main" use-case for this is to start your
> project in git and then migrate away by feeding your history to subversion
> ;-).

FWIW I had a single case where I could have used something like this 
myself, in my whole life.  It was when I started to write 
git-edit-patch-series.sh in its own repository, only to realize at the end 
that I should have started it in a topic branch in my git.git tree.

Ciao,
Dscho
