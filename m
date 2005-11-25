From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 22:28:46 +0100
Message-ID: <20051125212846.GB5434@schottelius.org>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org> <43866EDA.9050203@michonline.com> <20051125103048.GB30691@schottelius.org> <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Cc: Ryan Anderson <ryan@michonline.com>, Git ML <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 25 22:29:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efl7o-0005x6-5y
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 22:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKYV2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 16:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVKYV2u
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 16:28:50 -0500
Received: from wg.technophil.ch ([213.189.149.230]:20704 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750828AbVKYV2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 16:28:49 -0500
Received: (qmail 27899 invoked by uid 1000); 25 Nov 2005 21:28:46 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12750>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good evening,


Linus Torvalds [Fri, Nov 25, 2005 at 11:12:00AM -0800]:
>   Nico gave me private access to the tree, so I quickly cloned it and=20
> started bisecting it to figure out where the problem was. I haven't looke=
d=20
> at the source code, and all the commit messages seem to be in German=20
> (which I can kind of understand if I work at it, but not very well), but=
=20
> it definitely turns out none of that matters.

Well, there's still a broken username, but that's our problem with
iso8859-1 in passwd.

> The problem is a bad merge. And in fact, that merge lost _more_ than just=
=20
> the three files under Code/Spikes/Statistik/, it also lost a file called=
=20
> Code/lw1/Client/Pics/icon/lw1-icon.png.

Good to know, we didn't that we lost it until now :)

> Pasky - do you know of any historical cogito problems like this?

For information:

[22:07] srsyg03:packages% ls -l /usr/packages=20
insgesamt 28
drwxr-xr-x  4 root root 4096 Nov 10 15:52 cogito-/
drwxr-xr-x  4 root root 4096 Okt 14 15:15 cogito-0.15/
drwxr-xr-x  4 root root 4096 Nov 23 13:31 cogito-73874dddeec2d0a8e5cd343eec=
762d98314def63/
drwxr-xr-x  4 root root 4096 Okt 14 15:15 cvsps-2.1/
drwxr-xr-x  4 root root 4096 Nov 10 15:52 git-/
drwxr-xr-x  4 root root 4096 Okt 17 14:09 git-20051016.git/
drwxr-xr-x  4 root root 4096 Nov 23 13:31 git-c61642185d411e5e3350566a68483=
e358ca392b9/

At the time of 2005-11-17 we'll have used a cogito and git version,
which was from 2005-11-10.

> [...]=20
> So I do not see how that bad commit happened, especially since it's even=
=20
> a fairly recent commit (the date of the merge is 2005-11-17).
>=20
> I wonder if there's a really old and broken version of cogito somewhere=
=20
> around. If so, it's on "srsyg03".

Above you see the versions of which were/are installed. I always
link the latest binaries to /usr/local/bin/, so our developers do not
need to care about what version we have.

> (And the two commits that needed manual merging _look_ fine. No lost file=
s=20
> at least, except for one of the merges losing "bitte_bitte_loesch_mich",=
=20
> which judging by it's name _should_ be lost ;)

Those were some lessons in our house. Our developers had to test
if everything works, including deleting :)

> Finally: Nico, I've deleted the trees on my machine, and you can remove m=
y=20
> ssh key. I don't think I can tell you anything more.

Ok. Thanks for your help! I think we'll add those four files
back to git on monday and continue to work with them.

Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ4eCDbOTBMvCUbrlAQLAcQ//SvTWMeSWSEc/H1LDffzHY5p/cD7rvX38
sa+GbIFdRjS7F/GpD0RWakkbFchnP2o2oluoBF3RpCYGcDBx3JoeaB+8aIq+iKu1
P0la7P/ftoeQm0juPV1u0G6e38Fjf6PVn9FXVAHps2P1EhZVT9L6l36pPY/etF+7
eBVDStjeD3729uSN/5wRZRwk9MqQ7UJGI6An2UDe/zQDPIhJopyDKarhvdKTfSII
UrOPv9DpYFRCqt53GxG/x4Xfb+kSYnzqWL0+YYeHiIA6Tg1nqkbI41z5Ukpqa93q
PVHsDQNMgqYQjs3AM452fOd5+UggGkmVTn8XeK7FDDP9i/6kR35+swboMceYolC1
2keiMh4n59h7xnZQAVKOGyPkXM8bhKFROxK0C7wf/40zSGxMQAbyxqvCfspot3Ln
/kjpgZ/sagMmRZVuxtwGRVahacSIVkiFb4GioNmeq7LXjjayVHITQ+va7BlRVI1b
RX9B4GuM4USq37L+aBwfLwLDz4mVYt2LhmHN+2Tv6MvrMvPZZ1mM5/dnEZYHXtlG
s30NxMzZuj3M92uBdqzsonmObnMBHCdNJi/+i/oJQ4MNL8Vd75/cBZe+eZQl68Wh
dfNFRfFio78pkvjyGkmEMrsJNhIERqhbyRbmtLJ4GaUl/+m92YaXsiJI1CsXHTyI
KDq4JnmMEVw=
=PQ5t
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
