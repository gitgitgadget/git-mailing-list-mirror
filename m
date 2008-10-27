From: Arne Babenhauserheide <arne_bab@web.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 22:30:44 +0100
Message-ID: <200810272230.51683.arne_bab@web.de>
References: <ge0rla$mce$1@ger.gmane.org> <200810272149.13542.arne_bab@web.de> <20081027210716.GS2273@genesis.frugalware.org>
Reply-To: "Arne Babenhauserheide" <arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1632877.uyqaAl2XdW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com, SLONIK.AZ@gmail.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 22:32:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuZhN-0007m7-KH
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 22:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbYJ0VbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 17:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbYJ0VbR
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 17:31:17 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:45449 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYJ0VbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 17:31:16 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id A69EDF82E504;
	Mon, 27 Oct 2008 22:30:59 +0100 (CET)
Received: from [217.227.70.45] (helo=fluss.localnet)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KuZfv-0005z3-00; Mon, 27 Oct 2008 22:30:59 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.25-gentoo-r7; KDE/4.1.1; x86_64; ; )
In-Reply-To: <20081027210716.GS2273@genesis.frugalware.org>
X-Sender: arne_bab@web.de
X-Provags-ID: V01U2FsdGVkX18uxw/UuvWSA01oF+mrkVhp/KSdn9d8cGtNBfDP
	Iy3mnOKRte8p7tn9OrZwV3hJ6QYQuHBILLSVi1R1JKARD5Amw1
	r0ZWmQFVY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99267>

--nextPart1632877.uyqaAl2XdW
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 27 Oktober 2008 22:07:16 schrieb Miklos Vajna:
> You compare Python to C here, but did you realize that in git you can
> write your git command in any language you want? Of course it's
> recommended to do it in C/shell/perl if you want to get it included in
> git.git, but that's just a decision.

I was asked explicitely about the difference of writing a Mercurial extensi=
on=20
and of writing some addition for git in C, so I answered that.=20

> IIRC the main reason git aliases can't overwrite git commands is because
> that would break scripts relying on the output of existing git commands.
> Given that I install such an extension, won't my script break?

Since that "script" will likely be an extension which will use the core=20
function instead of the UI command, it won't break.=20

Stuff which does command line parsing can naturally break when I change the=
=20
output. But it can also directly use the advanced features.=20

> From a user's point of view, I think external git commands and such hg
> plugins are equal. The user instally the "foo"
> extension/command/plugin/whatever and gets the "git/hg foo" command.
[snip]
> Same for git, as long as it's written in a scripting language; you
> should include git-foo in PATH then you can use git foo.

Means git can provide additional commands and only has the limitation that =
I=20
can't overwrite the basic commands, right?=20

But we're slowly moving off topic, aside from "OK, git also has extensions =
=2D=20
they are called external commands".=20

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

--nextPart1632877.uyqaAl2XdW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkGMwsACgkQMwdGm/6WxATedQCg1mSt1aUFdhtBIpovVfXAZUDN
r/EAn14p6ZVdVU047Gi7KoJh/utxHY59
=+DNq
-----END PGP SIGNATURE-----

--nextPart1632877.uyqaAl2XdW--
