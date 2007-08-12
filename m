From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk - dont warn when deleting synonym for current head
Date: Mon, 13 Aug 2007 09:44:29 +1000
Message-ID: <18111.39773.231609.306547@cargo.ozlabs.ibm.com>
References: <1186952583887-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 02:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKNi1-0007sn-FZ
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 02:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934866AbXHMAW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 20:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934860AbXHMAW5
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 20:22:57 -0400
Received: from ozlabs.org ([203.10.76.45]:39716 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbXHMAW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 20:22:56 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 58D7DDDECE; Mon, 13 Aug 2007 10:22:55 +1000 (EST)
In-Reply-To: <1186952583887-git-send-email-mdl123@verizon.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55735>

Mark Levedahl writes:

> Selecting "remove this branch" on a branch equal to HEAD yielded a
> warning that this branch is not in any other: it is, it is on HEAD.

Do you mean that HEAD was a direct ref to the same commit as the
branch you were deleting, or that HEAD pointed to the branch you were
deleting?  I.e. what was in .git/HEAD, a commit ID or a branch name?

If the latter, then I think gitk was correct to warn, since you'll end
up with .git/HEAD pointing to a non-existent branch, won't you?

> Curiosly, this warning was not triggered for any other deletion and
> so is at best misleading. Get rid of it.

I'd rather fix it.

Paul.
