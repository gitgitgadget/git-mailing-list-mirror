From: magnuspalmer <magnus.palmer@jayway.com>
Subject: Re: Migrating from subversion via git svn contains log entry, but
 not the file change in the branch.
Date: Tue, 4 May 2010 08:32:35 -0700 (PDT)
Message-ID: <1272987155533-5003911.post@n2.nabble.com>
References: <1272889536578-4997493.post@n2.nabble.com> <4BDEC3AE.90409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 17:32:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9K70-0002Uq-Ez
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 17:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab0EDPch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 11:32:37 -0400
Received: from kuber.nabble.com ([216.139.236.158]:52587 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab0EDPcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 11:32:36 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <magnus.palmer@jayway.com>)
	id 1O9K6t-0002ax-HU
	for git@vger.kernel.org; Tue, 04 May 2010 08:32:35 -0700
In-Reply-To: <4BDEC3AE.90409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146318>


Ok, I have a local copy of the Subversion repo not using svnsync to speed up
testing.

I also upgraded git and git-svn to 1.7.1
Svn is at 1.6.5

I do the git svn init as before, but with the
file://<path_to_local_svn_repo>
It is saying using higher level url, if that does anything?

I asume that this error message is what is causing my problem?

r10623 = 7191e343c78eb0705173c47b1f914da8b1c6d6f5 (refs/remotes/svn/trunk)
Found possible branch point:
file:///home/user/svn-repo/services/project/clients/branches/develop/pom.xml
=>
file:///home/user/svn-repo/services/project/clients/branches/release-1.1.0,
10623
Initializing parent: refs/remotes/svn/release-1.1.0@10623
W: Ignoring error from SVN, path probably does not exist: (160013):
Filesystem has no item: File not found: revision 101, path
'/services/clients/branches/develop/pom.xml'
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories
r9529 = f4b81a737c453f18ab613cb216f26671e24b5d6e
(refs/remotes/svn/release-1.1.0@10623)
r9812 = 9359c6b9aac2c753e484d3a6ba26c857f578ad15
(refs/remotes/svn/release-1.1.0@10623)
Found branch parent: (refs/remotes/svn/release-1.1.0)
9359c6b9aac2c753e484d3a6ba26c857f578ad15
Following parent with do_switch
Invalid filesystem path syntax: Cannot replace a directory from within at
/usr/lib/git-core/git-svn line 5097


Btw, why do I get a @<revision> branch here?
remotes/svn/release-1.1.0
remotes/svn/release-1.1.0@10623


git checkout -b develop svn/develop
HEAD is now at 5012366... increased version to 1.2.0-SNAPSHOT

Version in file is not 1.2.0-SNAPSHOT as the log says and as it is in
Subversion.


-- 
View this message in context: http://git.661346.n2.nabble.com/Migrating-from-subversion-via-git-svn-contains-log-entry-but-not-the-file-change-in-the-branch-tp4997493p5003911.html
Sent from the git mailing list archive at Nabble.com.
