From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 14 Jan 2014 13:42:09 -0800
Message-ID: <20140114214209.GJ23617@odin.tremily.us>
References: <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub>
 <20140114165709.GH7078@odin.tremily.us>
 <20140114205830.GA838@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqSa+Xr3J/G6Hhls"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 14 22:42:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3BkX-0000Bs-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 22:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaANVmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 16:42:14 -0500
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:45337
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367AbaANVmM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 16:42:12 -0500
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id DrYy1n0090QuhwU5BxiBAC; Tue, 14 Jan 2014 21:42:11 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta02.westchester.pa.mail.comcast.net with comcast
	id Dxi91n00Q152l3L3NxiAiR; Tue, 14 Jan 2014 21:42:11 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 4FA95ED1BE5; Tue, 14 Jan 2014 13:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389735729; bh=2YITIP3EWDSHbDiGx/SQC7bWhMMxJfnU0ZipBHoJ7to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V6aTXMxCHtFoFkN+V1exwswHsfBCwVH9uGfkgXe+99CEG02eN+1VeF2faGfDk8aif
	 e6MBoTP5pDSEbZD3ki1VXzudkLpWhl37u7/dCTFHQK06XAwyF+k+hP5Y/0iMpgcK6Q
	 Ea35DOIxcWxT2Kt2UBtlQJQHmxa8WEQblkvdyvSQ=
Content-Disposition: inline
In-Reply-To: <20140114205830.GA838@sandbox-ub>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389735731;
	bh=ghDByjddsEwYmY8FpxPQPFLWLJA+AvnoVfN+ZAJxvao=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=CQwxF1TR/BwRfe5kmFL5ookPQUUG5pv5UGewU/nIgCQ3gX9dTMFH3hDeCIW7qkoeD
	 gY5i//h3V2KW0oQLJp8VUvgVGjH5qJ2EmZ0E4Q9ATD+hgWi57ncGHCuKOnYDXwNb8c
	 hEul+F4Cah1QA++9jtHzzmltExpSCCdTFfPCkRqok/1WRGZYLkDx1vrNDjJy6BhRCZ
	 4e0Pc0dC5jy2vU0VRzKyB15hfid7/tf1wad7FuAXAgchkrAgAS8qVUsxN0DC6YV5iX
	 EqRESu4rzxblFNdnznNDljbrCR5kbZAQfrJ8KLp5rWFqEQZWOr0LpP8ahSMk1P1oOo
	 OwzOBG7Q1dd1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240414>


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 09:58:30PM +0100, Heiko Voigt wrote:
> A typical workflow where a feature in a project needs some extension or
> change in a submodule goes like this:
>=20
> 1. The developer does his changes locally implementing everything
>    needed. To commit he creates a local branch in the submodule and in
>    the superproject (most of the times from the current HEAD that is
>    checked out).
>=20
> 2. For convenience I usually commit the resulting commit sha1 of the
>    submodule in the commit that needs the change. That way when I switch
>    to a different branch and back I can simply say: git submodule update
>    and get the correct code everywhere.

This checkout functionality is exactly what my
submodule.<name>.localBranch is designed to automate [1].  I think
that should be different from integrating local and external changes,
which is what 'git submodule update' is about.  For example, after you
run 'git submodule update' here, you'll have your original commit
checked out, but you'll be on a detached HEAD instead of your original
branch.  If you want to further develop the submodule feature branch,
you currently have to cd into the submodule and check the branch out
by hand.

> How about the use-case I sketched above? Is that what you are searching
> for? In that use-case we have to update to the new master after a
> submodule change was merged. That could be achieved by
>=20
> 	git submodule update --remote <submodule>
>=20
> with the wanted stable branch configured. But in practise something
> along the lines of
>=20
> 	(cd <submodule> && git checkout origin/<stable>)
>=20
> is usually used and simple enough.

The =E2=80=9Cgitlinked commits must be in the subproject's master=E2=80=9D =
rule
protects you from blowing stuff away here.  You could use rebase- or
merge-style integration as well, assuming the maintainer didn't have
dirty local work in their submodule.

> We have a tool in our git gui configuration that does
>=20
> 	git submodule foreach 'git fetch && git checkout origin/master'

I agree that with 'submodule update' seems superfluous.  With proper
out-of-tree submodule configs specifying remote URLs and upstream
branches,

  git submodule foreach 'git fetch && git checkout @{upstream}'

(or merge/rebase/=E2=80=A6) should cover this case more generically and with
less mental overhead.

> I hope that draws a clear picture of how we use submodules.

It's certainly clearer, thanks :).  I'm not sure where checkout-mode
is specifically important, though.  In your step-2, it doesn't restore
your original branch.  In your =E2=80=9Cupdate the superproject's master=E2=
=80=9D
step, you aren't even using 'submodule update' :p.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240336

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--NqSa+Xr3J/G6Hhls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1a8uAAoJEKKfehoaNkbtI0YP/0PR9yySvPPp6NxyABFJPUkv
zjx91HkxrK811bYkyCO35xq1neywQ4kZKTmUb7Z0dO5QVt+LXn6OvAtJDLJlXHy0
i8Joqx3QSOzFi2acE1XbmHb8BypT6PSDWx8sP2FRAwnpNsK/1u57Sp/+to1ppQfO
xx0eLX/k/GqJxx5UTuDY40AEfawn2Jhp3NlYNgyMEEmXfqjYbzbC1f6QByjSvZnc
m5VpbRmTE5ydEt2NV9GnZIzqfRdCI8sU3EJ1qBj0WedlKFMA2vYYkAD9ixCNv1w9
MBNpLzVLWGmY9Oum6bse5nXidIwP1DfG1/Lgzn4V3e/+37IiPUioJeKAFiQPEWzu
Qf/See0AL59SwjdM3uxFg7pEeQPPV1BiITdx5RnAEPiiJC8lCKFd8rBcTR0EdNx3
pKCzqnC6XOqqpkCQ7CWmkQtwpD3tQUP7IcmFhI3Auqf2UbmeIZsfOvEU/Te/90f3
63/vOmuWEWHQqDztuwK3p0xHVnmxstHfS2g7mEk9mjuNRFCXLgRexBCfUorhzc05
9107DhuYCaZDoUcchu0eaHQiUOLyPD6zQ3+hitvMXCWEe8EMZuiJaZsfKKFQQJY/
d7zfuFng991RUCkIhiScQN2iFFGFj0P/Po/YXFxNsh9N9Zd+W6ZWLp78p0jeXjn8
FXL/YydhwBF0Jz6Z+BYl
=OzBb
-----END PGP SIGNATURE-----

--NqSa+Xr3J/G6Hhls--
