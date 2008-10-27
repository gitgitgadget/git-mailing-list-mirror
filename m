From: Arne Babenhauserheide <arne_bab@web.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 21:48:50 +0100
Message-ID: <200810272149.13542.arne_bab@web.de>
References: <ge0rla$mce$1@ger.gmane.org> <200810271512.26352.arne_bab@web.de> <200810271901.48925.jnareb@gmail.com>
Reply-To: "Arne Babenhauserheide" <arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1436709.G6sfbUyaTi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com, SLONIK.AZ@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 21:50:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuZ2t-00074X-QM
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 21:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbYJ0UtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 16:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYJ0UtZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 16:49:25 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:36837 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbYJ0UtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 16:49:24 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3F968F530F67;
	Mon, 27 Oct 2008 21:49:23 +0100 (CET)
Received: from [217.227.70.45] (helo=fluss.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KuZ1e-0007sN-00; Mon, 27 Oct 2008 21:49:22 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.25-gentoo-r7; KDE/4.1.1; x86_64; ; )
In-Reply-To: <200810271901.48925.jnareb@gmail.com>
X-Sender: arne_bab@web.de
X-Provags-ID: V01U2FsdGVkX19GFzesirRdvg8lainfgiYhPOkSLihjLW4IMIxY
	08jQv06XrQi6X/cX2Iw7nVj2+gxISBJlyFB3sMxnbrT65oJM2o
	XZy1YJm10=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99265>

--nextPart1436709.G6sfbUyaTi
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 27 Oktober 2008 19:01:48 schrieb Jakub Narebski:
> AFAIK Git mostly follows BitKeeper UI; it is quite natural as it was
> meant as replacement for BitKeeper for Linux kernel development.

It is a great choice for an SCM intended for kernel development where every=
one=20
knows bitkeeper, but might not be optimal for other tasks.=20

> Besides is writing plugin in Python for Mercurial that much easier
> than writing new command or stuff in C for Git? Well, perhaps it is,
> as only recently there began to appear API documentation, and there
> were created utility mini-libraries like strbuf, or string_list,
> or parseopt.

Yes, for two main reasons:=20

1) Writing Python is much easier and quicker than writing C, especially whe=
n=20
you can just experiment with the Python interpreter (or better still: with=
=20
ipython). No memory management hassle, no strange compiler bugs, no stray=20
pointers. Just plain writing what you want to do. But if you need C speed, =
you=20
can still include parts written in C - where you really need it. For all ot=
her=20
cases you have more readable and far more compact code.=20

2) You can easily access every core function, and you can replace every=20
command.=20
You don't have to invent a "git foolog" command. Instead you can just adapt=
=20
the regular log to do a foolog which people can use via "hg log".=20

> Also often third-party projects or stuff in contrib gets incorporated
> into git proper; sometimes stuff is moved from git core to contrib,
> if there is no maintainer however (git-svnimport, git-p4import).
> Git repository has many roots: one from git core, one with gitk
> (graphical history viewer), one from what was git mail tools, one
> with gitweb (web interface), and one with git-gui (graphical commit
> tool).

Maybe I should include the extensions in the codeswarm to have matching=20
repositories.=20

> The extending via plugins idea used by Mercurial, so succesfull IMHO
> for Firefox, and I think quite successfull for ikiwiki for example, is
> not without drawbacks, especially that there is no plugins clearinghouse,
> and plugins are required for what is considered pretty required
> functionality, like bisect before hg 1.0.

But they can just be included in the core distibution once they become cent=
ral=20
enough.=20

It's a way of allowing people to add functionality they miss without forcin=
g=20
them to mess with core code instantly.=20

> See also blog post on vcscompare: "Plugins In Version Control"
> http://vcscompare.blogspot.com/2008/06/plugins-in-version-cotnrol.html

I just read it, and it didn't convince me, because in my opinion a VCS has=
=20
certain core functions which it should provide to everyone, and other=20
functionality which only certain people need.=20

=46or example I normally don't need rebasing, mercurial queues, transplanti=
ng=20
and similar. Why should my tool include the commands by default?=20

The defaults should be the most common way to use the tool, so people can=20
easily learn it.=20

Advanced stuff can be added with extensions.=20

And because the most used plugins are distributed with Mercurial, I can als=
o=20
activate them when I don't control the Mercurial installation - and should=
=20
something be missing which I need, I can just download and activate a plugi=
n=20
without having to compile anything, since they are simply Python modules.=20

Just set=20
[extensions]
foo =3D /blah/foo.py

in ~/.hgrc and the foo plugin is active.=20

Gits missing plugin system might just be a reason, why its usability still=
=20
suffers from many problems: They have to do everything for everyone all the=
=20
time, so the chances are high, that they won't do it really good for anyone=
=20
(but the main git coders).=20

Best wishes,=20
Arne

=2D- My stuff: http://draketo.de - stories, songs, poems, programs and stuf=
f :)
=2D- Infinite Hands: http://infinite-hands.draketo.de - singing a part of t=
he=20
history of free software.
=2D- Ein W=FCrfel System: http://1w6.org - einfach saubere (Rollenspiel-) R=
egeln.

=2D- PGP/GnuPG: http://draketo.de/inhalt/ich/pubkey.txt

--nextPart1436709.G6sfbUyaTi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkGKUkACgkQMwdGm/6WxAS7HACgyOuloXST5jQBr9FWbTdn+JBP
vFwAoJST9CmOlWY8Hn9BklSCMtThTyzf
=zXN+
-----END PGP SIGNATURE-----

--nextPart1436709.G6sfbUyaTi--
