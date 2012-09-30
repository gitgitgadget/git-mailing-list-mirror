From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Merging/joining two repos (repo2 should be a subdirectory of repo1)
Date: Sun, 30 Sep 2012 17:17:53 +0200
Message-ID: <506862A1.8000508@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 17:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TILMJ-0003Ey-1R
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 17:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab2I3PW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 11:22:56 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:48644 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2I3PW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 11:22:56 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Sep 2012 11:22:56 EDT
Received: from [84.176.34.171] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1TILHG-0001Iz-5j
	for git@vger.kernel.org; Sun, 30 Sep 2012 17:17:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206688>

Hi!

I have repo1 with ~4 years of history and another repo2 with ~1 year of
history, both of which I don't want to loose. Now I want to join them so
that repo2 becomes a subdirectory whithin repo1, including all the
history of repo2.

A simple git-merge won't do because both repos have some same files (at
least e.g. .gitignore) in their root directories. Of course I could
resolve the conflicts, but I don't want that.

My naive approach is "move everything in $repo2 one directory below" and
then "merge $repo2 into $repo1". Actually I wouldn' call that a "merge"
but an "import".

I know of "git filter-branch --subdirectory-filter foodir" but that's
just the opposite of what I need.

Is there a nifty trick to get this? Or will I have to do "git
filter-branch --tree-filter 'mkdir subdir && git mv * subdir' --all" on
$repo2 and then "git merge $repo2" in $repo1?

Thanks in advance
Dirk
