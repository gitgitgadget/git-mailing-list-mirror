From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] perf: make the tests work in worktrees
Date: Mon, 30 May 2016 10:28:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605301026430.4449@virtualbox>
References: <cover.1462955446.git.johannes.schindelin@gmx.de> <cover.1463145936.git.johannes.schindelin@gmx.de> <0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de> <574B1C3D.3000706@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1219177588-1464596890=:4449"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon May 30 10:45:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7IpL-00021O-Pu
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 10:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbcE3Ipc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 04:45:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:63807 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141AbcE3Ipb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 04:45:31 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MPYqL-1bBPQe0b69-004m4N; Mon, 30 May 2016 10:45:21
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <574B1C3D.3000706@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9kRpC5eKybcv5RMB/n/dj6NdB2cWrhw84PRzjttxljVdgkfU4t6
 YocBBykd6E2DZMyBokTwhJOmRxcIqWwt/lL8stwXScpeB9XkvMJcQxThPs8Ko5IKyY0vZnQ
 I17H6W2yrPDkUE1CKsngVUb59kQPeotLGMkI21t7b/Ct/eVwJ/NrhqtyPigCyDVMV5Utitf
 D3C1LcqLCCeEdD86lFpXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UE7dVwKaPMs=:WsUk2Vg9GxM+jlLSCRawNk
 3eD2SkTerAjDw6wzCXhK0QSNNrcI3ScEiNXKQAw23zF1nIYafTz1XHj0kcjzUwX/ddlltWMB9
 7Gby6Ki9KcNM7QsyX74p49muz7Qd5biF3ICCFHUWMQzVWOHG3cK7o7EDAD3YMedr07QEArRoS
 esib2zX02iVO7OhcYW+vqFO0mDGA6gHpRtOHWORQJKON8dZpcnOwrtZ7StEKpK9CWROGDtchm
 YBBA4MmERwwj89voQlKqJvsZsZ3K58IOnoX6QrpJOT3VSSzjNY+kyjv8uScT8RPJ7MUpb+3VS
 bS6HvcKto23g/4rdKimrlWcoUhxNrUnHvIT9Tc6aiH7kWC1Ue6oCht0ZHd3O/jDLKHIFBU8hw
 qeAydm0FEjffRPYgxI7EslQVl4ggrQTFkMJUZsuUsB2Q4lmSUZl9enQG86poHeCbMN9hHOI+b
 18MV6DxZUWLj6njaKssAbNvP+KJG6957QJ2ftQfzTu1KmC2J3wBbJ3w+jyEdJYoGebtIM9a4x
 H0+VDKXP5YAV15TWzpu3mWqosf/WemIxlxHudubGi6gBPSmqfO9chq5pk9/l5SWxPE8sMOHZi
 t3OF4ZIjBwCQx9ZwvMqN5y1HewgQ5rFjro0D4PMAJUE9uyfYcg5cEe4oqSHTVO+O+jQdC/8es
 T19ItPNRUvtDxSojUg+pOL6dNSo41A2UCaI/Ci2YyNHLtZJXjbJmI5N/6CqXJWcTbttCm7sfn
 3c8asQ+e2vCeGxsijNuvrN5+TUdpLr5GIz1Ar0BYgbb57NFndP3ldYenxR+wsRKz1aiQv5Rz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295871>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1219177588-1464596890=:4449
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sun, 29 May 2016, Ren=C3=A9 Scharfe wrote:

> Am 13.05.2016 um 15:25 schrieb Johannes Schindelin:
> > This patch makes perf-lib.sh more robust so that it can run correctly
> > even inside a worktree. For example, it assumed that $GIT_DIR/objects i=
s
> > the objects directory (which is not the case for worktrees) and it used
> > the commondir file verbatim, even if it contained a relative path.
> >=20
> > Furthermore, the setup code expected `git rev-parse --git-dir` to spit
> > out a relative path, which is also not true for worktrees. Let's just
> > change the code to accept both relative and absolute paths, by avoiding
> > the `cd` into the copied working directory.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   t/perf/perf-lib.sh | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> > index 9fa0706..5ef1744 100644
> > --- a/t/perf/perf-lib.sh
> > +++ b/t/perf/perf-lib.sh
> > @@ -80,22 +80,22 @@ test_perf_create_repo_from () {
> >   =09error "bug in the test script: not 2 parameters to test-create-rep=
o"
> >   =09repo=3D"$1"
> >   =09source=3D"$2"
> > -=09source_git=3D$source/$(cd "$source" && git rev-parse --git-dir)
> > +=09source_git=3D"$(git -C "$source" rev-parse --git-dir)"
> > +=09objects_dir=3D"$(git -C "$source" rev-parse --git-path objects)"
> >   =09mkdir -p "$repo/.git"
> >   =09(
> > -=09=09cd "$repo/.git" &&
> > -=09=09{ cp -Rl "$source_git/objects" . 2>/dev/null ||
> > -=09=09=09cp -R "$source_git/objects" .; } &&
> > +=09=09{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
> > +=09=09=09cp -R "$objects_dir" "$repo/.git/"; } &&
> >   =09=09for stuff in "$source_git"/*; do
> >   =09=09=09case "$stuff" in
> > -=09=09=09=09*/objects|*/hooks|*/config)
> > +=09=09=09=09*/objects|*/hooks|*/config|*/commondir)
> >   =09=09=09=09=09;;
> >   =09=09=09=09*)
> > -=09=09=09=09=09cp -R "$stuff" . || exit 1
> > +=09=09=09=09=09cp -R "$stuff" "$repo/.git/" || exit 1
> >   =09=09=09=09=09;;
> >   =09=09=09esac
> >   =09=09done &&
> > -=09=09cd .. &&
> > +=09=09cd "$repo" &&
> >   =09=09git init -q && {
> >   =09=09=09test_have_prereq SYMLINKS ||
> >   =09=09=09git config core.symlinks false
> >=20
>=20
> This breaks perf for the non-worktree case:

Oh drats!

> lsr@debian:~/src/git/t/perf$ make
> rm -rf test-results
> ./run
> =3D=3D=3D Running 12 tests in this tree =3D=3D=3D
> cp: cannot stat '.git/objects': No such file or directory
> error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash =
directory.p0000-perf-lib-sanity'
> cp: cannot stat '.git/objects': No such file or directory
> error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash =
directory.p0001-rev-list'
> ...
>=20
> Here's a fix:
>=20
> -- >8 --
> Subject: perf: make the tests work without a worktree
>=20
> In regular repositories $source_git and $objects_dir contain relative
> paths based on $source.  Go there to allow cp to resolve them.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  t/perf/perf-lib.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 5ef1744..1888790 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -84,6 +84,7 @@ test_perf_create_repo_from () {
>  =09objects_dir=3D"$(git -C "$source" rev-parse --git-path objects)"
>  =09mkdir -p "$repo/.git"
>  =09(
> +=09=09cd "$source" &&

I fear that interacts badly with the `cd "$repo"` I introduced later
(replacing a `cd ..`)...

Ciao,
Dscho
--8323329-1219177588-1464596890=:4449--
