From: Christian Dietrich <stettberger@dokucode.de>
Subject: Re: [ANNOUNCE] metagit 0.1.2
Date: Fri, 08 Oct 2010 20:04:14 +0200
Message-ID: <8639sgef35.fsf@peer.zerties.org>
References: <86k4lteow6.fsf@peer.zerties.org>
	<201010081207.20617.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 20:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4HJH-0001aV-PE
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 20:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310Ab0JHSEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 14:04:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:58193 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932520Ab0JHSEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 14:04:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P4HIx-0001Uv-L1
	for git@vger.kernel.org; Fri, 08 Oct 2010 20:04:27 +0200
Received: from peer.zerties.org ([188.40.33.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 20:04:27 +0200
Received: from stettberger by peer.zerties.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 20:04:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: peer.zerties.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:fc9jLRNZg5sWxmjwIpknYL232nw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158518>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Koch <thomas@koch.ro> writes:

> Would you mind comparing your project with
> http://kitenet.net/~joey/code/mr/ ?

I didn't know mr, when i started hacking metagit (which was based on an
Idea mit mschilli in the German Linux Magazin). My focus was always,
that i can run the same config on all of my machines, because I tend to
have all my documents in single git repos (e.g. every course at
university is a git repo).

To make this happen, i needed to define some modules that list me all my
repositories on the server where my university stuff is. But i didn't
want to see my uni stuff at work, so i needed policies where the repos
should come up. As i see these features aren't implemented directly in
mr.

For my work, where svn with svn:externals is used, I implemented the
svn:externals support, where all the externals are cloned
recursivly. (You can even define if a given command is executed on the
externals or not). This is also a feature mr doesn't have.

And there is the simple, but useful metagit cd, which echos a cd command
to a repository path. So with the bash function

mm () {
        $(metagit cd $@)
}

I can simply jump to the metagit repo with `mm meta', where ever it was put.

On the other hand metagit doesn't implement recording of actions if
you're offline. And of course the most important point that metagit is
worse than mr is, as already mentioned, that it is written in python and
not in perl.=20

greetz didi
=2D-=20
(=CE=BB x . x x) (=CE=BB x . x x) -- See how beatiful the lambda is
No documentation is better than bad documentation
=2D- Das Ausdrucken dieser Mail wird urheberrechtlich verfolgt.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJMr10eAAoJEBQksfbRvb+a0BMQAKC5vkBa8Ocai/x1nMJ4UTl4
2TYyOnAEFmwFpLGAq7blxZ/gOwqpoT3BLDeR9mVBch1u2VtEe1ZXkDqN+rKV/9y9
lKoyRnHsau9p7eEYdJmPewSG/Sqoo0/RUKI5WgJ5E4fI4vQg9nyo3TrFOoip4IA3
jWsM8du3/P9AI1O1oDmzraVK3601JpFGR0mkkE6pQZ5heTMkorAiBy/fORrZiA5n
OpNr33w4MdQnh+f2WEbj79i3HQraY/fwUBkmzS/3E0FPTQetixH7c9ljjYe8+aWh
o4EGrqN/UaXV5JBQM4yoR4LUsvKf1udrqOegi+FCogO9TEaEG+VL2hOd0DLjpNdt
lClxs5uvxwGpqhqFslOQZj1HWTrGvQTuAFIJYwBAQp6SmI3iz348mMmJUtrLIFsM
rBlqkPH3aog9MIyLnkD6Eo7Z/iEBESBEU7oeShfPf5lFxFWlJ73ztPk31v8wPchx
yErYoZrDvnbBgp5VBSwAwGtZ039X52XKmVqHtfgs/GVB2Am2SrLlEsTs3E9E+khw
ZPDy8VyP4nwW/Df5bQTm2rNRZtKiXL+eGdtO7WOAb4/xI5p37qwKhcKznyKHIOnA
cQowiN4HvjIpTBjRY+MEHtSym2HQ7GbBv1FEBynNE/8dRpUgfNr27bt80Ooqy6ey
hu6c2hhUnPf9LibxqNJb
=5rO9
-----END PGP SIGNATURE-----
--=-=-=--
