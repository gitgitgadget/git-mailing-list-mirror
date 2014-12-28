From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] git svn updates for master
Date: Sun, 28 Dec 2014 09:45:54 +0000
Message-ID: <20141228094554.GB29140@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alfred Perlstein <alfred@freebsd.org>,
	David Fraser <davidf@sjsoft.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 10:50:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5AUc-0006E5-Oh
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 10:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbaL1Jp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2014 04:45:56 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40068 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbaL1Jpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2014 04:45:55 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2DA11F7D4;
	Sun, 28 Dec 2014 09:45:54 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261855>

Oops, forgot to Cc: the list

Hi Junio, please pull at your convenience.

This is probably it for the next few weeks.  I was hoping to be able to
reproduce (and fix) a weird tempfile problem which commit 822aaf0f
("Git.pm: add specified name to tempfile template") was intended to help
track down, but haven't seen the problem resurface, yet.

The following changes since commit c18b86734113ee2aeb0e140c922c8fbd4accc860:

  First batch for 2.3 cycle (2014-12-05 12:03:57 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git for-junio

for you to fetch changes up to 83c9433e679635f8fbf8961081ea3581c93ca778:

  git-svn: support for git-svn propset (2014-12-09 22:03:15 +0000)

----------------------------------------------------------------
Alfred Perlstein (1):
      git-svn: support for git-svn propset

 git-svn.perl               | 49 +++++++++++++++++++++++-
 perl/Git/SVN/Editor.pm     | 38 +++++++++++++++++++
 t/t9148-git-svn-propset.sh | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100755 t/t9148-git-svn-propset.sh

Thanks!
