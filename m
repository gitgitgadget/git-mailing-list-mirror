From: Bill Lear <rael@zopyra.com>
Subject: Using the --track option when creating a branch
Date: Wed, 29 Oct 2008 09:23:54 -0600
Message-ID: <18696.32778.842933.486171@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 16:58:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvDOK-0001A9-8f
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbYJ2PyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbYJ2PyL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:54:11 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61779 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYJ2PyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:54:10 -0400
X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Oct 2008 11:54:10 EDT
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m9TFNxw29170;
	Wed, 29 Oct 2008 09:23:59 -0600
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99375>

We have had a few "crossed stream" problems when developers are
working on a local branch and they do an unguarded git push/pull,
when they really intended to do git push/pull origin branchname.

We use git in a way that makes it desirable for us to only push/pull
to the same remote branch.  So, if I'm in branch X, I want 'git push'
to push to origin/X, and 'git pull' to fetch into origin/X and then
merge into X from origin/X.

In other words, we want git push/pull to behave in branches other than
master the same way it does when in master.

I have discovered the '--track' option when creating a local branch,
and this appears to me to be the thing that gives us the desired
behavior.

Before I tell the rest of the team that this is the correct way
to do things, I need to be sure I am correct, so if anyone here
can confirm or deny this, I'd appreciate it.

Also, once a branch has been created, how can we add a '--track' option
after the fact?

Finally, is there a 'global' config setting that would set this behavior
for all repos (new or existing)?

We are using git 1.6.* versions here, mostly.

Thanks.


Bill
