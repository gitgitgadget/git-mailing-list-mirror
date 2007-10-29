From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: New features in gitk
Date: Mon, 29 Oct 2007 07:20:00 +0100
Message-ID: <20071029062000.GB4310@artemis.corp>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> <20071028183216.GA4310@artemis.corp> <18213.6055.235067.730640@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/WwmFnJnmDyWGHa4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImNz0-00005W-IE
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 07:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbXJ2GUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 02:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbXJ2GUE
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 02:20:04 -0400
Received: from pan.madism.org ([88.191.52.104]:58552 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbXJ2GUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 02:20:02 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1ADA227568;
	Mon, 29 Oct 2007 07:20:00 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2F2D2C326; Mon, 29 Oct 2007 07:20:00 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <18213.6055.235067.730640@cargo.ozlabs.ibm.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62600>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 28, 2007 at 11:13:43PM +0000, Paul Mackerras wrote:
> Pierre Habouzit writes:
>=20
> > As you seem to be the guy to ask for, I've a couple of requests wrt
> > gitk.
> >=20
> >   * the diff window is quite bad with merge commits, the colorization is
> >     rather poor, and the last version you just merged isn't especially
> >     better.
>=20
> That's not a request, that's a grizzle. :)  What would you like it to
> look like?

  I believe that git show/diff has it right: lines with a + should be in
the "added" color, and lines with a '-' in the "removed" one. gitk only
take the first "column" of +/- into account or sth I find awkward at
best, and I often go to the console to see a merge commit because of
that.

> >   * the 'sha1' input field is a major pain in the UI: the cut&paste
> >     interaction is very poor. I don't know why, but it's often very very
> >     hard to really copy the sha id, probably because it's selected by
> >     default.
>
> It's selected so that the contents are in the cut buffer and you can
> paste them in an xterm with middle-button.  Possibly I need to check
> that control-C (or command-C under macos) is properly bound to copy.

  Well, doing ^C doesn't always copy it (probably a glitch wrt which
input has the focus), and it certainly doesn't synchronize with the cut
buffer for me. And it doesn't work for anyone at work either. I use ion
with the KDE clipboard manager (klipper -- because I never managed to
find a clipboard manager that is as good yet, not depending upon KDE),
and at work most people use KDE, with the same klipper. Maybe it's a bad
interaction, I should try to use it under gnome or so to see if it is.

> >   * the fact that it remembers the position where it was in the WM when
> >     it was closed is really annoying. the WM is supposed to place the
> >     window. With at least ion3 and xinerama it often shows up on the
> >     wrong screen. Remembering the window size though is fine.
>=20
> That came in with some changes that make gitk start up correctly under
> windows.  I could see about making it set the window position only
> under windows.

  That'd be really great.

> >   * still wrt the layout, the focus is quite cumbersome. Gitk would be
> >     really really really nice to be used only from the keyboard, but
> >     because of a very unclear focus policy, it really isn't for me.
> >     Maybe it's just me, and I know this may not be 100% helpful, but I
> >     never know which part of gitk will receive my keys (history part,
> >     diff part, tree, ...).
>
> What focus policy would you like?

  Well, what would make sense (to _me_ at least) would be some shortcuts
to move to the history panel (say e.g. using F1), or to the diff view
(using e.g. F2), or in the file list (say F3).
  That would hilight with a black 1px line (like it does for other
inputs fields) to say that this is the primary window part that takes
the keyboard inputs atm. And when doing that, if you press 'down' or
'up' it would scroll the adequate panel. It's really confusing that the
keyboard (or hjkl) right now always make the history change.

  This way you can make the difference between the keyboard shortcuts
that apply to the focused part of the window (up/down, pgup/pgdown are
IMHO of that kind), and the one that the user (or the default gitk) has
associated to a specific part, no matter if it has the focus. E.g. J/K
(or for emacsish people ^N/^P) could always move the history, that would
make sense.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJXuQvGr7W6HudhwRAlThAJ0XoqHK+FoPZWjIebdwkNq/eJvDrACfd5fl
eH4nTNU8heau8KIiKqqWH4A=
=KESA
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
