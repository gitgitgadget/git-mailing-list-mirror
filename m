From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Documentation Bugs
Date: Sun, 6 May 2007 15:09:22 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070506130921.GA3750@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 15:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkgUW-0002AM-K3
	for gcvg-git@gmane.org; Sun, 06 May 2007 15:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXEFNJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 09:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbXEFNJZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 09:09:25 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:59901 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752965AbXEFNJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 09:09:25 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HkgUN-0007NO-QP
	for git@vger.kernel.org; Sun, 06 May 2007 15:09:24 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l46D9LTh011474
	for <git@vger.kernel.org>; Sun, 6 May 2007 15:09:21 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l46D9LZq011473
	for git@vger.kernel.org; Sun, 6 May 2007 15:09:21 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46332>

Hello,

1) git-fetch(1) (from maint) states:

       -q, --quiet
           Pass --quiet to git-fetch-pack and silence any other interna=
lly
           used programs.
=09
   but git-fetch doesn't like -q.  (master has
   a858c006fae17cef44dd63737771f2bebb6eeae8, but maint only has
   42905294de0c1885f5636319c4790f184d767875)

Maybe more difficult:
2) rebase a merged tree:

   If I made a local commit and pulled from origin, I get:

	zeisberg@cassiopeia:~/gsrc/git$ git show
	commit 15386213004a20dfdf92c654c737795079202545
	Merge: 9d740f0... 9159afb...
	Author: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
	Date:   Sun May 6 14:49:59 2007 +0200

	    Merge branch 'master' of git://git.kernel.org/pub/scm/git/git

	zeisberg@cassiopeia:~/gsrc/git$ git rebase junio/master
	Current branch master is up to date.

   (where junio/master is the tracking branch for
   git://git.kernel.org/pub/scm/git/git) but git-rebase(1) states:

	All changes made by commits in the current branch but that are
	not in <upstream> are saved to a temporary area. This is the
	same set of commits that would be shown by git log
	<upstream>..HEAD.

   and git-log junio/master..HEAD is not empty.

I didn't have the time to look into 2).  So I only report it for now.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dsin%28pi%2F2%29
