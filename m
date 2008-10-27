From: Arne Babenhauserheide <arne_bab@web.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 11:14:00 +0100
Message-ID: <200810271114.03406.arne_bab@web.de>
References: <ge0rla$mce$1@ger.gmane.org> <200810270850.09696.arne_bab@web.de> <200810271041.54511.jnareb@gmail.com>
Reply-To: "Arne Babenhauserheide" <arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14431692.rTk519YLxh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, SLONIK.AZ@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 11:15:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuP8H-0000am-Rn
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 11:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYJ0KOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 06:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYJ0KOR
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 06:14:17 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41569 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYJ0KOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 06:14:15 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 14AB0F30F122;
	Mon, 27 Oct 2008 11:14:14 +0100 (CET)
Received: from [217.227.70.45] (helo=fluss.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KuP6w-0002Lw-00; Mon, 27 Oct 2008 11:14:13 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.25-gentoo-r7; KDE/4.1.1; x86_64; ; )
In-Reply-To: <200810271041.54511.jnareb@gmail.com>
X-Sender: arne_bab@web.de
X-Provags-ID: V01U2FsdGVkX191HlgqY5lH4s+tCByIaCDA0LxUxYUTVXAEorwy
	uqYhj7+JjGaj8EkgNUVyIrijjCpvpfh3C78J1jgsSSoUDchOW0
	b/XInQ19E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99221>

--nextPart14431692.rTk519YLxh
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 27 Oktober 2008 10:41:53 schrieb Jakub Narebski:
> > If you tell a disk "give me files a, b, c, d, e, f (of the whole abc)",
> > it is faster then if you tell it "give me files a k p q s t", because t=
he
> > filesystem can easier optimize that call.
>
> I would expect _good_ filesystem to be able to optimize this call as
> well. As I said it looks like Mercurial and Git are optimized for
> different cases: Git relies on filesystem for caching, and optimizes
> for warm cache performance.

The problem is by which knowledge the filesystem should optimize this call=
=20
when it is storing the files in the first place.=20

> > relying on crontab which might not be available in all systems (I only
> > use GNU/Linux, but what about friends of mine who have to use Windows?)
>
> But that doesn't matter in the context of this discussion, which is
> DragonflyBSD; worse or better support for MS Windows doesn't matter
> here, does it?

It only matters, if some developers are forced to work on WIndows machines =
at=20
times.=20

> > But Mercurial normally works on standard filesystems, so this isn't the
> > case for normal operations.
>
> Mercurial implements transactions as a way to keeping operations atomic.
> So I don't know what you mean by "normally works on standard filesystem"
> here.

I just meant "databases are a bit off topic" :)=20

> > You could say, though, that git implements a very simple transaction
> > model: Keep all old data until it gets purged explicitely.
>
> Git just uses different way to keep operations atomic, different way
> of implementing transactions.

That's what I wanted to express.=20

> And probably requires transactions and locks for that. Git simply uses
> atomic write solution for atomic update of references.

Doesn't atomic write also need locks, though on a lower level (to ensure=20
atomicity)?=20

> Behind the scenes, at a lower level, Git does necessary delta resolving.
> Delta chains in packs have limited length (as they have in Mercurial).

So both do snapshots - they seem more and more similar to me :)=20

> The answer usually is: did you have this repository packed? I admit
> that it might be considered one of disadvantages of git, this having
> to do garbage collection from time to time... just like in C ;-)

I cloned from the official repositories.=20

I hope Linus had his repository packed :)=20

> Well, understanding "git checkout ." doesn't require understanding
> inner workings of git. Your friend was incorrect here. I'll agree
> though that it is a bit of quirk in UI[1] (but I use usually
> "git reset --hard" to reset to last committed state).

Damn - one more way how I could have archieved what I wanted... one more wa=
y I=20
didn't find.=20

> Just Google for "Worse is Better". But what I actually mean that Git
> feature set and UI has evolved from very bare-bones plumbing, adding
> features and UI _as needed_, instead of being designed according to
> what designer thought it was needed.

And that's how it feels to me.=20

A great testing ground, but it developed too many stumbling blocks which ke=
ep=20
me from trying things.=20

When I now use git, I only do the most basic operations: clone, pull, push,=
=20
add, commit, checkout. When anything else arises, I check if it is worth th=
e=20
risk of having to read up for hours - and since that wasn't the case for th=
e=20
last few months, I then just ignore the problem or ask someone else if he c=
an=20
fix it.=20

As a contrast, when I encounter a problem with Mercurial, I simply check th=
e=20
commands for a moment and then try to solve it, and normally I have what I=
=20
wanted within seconds to minutes.=20

Git instead bit me once too often.=20

I know that this isn't something which hits everyone and that it is=20
subjective, but since it hit me, I'm wary of git, because in my view it isn=
't=20
something for the majority of people - and you almost always have someone f=
rom=20
that "majority" in your project.=20

I don't want people getting afraid of solving their own problems, so I avoi=
d=20
systems which bite so often, that they create fear (for example of losing m=
uch=20
time on something which should be a side issue).=20


All in all it's a UI issue - while the git UI bit me quite often, the=20
Mercurial UI just works.=20

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

--nextPart14431692.rTk519YLxh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkFlGsACgkQMwdGm/6WxARUTACgl8RjxAd3inkignTEYxodLHS8
cC8An3GfHQdl2aw5gBjfXWVE2OEzL3zU
=DlJ2
-----END PGP SIGNATURE-----

--nextPart14431692.rTk519YLxh--
