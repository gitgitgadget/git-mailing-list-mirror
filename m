From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 03/15] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 10 Feb 2013 16:54:43 -0500
Message-ID: <20130210215442.GB8000@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
 <7v8v6vua50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=OwLcNYc0lM97+oe1
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:55:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4erb-0005Yr-Gh
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab3BJVyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:54:45 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:58591 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab3BJVyo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:54:44 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI0009K2Y77TG80@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 15:54:44 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 16E7A879935; Sun,
 10 Feb 2013 16:54:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360533283; bh=7enYc2ydOoXB8trXRPF6twAzb/kb86gcp/w2ZT1JdDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=s+BGFVE+L6kMMmqaKtbibduk7ReqElMUpDx3zEdCCo6wDUtECfSoJgTVRiKx8C8V6
 Ld6T4nj6MfUcoluu1FYQeT+ufabSY2GEE8CpMGEeCktDPAwM6e6zvvy1xXT/de+zSE
 JuucDaxBghMk7uzBE+VeHEd66x73FjO6D1Xt1u+4=
Content-disposition: inline
In-reply-to: <7v8v6vua50.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215941>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 01:33:31PM -0800, Junio C Hamano wrote:
> Look at how "Fetching branches from other repositories" is done.  It
> shows the use of "remote add" and then shows the result by running
> "cat" to show the contents.
>=20
> I think that organization is much nicer than completely hiding how
> the result looks like behind another "git config --set" call, like
> the latter half of this patch does.

I think for new users, `git config =E2=80=A6`'s opacity may a good thing.  =
Who
cares how Git stores the config values?  Only users who like to edit
the config files by hand (like, um, me ;).  For someone trying to wrap
their head around Git for the first time, the fact that you can read
and set config values which are stored somewhere should be enough.

I don't feel strongly enough in favor of `git config` to push on this
though, so I'd be happy dropping this patch in favor of:

> The resulting text may read like so:
> =E2=80=A6

I'm fine with this too, but if this is the suggested route, why bother
with `git config` at all?  Is it just for ease of scripting?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGBciAAoJEEUbTsx0l5OMwzcQAKON7F5blMTxwDcwU25wNEEX
unnRpuKEBiPul3RhPiMUjczxnxetbnqrvxM9ca1qFbsmwJoAmcVLQk2XI2DFAZd2
t9xz4+OK5+0jAvWCaiIK02/C/V8NpcuOVSlsvuVfwq2HVKvkvrS+H/cR0t3jliqg
93/tjntY2F09ID9twzzRfixkCnNVG7mSjdyZKQN6TaNpr+5MI99Np/1VcycgSCPo
K4vdwrEp6aR4ubUM9J6Vp7Qm/vt7kXuErnZ6i3xERuZhQfhbgO7FuJCdVWKASNTF
y8WC9pIBEtEEYRlk2ms19rbNLdc1ElDyl8wR3bdhvnaNzycEGaUOK6ag7yzcmt18
gx/ML6880N7oOkY6l9JR5Ll+noT/T8zJvuegpBvYhd6aHXUG2aFgE1oI1O3t3gju
P9EOKpFhze4LdfTzZXgJ+EYHfEmNgie6py+7dlNj7ExSY/hrOSJHbtbzYiU10pgX
YyGXqeUXNRqclmE4Sy7eMu3wHhae+ShwqZwEDbPjXwZv4lDrHFjz3qrh2i2jZaFV
aqzMRGIk4Txua6CAgBXnSHPxPyc+vTgovX0LbjpCcGb4aN/EUOvl634sybXPXebA
9bo5aesA293coStTd4TA8c1ewvicu/hGqQeVwQMX21kGQLPIOio/aDouuWP8/o9t
ySCkPSnuk+lkpcoMy9I8
=BdFw
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
