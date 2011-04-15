From: Maaartin <grajcar1@seznam.cz>
Subject: Renaming remote branch
Date: Sat, 16 Apr 2011 01:12:03 +0200
Message-ID: <ioajc1$rc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAsBd-0005XK-V5
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 01:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab1DOXMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 19:12:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:35155 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127Ab1DOXMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 19:12:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QAsBT-0005NL-Ae
	for git@vger.kernel.org; Sat, 16 Apr 2011 01:12:15 +0200
Received: from 188.120.198.89 ([188.120.198.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 01:12:15 +0200
Received: from grajcar1 by 188.120.198.89 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 01:12:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.120.198.89
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171646>

I'm tracking a couple of other people's projects using git. Some of them
are git repositories, some are svn. For the svn repos I get sometimes a
remote branch called "trunk", sometimes I get "git-svn". For the git
repos I get always the "master" branch and sometimes some more.

I am only interested in the master branch (i.e., master, trunk, or
git-svn, whatever applies). I'd like to make it all work the same, and
ideally name the remote branch "org", so I can do

git checkout master; git fetch-upstream; git rebase org

where "fetch-upstream" is my repository-local alias getting the data
from the upstream (e.g., "git svn fetch"). The fetch works fine, but I'm
failing to rename the remote branch for one repository (I may be using a
wrong term here; what I want is to make the above command line work for
all my repos).

Regards, Maaartin.
