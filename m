From: layer <layer@known.net>
Subject: I want to omit the commit log message from the log output
Date: Wed, 27 Oct 2010 11:58:02 -0700
Message-ID: <18995.1288205882@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 21:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBBNX-0003UO-Fv
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 21:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab0J0TJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 15:09:25 -0400
Received: from relay.known.net ([173.13.135.57]:42971 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755340Ab0J0TJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 15:09:24 -0400
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 15:09:24 EDT
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.21) id 000000133619; Wed, 27 Oct 2010 11:58:02 -0700
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160114>

I'm trying to simulate the output that comes at the end of the merge:

$ git merge origin/master
Updating f682676..b37ad77
Fast-forward
 MODULES                           |    3 +-
 Makefile.patch82                  |    2 +-
 bin/subs.sh                       |   43 +++-
...
 status.sh                         |   14 +-
 whatsnew.sh                       |   15 +
 12 files changed, 636 insertions(+), 26 deletions(-)
 create mode 100755 bin/git-what-branch
 create mode 100644 bin/git-what-branch.readme
 create mode 100755 whatsnew.sh
$ 

That is, I want to run a command that will show me the above output
without doing the merge.  This is close, but not quite:

$ git log --summary --stat origin/master ^HEAD


Are there arguments to git log that can do what I want?

Thanks.
