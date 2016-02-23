From: fhaehnel <fhaehnel@atlassian.com>
Subject: Re: Question about pull-requests
Date: Mon, 22 Feb 2016 19:58:35 -0700 (MST)
Message-ID: <1456196315828-7648733.post@n2.nabble.com>
References: <CAOh0v-WW=hOXw=uTdzkd3afzXCguBHWdaDShwKE3QKqUCOBTzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 04:07:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY3KE-0007Mx-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 04:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbcBWDHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 22:07:41 -0500
Received: from mwork.nabble.com ([162.253.133.43]:53271 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbcBWDHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 22:07:41 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2016 22:07:41 EST
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id BE31A16D4A78F
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 18:50:02 -0800 (PST)
In-Reply-To: <CAOh0v-WW=hOXw=uTdzkd3afzXCguBHWdaDShwKE3QKqUCOBTzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287009>

=46rom your message I=E2=80=99m guessing you are using Bitbucket Server=
 with branch
permissions [1].=20
We=E2=80=99re aware the conflict resolution instructions can not always=
 be followed.
Improving these is on our backlog
(https://jira.atlassian.com/browse/BSERV-7561) - feel free to watch/vot=
e for
that issue.=20

=46irst, let=E2=80=99s start with the most basic case: a pull request y=
ou created is
conflicted and can=E2=80=99t be merged.=20
Here, you can apply Jeff King=E2=80=99s solution and back-merge the tar=
get branch.
Alternatively, you can, of course, rebase the branch too. (Check out
https://www.atlassian.com/git/tutorials/merging-vs-rebasing for more in=
fo on
which option to pick and when).

If you are using cascading merges [2] in Bitbucket Server, there=E2=80=99=
s a chance
of conflicts during the merge-cascade, which will generate =E2=80=9CAut=
omatic merge
failures=E2=80=9D.
If this happens, Bitbucket will create a new pull request on your behal=
f.
The same strategy as above can be applied: merge the target branch and
resolve the conflicts, or rebase.


[1]
https://confluence.atlassian.com/bitbucketserver/using-branch-permissio=
ns-776639807.html
[2]
https://confluence.atlassian.com/bitbucketserver/automatic-branch-mergi=
ng-776639993.html

- Felix



--
View this message in context: http://git.661346.n2.nabble.com/Question-=
about-pull-requests-tp7648649p7648733.html
Sent from the git mailing list archive at Nabble.com.
