From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 18:12:09 -0600
Message-ID: <200812301812.12759.bss@iguanasuicide.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D33@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2908534.RfjALuUWof";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 01:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHoi7-0003sx-T2
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 01:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbYLaALx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 19:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYLaALu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 19:11:50 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:35353 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYLaALs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 19:11:48 -0500
Received: from [206.104.161.8]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHogd-0005Lt-I7; Wed, 31 Dec 2008 00:11:47 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D33@ALTMORE-SVR.altmore.local>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104231>

--nextPart2908534.RfjALuUWof
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 December 30 16:55:38 Conor Rafferty wrote:
> Whoa there Stevey, I'm a windows user, don't forget

I just assumed you were also a git user. ;)

> However if this is what its gonna take to get what I want, then Im'
> outta here.

You aren't being entirely clear about what you want.

> Getting a snapshot on the filesystem, in terms of a directory tree (not
> a reference to, representation of etc etc. but a real life directory
> tree, files and folders that you can actually interact with - build,
> edit etc.), of a past version is a basic operation in my book.
> Even in clearcase this was a cinch.

Well, there's a lot of things about UNIX and Windows directories that git=20
doesn't store.  It'll restore the contents, sure, but not the permissions,=
=20
timestamps, etc.  However git also stores the *history*, if you don't care=
=20
about that, tarballs or zip archives might actually be a better system for=
=20
your purposes.

But, each time you commit you've made some snapshot (completeness depends o=
n=20
what you staged with git add and friends) and recorded that snapshot as=20
a "later point in time" from the last snapshot you "git checkout"ed.  That=
=20
new object (a "commit") can be identified by it's sha1.  It holds a sha1 of=
=20
all it's parents (also "commits") and of the snapshot alone (a "tree").

You've also figured out how to use lightweight tags to give names (other th=
an=20
their sha1) to your commits.

> Is there anyone who can see anyway to do this simply, without a script,
> without creating a branch ?

Branching is arguably easier than tagging, and probably what you want to do=
=20
instead.  Sure, branches are mutable, but unsigned tags are also fairly=20
mutable.

> Personally I suspect "$ git checkout <version> ." is what should be
> doing this.

I'm pretty sure what you want is "git checkout <version>" not "git checkout=
=20
<version> <paths>".  They operate differently.  Modern git can checkout a=20
lightweight tag, but it's going to warn you that it not what you want.

> - but if you want ppl out there in the user world to take this stuff on,
> its gotta work for them

Maybe others do, but I don't really see git as an end-user tool.  It's a=20
developer tool and rightly demands a bit of RTFMing before using it=20
effectively.

What you seem to *really* want is a bunch of named trees without any=20
relationship between one another.  IMHO, git isn't really good at that (but=
=20
only because it demands to do more).  A directory full of tarballs /=20
zip-archives and a couple of scripts you wrote yourself (extract.sh;=20
name-and-save.sh) would probably be better.

I admit that there seems to be quite a niche for some sort of trivially usa=
ble=20
VCS, but it needs to be good at merging spreadsheets, compressed/binary XML=
,=20
presentations/decks, and other things not-text, have a pretty GUI, and run=
=20
securely over TCP/IP ports that no one is willing to block.  It will probab=
ly=20
be next to useless for doing what git was initially designed for (managing=
=20
Linux kernel patches).
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2908534.RfjALuUWof
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklauNwACgkQdNbfk+86fC3ydgCeP7una4nym4+T3miKngRCsMZ/
56cAn3F40AYb3AMB6yyp4/ZJ/tjm8eNF
=Wwwg
-----END PGP SIGNATURE-----

--nextPart2908534.RfjALuUWof--
