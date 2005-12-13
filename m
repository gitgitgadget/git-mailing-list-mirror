From: freku045@student.liu.se
Subject: [PATCH 0/11] Usage string clean-up
Date: Tue, 13 Dec 2005 23:30:30 +0100
Message-ID: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Dec 13 23:35:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIgP-0006dV-I3
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVLMWat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVLMWat
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:49 -0500
Received: from [85.8.31.11] ([85.8.31.11]:50386 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030292AbVLMWak (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:40 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP id 32E4D40FD
	for <git@vger.kernel.org>; Tue, 13 Dec 2005 23:40:59 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001yh-00
	for <git@vger.kernel.org>; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13606>

Hi,

This is a redone version of the usage string clean-up patch series. It
should apply cleanly on top of the current 'pu' branch.

This version is supposed to get the details right.

The scripts are supposed to set the variable USAGE to some suitable
value before they source git-sh-setup. Optionally they can also set
LONG_USAGE to a more descriptive help message.

* --help makes the scripts print the (long) usage string and exit
  cleanly.
* Unrecognized options prints the usage string and exits non-cleanly.
* The printed string is of the form "Usage: $0 options". The "Usage:
  $0 " part can easily be changed by changing git-sh-setup.sh

The real value of this series is that all commands prints a usage
message when they get '--help'.

I have left *.perl for a later patch.

 git-add.sh           |   13 +++----------
 git-am.sh            |   10 +++-------
 git-applymbox.sh     |    6 +-----
 git-applypatch.sh    |    4 ++++
 git-checkout.sh      |    6 ++----
 git-cherry.sh        |   13 +++++--------
 git-clone.sh         |    2 +-
 git-commit.sh        |    5 +----
 git-count-objects.sh |    4 +++-
 git-fetch.sh         |    5 +++++
 git-format-patch.sh  |   25 ++++++++-----------------
 git-grep.sh          |    7 +++++--
 git-lost-found.sh    |   10 +++++++++-
 git-merge.sh         |    6 ++----
 git-prune.sh         |    3 ++-
 git-pull.sh          |   13 ++-----------
 git-push.sh          |    7 ++-----
 git-rebase.sh        |    5 +++--
 git-repack.sh        |    2 ++
 git-request-pull.sh  |   12 +++++-------
 git-reset.sh         |    6 ++----
 git-resolve.sh       |    6 ++----
 git-revert.sh        |   19 +++++--------------
 git-tag.sh           |   14 +++-----------
 git-verify-tag.sh    |   14 ++++++++------
 25 files changed, 88 insertions(+), 129 deletions(-)

- Fredrik
