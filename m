From: "Ruud Huynen" <ruud.huynen@hispeed.ch>
Subject: GIT: cherry-picking includes changes from a different commit
Date: Fri, 5 Dec 2014 21:04:28 +0100
Message-ID: <02f801d010c6$ad32a1d0$0797e570$@hispeed.ch>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 21:21:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwzNB-0001Fq-9Q
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 21:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbaLEUVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 15:21:00 -0500
Received: from [62.179.121.34] ([62.179.121.34]:45675 "EHLO
	fep14.mx.upcmail.net" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750748AbaLEUU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 15:20:59 -0500
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Dec 2014 15:20:59 EST
Received: from edge02.upcmail.net ([192.168.13.237])
          by viefep31-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20141205200440.BCUG20501.viefep31-int.chello.at@edge02.upcmail.net>
          for <git@vger.kernel.org>; Fri, 5 Dec 2014 21:04:40 +0100
Received: from PC13 ([77.58.148.244])
	by edge02.upcmail.net with edge
	id Pw4T1p01A5Gd0pH01w4U3A; Fri, 05 Dec 2014 21:04:28 +0100
X-SourceIP: 77.58.148.244
X-Authenticated-Sender: ruud.huynen@hispeed.ch
X-Mailer: Microsoft Outlook 15.0
thread-index: AdAQxqoqTqFO74acST2R6lzBeSoq6w==
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260889>

I noticed when cherry-picking a commit it includes changes from this commit
and also changes from a different commit as the one I was picking.

I was in contact with "jast" on IRC, who noticed the issue, but didn't had
time to look further.

For a description of my problem, please read
http://stackoverflow.com/questions/27220638/git-cherry-pick-info-about-picke
d-commits


git clone git://github.com/MythTV/mythtv.git
git checkout fixes/0.27

git cherry-pick 30df98ce5d11b69d0b5c5114a9007cdfc79a7e9b
# from master
# commit also picked: 17f17e1fc51b3b4017e08f5ea35c8a7b5a64eeec
# resulting in a conflict

For the commits and before/conflict files, see
https://gist.github.com/FritzHerbers/4f9b0990b6bca15a70eb

As nobody could believe me, that changes from another commit are included,
is something wrong, or is it new behavior? Why did it happen?
With which command, can I have a listing of "intermediate" commits picked?
How can I automate such situations?

Fritz
git version 1.9.1
