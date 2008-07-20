From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3]
 add new Git::Repo API)
Date: Sun, 20 Jul 2008 12:38:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201233010.3305@eeepc-johanness>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <200807192254.24622.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Lea Wiemann <lewiemann@gmail.com>,
	git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 12:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKWJ8-0006Jk-8L
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYGTKhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbYGTKhV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:37:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:53504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754556AbYGTKhT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:37:19 -0400
Received: (qmail invoked by alias); 20 Jul 2008 10:37:17 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp015) with SMTP; 20 Jul 2008 12:37:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LTQ00oI7LHXFCv94oNoXkEXDRH82n8vb4k+LOaN
	qI5TJRMPlht17u
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807192254.24622.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89180>

Hi,

On Sat, 19 Jul 2008, Jakub Narebski wrote:

> From git commands in Perl the following include "use Git" in their 
> sources: git-cvsexportcommit, git-send-email, git-svn, and helper
> script git-add--interactive.  There are Perl scripts which do not
> use Git.pm: git-archimport (which I think should be obsoleted or
> moved to contrib), git-cvsimport, git-cvsserver, git-relink.  This
> means that half of Perl scripts use Git Perl API.
> 
> The situation is worse for scripts in 'contrib/'.  From those, only
> contrib/examples/git-remote.perl uses Git.pm; neither blameview,
> continuous, git-import and import-tars in fast-import, setgitperms
> and update-paranoid in hooks, stats, nor other Perl scripts in
> examples (git-rerere, git-svnimport) include "use Git".

You call that "worse"?  Pasky tried to convert all Perl scripts at once 
IIRC, and my numerous problems just _making_ the Git scripts led me to 
rewrite a few Perl scripts in C, so I could safely exclude the Perl 
scripts from my personal fork.

I guess that it was this experience which prevented more of the old 
scripts from being converted.

But your mention of git-add--interactive actually brings up my pet-peeve: 
this script is the only Perl script needed for common operations, i.e. the 
only reason msysGit has to ship bloated with Perl.

Ciao,
Dscho
