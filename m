From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git repository
Date: Sun, 8 Feb 2009 19:18:29 -0600
Message-ID: <200902081918.35665.bss@iguanasuicide.net>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com> <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org> <e38bce640902081613v3e93c1e3g716118c38ce861ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5151000.1zzkeupsJk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWKof-0004tO-BL
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 02:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbZBIBSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 20:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbZBIBSj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 20:18:39 -0500
Received: from eastrmmtao102.cox.net ([68.230.240.8]:47631 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbZBIBSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 20:18:38 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090209011837.OIYO8735.eastrmmtao102.cox.net@eastrmimpo01.cox.net>;
          Sun, 8 Feb 2009 20:18:37 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id DdJc1b0072i4SyG02dJcq9; Sun, 08 Feb 2009 20:18:37 -0500
X-Authority-Analysis: v=1.0 c=1 a=SyfLwDWrooYA:10 a=ss7iJ0sHPtIA:10
 a=20KFwNOVAAAA:8 a=Fq1VQ0LPAAAA:8 a=1KwZ89VRIImvH8HM0lIA:9
 a=P0TCyQyI5JqiUdoD2m0A:7 a=d3drnxqfwNkD6_m3fWfMaRTft1AA:4 a=qIVjreYYsbEA:10
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=3QGZIm4sCEOkKeauYXMA:9
 a=Q7yHpS1BpK6asdyvgjOi4gRqkfsA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LWKnD-000GsH-Tj; Sun, 08 Feb 2009 19:18:35 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <e38bce640902081613v3e93c1e3g716118c38ce861ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109031>

--nextPart5151000.1zzkeupsJk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 08 February 2009 18:13:00 you wrote:
> On Sun, Feb 8, 2009 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Now what is that topic branch is for?  Yes, it is about adding this new
> > feature, and nothing else.  Don't pull other people's changes made on my
> > tree into it.  That will make your topic branch "one new feature and
> > everything else" and useless as a topic branch.
>
> Fair enough, but I don't understand what is referred to by "my tree" abov=
e?

Junio means his git tree.  Which is where we get releases from.

> >        $ git checkout -b bg/no-progress origin/master
> >        ... work on e802880 ...
> >        ... test it ...
> >        $ git commit ;# record that on bg/no-progress topic
> >
> >        $ git checkout master
> >        $ git merge bg/no-progress
> >        ... test the result of the merge ...
>
> Refering to that git merge bg/no-progress command above. You said not
> to merge from master to bg/no-progress at this early stage, which
> makes sense, but now you are going in the reverse via master <--
> bg/no-progress.

Well, master is not a topic branch, so merging a topic branch into it is no=
t=20
necessarily bad.

> And here I do not see a commit, but that command is
> followed straight way with a "git checkout bg/no-progress" below.  Is
> that just for testing the merge with the intent of just throwing the
> changes away?

Merge automatically does a commit unless there are conflicts.

> In other words, is this next "git checkout
> bg/no-progress" command going to silently throw away the "git merge
> bg/progress" step at this point?

No, it doesn't throw it away.  However, it never made any changes to pg/no-
progress just to master, so bg/no-progress will not show the results of the=
=20
merge.

> Similar question: Is this next "git checkout bg/no-progress" below
> going to loose the conflicts I would have just resolved above
> (referring to the most recent "... resolve conflicts ..." line above)?

It's going to but you back on bg/no-progress, which doesn't have Junio's=20
latest changes, so there won't be any conflicts immediately.

> > which may conflict again (but that would be the same conflict you saw
> > with your "git pull" from me, and rerere may remember it).
> What does "rerere" mean, or is that a typo?

REuse REcorded REsolutions.  It's a git option to remember how you resolved=
=20
merge conflicts and automatically apply those resolutions later.

> > and reorder, squash, and fix them.
> What do you mean by "reorder, squash" mean here? Is that something
> that is done as a part of the -i option to git rebase?

Reordering and squashing can be done via rebase -i, but it's basically just=
=20
the practice of "prettying" your changes. =20
http://magazine.redhat.com/2008/05/02/shipping-quality-code-with-git/ has m=
ore=20
prose on the subject.

> >        $ git checkout bg/no-progress^0
> What is the significance of the ^0 construct tacked onto the end of
> "bg/no-progress" at this point, versus just "git checkout
> bg/no-progress" without the "^0"?

It took me a second, but I believe this checks out bg/no-progress and detac=
hes=20
HEAD.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart5151000.1zzkeupsJk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmPhGYACgkQ55pqL7G1QFmSDQCffFHCkzkPKuka3uTqps47ZXXe
UZQAoIrNDFjF5DxmXi5US/HDLmIVU16E
=4xyM
-----END PGP SIGNATURE-----

--nextPart5151000.1zzkeupsJk--
