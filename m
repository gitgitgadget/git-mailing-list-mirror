From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-rebase -i not escaping # at the beginning of the line
Date: Wed, 3 Jun 2009 12:57:03 +0200
Message-ID: <20090603105703.GB10035@machine.or.cz>
References: <ce2236de-8670-4213-8474-52365f0397bc@z14g2000yqa.googlegroups.com> <20090603104718.GA10035@machine.or.cz> <alpine.DEB.1.00.0906031252070.10241@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: donnoman@gmail.com, git-users@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 03 12:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBo9h-0006Qp-G4
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 12:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbZFCK5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 06:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbZFCK5D
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 06:57:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53579 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237AbZFCK5C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 06:57:02 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1F2CF125A0E8; Wed,  3 Jun 2009 12:57:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0906031252070.10241@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120601>

  Hi,

On Wed, Jun 03, 2009 at 12:53:27PM +0200, Johannes Schindelin wrote:
> On Wed, 3 Jun 2009, Petr Baudis wrote:
> 
> > On Tue, Jun 02, 2009 at 12:28:41PM -0700, donnoman wrote:
> > > Redmine automatically links those log messages to the ticket when we
> > > use this method.  It works well for git commit -m "#1234 story xyz"
> > > 
> > > However, when we use git rebase -i, all of the lines that include the
> > > # character get stripped out of the commit messages.
> > > 
> > > How can we escape these?
> > 
> > This definitely sounds like a bug, what git version are you using?
> 
> It is sort of a bug, in a very peculiar: try amending such a commit 
> _interactively_.  It will not work.
> 
> The reason: you are not supposed to start any line in a commit message 
> with a '#'.  I would actually have expected "git commit -m" to refuse such 
> a line.

  the line can also come there during import from another VCS, through
email, or so... I think it's more reasonable to deal with them when
filling in the commit message to the editor than in all the other
places.

-- 
				Petr "Pasky" Baudis
The lyf so short, the craft so long to lerne. -- Chaucer
