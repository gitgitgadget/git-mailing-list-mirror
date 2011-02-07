From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 22:11:27 +0100
Message-ID: <20110207211127.GG63976@book.hvoigt.net>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:11:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYMw-00067o-Pt
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab1BGVL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:11:29 -0500
Received: from darksea.de ([83.133.111.250]:49264 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753949Ab1BGVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:11:29 -0500
Received: (qmail 11874 invoked from network); 7 Feb 2011 22:11:27 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2011 22:11:27 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1102062234010.3788@debian>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166295>

Hallo Martin,

On Mon, Feb 07, 2011 at 06:01:51AM -0500, Martin von Zweigbergk wrote:
> Proposal:
> 
> 'git checkout refs/heads/foo' (or 'git checkout heads/foo' for that
> matter) does not check out the branch, but instead detaches HEAD at
> foo. This is quite counter-intuitive (at least to me) and the same
> functionality can be achieved by using e.g. foo~0. Change the behavior
> so that the branch is actually checked out. This also applies to
> e.g. 'git rebase master refs/heads/topic', which currently rebases a
> detached HEAD. There are probably other examples as well that I'm not
> aware of.

Just to clarify: You are not proposing that 'git checkout origin/master'
would also not checkout to a detached head, right? Because that is a
feature I am using frequently to test branches that have been pushed by
another developer to a remote server. If that would create a new local
branch that would be confusing.

Cheers Heiko
