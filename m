From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: strange temporary pull-errors
Date: Fri, 22 Aug 2008 20:13:24 +0100
Message-ID: <20080822191324.GO10819@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 21:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWc5i-0005KO-0l
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbYHVTN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbYHVTN0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:13:26 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:62076 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbYHVTN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:13:26 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1KWc4a-0004lh-Ou; Fri, 22 Aug 2008 20:13:24 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id A6107DAE92;
	Fri, 22 Aug 2008 20:13:24 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 91D51741BE; Fri, 22 Aug 2008 20:13:24 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93344>

Hi,

again and again (first I ignored it) I get the
following with version 1.6.0:

> git pull
remote: Counting objects: 55, done.
remote: Compressing objects: 100% (31/31), done.
remote: Total 34 (delta 10), reused 24 (delta 3)
Unpacking objects: 100% (34/34), done.
From /h/21/GemeinsameBasis/SAT-Algorithmen/OKplatform/OKsystem/Transitional/
   d69da9e..d9b9324  master     -> origin/master
Updating 688e3cb..d9b9324
error: Entry 'Buildsystem/Configuration/Html/local_html.mak' not uptodate. Cannot mer
ge.
> git pull
Updating 688e3cb..d9b9324
error: Entry 'Buildsystem/Configuration/Html/local_html.mak' not uptodate. Cannot mer
ge.
> git status
# On branch master
# Your branch is behind 'origin/master' by 3 commits, and can be fast-forwarded.
#
nothing to commit (working directory clean)
> git pull
Updating 688e3cb..d9b9324
Fast forward
 Buildsystem/Configuration/Html/local_html.mak      |    3 +
 .../Configuration/ReleaseProcess/ReleaseHistory    |    1 +
 Buildsystem/Html/Local/History.html                |   11 +++-
 Buildsystem/Html/Local/PackageHistory.html         |   52 ++++++++++++++++++++
 Buildsystem/Html/Local/plans/History.hpp           |    2 +-
 Buildsystem/Html/Local/plans/milestones.hpp        |    4 +-
 Buildsystem/OKlibBuilding/Targets/html/Makefile    |    1 +
 Buildsystem/ReleaseProcess/README                  |    9 +++-
 Buildsystem/ReleaseProcess/plans/general.hpp       |    5 +-
 Buildsystem/ReleaseProcess/plans/milestones.hpp    |    4 +-
 plans/general.hpp                                  |    7 ++-
 11 files changed, 87 insertions(+), 12 deletions(-)
 create mode 100644 Buildsystem/Html/Local/PackageHistory.html


There is nothing special going out, the simple pull should succeed, but
I have to try several times; don't know whether the "git status" is
instrumental here or not --- will try the next time.

Oliver
