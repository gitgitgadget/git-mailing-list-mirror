From: Peter van der Does <peter@avirtualhome.com>
Subject: [ANNOUNCE] git-flow AVH Edition 1.7.0
Date: Sat, 16 Nov 2013 19:08:34 -0500
Message-ID: <20131116190834.319d5c2f@Indy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 17 01:29:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhqFB-0006jx-Gu
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 01:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab3KQA3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 19:29:34 -0500
Received: from zandvoort.avirtualhome.com ([96.126.105.64]:45700 "EHLO
	mail.avirtualhome.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab3KQA3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 19:29:33 -0500
X-Greylist: delayed 1257 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Nov 2013 19:29:33 EST
Received: from Indy (c-69-248-90-230.hsd1.nj.comcast.net [69.248.90.230])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.avirtualhome.com (Postfix) with ESMTPSA id D301B17643
	for <git@vger.kernel.org>; Sat, 16 Nov 2013 19:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=avirtualhome.com;
	s=mail; t=1384646915;
	bh=rVesuJt8WR5pF4OwyITjvAjUPdnRj+KIc5yRL4h9KvQ=;
	h=Date:From:To:Subject:From;
	b=gj1US187ycZa9vogqHowrPIsFOI5v3aj9Vtz+CuwyTz0E6XLXGNza5RhYhHjMbgrV
	 CTW3LA6wBe3Adbi/CGaC0IZMw7iZ9ci/IBmQ01FevWgpCIsEw4cR5vb8vNDMoiD+Ei
	 1MEaN0etJkBuAfJMPyELzjIky821qKUQVQlBeGdM=
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237949>

We are pleased to announce the release of git-flow AVH Edition 1.7.0

git-flow AVH Edition is a collection of git extensions to provide
high-level repository operations for Vincent Driessen's branching
model.
The AVH Edition adds more functionality to the original git-flow[1] and
several of the internal commands have been rewritten to speed up the
software.

The release tar-ball and zip file can be found at:

	https://github.com/petervanderdoes/gitflow/releases


git-flow AVH Edition is compatible with the following systems:
	Linux
	BSD
	Mac OS X
	Windows


Installation instructions for these systems can be found at:

	https://github.com/petervanderdoes/gitflow/wiki#installing-git-flow



git-flow AVH Edition 1.7.0 Release Notes
========================================
* Refactor the gitflow override flag functions.

* Shortcut for finish, delete, and publish commands.  
  Introduce the following new commands:  
  * git flow finish
  * git flow delete
  * git flow publish
  
  These commands will perform the action on the branch that's currently
  active.

* No branch is needed for the following function:  
  * git flow feature publish/finish/delete
  * git flow release publish/finish/delete
  * git flow hotfix publish/finish/delete
  
* Remove base configuration when deleting a feature/hotfix/release
  branch.

* Help text for certain commands is wrong.

* Bugfix: Invalid function call.

* Bugfix: No make installer fails

* Support branches are no longer marked as experimental.
  
* Fix sanity check for release track command.

* Fix feature pull.  
  The pull request fails when there's no local branch with the same
  name as the remote branch.
  
* Option for global hooks and filters directory.  
  This is only for hooks and filters related to git-flow, not the
  standard git hooks.

--------------------------------------
Footnotes:
[1] The original set of extensions have not been updated since 2012 and
    the last release was done in 2010
-- 
Peter van der Does

GPG key: CB317D6E

Site: http://avirtualhome.com
GitHub: https://github.com/petervanderdoes
Twitter: @petervanderdoes
