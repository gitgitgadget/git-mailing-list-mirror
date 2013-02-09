From: "W. Trevor King" <wking@tremily.us>
Subject: [BUG] can't switch branches with submodules
Date: Sat, 09 Feb 2013 07:32:06 -0500
Message-ID: <20130209123205.GC1795@odin.tremily.us>
References: <CALkWK0=aifKVHnPZSfqE0rLn1aUGqC0nBULaLCe6UY2=6YGZ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	Git <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 13:32:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U49bk-0000Hj-5s
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 13:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab3BIMcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 07:32:08 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:32027 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab3BIMcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 07:32:07 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MHY00CC3DHINN40@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 09 Feb 2013 06:32:07 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 301D887855B; Sat,
 09 Feb 2013 07:32:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360413126; bh=GLrJPXk4NRvOsUq8Vt3ikR7bDIvMytUoc4rnRUnNh8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=E9ttxli7epBvrRomv6U2AtfPtNdKC+Wx1y/071H167yF16htSVJl4jM5HAgq+rI6E
 7CgTot4VmpzNbNtA3gSLuYJQQ+QZuZjTreptFkk91CVI9xOdGmly36/uX+WXQ8VcXD
 bwtzJiQQ5ceMVxozQpjNuUZPPC5jFh2fUnO93LWs=
Content-disposition: inline
In-reply-to: <CALkWK0=aifKVHnPZSfqE0rLn1aUGqC0nBULaLCe6UY2=6YGZ9g@mail.gmail.com>
 <50EA7269.1080006@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215862>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2013 at 05:55:26PM +0530, Ramkumar Ramachandra wrote:
> I have two branches: master and gh-pages.  master has one submodule
> called foo that gh-pages doesn't.  When I try to check out gh-pages
> from master:
>=20
>     warning: unable to rmdir foo: Directory not empty
>=20
> And the foo directory exists in my worktree.  This is very annoying,
> and I want to fix it now.  Where is this error coming from?  How does
> the worktree get updated when I checkout?

You may want to look at the pending Great Submodule Integration
Branch:

On Mon, Jan 07, 2013 at 07:59:53AM +0100, Jens Lehmann wrote:
> I=B4m currently working on teaching mv to move submodules and intend
> to send those patches to the list after finishing submodule deinit.
> Please see
>   https://github.com/jlehmann/git-submod-enhancements/commits/mv-submodul=
es
> for the current state of this series.

;)
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRFkHFAAoJEEUbTsx0l5OM+lcP/RQKA/n4KpcIaI1U12a/2ahd
XRCAbv7rtOgRPShlEoXTvuAHjIXhLzzD5KlKK5ff/JKZDyqjdpUme6KX8PJIMzob
ADeCDlBce46AL1kf/dJ2ah+g6x1VQJRXQQnvYRaB4PwZDVrnvNKaH/yUqd/qgsVe
Mz19EOELvCGAPmpEEIMYFSso8V0dhjN9JToErMRiR6lMwvYq8oIaDMPfw6optXp+
5d2PnT3DJss3RBRZzY0TRgu2yUJ/PQAJIiWcWdpvZ6ddnCPjKkFY4auKze/pgQ0R
8cfKkXJWAHEIQOOZwe/ySyuSNVMzrUStfF9jJQy//YtDI/RT6YUUklWfeycuzo+B
gE48EORK0xSQFub9i/aESRALjJmVin2XcyrTJ79LPFmE56A0klvjCnWrCKv1TjF3
PZM8wSbRVaxWH/8J+imCW57MLkY25J9EwobAndhz0EpdYqF1v9EtLgjIOVyG80v7
45G5NIq2eW9rvoXD6EOeK5ZQVQnUIeM17DI8QkWoX5Y1Yw2UQxs0gO5qShQLnImI
d6FL5Ogmb3VdSEzTTOAPIi+CExPO6lscibPERNnftrdPBSLz3VEYBcu0nK4p+ukq
b5jGZD+DTvIIa7kAebRDoP/ElEf0AyxQqmL/qo585hCqNPnJyzLUV54m83cXqt08
JKfD35FJnUhruXeTRdwk
=edPv
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
