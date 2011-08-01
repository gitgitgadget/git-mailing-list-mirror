From: martin f krafft <madduck@madduck.net>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 22:55:23 +0200
Message-ID: <20110801205523.GB15401@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <CAGdFq_h5gimMkwhyOv0PFqVwx4pExL7Zri8Tki_dT5HDtFcBFA@mail.gmail.com>
 <20110801183411.GA5182@fishbowl.rw.madduck.net>
 <20110801200149.GA20861@toss>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
To: Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:55:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnzWn-0001Bz-Or
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab1HAUzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:55:54 -0400
Received: from seamus.madduck.net ([213.203.238.82]:59730 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab1HAUzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:55:52 -0400
Received: from fishbowl.rw.madduck.net (70-204.79-83.cust.bluewin.ch [83.79.204.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 099C7407D24;
	Mon,  1 Aug 2011 22:55:24 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id A0E721FFE2; Mon,  1 Aug 2011 22:55:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110801200149.GA20861@toss>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178413>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Clemens Buchacher <drizzd@aon.at> [2011.08.01.2201 +0200]:
> Notes are tracked using a 'branch' too. It's just a branch in the
> refs/notes namespace, the notes ref. You could simply tag your
> notes ref or point a ref from the refs/heads namespace to it each
> time you create new notes.

Hi Clemens, thanks for responding!

You suggest integrating refs/notes/foo into refs/heads by means of
a pointer=E2=80=A6 at which point we are polluting the branch history space
again (think gitk), no?

I appreciate the simplicity of this idea of yours, which I had not
thought of. Indeed, maintaining a head at the top of
refs/notes/topgit-metadata (or whatever) has charm. I do not mean to
discard it at all right now, and will think about this more!

git-notes was designed to be used for such cases, I was pleased to
note the configurability. Maybe it is the ticket.

Still: why not commit headers?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
=2E.. with a plastic cup filled with a liquid that was almost,
but not quite, entirely unlike tea.
            -- douglas adams, "the hitchhiker's guide to the galaxy"
=20
spamtraps: madduck.bogus@madduck.net

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJONxK7wBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xG7C
D/0db7ChmIgDJelBXAbzybmCFV0CEiKhxNXxcJytsJ77sXLVoOJfkhLLk7yRBzGR
4XwAWGyqxJ9xxDrfolZkZhOlLjIYq8REQdv+THchcipVsTZyr+fxKwhgPwLg6KEr
0nAIOGyClWI6mPQsgeqiVgVXQ2O3Qqkj/B+8JFHuL5fQ4RPe0hgt+VutKl8xqcHj
fSjQw4OLLU/2dO+WgP5DVTCMV3D2hbnEc1SDZ5S8VubN2jGgj+334QVnO/7SDSUO
eCN4Dy4cQzqsCdFB80q/nmy19OrSpu/3Fq6Gb7e6zF4iK2GeLehVk3h6AVHlMP1E
uzfYdHzDRF4N3h5SpKjDuo1RnVvBL7TBzqUJ5pCB13frZ5T9bjPF+hgWvCKCp1pp
lQ4oFEZLU5oqzHz1qhMOOuJDWTtZyHOmkNgEd3qHV116gH0EAjf8TyDp5ORLozDL
FWu2dfBd3TuSyyWhyoaTNfvKEJLZMogDc8wvNOv2fFLRi0Ds8qDuMXwE9+NhErtl
6rxKi4teVyH/KQ1V9BrcWnZ69CthhajAdLDXo0SSOdMr41IjOq4K7Iu0mGtGbp1p
4jv7SNAYpF6QkEZtrz9azjeuCPzGA5K1mq9fIkxhEMu/UShnJrGbr+ycLLnDskFm
tG5i958A6D+YhVqdrlWj4XFdoPjQyNq0mH7teF+8RcUtTg==
=W/S6
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
