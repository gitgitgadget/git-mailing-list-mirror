From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 18:12:11 +0100
Message-ID: <45BB87EB.7010200@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BB5888.9020608@fs.ei.tum.de> <Pine.LNX.4.63.0701271728020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C0DBB811837C5EDAEC9715E"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAr6I-0005eS-Bm
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXA0RMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbXA0RMS
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:12:18 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:58494 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbXA0RMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:12:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id D62AE28146;
	Sat, 27 Jan 2007 18:12:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vkV2ttlQFwxl; Sat, 27 Jan 2007 18:12:15 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 287612807D;
	Sat, 27 Jan 2007 18:12:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <Pine.LNX.4.63.0701271728020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37964>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C0DBB811837C5EDAEC9715E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> Ah, I think you fall in the "files matter" trap.
>=20
> My point is: for what git does it does not need information which might=
 or=20
> might not be present, but it derives that information which was there f=
rom=20
> the beginning: the ancestry path.
>=20
> Many people don't use or even need blame. And what you want to introduc=
e=20
> would affect them, too.

Many people do not use colored diffs.  Introducing colored diff support a=
ffects them, too.  In which way?  Additional command line switches, for e=
xample.  I don't think that's a big deal, and neither is a reverse map to=
 create object-level DAGs.

> That is why I proposed a cache (of precomputed data): you don't have to=
=20
> change _anything_ in the file format, but you can speed the processes u=
p=20
> -- locally! -- if they matter to you.
>=20
> Which means it works on old repositories, too.

Maybe I was not clear enough.  I do not propose to change the file format=
, but to extend the information stored.  In which way whatsoever.  Howeve=
r I think that keeping this information along with trees in pack files se=
ems very sensible.  Or along pack files, whatever.

>> It might be sufficient for git.git, but certainly not for projects wit=
h=20
>> a long history.  we are talking KDE, FreeBSD, OOo, something like this=
=2E =20
>> They each got about 400k commits.  It takes literally *minutes* to get=
 a=20
>> rev-list or a blame for a certain path.  The algorithm simply does not=
=20
>> scale.  And this has nothing to do with superior output, because hg do=
es=20
>> it in O(num_of_file_revs), so it *can* be done.
>=20
> But can hg do it that fast, if you track code _movement_ between files?=
 I=20
> doubt so.
>=20
> I don't know if git can, at the moment, but even if it cannot, in futur=
e=20
> versions this may well be possible, exactly because we do _not_ rely on=
=20
> metadata to be stored in the objects, which can be derived from the=20
> history as-is anyway.

Please don't take the mentioning of hg as an attack on git.  You don't ha=
ve to shoot back.  It was just to illustrate that this information can be=
 used to speed up certain operations considerably.  Besides, I don't thin=
k that hg's repo format prevents it to do things which git can do.  Just =
some things might be less elegant or easy.

> The important part is that you should not change the file format when y=
ou=20
> do not have to.

Do doubt.  Especially not in a way which breaks backwards compatibility.

> Rather, calculate the information you need from the existing data, and =
if=20
> you can reuse it, store it locally. _That_ is flexibility.

Of course this is flexibility.  But this also means that every consumer h=
as to do this for every repo.  Wouldn't it be nice to have it done one ti=
me and then stored in a pack?

> It also gives me a warm fuzzy feeling that no bogus "auxillary=20
> information" can be introduced by fetching from somewhere else. (It doe=
s=20
> not matter if intended or unintended.)

I agree on that.

> And if something is wrong with that "auxillary information", it can be =

> regenerated correctly, without touching the real data -- the commit=20
> ancestry.

Yes, it always can be regenerated.  I never said it should be made part o=
f the core structure.

>>> Besides, we already introduced an orthogonal historisation by reflogs=
,=20
>>> and your method would not cope gracefully with that, would it?
>> I don't see how reflogs can play into this.  After all we're talking=20
>> about the series of commits the blob experienced to get into its curre=
nt=20
>> state, not the series of actions it took this repo to contain this blo=
b.
> My point was that you want to introduce a reverse mapping onto the hist=
ory=20
> DAG. But this claims that there is only one history you can possibly lo=
ok=20
> at. This assumption is wrong.

Then you are reading it wrong.  It is just a way to speed up the common w=
ay of operation.  That doesn't mean that other ways stop working.  git-re=
v-list does one thing and you wouldn't call it not being gracefull, just =
because it doesn't operate on reflogs?

> It can make a lot of sense to git-blame a change on a pull, maybe becau=
se=20
> you don't want to fix it yourself, but throw it all back to the lieutna=
nt=20
> whom you pulled that part from.
>=20
> You could find that pull (in theory; I don't think it works right now) =

> with git-blame walking the _reflogs_ instead of the _commit history_.

Fair enough.  Nobody said that this wouldn't work anymore.  I just said t=
hat working on commit history could be sped up considerably.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig0C0DBB811837C5EDAEC9715E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFu4fur5S+dk6z85oRAmy4AJoDIFP0NnxXl0VJdCUemtv0o2XbrgCg2kXR
2q8F/4Ai9C38wC4X6gu0+QI=
=9HDo
-----END PGP SIGNATURE-----

--------------enig0C0DBB811837C5EDAEC9715E--
