From: Petr Baudis <pasky@suse.cz>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3]
	add new Git::Repo API)
Date: Sun, 20 Jul 2008 23:38:18 +0200
Message-ID: <20080720213818.GF10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <200807192254.24622.jnareb@gmail.com> <20080719211403.GA10151@machine.or.cz> <200807200216.37260.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgci-0001jO-4T
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbYGTViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYGTViU
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:38:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60309 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbYGTViU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:38:20 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5BE38393B32A; Sun, 20 Jul 2008 23:38:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807200216.37260.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89239>

On Sun, Jul 20, 2008 at 02:16:36AM +0200, Jakub Narebski wrote:
> By the way, git-svn can use command(...) instead of $repo->command(...)
> because it sets $ENV{'GIT_DIR'} if it is unset... but I don't see
> where Git.pm inserts 'git' to commands list...

In _execv_git_cmd(), or did I misunderstand your question?

(I think that level of indirection is probably residuum of the XS
interface.)

				Petr "Pasky" Baudis
