From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a
 separate gitdirs.
Date: Sat, 08 Mar 2014 01:50:52 +0100
Message-ID: <1394239852.7891.40.camel@Naugrim>
References: <1394178834.7891.38.camel@Naugrim>
	 <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
	 <1394231714.7891.39.camel@Naugrim>
	 <xmqqvbvpshqn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EbDOVxO+KHxjujM3BsRH"
Cc: Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 01:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM5Tj-00084Q-Hf
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 01:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbaCHAu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 19:50:59 -0500
Received: from smtpout4.laposte.net ([193.253.67.229]:38061 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaCHAu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 19:50:58 -0500
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8507-out with ME
	id aoqs1n0082iaXuy03oqsT2; Sat, 08 Mar 2014 01:50:53 +0100
In-Reply-To: <xmqqvbvpshqn.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243639>


--=-EbDOVxO+KHxjujM3BsRH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 07 mars 2014 =C3=A0 15:37 -0800, Junio C Hamano a =C3=A9crit :
> Henri GEIST <geist.henri@laposte.net> writes:
>=20
> > This information is technical in nature but has some importance for gen=
eral users.
> > As this kind of clone have a separate gitdir, you will have a surprise =
if you
> > copy past the worktree as the gitdir will not come together.
>=20
> I am not sure if I understand exactly what you are trying to say.
> Are you saying that you had a submodule at "sub/dir" in your working
> tree, and then "mkdir ../another && cp -R sub/dir ../another" did
> not result in a usable Git working tree in ../another directory?
>=20
> It is almost like complaining that "mkdir ../newone && cp -R * ../newone/=
"
> did not result in a usable git repository in ../newone directory and
> honestly speaking, that sounds borderline insane, I'd have to say.
>=20
> Yes, if a user knows what she is doing, she should be able to make
> something like that work, without running "git clone" (which is
> probably the way most users would do it).  And yes, it would be good
> to let the user learn from the documentation enough so that she
> "knows what she is doing".  But no, I do not think end-user facing
> documentation for "git-submodule" subcommand is the way to do that.
>=20
> That is why I suggested repository-layout as potentially a better
> alternative location.
>=20
> But perhaps I am mis-reading your rationale.
>=20
>=20

Let me rephrase my example :

To give one of my project to someone else I have copied it on a USB key.
By a simple drag and drop with the mouse.
And I am quite sure I am not alone doing this way.

I have done those kind of things lot of time without any problem.
But that day 'the_project' happened to be a submodule cloned by
'git submodule update' then on the USB key the $GIT_DIR of 'the_project'
was missing.

If 'man git-submodule' have made me aware of the particularities of submodu=
les
clone I had write in a terminal:

git clone the_project /media/usb/the_project

Or at least I had understand what happened quicker.

I have nothing against also adding something in repository-layout but I am
pretty sure normal users never read repository-layout as it is not a comman=
d
they use. And it is not mentioned in most tutorials.



--=-EbDOVxO+KHxjujM3BsRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMaaWwACgkQkKuHPdwEGdTpogEAiy5X78AmeqUkWKfnEXNXiDeJ
secv5weG07WnmyciLk4BAIWSWmlQoAx/DtFc4mx/v4/z3Eh/K2IgHXjqi03xjFQs
=+J/6
-----END PGP SIGNATURE-----

--=-EbDOVxO+KHxjujM3BsRH--
