From: Marc Haber <mh+git@zugschlus.de>
Subject: How to check repository/working tree status from a script
Date: Tue, 19 May 2009 16:35:37 +0200
Message-ID: <20090519143537.GA23505@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 17:28:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6REi-0004tb-QS
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 17:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZESP1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 11:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZESP1n
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 11:27:43 -0400
Received: from torres.zugschlus.de ([85.214.68.41]:60854 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZESP1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 11:27:43 -0400
X-Greylist: delayed 3125 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2009 11:27:42 EDT
Received: from mh by torres.zugschlus.de with local (Exim 4.69)
	(envelope-from <mh+git@zugschlus.de>)
	id 1M6QPp-00069I-J6
	for git@vger.kernel.org; Tue, 19 May 2009 16:35:37 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119538>

Hi,

I am kind of new to git, and my thinking is still somewhat
svn-centric. Please keep this in mind just in case that I have
misunderstood some of git's concepts.

I would like to check in a script whether there (a) are uncommitted
changes (as in "working tree differs from local repository") and/or
whether there (b) are unpulled changes in the "remote origin"
repository.

I have to admit that I didn't bother about (b) yet, but for (a) there
seems no possibility other than to parse git status' output since it
seems to always return exit code 1:

$ GIT_PAGER=cat git status; echo $?
# On branch master
nothing to commit (working directory clean)
1
$ touch keks
$ GIT_PAGER=cat git status; echo $?
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       bla
nothing added to commit but untracked files present (use "git add" to
track)
1
$

Am I missing something here? Is there documentation about the exit
codes of the different git subcommands or probably a complete solution
for my two endeavours?

Any hints will be appreciated.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 2323190
