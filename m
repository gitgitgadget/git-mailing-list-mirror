From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 15:10:35 -0700
Message-ID: <FC00A4BB-6CB9-421D-83D6-4E1AFBB4CB3C@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <4EA0D79811C348C6893039D315E6E190@PhilipOakley>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDL8H-0006eO-RN
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbaHAWQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 18:16:58 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:45166
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755387AbaHAWQ5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 18:16:57 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2014 18:16:57 EDT
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id ZZyj1o0020ldTLk5CaAro2; Fri, 01 Aug 2014 22:10:51 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta04.westchester.pa.mail.comcast.net with comcast
	id ZaAo1o00k2ztT3H01aApLZ; Fri, 01 Aug 2014 22:10:51 +0000
X-Priority: 3
In-Reply-To: <4EA0D79811C348C6893039D315E6E190@PhilipOakley>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406931051;
	bh=y7gamJXeBZUr+nGhBQafmAqs15CH/+B83kOc0K4UVgo=;
	h=Received:Received:Subject:Mime-Version:Content-Type:From:Date:
	 Message-Id:To;
	b=rPoW26aap1n/vmLK2imSjqJNSJeV3Yn/pob/YW5+cstnrAbJ2dt0qY+o2289ALG4L
	 32yq8elu66+bJF4JWMhQXbPrLGbmJk3/sbdOmiqjFRq8/yGZE9eZ6VsMLVojxX1JZo
	 e0LdHfrMECAyAP/3586nL9QAy8TFgmeJTgfJajAzq3M63v8z7wYW48onlux67cV4m8
	 SCJWdqzIjO40FSN+wlz3RVF61BzDXKQ+qzevJ3jzsW/AgT5cHFi3I8APwUaMr2bEgW
	 GtHi4wUpkajX0RfaXVWS8QcP4qGxfCqztErQfWlAvHuQFyIlkPK6h4RLPNm6dRoc2n
	 Ftu8oKcG1DZOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254672>

On Aug 1, 2014, at 11:57 AM, Philip Oakley <philipoakley@iee.org> wrote=
:
> But that goes both ways, and is a philosophical issue about what is t=
o be expected in various cases.

The problem is, users expect merge to merge.  There isn=92t a user that=
 expects it to scramble the source code, because the command is called =
merge, not scramble.  That word has semantics that were not invented by=
 your project.  You cannot change the semantic of the word.  Merge has =
a nice mathematical definition.  Merge branch into master means, place =
into into master the work from that branch.  git already does this 99% =
correct, it is missing one corner case.

This is not a philosophical issue.  It is a definitional one.

> For some central control use styles, the ideas behind _distributed_ v=
ersion control are anathema and (Git) just grinds away at the policies =
that are expected.

This is irrelevant to the issue at hand.

> That said, Git doesn't claim to be perfect

Again, irrelevant.

> (and can't because

Do you mean, and can=92t be?  If so, you are wrong in the case at hand.=
  svn is an existence proof that you are wrong.

> of the 'relativity' that comes with being distributed - truth has to =
give way to a web of trust). Also the artefacts that Git validates are =
at a different level of abstraction i.e. the whole project as a commit,=
 rather than just a few/one file at a time.

Ah, so that gives me an idea.  [ pause ] If we try the cherry-pick as r=
etroactively creating a feature branch, cherrying into that, then merge=
 unconditionally so that no change happens that into trunk (thus killin=
g those conflicts), and then git merge that feature branch into branch =
then it all works perfectly.  See, another existence proof that you are=
 wrong, this time with git itself.

It was 13 lines of code, so, apparently, it is possible and easy to do,=
 in git.  Now, we just want the cherry-pick to create a temporary cherr=
y branch, cherry the pick into it, merge and drop into trunk and merge =
into branch=85

I tested with the below and it worked just fine.  Things to clean up, w=
e want the meta data on the cherry on the merge commit, but, you get th=
e idea.

branch=3Db
master=3Dmaster
base=3D$(git merge-base $branch $master)
cherry=3D"$1"

git checkout -b cherry-$branch $base
git cherry-pick "$cherry"
git checkout $master
git merge -s ours cherry-$branch
git checkout $branch
git merge cherry-$branch
git branch -d cherry-$branch
git cherry-pick --strategy=3Dours --allow-empty "$cherry"
git commit --allow-empty

I tested that with two cherries with further changes on master to ensur=
e that it works for more than a single one, no problem.  Wow, even trie=
d a merge of master back into b, and it worked just fine, no conflicts,=
 yet, all the code was jammed up together nicely.

So, if you wish to continue your position, please explain why it can=92=
t get this better, given the existence proof above of it working better=
 in git.

> In your example (when generalized)

I=92m not interested in other bugs that I didn=92t state, in this email=
=2E  I don=92t care about those.  Please don=92t detract from fixing th=
is issue, because you can identify other things that might not be perfe=
ct.  We attain perfection one step at a time.

> the problem is deciding when, in the change sequence, the cherry pick=
 is to be backed out, especially if there are conflicts in the change s=
equence that would need fixing anyway, and in a long change sequence th=
at would be a lot of conflict fix-ups, hence the current choice of gett=
ing the merge conflicts all resolved in the one go.

I have two possible conflict fixups in the above.  In my case (I have a=
 specific patch in gcc-land i wanted to cherry), those fixups were triv=
ial (no conflicts).  When they are trivial, I don=92t care much that th=
ere were two of them.  When non-trivial, well, I=92m resigned to the id=
ea that I have to explain what is going on.

> Selecting a compatible workflow is a problem of usage,

Not when the workflow is mandated on you to work around trivial little =
bugs that can be fixed but for which the author=92s don't even comprehe=
nd the bug.

> rather than a problem in Git.
