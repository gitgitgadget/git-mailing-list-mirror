From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: New features in gitk
Date: Sun, 28 Oct 2007 19:32:16 +0100
Message-ID: <20071028183216.GA4310@artemis.corp>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J2SCkAp4GZ/dPZZf";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 19:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCw4-0003GH-Tw
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 19:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXJ1ScU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 14:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbXJ1ScU
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 14:32:20 -0400
Received: from pan.madism.org ([88.191.52.104]:34682 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbXJ1ScT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 14:32:19 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7250827497;
	Sun, 28 Oct 2007 19:32:17 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 355081638C; Sun, 28 Oct 2007 19:32:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62588>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On dim, oct 28, 2007 at 01:39:34 +0000, Paul Mackerras wrote:
> I just pulled the dev branch of gitk into the master branch, so the
> master branch now has the new features and improvements that I have
> been working on, namely: [...]

As you seem to be the guy to ask for, I've a couple of requests wrt
gitk.

  * the diff window is quite bad with merge commits, the colorization is
    rather poor, and the last version you just merged isn't especially
    better.

  * the 'sha1' input field is a major pain in the UI: the cut&paste
    interaction is very poor. I don't know why, but it's often very very
    hard to really copy the sha id, probably because it's selected by
    default.

  * hjkl in the history list do very very very curious things, whereas I
    would expect j/k to do the same as (resp) down/up. Note that in
    [Help->Key bindings] it's said it should work that way, but it
    doesn't here at least. A way to customize bindings would be much
    appreciated (I like vi bindings, and I miss ^U/^D, and ^E/^Y e.g.).

  * I really really really miss an option to ignore whitespaces in
    diffs, a small checkbox to view the full blown diff, or the one
    without spaces changes (-w -b) would be _really_ great.

  * the fact that it remembers the position where it was in the WM when
    it was closed is really annoying. the WM is supposed to place the
    window. With at least ion3 and xinerama it often shows up on the
    wrong screen. Remembering the window size though is fine.

  * wrt the layout, when the gitk window is resized, the resizing of the
    three columns (subjects, commiter, date) is really cumbersome. I
    would expect that the subject one would be the sole one to be
    resized.

  * still wrt the layout, the focus is quite cumbersome. Gitk would be
    really really really nice to be used only from the keyboard, but
    because of a very unclear focus policy, it really isn't for me.
    Maybe it's just me, and I know this may not be 100% helpful, but I
    never know which part of gitk will receive my keys (history part,
    diff part, tree, ...).

  * in the diff [lines of context] input, if you hit "down" it
    decrements the number of lines which is okay, but _also_ moves the
    selected history line which is not.


  This list may sound harsh, I hope not, I love gitk, it's one of the
10 git commands I use the most.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJNWwvGr7W6HudhwRAoSgAKCl3DkH0s1UtAzXi4CvGL/Om1PqQQCff18B
nOQ8w+f7uzYASYHIU1GDGT4=
=sjDq
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
