From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a
 separate gitdirs.
Date: Mon, 10 Mar 2014 19:22:13 +0100
Message-ID: <1394475733.7891.53.camel@Naugrim>
References: <1394178834.7891.38.camel@Naugrim>
	 <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
	 <1394231714.7891.39.camel@Naugrim>
	 <xmqqvbvpshqn.fsf@gitster.dls.corp.google.com>
	 <1394239852.7891.40.camel@Naugrim>
	 <B2A4F350-1F20-4ABA-80A6-CF244DD7FAFD@kellerfarm.com>
	 <xmqq61nmrrxe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-pHSztPuDfRKdvb9+tTt7"
Cc: Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 19:22:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN4qM-0002Fm-RG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaCJSWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:22:25 -0400
Received: from smtpout4.laposte.net ([193.253.67.229]:53885 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaCJSWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:22:24 -0400
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8507-out with ME
	id buND1n0092iaXuy03uNEBf; Mon, 10 Mar 2014 19:22:20 +0100
In-Reply-To: <xmqq61nmrrxe.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243784>


--=-pHSztPuDfRKdvb9+tTt7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 10 mars 2014 =C3=A0 08:31 -0700, Junio C Hamano a =C3=A9crit :
> Andrew Keller <andrew@kellerfarm.com> writes:
>=20
> > On Mar 7, 2014, at 7:50 PM, Henri GEIST wrote:
> > ...
> >> To give one of my project to someone else I have copied it on a USB ke=
y.
> >> By a simple drag and drop with the mouse.
> >> And I am quite sure I am not alone doing this way.
> >>=20
> >> I have done those kind of things lot of time without any problem.
> >> But that day 'the_project' happened to be a submodule cloned by
> >> 'git submodule update' then on the USB key the $GIT_DIR of 'the_projec=
t'
> >> was missing.
> >>=20
> >> If 'man git-submodule' have made me aware of the particularities of su=
bmodules
> >> clone I had write in a terminal:
> >>=20
> >> git clone the_project /media/usb/the_project
> >>=20
> >> Or at least I had understand what happened quicker.
> >>=20
> >> I have nothing against also adding something in repository-layout but =
I am
> >> pretty sure normal users never read repository-layout as it is not a c=
ommand
> >> they use. And it is not mentioned in most tutorials.
> >
> > How about something like this:
> >
> > "The git directory of a submodule lives inside the git directory of the=
 parent repository instead of within the working directory."
> >
> > I'm not sure where to put it, though.
>=20
> This is not limited to submodules.  There are multiple lower-level
> mechanisms for a $path/.git to borrow the repository data from
> elsewhere outside of $path and a cloned submodule uses only one of
> them.  For any such $path, "cp -R $path $otherplace" will result in
> an "$otherplace" that does not work as a Git repository in exactly
> the same way, whether it happens to be a submodule checkout or not.
>=20
> That is why I suggested to enhance description on a more general
> part of the documentation that covers what a Git repository is.

You are entirely right.
My view of the situation was biased by the fact that submodule cloning
is the only case I am aware of except when the user manually type
'--separate-git-dir' where this problem could occur.

If there is some other situation where this can occur as a side effect
of a git command it can be good to have the user aware of the list or
at least inform them in general case a git repository cannot be copied
in a place every body will see.
Or place a note in the manpage of every git command which can have this
side effect.



--=-pHSztPuDfRKdvb9+tTt7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMeAtUACgkQkKuHPdwEGdQ5zQD6ApmJGmoI1WfjOOY5yPpMhwFn
23OF+Brb+c+FXcZaTdEBAI8scrxd/rj2kOuGsCEuGytM0oXYRx/9nLtl8ScwhNKs
=TnNe
-----END PGP SIGNATURE-----

--=-pHSztPuDfRKdvb9+tTt7--
