From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [BUG] git gui and my =?iso-8859-1?Q?=F6?=
Date: Mon, 23 Apr 2007 13:32:25 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070423113225.GA5427@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 13:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfwn7-0000YV-2z
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 13:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbXDWLca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Apr 2007 07:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbXDWLca
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 07:32:30 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:54820 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161466AbXDWLc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 07:32:29 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HfwmS-0001JM-7h
	for git@vger.kernel.org; Mon, 23 Apr 2007 13:32:28 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l3NBWPUx013397
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 13:32:25 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l3NBWPnP013396
	for git@vger.kernel.org; Mon, 23 Apr 2007 13:32:25 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45317>

Hello,

when I try to amend a commit with git gui that is properly signed-off b=
y
me and hit "Commit", I get=20

	commit-tree failed:

	<sha1 sum>
	Warning: commit message does not conform to UTF-8.
	You may ...

The commit was done with git-commit, I have=20

	zeisberg@cassiopeia:~$ set | grep -E '^L(ANG|C_)'
	LANG=3Den_US.UTF-8
	LC_CTYPE=3Den_US.UTF-8

and the =F6 is properly displayed in the commit message text box before
hitting Commit.  When I remove the =F6, I can commit (and re-amend on t=
he
cmdline).

I'm using:

	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git version
	git version 1.5.1.1.190.g74474
	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git gui version
	git-gui version 0.6.5.10.g845d3

I don't know tcl/tk very well, so for now you only get a report and no
patch :-(

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5%2B7
