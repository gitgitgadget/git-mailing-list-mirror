From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a
 separate gitdirs.
Date: Mon, 10 Mar 2014 08:52:26 +0100
Message-ID: <1394437946.7891.44.camel@Naugrim>
References: <1394178834.7891.38.camel@Naugrim>
	 <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
	 <1394231714.7891.39.camel@Naugrim>
	 <xmqqvbvpshqn.fsf@gitster.dls.corp.google.com>
	 <1394239852.7891.40.camel@Naugrim>
	 <B2A4F350-1F20-4ABA-80A6-CF244DD7FAFD@kellerfarm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-wrDJf7BlRpy8m3F1+sEN"
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 08:52:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMv0s-0005x1-UU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 08:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbaCJHwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 03:52:39 -0400
Received: from smtpout7.laposte.net ([193.253.67.232]:43094 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaCJHwi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 03:52:38 -0400
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8514-out with ME
	id bjsS1n0032iaXuy03jsS3G; Mon, 10 Mar 2014 08:52:33 +0100
In-Reply-To: <B2A4F350-1F20-4ABA-80A6-CF244DD7FAFD@kellerfarm.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243708>


--=-wrDJf7BlRpy8m3F1+sEN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dimanche 09 mars 2014 =C3=A0 19:24 -0400, Andrew Keller a =C3=A9crit :
> On Mar 7, 2014, at 7:50 PM, Henri GEIST wrote:
> > Le vendredi 07 mars 2014 =C3=A0 15:37 -0800, Junio C Hamano a =C3=A9cri=
t :
> >> Henri GEIST <geist.henri@laposte.net> writes:
> >>=20
> >>> This information is technical in nature but has some importance for g=
eneral users.
> >>> As this kind of clone have a separate gitdir, you will have a surpris=
e if you
> >>> copy past the worktree as the gitdir will not come together.
> >>=20
> >> I am not sure if I understand exactly what you are trying to say.
> >> Are you saying that you had a submodule at "sub/dir" in your working
> >> tree, and then "mkdir ../another && cp -R sub/dir ../another" did
> >> not result in a usable Git working tree in ../another directory?
> >>=20
> >> It is almost like complaining that "mkdir ../newone && cp -R * ../newo=
ne/"
> >> did not result in a usable git repository in ../newone directory and
> >> honestly speaking, that sounds borderline insane, I'd have to say.
> >>=20
> >> Yes, if a user knows what she is doing, she should be able to make
> >> something like that work, without running "git clone" (which is
> >> probably the way most users would do it).  And yes, it would be good
> >> to let the user learn from the documentation enough so that she
> >> "knows what she is doing".  But no, I do not think end-user facing
> >> documentation for "git-submodule" subcommand is the way to do that.
> >>=20
> >> That is why I suggested repository-layout as potentially a better
> >> alternative location.
> >>=20
> >> But perhaps I am mis-reading your rationale.
> >>=20
> >>=20
> >=20
> > Let me rephrase my example :
> >=20
> > To give one of my project to someone else I have copied it on a USB key=
.
> > By a simple drag and drop with the mouse.
> > And I am quite sure I am not alone doing this way.
> >=20
> > I have done those kind of things lot of time without any problem.
> > But that day 'the_project' happened to be a submodule cloned by
> > 'git submodule update' then on the USB key the $GIT_DIR of 'the_project=
'
> > was missing.
> >=20
> > If 'man git-submodule' have made me aware of the particularities of sub=
modules
> > clone I had write in a terminal:
> >=20
> > git clone the_project /media/usb/the_project
> >=20
> > Or at least I had understand what happened quicker.
> >=20
> > I have nothing against also adding something in repository-layout but I=
 am
> > pretty sure normal users never read repository-layout as it is not a co=
mmand
> > they use. And it is not mentioned in most tutorials.
>=20
> How about something like this:
>=20
> "The git directory of a submodule lives inside the git directory of the p=
arent repository instead of within the working directory."
>=20
> I'm not sure where to put it, though.
>=20
>  - Andrew Keller
>=20

'git directory' seems ambiguous to me. Maybe we could use 'git metadata'.



--=-wrDJf7BlRpy8m3F1+sEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMdbzoACgkQkKuHPdwEGdQVbQD+PjxBI41KYrC2sLbkT2PjloMg
E3AIj9PtvjNX1AuAoDgA/Rzi53Tt/2WApkRgb7DBh2XWcV7Bxp9lMi/MfGIG9f+C
=tF5Z
-----END PGP SIGNATURE-----

--=-wrDJf7BlRpy8m3F1+sEN--
