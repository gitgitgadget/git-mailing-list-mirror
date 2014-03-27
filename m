From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Possible regression in master? (submodules without a
 "master" branch)
Date: Thu, 27 Mar 2014 11:54:05 -0700
Message-ID: <20140327185405.GS4008@odin.tremily.us>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
 <xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
 <5334606F.5010109@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cjNiBkmi8s9yAE0W"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 27 19:54:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFRR-0006i9-HB
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140AbaC0SyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:54:11 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:52331
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757056AbaC0SyI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:54:08 -0400
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id ihug1n0041ZXKqc51iu72X; Thu, 27 Mar 2014 18:54:07 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id iiu61n00P152l3L3hiu7Ci; Thu, 27 Mar 2014 18:54:07 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id DACA410DD951; Thu, 27 Mar 2014 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395946445; bh=1UBW8spWpRCsdTxpgH9qbCksVinIwUGSV5hIEuYT5Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rup36KWQA26fu+3EW8b5AZeyiEfFrVoVpYIT5P4Kr+rdM+7W1vzcTokP/sMYxT4a1
	 C+OrIS299dPbFG5p39s+UYN2r8ujSHujZp9+/EnPL0Zh2oqDufEK7kbCaMh9ks0+Dc
	 qRlgmdGJuRemhe3MVUnQQox9OXFSYqMLYP0IMmBM=
Content-Disposition: inline
In-Reply-To: <5334606F.5010109@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395946447;
	bh=RuxeU395WCKatyjrfhssWYcenPT/cHcda1x6VvxemfY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=lc7HjWlX1MXccVB+MYS0QcDfP8qru0nNUrgMnl+8dLxdPD7F//j2JVMyB3jLUbiHI
	 m73ScYJCln5rcUucf3eFLyTITNiSKIRQcqsL764xFuCXoefQYum8ABiaEmuj68SLQc
	 M689ucDoy7If5kbLo02UHkkNMSUG4G3WLxHbZH8t7m6d/GppHRfoHc2a7lu7IPNhk2
	 x0iBuoqiPxQJdSXSnpo890hSclacqnaplZ+d0wBubKPijGe18OT3VxMCJuARRUNagB
	 giquWrhIWY4G/SxzGXOjM6aGW8cVaPpLZx7oneqGFjdKjs2AUiHctnGvdhjgFnUR7C
	 FY2RfFYRZvXgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245319>


--cjNiBkmi8s9yAE0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 06:31:27PM +0100, Jens Lehmann wrote:
> Am 27.03.2014 18:16, schrieb Junio C Hamano:
> > Johan Herland <johan@herland.net> writes:
> >=20
> >> I just found a failure to checkout a project with submodules where
> >> there is no explicit submodule branch configuration, and the
> >> submodules happen to not have a "master" branch:
> >>
> >>   git clone git://gitorious.org/qt/qt5.git qt5
> >>   cd qt5
> >>   git submodule init qtbase
> >>   git submodule update
> >>
> >> In current master, the last command fails with the following output:
> >=20
> > ... and with a bug-free system, what does it do instead?  Just clone
> > 'qtbase' and make a detached-head checkout at the commit recorded in
> > the superproject's tree, or something else?
>=20
> After reverting 23d25e48f5ead73 on current master it clones 'qtbase'
> nicely with a detached HEAD.

Fixing this for initial update clone is pretty easy, we just need to
unset start_point before calling module_clone if
submodule.<name>.branch is not set.  However, that's just going to
push remote branch ambiguity problems back to the --remote update
functionality.  What should happen when submodule.<name>.branch is not
set and you run a --remote update, which has used:

    git rev-parse "${remote_name}/${branch}"

since the submodule.<name>.branch setting was introduced in 06b1abb
(submodule update: add --remote for submodule's upstream changes,
2012-12-19)?

gitmodules(5) is pretty clear that 'submodule.<name>.branch' defaults
to master (and not upstream's HEAD), do we want to adjust this at the
same time?  For folks using non-checkout updates, should the preferred
local branch name still be master, or should it match upstream's HEAD?
If upstream's HEAD changes, should we update the local branch name to
stay in sync?  If we don't rename the local branch, do we keep
integrating remote changes from upstream's original branch or keep
integrating HEAD?

I think this would all be simpler if we just made the
superproject-branch-to-submodule-local-branch binding explicit and
pushed this submodule-to-upstream-subproject binding down into the
submodule itself [1].  Then the usual single-project commands would
handle the tricky remote-tracking cases (with explicit
branch.<name>.merge entries, etc.), and a dumb syncing mechanism would
pull those clever choices back up into the superproject for
distribution.

> > If an existing set-up that was working in a sensible way is broken
> > by a change that assumes something that should not be assumed,
> > then that is a serious regression, I would have to say.
>=20
> Yes, especially as it promised to not change this use case.

Sorry.  A side effect of relying too much on our existing
documentation and not enough on testing actual use cases.  I can work
up some non-master submodule tests to go with the fix.

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.comp.version-control.git/239955/focus=3D=
240336

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--cjNiBkmi8s9yAE0W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNHPLAAoJEKKfehoaNkbtBmYP/jasQ2cXzHIiA/NHcDpXB7/F
7ndzDirT4++JKeuwEJKxmhzLtFy5WW4MbsKNHH9yeGfsxthRGpzF7KMmpIir4E2q
K4thN5kxM3G5m5HkQ3EI+/QT/7DAEXBL/1Vf1zTr7ONMONdReT+1NvY51dDZFP32
WI8D3b8EE3qdDKuXOjqkmbfyApGgPPmkPmbSBImrpNg4HjrPkLLL/wSCSsEId0LC
DVlZd84Ya2b+atXOobKpUyJLx93gFE9X+tGGnfEIjkfuuxLnkVvjzL045WjC2ReM
oMq//fP9t7rZ3nnf2/RaXB1LCmXuyOpG5r8owEXWzDMdPdri8ChAAr6Er2q6fcYS
U7fJCMyb8gi7JgTRlp2dow3Tb7y2HczYJBZqAXjz+9EwUaY0MKOEXAYzOd/Z42AX
2L6ESSDRO8NYb2g8LLAbqUJE4jqvxjbTvLMVr1yfGGIEV4dt0WTQSMXXT16koWNq
ZeIRigkGO2lMlrdkBx3GUV/mO9sfEkfQkNI+r0ou5pUa4pBsTeQyX4sCm6yCeV6J
XceBKD56S/ELh9rXpQ4J67r5qUSDLzny3U6BIHP2V9dR9VMY1qn/YsPGZd5NDb+7
wP2xEwd5+6/7PP5DMWADO1XC/qZEhd7re//I/jB3QWJ80nBKv6vMfV+7D3QjKKyl
+Bot7gRaVzKKUO64XK/L
=Lp0M
-----END PGP SIGNATURE-----

--cjNiBkmi8s9yAE0W--
