From: Jeff Kowalczyk <jtk@yahoo.com>
Subject: Re: git svn: Bad URL passed to RA layer: Unrecognized URL scheme
Date: Sun, 05 Oct 2008 22:28:36 -0400
Message-ID: <pan.2008.10.06.02.28.35.643705@yahoo.com>
References: <pan.2008.10.05.17.24.02.167465@yahoo.com> <237967ef0810051244m51156925x26ae51db038dad49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 04:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmfrQ-0001Wp-9d
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 04:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYJFC2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYJFC2v
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 22:28:51 -0400
Received: from main.gmane.org ([80.91.229.2]:41172 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbYJFC2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 22:28:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kmfq3-00009p-Ra
	for git@vger.kernel.org; Mon, 06 Oct 2008 02:28:47 +0000
Received: from 75-94-104-185.roc.clearwire-dns.net ([75.94.104.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 02:28:47 +0000
Received: from jtk by 75-94-104-185.roc.clearwire-dns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 02:28:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 75-94-104-185.roc.clearwire-dns.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97558>

Mikael Magnusson wrote:
> That somehow looks more like an svn error than a git error, does
> svn checkout http://code.djangoproject.com/svn work?

You were correct, I tried subversion and got the same error. I rebuilt
(gentoo ~x86) neon-0.28.3, subversion-1.5.2 and git-1.6.0.2, and have
functional git svn operations.

However, each operation ends with a segmentation fault. This is the case
with all git svn repositories (e.g. several different svn remote hosts).

  (master) $ git svn rebase
     M  django/core/management/commands/makemessages.py
     M  docs/topics/i18n.txt
  r9155 = 4c86e60f62366ac9c3fd9369c17c54801a8f2ea0 (trunk)
  First, rewinding head to replay your work on top of it...
  Fast-forwarded master to refs/remotes/trunk.
  Segmentation fault

Does the segfault risk corruption of the git repository data?

Would I report this as a git bug or distribution bug?

Thanks.
