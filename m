From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Fri, 18 Oct 2013 13:38:09 +0200
Message-ID: <C7A28BEB-5B2D-4D21-AC3D-CC5BACDF742D@quendi.de>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com> <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com> <CAMP44s3u_SMyZOe5jxkvoGn5MBJ_g70iHRT5v_3u1rZwFoqiVA@mail.gmail.com> <xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_50C76F43-5D11-4425-A677-F64E028B6E6C"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 13:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX8Nq-0005ws-Lb
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 13:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab3JRLiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 07:38:17 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:55215 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753097Ab3JRLiQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 07:38:16 -0400
X-Greylist: delayed 1021 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2013 07:38:15 EDT
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VX8Ni-00074G-5O; Fri, 18 Oct 2013 13:38:14 +0200
In-Reply-To: <xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1382096295;89f0a5cf;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236344>


--Apple-Mail=_50C76F43-5D11-4425-A677-F64E028B6E6C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 17.10.2013, at 21:50, Junio C Hamano <gitster@pobox.com> wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:

[...]

>=20
> However, since you asked, I would share a couple of comments
> regarding the index, cache and staging area.
>=20
> (1) "Staging area".
>=20
> The phrase "staging area" is not an everyday phrase or common CS
> lingo, and that unfortunately makes it a suboptimal choice of words
> especially to those of us, to whom a large portion of their exposure
> to the English language is through the command words we use when we
> talk to our computers.

Interestingly, as a non-native speaker, I draw the exact reverse =
conclusion from this: While I had no idea what a "staging area" or "to =
stage" was (I did know the "stage" in a theater, though), I found this =
to not be a major problem: Using a dictionary and reading up on what it =
means in git made it clearly quickly enough.

To the contrary, the fact that the term was not yet overloaded with =
conflicting other meanings made it easier for me to attach the semantics =
git associates with it.

In contrast, "index" was exceedingly bad and confusing to me... I =
already had various notions of what an "index" is (e.g. the index of a =
book -- the same word actually exists in German; or more generally an =
index in computer science, as a kind of loopup table, etc.), and to this =
day, have a hard time consolidating this with the way git uses it. For =
me, it is yet another, seeming completely unrelated, meaning of the word =
"index" I had to memorize. Hey, just take a look at Wiki page =
<http://en.wikipedia.org/wiki/Index> for the many dozens of meanings =
associated to this word. Ugh. And worst of it, I am actually not quite =
sure on which of the meanings listed there "the index" as used by git is =
based... I.e. I don't even see a helpful analogy that would make it =
easier to understand the choice of name.=20

In summary: For me as a non-native speaker, "index" feels like about the =
worst possible choice (well, you could have called it the "file" or =
"thing", that might have been worse ;-). While staging area turned out =
to be surprisingly good, *precisely* because I was unfamiliar with it.=20=


So, while "staging area" might not be perfect, it seems good enough to =
me. If this matter had indeed been discussed here for years, and no =
better suggestions has come up, then perhaps it is time to end the =
search for the (possibly non-existent) perfect solution, and instead do =
the pragmatic?


> The index can also be thought of "like the buffer cache, where new
> contents of files are kept before they are committed to disk
> platter."  At least, non-native speaker with CS background would
> understand that, much better than "the index" (no, I am not saying
> that we should call it "the cache"; I am just saying "the index" is
> not a good word, but we may need to find a better word than "the
> staging area").

Huh? As a non-native speaker with CS background, this actually leaves me =
more confused than I was before. I think about "the staging area", and I =
don't see how this is anything like an "index" (in any of the meaning I =
see on <http://en.wikipedia.org/wiki/Index>). I can vaguely recognize a =
faint similarity to a "cache", and yet more relation to a "buffer", but =
in the end, none of these strike me as particularly illustrative.

For that matter, I never really understood of why I had to do "git diff =
--cached", I simply learned it by rote.=20

On the other hand, I feel that after understanding what the staging area =
is, then writing "git diff --staged" is very logical and simple to =
memorize.




Cheers,
Max

--Apple-Mail=_50C76F43-5D11-4425-A677-F64E028B6E6C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJhHaUACgkQIpJVslrhe1lo3gD/a6WyrIALek6UrZIvqq6OngmF
QncRDeb72LhoiaU7t0sA/222L10uMYFaCC3evdVRTwO0tjCtrYTQCuG0U5Nwn5lt
=N4Yh
-----END PGP SIGNATURE-----

--Apple-Mail=_50C76F43-5D11-4425-A677-F64E028B6E6C--
