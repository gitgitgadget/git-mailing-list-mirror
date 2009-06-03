From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rebase -i not escaping # at the beginning of the line
Date: Wed, 3 Jun 2009 12:53:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906031252070.10241@intel-tinevez-2-302>
References: <ce2236de-8670-4213-8474-52365f0397bc@z14g2000yqa.googlegroups.com> <20090603104718.GA10035@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: donnoman@gmail.com, git-users@googlegroups.com, git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jun 03 12:53:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBo6D-00054f-KU
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 12:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510AbZFCKx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 06:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756280AbZFCKx2
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 06:53:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:56586 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756359AbZFCKx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 06:53:27 -0400
Received: (qmail invoked by alias); 03 Jun 2009 10:53:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 03 Jun 2009 12:53:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uWMAbcrVuzCLDRBDS9ArPsqvNqfuG14NXP93g+E
	YbEtNskQe6Vq+o
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090603104718.GA10035@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120600>

Hi,

On Wed, 3 Jun 2009, Petr Baudis wrote:

> On Tue, Jun 02, 2009 at 12:28:41PM -0700, donnoman wrote:
> > Redmine automatically links those log messages to the ticket when we
> > use this method.  It works well for git commit -m "#1234 story xyz"
> > 
> > However, when we use git rebase -i, all of the lines that include the
> > # character get stripped out of the commit messages.
> > 
> > How can we escape these?
> 
> This definitely sounds like a bug, what git version are you using?

It is sort of a bug, in a very peculiar: try amending such a commit 
_interactively_.  It will not work.

The reason: you are not supposed to start any line in a commit message 
with a '#'.  I would actually have expected "git commit -m" to refuse such 
a line.

Ciao,
Dscho
