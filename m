From: Petr Baudis <pasky@ucw.cz>
Subject: git-rebase -i not escaping # at the beginning of the line
Date: Wed, 3 Jun 2009 12:47:18 +0200
Message-ID: <20090603104718.GA10035@machine.or.cz>
References: <ce2236de-8670-4213-8474-52365f0397bc@z14g2000yqa.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-users@googlegroups.com, git@vger.kernel.org
To: donnoman@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 03 12:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBo0J-0003Ke-Tl
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 12:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbZFCKrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 06:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbZFCKrU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 06:47:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45099 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbZFCKrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 06:47:20 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 695FA125A0E8; Wed,  3 Jun 2009 12:47:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ce2236de-8670-4213-8474-52365f0397bc@z14g2000yqa.googlegroups.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120598>

On Tue, Jun 02, 2009 at 12:28:41PM -0700, donnoman wrote:
> Redmine automatically links those log messages to the ticket when we
> use this method.  It works well for git commit -m "#1234 story xyz"
> 
> However, when we use git rebase -i, all of the lines that include the
> # character get stripped out of the commit messages.
> 
> How can we escape these?

This definitely sounds like a bug, what git version are you using?

-- 
				Petr "Pasky" Baudis
The lyf so short, the craft so long to lerne. -- Chaucer
