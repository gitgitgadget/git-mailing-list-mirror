From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn merge helper
Date: Sun, 30 Sep 2007 16:15:49 +0200
Message-ID: <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr>
References: <20070930110550.GA4557@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-20-253668563"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 16:16:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibzao-0001QP-7K
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 16:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbXI3OQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 10:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbXI3OQO
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 10:16:14 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38114 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358AbXI3OQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 10:16:14 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Ibzae-0004Vr-EX; Sun, 30 Sep 2007 16:16:12 +0200
In-Reply-To: <20070930110550.GA4557@atjola.homenet>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59543>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-20-253668563
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Sep 30, 2007, at 1:05 PM, Bj=F6rn Steinbrink wrote:

> Hi,
>
> I recently discovered git-svn and absolutey love it. One thing that =20=

> I'm
> missing though, is an equivalent of "svn merge" for merging between =20=

> svn
> remotes, to support the SVN way of using "squashed" merges, where you
> just note the merge meta-data in the commit message. "git merge" =20
> didn't
> work for me (and probably isn't expected to work) to merge between two
> svn branches, so I've resorted to cherry-picking the required commits
> one by one into a temporary branch and then squashing them together by
> doing a --squash merge with a second temporary branch (as in [1]).

I fail to see why you'd want to reproduce the broken behavior of svn =20
merge.  Anyways, git-svn is a great way to merge SVN branches, =20
unfortunately it can't detect when merges happened on the SVN side.  =20
I think you can use it nevertheless by manually adding a graft at the =20=

last merge point, which would help you merging the right revisions =20
without having to specify what needs to be merged (unless someone =20
made another merge on the SVN side, in which case you need to update =20
your graft).

Cheers,

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-20-253668563
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG/6+VwwE67wC8PUkRAqZmAJ0aVQBCSEsRmD9e/cA9MZhVdM4yhgCeLPUV
XC1z7DriuYXt0TxhZJqFpmw=
=MYqM
-----END PGP SIGNATURE-----

--Apple-Mail-20-253668563--
