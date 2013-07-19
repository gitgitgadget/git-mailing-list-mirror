From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 13:08:30 -0400
Message-ID: <20130719170830.GD5999@euporie>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
 <7vr4euy4c6.fsf@alter.siamese.dyndns.org>
 <CALkWK0m-q=Aoof62zhXnUYsJ7PQZwTLbQ50BUEmufVO4gtWNUA@mail.gmail.com>
 <7vppuewl6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 19:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0EJE-0001RS-FS
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 19:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760166Ab3GSRRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 13:17:33 -0400
Received: from tmh.cc ([173.230.128.92]:50510 "EHLO elara.tmh.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab3GSRRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 13:17:32 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jul 2013 13:17:32 EDT
Received: by elara.tmh.cc (Postfix, from userid 1001)
	id AAC6E30226; Fri, 19 Jul 2013 17:08:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on elara.tmh.cc
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=5.0 tests=ALL_TRUSTED,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED autolearn=no
	version=3.3.2
Received: from euporie (unknown [66.162.194.174])
	by elara.tmh.cc (Postfix) with ESMTPSA id 1213430222;
	Fri, 19 Jul 2013 17:08:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vppuewl6h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230831>


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Junio C Hamano, Fri 2013-07-19 @ 09:48:06-0700:
> But there is a very commonly accepted long tradition for "-" to mean
> "read from the standard input", so we cannot reuse it to mean "the
> branch I was previously on" for every command without first making
> sure the command will never want to use "-" for the other common
> purpose.

It may be worth noting that Bash (and probably other shells as well)
allow you to type `cd -` to switch back to the previous working
directory. I always (apparently mistakenly) assumed that
`git checkout -` was deliberately designed to mirror that shortcut. I
think the symmetry gives it some credibility, in any case. This
alternative meaning for - is not totally without precedent.

What would it mean to check out the standard input, anyway? I cannot see
how that could ever make sense, unless `git checkout` gains some
additional capaabilities that are unrelated to its current purpose.
Maybe I am just being myopic, though.

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIbBAEBAgAGBQJR6XKOAAoJEDTWeng2oxKKjLUP+PT13aHSLhLM0DIchYww/VCr
kzGDDZ1DP4qHrp8bgDfwAhvsYuXZykIJmJyTGf5SCZ5AToSya4SmG2VsjK0u2dVE
izZKAXJsJdFBt37/+Rkco1HFDQUM5bTgxdwhlzOa/oOVf9r9gq22LuLxB1nAz2Jd
fUhtqem/w7FBE6MhZltiW/lJ+P9jKxCoBsZFWKdEuyqdrqTZUiDo1X5GicCfYatH
Sv/11c6F0duad6Bl5/OyUXauMT+pEzLL/FFQbnyNY8TZw5oJUwW/Er1+5Al7gwuQ
FsQn4pNJOa7ARuzd6kGi8FIBSSqFxTWWC653WpROtI8rh9dt+IzrtK1mXKGamrDb
mGWunBH2NmSo9dhn9QXH5/mYeIGOqinyUel8RVA+1cE0AfPer2bz0fLfbkRV2QOJ
o1oe+nMJUhhJuNF8XsNFXWNC7WgDaQHRmkdv6JCYBd925rgUX2eZmvPUf3526I2b
HlmtQjaaSsWsuvhJqgybWq6+o3A0fn9773aPO8NiI9lvf4VziUHCS9PXg7+zqbqm
Cth6pohd4djTxfs+3whQOLy1zutRemU/kOQKg4zeje/OSdWKsohrad9g51tzqoJK
tVwKiKxN1OK90RT+YL6RvAoAmLdZuT8uBLoKqfJrHi5hjRfPMF7F4psf4ezplHG9
JwNp1q5kVaRXuxJ7LIg=
=0aOc
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
