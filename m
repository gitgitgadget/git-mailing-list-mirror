From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 14:01:24 -0800
Message-ID: <20140105220124.GI3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
 <20140105214752.GH3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 23:01:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzvlE-0001UU-5y
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 23:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaAEWB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 17:01:28 -0500
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:60119
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbaAEWB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 17:01:27 -0500
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id AMlB1n0040Fqzac5EN1Scp; Sun, 05 Jan 2014 22:01:26 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id AN1R1n001152l3L3UN1RtC; Sun, 05 Jan 2014 22:01:26 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id A1D1DE8AE76; Sun,  5 Jan 2014 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388959284; bh=3XXbG9DwGIp9BynqjdVT/UBAmfm1G5QMBbI7tDWRXco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sO5rIf2VK8HVlGFIlnHKZfP8IoH6PxJtdyhijIaZUch/6w1XQ+MB1ce0G3rYcExdh
	 Fyfk6WWPty5fOiN4mw64sRmv8/AyDFkVv0c5xLpZwlUofzW0pSzstxtvmbf5TjQ4zN
	 0uY0miA0N8C6E6dFVNzgwKPdOiKqlog6r4Kw1nys=
Content-Disposition: inline
In-Reply-To: <20140105214752.GH3156@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388959286;
	bh=mwhEp9gSCt3G7XrMSo7kpZ32VIWIK8mv1p76DNQkZC8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=gusXCvBk2l3vfXLyAqaizc0KwZHdOckGM21MLTdxabCjmMv9ZuYVNEhRwnv/jykzx
	 6/DaX9bgCUmK5Wifn0fm98U71/7y3enEyzTYSafWbqCarTuRz9V6MZgOnBR4MHIMw2
	 f0TmtF9WmfjxvjNu+APZ1HXFkmoHuibuYbVepx2qVoC6KsbMgACI5+zS9E8uV/i6B/
	 vUGj3xSnxzuLIVuPkVZcZyK4c9RX/AIK+yIxOXJItMJeydBvbMKiPoTNWPZOnHlwpr
	 oXCJJ94uzOwplQY5vimnEuoCn7obxyma8GbmRNSiVxemPPHX3WeWIoQRNvRUhspbBj
	 dNU1Ds7LOgavg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239977>


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 01:47:52PM -0800, W. Trevor King wrote:
> On Sun, Jan 05, 2014 at 10:27:19PM +0100, Francesco Pretto wrote:
> > 2014/1/5 W. Trevor King:
> > Also it covers:
> > - an "autoremote" behavior when the user wants an attached HEAD:
> > with your patch "--remote" is still needed to really update the
> > branch with "git submodule update":
> > - voluntary reattach/detach the HEAD with command line;
> > - ff-only merge of changes in the case of "checkout" in an attached
> > HEAD (doing "git checkout <branch>" is not enough);
> > - reattach of the HEAD with orphaned commits.
>=20
> Personally, I don't think autoremote updates are worth the additional
> UI complication (hence my alternative patch ;), but I'm open to
> discussion on this point.  Can you make a case for why and explicit
> --remote update is burdensome?
>=20
> I'm also not entirely clear on the problems avoided or workflows
> enhanced via the last two entries.  Could you sketch an example
> workflow that makes that more obvious?

For example, your original patch [1] claimed a reduction from:

  # Maintainer
  $ git submodule add --branch "master-project1" <repository> common
  $ git commit -m "Added submodule"
  $ git config -f .gitmodules submodule.common.ignore all
  $ git push
  $ cd <path>
  $ git checkout "master-project1"

to:

  # Maintainer
  $ git submodule add --branch "master-project1" --attach <repository> <pat=
h>
  $ git commit -m "Added submodule"
  $ git push

My patch does not effect this maintainer flow at all, but I'm pretty
sure the initial checkout is already automatic:

  $ git --version
  git version 1.8.3.2
  $ cd b/
  $ git init
  Initialized empty Git repository in /tmp/b/.git/
  $ git submodule add --branch master ../a
  Cloning into 'a'...
  done.
  Checking connectivity... done
  $ cd a/
  $ git branch
  * master

You also claimed a reduction from:

  # Developer
  $ git pull
  $ git submodule init
  $ git submodule update --remote
  $ cd <path>
  $ branch=3D"$(git config -f ..\.gitmodules submodule.common.branch)"; git=
 checkout $branch

to:

  # Developer
  $ git pull
  $ git submodule init
  $ git submodule update

My patch should cover the developer reduction (auto branch checkout on
the initial cloning update) without confusing the situation with
autofloated updates.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/239799

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSydYyAAoJEKKfehoaNkbtk7MQAKDyoNBdb9xAtmm9Ab/QspOf
wFOJvqBcXkoJr/gO2vEOePirVXh1yKVtsiqCspBu/QaNHJFaHzis1cnjBlRgLsHY
F1RwKc5hTi+sF00Y8uBqXbOB4rwiEcCWReTa11hv93AEN6epOh+e0IuvPN7PH913
VRSlSDnfdpd2NUP6ACmZ7Z8pPYscQMHUqtbBBF8kSVsdibv0CClHMRtvqm3A9eAm
T2gOXvGYrwi+GLsIpPgO4p2lMbeNmikJ2+hVFkgHfA4/3L9JP6muMoWQUjiZyHEE
LUKVc8Iu1zatDlRKQajxO6s/RTdfJV8FoOGxXjVYIAbYAgL7xep43UE69ewqAhDR
An0jBLerEe07eVqFaNhMiWURj1UtNOf+/CtoebcYKVYrFXx/47agtmQjq4Bc1YOI
ZwekgeVladJCCFbKA1YhWgZpxHrU0P1q9Yw1vqnN/7hPNeEhcaUalNLD4RxrjRYB
SKHCyi5Mh10rH00m/BRMJItEX5RnZ9bNQN7gKNpZd6DxU2NHvaRfTip1KG1rhIFb
O+7I7m52seudSJaKU10Ajn3NrWFm8P2LdW+zloXFC1DgtyPgc/dvraw0CgJKki85
jV1lXi/eWAFE0PQ8Z25N/VAFPJJjT1f3Rx3VmTtKoVqcVNvKr+6iM4neKVo5Iwuc
yaED/KNb6zHzUjb6O2es
=VjbT
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
