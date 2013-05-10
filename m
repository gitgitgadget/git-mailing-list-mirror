From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] git-svn updates for 1.8.3-rc2
Date: Fri, 10 May 2013 20:26:40 +0000
Message-ID: <20130510202640.GA16349@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Walmsley <pjwhams@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Contreras <michael@inetric.com>,
	Avishay Lavie <avishay.lavie@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 22:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uattv-0007mc-N3
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 22:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab3EJU0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 16:26:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37040 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887Ab3EJU0n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 16:26:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324FB1F5BD;
	Fri, 10 May 2013 20:26:42 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223903>

The following changes since commit 9b795193a6a7e963db62d9cd8e86752a40940520:

  Update draft release notes for 1.8.3 (2013-05-07 22:50:05 -0700)

are available in the git repository at:

  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to a7b102302ad9495fb4eb5088ffcb09c44a406c06:

  git-svn: added an --include-path flag (2013-05-09 01:13:36 +0000)

----------------------------------------------------------------
Jonathan Nieder (1):
      Git::SVN::*: add missing "NAME" section to perldoc

Michael Contreras (1):
      git-svn: avoid self-referencing mergeinfo

Paul Walmsley (1):
      git-svn: added an --include-path flag

 Documentation/git-svn.txt              |  12 +++
 contrib/completion/git-completion.bash |   2 +-
 git-svn.perl                           |  15 +++-
 perl/Git/SVN/Editor.pm                 |   2 +
 perl/Git/SVN/Fetcher.pm                |  18 +++-
 perl/Git/SVN/Prompt.pm                 |   2 +
 perl/Git/SVN/Ra.pm                     |   2 +
 t/t9147-git-svn-include-paths.sh       | 149 +++++++++++++++++++++++++++++++++
 t/t9161-git-svn-mergeinfo-push.sh      |   1 -
 9 files changed, 196 insertions(+), 7 deletions(-)
 create mode 100755 t/t9147-git-svn-include-paths.sh

-- 
Eric Wong
