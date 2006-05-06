From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Managing projects - advanced Git tutorial/walkthrough
Date: Sat, 06 May 2006 10:43:37 +0200
Organization: At home
Message-ID: <e3hnjg$k9f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat May 06 10:43:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcIOD-0007Re-Nw
	for gcvg-git@gmane.org; Sat, 06 May 2006 10:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWEFInr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 04:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWEFInr
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 04:43:47 -0400
Received: from main.gmane.org ([80.91.229.2]:60855 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751297AbWEFInq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 04:43:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FcIO1-0007ON-BH
	for git@vger.kernel.org; Sat, 06 May 2006 10:43:37 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 May 2006 10:43:37 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 06 May 2006 10:43:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19656>

I have browsed through Git documentation: "A tutorial introduction to
git" (tutorial.txt), "A short git tutorial" (core-tutorial.txt) which
contrary to the title is the tutorial in low-level git commands and is
longer that the first one, "Everyday GIT With 20 Commands Or
So" (everyday.txt) and "git for CVS users" (cvs-migration.txt) which does
not mention git-blame and git-annotate.

What I miss is walkthrough type tutorial, describing typical workflow (or
workflows), and tutorial concentrating on advanced topics which may come
once in a while or for some topics only, but it would be nice to know how
to resolve them.

Perhaps some of the following problems would need Git improvement (e.g.
better support for subprojects: "bind" idea)...


1. Description of typical workflow, with 'stable'/'maintenance'/'fixes' and
'development'/'master'/'main' branches, how to put bugfixes into both
branches etc. Perhaps description of git branches and workflow, or Linux
kernel branches and workflow.

2. Contrib: how to add project which was externally managed to contrib and
later/or to core, preserving history. Examples: gitk for git, or like
perhaps parsecvs would be for git, or like git-svn for git.

3. Subprojects: how to manage project which depends on other externally
managed (third-party) project, and perhaps needs patches for it. Examples:
out of tree kernel patches + userspace tools, plugin for some program which
may need bugfixes, program which need some library, gitk before
incorporating into git,... Perhaps description of the whole sequence of
project development from add-on project (some new filesystem for Linux,
gitk) to being incorporated into bigger project (filesystem included in
Linux kernel, gitk in git repository).

4. Splitting repository: splitting one big project (X.org, Linux
distribution) into modules.

-- 
Jakub Narebski
Warsaw, Poland
