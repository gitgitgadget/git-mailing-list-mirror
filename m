From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Mon, 21 Apr 2014 21:04:43 -0700
Message-ID: <20140422040443.GC9243@odin.tremily.us>
References: <CAB=NE6U7zYurAXNvjkHmk12Qsp9rerr=JyMjrVHrab98h9_+gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MHoG8na4IvP3G3ze"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, Andreas Schwab <schwab@suse.de>,
	Jan Kara <jack@suse.cz>, Jeff King <peff@peff.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 06:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcRx1-0002a2-8m
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 06:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbaDVEEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 00:04:51 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:58581
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750723AbaDVEEs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 00:04:48 -0400
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id sryS1n0011ei1Bg5Fs4n3b; Tue, 22 Apr 2014 04:04:47 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta24.westchester.pa.mail.comcast.net with comcast
	id ss4l1n00C152l3L3ks4mSW; Tue, 22 Apr 2014 04:04:47 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 8AD2B1169213; Mon, 21 Apr 2014 21:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398139483; bh=UKYJNpvgjyJ70xDjwg1CHsdL9DVClVDKkBwlthxXIPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=pUt4wv4+NuArvhCvnAjPmAt8hrnkFi5ucduu0B3QeJJb38D9PfBR+X/CRNoo/aaod
	 NeX//ZR3qe0+afKQc0YAQ3gpAiHImW6wblJDij+xXf4mZd+a08tBulSn5lAMbpLyt+
	 DOstcVHc5yHWRmmtS+HLFV9RBT7IKyTWBXUWlI0c=
Content-Disposition: inline
In-Reply-To: <CAB=NE6U7zYurAXNvjkHmk12Qsp9rerr=JyMjrVHrab98h9_+gQ@mail.gmail.com>
 <20140417221619.GA697@sigill.intra.peff.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398139487;
	bh=UJ8Ld2YSJaFBLQ4V96zcrGKWc781Egw1Tg3gD5mlbfU=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=OfTfrcej6FurDXTmbvnJMxkBOa52C3c0Y9baQUK0hKPshXR4n8Bw+zlbM2A4+eWnQ
	 EPviDSET9nreQmjTc0iOmacxexMvBbG6nDPl0qMNGxEK2BuSUkb1+Xy+He2ZjwCqzB
	 5uWMaSOrK0QoaclGyclODhSPYrnFdYLYopyBuJcSRa0AVHO+0bjWAAYGgEJO5804lr
	 Bk0PiDCnPGznhp+BmbeRPqG2vqtFdaZC3FuAGhufAga2dtNS164uZeFzMG2Okqetcx
	 9smqbQ4dZ3hEkVsOe8NC557DZCrR6pOFgRyVIRYrCJHHrzeMkYMvut0quIL9O8reIR
	 xA16zCQGDMgyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246689>


--MHoG8na4IvP3G3ze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2014 at 05:38:34PM -0700, Luis R. Rodriguez wrote:
> [0] mcgrof@ergon ~/linux (git::master)$ git log c5905afb..v3.5| grep
> ^commit | wc -l
> 24878
> [1] mcgrof@ergon ~/linux (git::master)$ git log c5905afb..v3.4| grep
> ^commit | wc -l
> 13106
> [2] mcgrof@ergon ~/linux (git::master)$ git log c5905afb..v3.3| grep
> ^commit | wc -l
> 1360

=46rom gitrevisions(7), r1..r2 is =E2=80=9Ccommits that are reachable from =
r2
excluding those that are reachable from r1=E2=80=9D.  Using Peff's example:

On Thu, Apr 17, 2014 at 06:16:20PM -0400, Jeff King wrote:
>  ---A---B---C-----D---E---F (maint, v3.4)
>      \   \       /
>       \   ---G-----H---I (master, v4.0)
>        \       /  /
>         ------J---
>=20
> The fix is J, and it got merged up to maint at D, and to master at H.
> v4.0 does not contain v3.4. What's the best description of J?

J..v3.4 is going to include B, C, D, E and F.  However, the =E2=80=9Cdistan=
ce=E2=80=9D
used by =E2=80=98git describe=E2=80=99 uses the shortest path between the c=
ommits
(J-D-E-F), which doesn't care about development between A and D.

> The results for command [2] above however a bit surprising, I'd take a
> look but I should go back to look at other stuff, figured I'd at least
> bring it up now as it seems relevant.

Here's a simplified graph with d1-* tags for the v3.5-rc1~120^3~76^2
description and d2-* tags for the v3.4~479^2~9^2 description [1]:

  * f8f5701 (tag: v3.5-rc1) Linux 3.5-rc1
  * 912afc3 (tag: d1-F) Merge tag 'dm-3.5-changes-1' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/agk/linux-dm
  *   56edab3 (tag: d1-E) Merge branches 'perf-urgent-for-linus' and 'perf-=
core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
  |\ =20
  | * ab0cce5 (tag: d1-D) Revert "sched, perf: Use a single callback into t=
he scheduler"
  | * 26252ea (tag: d1-C-1, tag: d1-C) perf evlist: Show event attribute de=
tails
  | *   a385ec4 (tag: d1-C-64) Merge tag 'v3.4-rc2' into perf/core
  | |\
  | * \ 659c36f (tag: d1-C-65) Merge tag 'perf-core-for-mingo' of git://git=
=2Ekernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
  | |\ \
  | | * | 5a7ed29 (tag: d1-C-65-2) perf record: Use sw counter only if hw p=
mu is not detected
  * | |/  76e10d1 (tag: v3.4) Linux 3.4
  | |/| =20
  |/| | =20
  * |/ dd775ae (tag: v3.4-rc1) Linux 3.4-rc1
  |/| =20
  * |  c5bc437 Merge tag 'perf-core-for-mingo' of git://git.kernel.org/pub/=
scm/linux/kernel/git/acme/linux into perf/urgent
  |\| =20
  | * 9521d83 (tag: d1-C-66) Merge tag 'perf-core-for-mingo' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
  * |   9c2b957 (tag: d2-E) Merge branch 'perf-core-for-linus' of git://git=
=2Ekernel.org/pub/scm/linux/kernel/git/tip/tip
  |\ \ =20
  | |/ =20
  | * bea95c1 (tag: d2-D, tag: d1-C-67) Merge branch 'perf/hw-branch-sampli=
ng' into perf/core
  | * f9b4eeb (tag: d2-C, tag: d1-C-68) perf/x86: Prettify pmu config liter=
als
  | * a706d4f (tag: d2-B, tag: d1-C-76, tag: d1-B) Merge branch 'perf/jump-=
labels' into perf/core
  | * c5905af (tag: A) static keys: Introduce 'struct static_key', static_k=
ey_true()/false() and static_key_slow_[inc|dec]()
  * | c16fa4f (tag: v3.3) Linux 3.3
  |/ =20
  * dcd6c92 (tag: v3.3-rc1) Linux 3.3-rc1

This shows the v3.4-rc1 bypass from 9521d83 (d1-C-66) to 659c36f
(d1-C-65) which sets up the v3.5-rc1~120^3~76 description.  It also
shows the c5905afb..v3.3 commits on the branch from c5905af's fork
(between v3.3-rc1 and v3.3) and v3.3.

Cheers,
Trevor

[1]: The simplified graph is from:

  $ git tag A c5905afb
  $ git tag d1-B v3.5-rc1~120^3~76
  $ git tag d1-C v3.5-rc1~120^3~1
  $ git tag d1-D v3.5-rc1~120^3
  $ git tag d1-E v3.5-rc1~120
  $ git tag d1-F v3.5-rc1~1
  $ for x in $(seq 76); do git tag d1-C-$x v3.5-rc1~120^3~$x; done
  $ git tag d1-C-65-2 d1-C-65^2
  $ git tag d2-B v3.4~479^2~9
  $ git tag d2-C v3.4~479^2~1
  $ git tag d2-D v3.4~479^2
  $ git tag d2-E v3.4~479
  $ git tag -d sound-fixes sound-3.4 v3.3-rc{2,3,4,5,6,7} v3.4-rc{2,3,4,5,6=
,7}
  $ git log --graph --topo-order --oneline --decorate --simplify-by-decorat=
ion v3.5-rc1
  =E2=80=A6simplified graph=E2=80=A6
  $ git tag -d A d1-{B,C,D,E,F} d2-{B,C,D,E} d1-C-65-2=20
  $ for x in $(seq 76); do git tag -d d1-C-$x; done

With some additional tweaks to cull the d1-C-* bits we don't care
about and clear up the 659c36f (d1-C-65) merge.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--MHoG8na4IvP3G3ze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVepYAAoJEKKfehoaNkbtX8cP/1KkFegXhoGRYAlICam7P6H0
3myyNgEO9mude0XhIsr/JGXUXkh7M+oFtpiPsfsGS4L0vrG4bn6B3EYhzIY4WR+S
o1nDoR0yZ6B0KuZ1NXkdKgGnL3Ejst4q0xDPqsQ0ah5Iok/dB0EY5XgKbgu8RCBD
ykpPPoaySP8qphV14BabyC9yugs1r94vZljbO/qSkS2Su5td72fiKKdi36n/FNqV
86VDgsMAvi1oWT31O3HhGTPs2KK55pS34R27KTXARb8Umo1vKNa26IgKhrTVpXbQ
qwln4U2YJixgy2eTPoQ7G66LDzT36AHucTnXT7d5MHyFJYxZlC+BQ8umbssHV3Em
mBBSxec9Rs1ra2Lcubfm9p8EHboLh8q+pYl8iV4aZRULnUlG4UfPA9Eao0XX3jd4
iPglWLUZyB1uQAzWawZjkm1aQnweJpfDG/31yDDwHGhEQDPpeTVkqIYrWn7c6Lha
MxJGjmz0WAhLmmUWYFmfu6sAs/gygoVw1UXeSmnekybfYUZ1B9KDl/xeMzyFpc6+
9ariTHzdPJcGcLGF57ZTopOfYtTF+GzRviOmr8MZwGMb9rBKnZJY57o+Dk/qDept
jN3fnupobjD2cadx+oxwfroYPtpxLc0C8iPyTS4ih3oi0Bfd2mv7lTBnzgm4DNYf
z71TzlsQCyvN6KQfbBYn
=6R9u
-----END PGP SIGNATURE-----

--MHoG8na4IvP3G3ze--
