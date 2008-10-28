From: Arne Babenhauserheide <arne_bab@web.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Tue, 28 Oct 2008 20:11:36 +0100
Message-ID: <200810282011.40647.arne_bab@web.de>
References: <ge0rla$mce$1@ger.gmane.org> <200810272230.51683.arne_bab@web.de> <4907506C.8090609@op5.se>
Reply-To: "Arne Babenhauserheide" <arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1626624.ycJZ4qY5Yc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com, SLONIK.AZ@gmail.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:13:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kutzx-0001LO-AC
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 20:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYJ1TLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 15:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbYJ1TLq
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 15:11:46 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54557 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYJ1TLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 15:11:46 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 59C2AF32CE6C;
	Tue, 28 Oct 2008 20:11:44 +0100 (CET)
Received: from [217.227.97.143] (helo=fluss.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1Kutyh-0007D1-00; Tue, 28 Oct 2008 20:11:43 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.25-gentoo-r7; KDE/4.1.1; x86_64; ; )
In-Reply-To: <4907506C.8090609@op5.se>
X-Sender: arne_bab@web.de
X-Provags-ID: V01U2FsdGVkX19zut8E4vJUcripJVpx0SMQcl2tK9yzWjQD80Zq
	eaMwlNPVK4IZrqxq4LG6+ESkAuoYr56W6Ee2DvypPkBlT7V9W0
	WC4pmzIsM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99311>

--nextPart1626624.ycJZ4qY5Yc
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 28 Oktober 2008 18:48:28 schrieb Andreas Ericsson:
> > Stuff which does command line parsing can naturally break when I change
> > the output. But it can also directly use the advanced features.
>
> But then you're back with a single language, taking valuable freedom
> away from the addon author.=20

Not really.=20

Extension authors just have to take care to keep their output compatible.=20

You can do command line parsing just like with git, but additionally you ca=
n=20
change the workings of the basic commands, but then you have to take care t=
o=20
keep the output compatible.=20

=46or example when I wrote the group extension, I made sure that the log on=
ly=20
gives grouped output, when it is explicitely asked to do so, either via=20
=2D-group or via the grouped_log=3DTrue setting in .hgrc.=20

> How many perl gurus have skipped writing
> stuff for hg because it's a "python-or-bust" thing?

How many Python people decided to write an extension for hg, because it can=
=20
very nicely be accessed via Python?=20

(and which one of these has the higher effect? :) )

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

--nextPart1626624.ycJZ4qY5Yc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkHY+wACgkQMwdGm/6WxAQp4ACbBivMwnn+ZHcbOvv7PHqfUSnn
XN0An06tWyJdMbBSQ+HHb0Aj5n+u9yrI
=kStY
-----END PGP SIGNATURE-----

--nextPart1626624.ycJZ4qY5Yc--
