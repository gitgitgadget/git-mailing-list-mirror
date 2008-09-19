From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Sep 2008, #03; Fri, 19)
Date: Sat, 20 Sep 2008 00:20:24 +0200
Message-ID: <200809200020.32285.trast@student.ethz.ch>
References: <7vprmzrh7w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12004202.v1J1DuQGEx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 00:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgoMC-0001eQ-3d
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 00:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbYISWUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 18:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYISWUd
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 18:20:33 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:45111 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbYISWUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 18:20:33 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 20 Sep 2008 00:20:31 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 20 Sep 2008 00:20:31 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vprmzrh7w.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Sep 2008 22:20:31.0114 (UTC) FILETIME=[ED5F46A0:01C91AA5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96320>

--nextPart12004202.v1J1DuQGEx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> * tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
>  + Documentation: Refer to git-rebase(1) to warn against rewriting
>  + Documentation: new upstream rebase recovery section in git-rebase
>=20
> I think the last one on "recommended practice" needs discussion.  I do not
> think it describes _the_ recommended workflow, although I think (1) what
> is recommended in the draft does make sense within its own scope, and (2)
> it may be impossible to come up with _the_ recommended workflow anyway.

[The patch referred to is

  http://article.gmane.org/gmane.comp.version-control.git/95806

and the only response so far, to an earlier version,

  http://article.gmane.org/gmane.comp.version-control.git/95620 ]

I was hoping for more feedback, but maybe the list is not the right
audience: the intended readers of the document probably aren't as
active on the list and confident about patch review.

Regarding _the_ recommended workflow, I can think of a few possible
approaches:

a) Authoritative: either because we really believe it's the One True
   Workflow, or just because we want to sound so.

b) Descriptive: describe it as the workflow "we" use (presumably this
   includes linux.git which may be worth mentioning; I haven't touched
   the kernel though).

c) Encyclopedic: describe and classify as many recipes (building
   blocks) and workflows as possible in an attempt to build a
   complete reference of sorts.

d) Blind eye: we're just the tool.  Others can devise workflows.

I certainly aimed the patch at (a), since I wanted to be able to point
people at it (mostly on #git).  The resources I learned Git with,
except for the videos, just show simple examples of pull/push usage,
which I found both unsatisfactory (e.g. I want to know _why_ it's a
good idea to make topic branches) and incomplete.  This list is an
excellent place to learn, but I doubt that's an effort the average
user is willing to put in.

That being said, I'm certainly willing to rewrite it in the direction
of (b), and possibly help with the writeup (though not brainstorming)
of (c), if either of those is the list consensus.

=2D Thomas

PS: Anyone else noticed the striking number of "we have <setup>, what
is the best workflow and how do I implement it" mails in the past few
days?  Is that just a statistical anomaly, or another need for
documentation?

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart12004202.v1J1DuQGEx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjUJa8ACgkQqUud07tmzP31IwCeMmte/PWYfIYamOV0mnP+drir
VksAniyvJafmy6SBZP1GHRzGQXswtHVT
=ONcL
-----END PGP SIGNATURE-----

--nextPart12004202.v1J1DuQGEx--
