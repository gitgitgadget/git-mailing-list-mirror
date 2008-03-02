From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: The EGIT Chronicles Issue Volume 2, Issue 1
Date: Sun, 2 Mar 2008 01:51:28 +0100
Message-ID: <200803020151.28397.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 01:51:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVcQk-0007ky-60
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 01:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYCBAvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 19:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYCBAvQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 19:51:16 -0500
Received: from [83.140.172.130] ([83.140.172.130]:6950 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbYCBAvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 19:51:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A21B2802673
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 01:51:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPdWDUTp7vyp for <git@vger.kernel.org>;
	Sun,  2 Mar 2008 01:51:12 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D0262800698
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 01:51:12 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75710>


Eclipse 0.3.1 is out

This release contains a number of minor features and bug fixes.

Features:
- Resources are now decorated with repository state, e.g. whether a merge or 
rebase is in progress.
- Better (subject to subjectivity) formatting of tooltips in the history view
- Actions to set/reset the assume valid bit for files, including decorations
- Improved layout of the history pane and user preferences for this
- Simpler layout of changed files in the compare editor, i.e. we do not list 
folders anymore, just changed files.
- Searching in the history view

Bug fixes:
- Bugfixes related to checkout and detection of changed files for commit. This
is the most important part of this release.
- The ability to perform the first commit in a repository from within Eclipse.
- Parsing of the config file

Documentation:
- Javadoc on anything public/protected in jgit. Should make it a little easier 
for newcomers. Also makes the project look better on Ohloh. Unit tests for 
jgit moved into it's own project and tests that do require external 
dependencies were separated from better defined ones that do not.
- A number of typo's fixed.

New branch:
- Created stable branch. Currently points to v0.3.1. This branch will contain
tagged versions.

Special thanks to Roger C. Soares for the history and compare editor 
improvements. Also thanks to Jing Xue, Ladislav Sladecek, Shunichi Fuji and 
Vincent Legoll for correcting some smaller bugs and typos.

Next edition will contain at least fetch thanks to Shawn Pearce. I still have 
a lot of loose ends to tie up before that happens. Roger Soares contributed 
some GUI's for this.

-- robin
