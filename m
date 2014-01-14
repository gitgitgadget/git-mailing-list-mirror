From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 14 Jan 2014 14:39:09 -0800
Message-ID: <20140114223909.GB2647@odin.tremily.us>
References: <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub>
 <20140114165709.GH7078@odin.tremily.us>
 <20140114205830.GA838@sandbox-ub>
 <20140114214209.GJ23617@odin.tremily.us>
 <20140114221907.GC838@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 14 23:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Cdk-0004Mm-TS
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 23:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbaANWjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 17:39:13 -0500
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:52989
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181AbaANWjM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 17:39:12 -0500
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id Dx5y1n0060EZKEL5CyfBBt; Tue, 14 Jan 2014 22:39:11 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id Dyf91n00J152l3L3MyfAv0; Tue, 14 Jan 2014 22:39:11 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 8D4A6ED1E7A; Tue, 14 Jan 2014 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389739149; bh=l5U/8jEkMFcTbPGn2IfBOSb5JHswCoS2QCIiPYcjcpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f+74m3GhfB5D2mE1G+ox+kYvl94fXsnWQdpQSkaxaYl6WyFSYoxeUEQOKPGQdPdkB
	 og34BbOde6NiMSbtXpS8Zs+SRqF1Hmrxbl7YThUi3Kr/gbdUG+Zu14kseHiqdj6xBf
	 y4wSpPGMk693VtEtxeQcPGdfz6A1vkcdHMCPB9ao=
Content-Disposition: inline
In-Reply-To: <20140114221907.GC838@sandbox-ub>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389739151;
	bh=GdUH+S8xBRPrHQ1s/sLlEWT4j04A/C5nj5ytYrIFFSw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=aAj96N/qQkQcctRpgLDBwd/AqxKiQlH+dcpUjRXxRAm8+y25byXTLzFsmY9gQu9WN
	 NT+/ujc5l4s1M0M2xwXsbVuj2C/4c5RhmLloAoMnNS1JuSxlgzsapaQC9gKG3z3DJh
	 OCqjV/d3V0RYC/wuhJkmI76sDrvz9wvY5obcBHJB2q1X2iEmX4OSysDebWy02QEXxC
	 nBoFKaCPwnSTaCu9EAY9YXZ+LJY64ZjlFIV7imdN4OF+NRWAII74lk9np2pcJzckLF
	 W/izbg5/eBmDV1i7VmBciDnPEvFeLd5CP6KzJ2FDPT6ndaNJ4g+ZUp/SvbhYd5O1Bf
	 dI9i0iPCqKUKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240419>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 11:19:07PM +0100, Heiko Voigt wrote:
> On Tue, Jan 14, 2014 at 01:42:09PM -0800, W. Trevor King wrote:
> > The =E2=80=9Cgitlinked commits must be in the subproject's master=E2=80=
=9D rule
> > protects you from blowing stuff away here.  You could use rebase- or
> > merge-style integration as well, assuming the maintainer didn't have
> > dirty local work in their submodule.
>=20
> No we can't. Developers are not allowed to merge in some submodules.
> The most central ones have maintainers and only they are allowed to
> merge into the stable branch. So we need to track exact commits on the
> stable branch, no local merge (except the fast-forward case of course)
> allowed. Thats why the developer does an exact checkout here.

Because both sides of the merge/rebase are required (by your rule) to
be in the subproject's master, you're guaranteed to have a
fast-forward merge/rebase.

> > > We have a tool in our git gui configuration that does
> > >=20
> > > 	git submodule foreach 'git fetch && git checkout origin/master'
> >=20
> > I agree that with 'submodule update' seems superfluous.  With proper
> > out-of-tree submodule configs specifying remote URLs and upstream
> > branches,
> >=20
> >   git submodule foreach 'git fetch && git checkout @{upstream}'
> >=20
> > (or merge/rebase/=E2=80=A6) should cover this case more generically and=
 with
> > less mental overhead.
> >=20
> > > I hope that draws a clear picture of how we use submodules.
> >=20
> > It's certainly clearer, thanks :).  I'm not sure where checkout-mode
> > is specifically important, though.  In your step-2, it doesn't restore
> > your original branch.  In your =E2=80=9Cupdate the superproject's maste=
r=E2=80=9D
> > step, you aren't even using 'submodule update' :p.
>=20
> Ah sorry I though that was clear. The "others" are using submodule update=
 ;-)
>=20
> I mean someone who gets stuff from a stable superproject branch by
> either rebasing their development branch or updating their local copy of
> a stable branch (e.g. master) by using
>=20
> 	git checkout master
> 	git pull --ff --ff-only
> 	git submodule update --init --recursive
>=20
> This also prevents the pure "updaters" from creating unnecessary merges.

Right.  Folks who don't do local development in their submodules can
get away with checkout-mode updates and their detached HEADs.
Assuming the upstream superproject only advances the gitlinked commits
using fast-forwards, they could equally well use any of the other
update modes, but there is no need for them to make that assumption.
*This* is the use case that I think the current recursive-checkout
facilitates [1].  I don't think it helps folks who are actually doing
submodule development on branches from within their superproject.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/239695

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1byMAAoJEKKfehoaNkbtUXoQAJDIU+30FEVVwNmj01AAxPwd
eZ9sIwJCQOvgUG0Y/HdHwT5amgV7GgOkybgNgl4mgZacUh3A5k0v99SMlKcwdnKr
W+j+BV+InEf+6MQU7JG7sAj1jc1omZtBjvk/sQnHe2LLE9Gqk/K1TlvhoYv7hR9N
JFv61sZYOewy7DQMCDEo+wwLfWnx6OBEy/MnLiRiXW+8psCLWFHyQGNDEbSuNcNT
S8kIHFjg+3oa4VPUUPrGpsJhMDYAiH/mcNFgghbb+qdZz9Xw23VgDnZNXwHdLhAD
55xNdBg3AUc90GjSxC/xOw1oZyssiIUTI1tNwcbhBnnZUEIuZFCjjbC7+SqIVhlx
a8Iuf78UOn9AeToEcrvvm9147o6PYAEjNIp0jaGfgZvpHnZgPJJaPbi2uMFQH5A1
btWjE4gr4lOB8n9RJd1Trr2dzfL6N8XzPTu8zsHujtzyQrypTi3ed8bgjVescJTl
2H8PAHj8h0G6SRHo/xbFc6iMkdSRDkBnHJQqyx42/F5gRcsjW0PQkfmIsuTEuWaf
/Bv8ssE2s1JkUOhGi0NQyYLrY/JdAK5HocnSkAPvCvNMpNLiHd9rV5bx5t94voR4
TUWtbjjRZqan/sC5euM7PYnlmnhAhjhZ8UbM73mESJjRq9kyHUG7M/OPqgnsabZv
hdnLP2r02SzX+e4QVaQs
=WMf2
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
