From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 9 Dec 2008 08:36:26 -0600
Message-ID: <200812090836.31012.bss03@volumehost.net>
References: <1228815240.18611.48.camel@starfruit.local> <20081209191704.6117@nanako3.lavabit.com> <1228819087.18611.73.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1430485.C2GJ6Q6UCL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "R. Tyler Ballance" <tyler@slide.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 15:39:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA3jE-0005AQ-SN
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 15:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbYLIOhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 09:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbYLIOhF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 09:37:05 -0500
Received: from eastrmmtao105.cox.net ([68.230.240.47]:36595 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYLIOhD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 09:37:03 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081209143702.UAES14968.eastrmmtao105.cox.net@eastrmimpo03.cox.net>;
          Tue, 9 Dec 2008 09:37:02 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id p2d11a00G2i4SyG022d1RH; Tue, 09 Dec 2008 09:37:01 -0500
X-Authority-Analysis: v=1.0 c=1 a=nEQGfrJnAAAA:8 a=va7Osm3rjVqN89tE9YoA:9
 a=BZ8iZjBDGpDYsIXCqnQA:7 a=K_tEug8wsGnNMfQBSDxMgR0bdp4A:4 a=6KGGfjhtujUA:10
 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=86hNAIf7FGFuU8hdw4cA:9
 a=mu4ZtNPPoVcHKV_jJIyoSMMl-kUA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss03@volumehost.net>)
	id 1LA3hU-000A68-BV; Tue, 09 Dec 2008 08:36:36 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <1228819087.18611.73.camel@starfruit.local>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102632>

--nextPart1430485.C2GJ6Q6UCL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 09 December 2008, "R. Tyler Ballance" <tyler@slide.com> wrote=20
about 'Re: Forcing --no-ff on pull':
>On Tue, 2008-12-09 at 19:17 +0900, Nanako Shiraishi wrote:
>> Quoting "R. Tyler Ballance" <tyler@slide.com>:
>> > The most common use-case involves a user merging a project branch
>> > into a stabilization branch (`git checkout stable && git pull .
>> > project`) in such a way that no merge commit is generated. Of course,
>> > without thinking they'll push these changes up to the centralized
>> > repository. Not 15 minutes later they realize "ruh roh! I didn't want
>> > to do that"
>>
>> Why does the user not want to fast-forward, if the merge she wants to
>> do is actually a fast-forward?
>
>I agree with you, this is more about preventing coworkers who are too
>lazy to understand the entirety of what they're doing from hurting the
>workflow of "the rest of us". It's a technically solution to a people
>problem (I understand technology far more than people ;))
>
>Consider the following scenarion:
>  % git checkout -b project=EF=BB=BF
>=EF=BB=BF  % <work>
>=EF=BB=BF  % git commit -am "A"=EF=BB=BF
>=EF=BB=BF  % <work>
>=EF=BB=BF  % git commit -am "B"=EF=BB=BF
>=EF=BB=BF  % <work>
>=EF=BB=BF  % git commit -am "C"=EF=BB=BF
>=EF=BB=BF  % <work>
>=EF=BB=BF  % git commit -am "D"
>=EF=BB=BF=EF=BB=BF  % git checkout stable
>=EF=BB=BF=EF=BB=BF  % git pull . project
>=EF=BB=BF=EF=BB=BF  % <fast-forward>
>=EF=BB=BF=EF=BB=BF  % git push origin stable
>=EF=BB=BF=EF=BB=BF
>At this point, QA is involved and what can happen is that QA realizes
>that this code is *not* stable and *never* should have been brought into
>the stable branch.
>
>Now we have two options "block" the stable branch until LazyDeveloper
>makes the appropriate changes to stabilize the branch again *OR* back
>out LazyDeveloper's changes (A, B, C, D) and beat them up in the
>alleyway :)
>
>Given the nature of our work, we have a stable branch per-team, and one
>funneling stable branch for the entire company (master), that branch
>being used to push the live web site with.

In the words of 4chan: "You're doing it wrong."

If QA decides what is appropriate for the stable branch, only QA should be=
=20
pushing to stable (not just any dev. or team) and this should be enforced.

QA can retrieve commits from individual developers or teams, via email, by=
=20
pulling from their private repositories, or pulling from "private"=20
branches in the public repository.  The last seems most appropriate for=20
your organization.

I think a better workflow would be for developers to pull from "stable" but=
=20
push to "<username>-tbr" (TBR =3D to be reviewed).  Team leads would review=
=20
code by pulling from "<developer>-tbr" and if it looked okay would push=20
to "<team>-tbt" (TBT =3D to be tested).  Of course, if they needed to=20
originate a change they could pull from "stable" instead of any individual=
=20
developer's branch.  QA would pull from "<team>-tbt", build, deploy, and=20
test and if it's good push to "stable".  Some automated process would=20
watch "stable" and update production from it.

This way bad commits are generally rejected before they become part of=20
history.  Hooks can be used to notify team leads and QA about new commits=20
for review or testing.

>[1] We've stressed with our developers as much as possible that the
>"origin" repository is to remain" pristine", that every action should be
>"auditable" insofar that if you rollback a change, we want to see a
>Revert commit, merges should create merge commits to where we can replay
>or unwind the revision history correctly at any point in time or slice
>of time. I *really* don't want "origin" to "lose commits".

To this end, I'd probably forbid non-ff commits to "stable".
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss03@volumehost.net                      ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.org/                      \_/    =20

--nextPart1430485.C2GJ6Q6UCL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk+gmoACgkQ55pqL7G1QFm6IgCghzZywzkAvdepLQ/RZFMzlV06
54gAn3Tac09/hUKLTcH6IRiihPdrZzFr
=KCmg
-----END PGP SIGNATURE-----

--nextPart1430485.C2GJ6Q6UCL--
