From: Garbageyard <varuag.chhabra@gmail.com>
Subject: Change default branch name (server side) while cloning a repository
Date: Fri, 27 Mar 2015 05:27:21 -0700 (MST)
Message-ID: <1427459241861-7627964.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 13:27:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbTMF-00046E-D7
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 13:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbbC0M1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2015 08:27:22 -0400
Received: from mwork.nabble.com ([162.253.133.43]:60977 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbbC0M1W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2015 08:27:22 -0400
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 78A3D18DB55E
	for <git@vger.kernel.org>; Fri, 27 Mar 2015 05:27:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266371>

We use Gitolite for access control and i have admin access on Git serve=
r. I
wanted to make sure that whenever a new repository is created and is th=
en
cloned on any machine, the default branch should point to mainline. To =
do
this, when I run the repository creation script, i change the content o=
f
file HEAD of a given repository to point to mainline i.e., default entr=
y of
=E2=80=9Cref: refs/heads/master=E2=80=9D in file HEAD is changed to =E2=
=80=9Cref:
refs/heads/mainline=E2=80=9D.

=46or example, if "work" is the repository name, then on Git server,

[gitolite@gitserver  repositories]$ cd work.git/

[gitolite@gitserver  work.git]$ cat HEAD
ref: refs/heads/mainline

If i now clone the repository on my local machine, then the default bra=
nch
should be pointing to mainline and not master. However, the issue is th=
at it
still points to master. Am I /wrong/ in assuming that changing the entr=
y in
file HEAD for a given repository on Git server will change the default
branch while cloning? If I=E2=80=99m wrong, can anyone please tell me h=
ow can I
enforce this change on the /server/ side correctly?




--
View this message in context: http://git.661346.n2.nabble.com/Change-de=
fault-branch-name-server-side-while-cloning-a-repository-tp7627964.html
Sent from the git mailing list archive at Nabble.com.
