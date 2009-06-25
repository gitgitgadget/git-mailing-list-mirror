From: Patrick Neuner <neuner@futureweb.at>
Subject: Parallell Development / Switching to GIT
Date: Thu, 25 Jun 2009 09:52:06 +0000 (UTC)
Message-ID: <loom.20090625T095000-90@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 11:55:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJlfm-0006VK-Dq
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 11:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbZFYJzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 05:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZFYJzD
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 05:55:03 -0400
Received: from main.gmane.org ([80.91.229.2]:60856 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbZFYJzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 05:55:01 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MJlfa-0003dI-F6
	for git@vger.kernel.org; Thu, 25 Jun 2009 09:55:02 +0000
Received: from chello080109165250.static.tirol.surfer.at ([80.109.165.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 09:55:02 +0000
Received: from neuner by chello080109165250.static.tirol.surfer.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 09:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.109.165.250 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.0.11) Gecko/2009060215 Firefox/3.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122191>

Hello,

we are using SVN right now and with the way we do / need to develop, it=
 seems we
are constantly get in a merging horror.=20
I did quite some reading about git now, but I am still not really sure =
if that
what we try to accomplish can be done with git,
Or if we are really doing something a too odd way.=20

Let my try to describe =E2=80=93 I also added an image.=20

---- repo 1
  |
   - repo 2 (=3Dbranch of repo 1 - for our external developers)

We have the main branch and 2nd branch for external developers.=20

We work inside the repo1, which are usually features/updates that go li=
fe after
a short turn.=20
Our external developer work on different features that will be merged i=
nto repo1
from time to time.=20

Usually during development, we sometimes need to push features from rep=
o1 to
repo2, and later the features developed on repo2 will be pushed back to=
 repo1,=20
And also smaller bug fixes come from repo2 that needs to go into repo1.=
=20

But this is a constant process, meaning, that both branches will exist,
especially repo2 will exist after this feature has finished for smaller
updates/bugfixes.=20
We don=E2=80=99t want to do a new branch for each bugfix, for each new =
small feature,
but have different branches for different developer teams.=20

So I was wondering, if this could cause troubles with GIT in case of me=
rging
around without closing a branch.=20

I am adding an link to an image that might show what I tried to explain=
=2E=20
http://temp.in.futureweb.at/parallell-development.png

Thanks
Patrick
