From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Submodules with feature branches
Date: Thu, 5 Jun 2014 08:15:49 -0700
Message-ID: <20140605151549.GQ21803@odin.tremily.us>
References: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 17:16:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsZOZ-00060h-5N
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 17:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbaFEPPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 11:15:55 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:34027
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbaFEPPy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 11:15:54 -0400
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id AcWD1o0030mv7h051fFtPn; Thu, 05 Jun 2014 15:15:53 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id AfFr1o00B152l3L3XfFs8e; Thu, 05 Jun 2014 15:15:53 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 72DCE120A28C; Thu,  5 Jun 2014 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1401981349; bh=Rii2QOEaNFZv+ChvU4jIiAmgUztE5OghTXQClTjpdAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BzduMj0AF4cN7uGXK1E7JdgE0xe1BNZFfQpLXCMtjNp6pCX/6JWg1Nk5OOgMtxKDz
	 qq+/06CzUeIOhkLhqX7t29iIyaGvzSyg6fe50xvvBQJOTrZC/nElV9xlGaqs1/N/Vb
	 osSiqTIqDYx2x8Ubr4Br7R3huNV6L/28NpKB+Zxs=
Content-Disposition: inline
In-Reply-To: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401981353;
	bh=2JL450sHgV/NtdyngWxNf1ETsd1VW3ruW4J4zHQ2lqA=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Eumx5agDiq4YtFkX3UwrZ9S5mhepVRK2K8cEJXTMRF7SRFwKWBrjRSJN2kS7eI7tt
	 bBc+HSs2P+uIqfJDBcz3FFg+YKsMuDQdhjwAOW3HnymxoB6RYTh0SCtCElnyYduXM9
	 nMoT4+uaIQX69JGbgizm93yiD3YPpPBv3jY8vqY1UtSmD4qj6hWmnmBKUJmgCU4qZY
	 QlVss4uuTGLhcWtzCXzQFQWlVLKijCS/55HhBG0w0vgIeD8qAa7aOfklN0cn8YUz7X
	 fRHKn7PvCf3jfi8kG5l0P4TWXri/AsT2QH2BY5lDOVlIsb6uzbNtOeV3vKVXZ4Mce+
	 FBwSFTuA2S23A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250844>


--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2014 at 09:03:25AM -0500, Robert Dailey wrote:
> When I work on a feature, I normally create a feature branch. If I
> happen to make changes to the submodule that only work with the
> changes introduced in my feature branch, that seems to complicate
> things. For the purposes of the feature branch, do I need to create
> a corresponding feature branch in the submodule and temporarily
> update the submodule URL to point to it? When I merge my feature
> branch, I'd have to swap it back?

So you have:

  On the trunk host:   On your public host:   Locally:
  superproject         superproject           superproject
  submodule            submodule              `-- submodule

In that case, a corresponding feature branch to the submodule, and an
update to submodule.<name>.url (and possibly submodule.<name>.branch)
would be the way I'd go (at A in the figure below).  Once the trunk
maintainers were happy with things, they could merge the submodule
branch into trunk's submodule (at B in the figure below), and you
could add a capping commit to your superproject branch that reverted
the gitmodule changes (at C in the figure below):

  -o---o---o---o-------o  trunk's superproject/master
    \                 /
     A---o---o---o---C    your superproject/feature

  -o---o-----------B  trunk's submodule/master
    \             /
     o---o---o----    your submodule/feature

An alternative is to use relative URLs in the trunk:

  superproject$ cat .gitmodules
  [submodule "bpl-subset"]
    path =3D submod
    url =3D ../submodule

which makes it easier for folks who mirror/fork both the superproject
and submodule (no need to change submodule.<name>.url).  However, it
makes it harder for folks who just mirror/fork the superproject (and
don't need to tweak the submodule), because they have to mirror/fork
the submodule as well to support the relative URL (or edit
submodule.<name>.url, which turns attempted mirrors into forks).
Personally, I prefer relative URLs [1,2], but both external projects
I've approached on this front have ended up with absolute URLs [3,4]
;).

This is less of an issue for loosely-coupled submodules, since you'll
can motivate your submodule changes to the submodule maintainers
independent of the superproject (i.e. you can just say things like
=E2=80=9CI'm extending the API so I can iterate over widgets.  This lets you
do things like frobbling whatsits in superproject=E2=80=9D without having to
present the associated superproject code).  Once you land the
submodule changes upstream, your superproject branch will work without
the need to tweak the URL (for absolute URLs) or publish a sibling
mirror (for relative URLs).

Cheers,
Trevor

[1]: https://github.com/inducer/pycuda/pull/21
[2]: http://thread.gmane.org/gmane.comp.python.ipython.devel/10287/focus=3D=
10299=20
[3]: https://github.com/wking/pycuda/commit/5218bd449d6aae0bce3a3d1bf54a913=
77445e2f9
[4]: https://github.com/minrk/ipython/commit/4fe230e96e357b3612b6fadaeec9d8=
de71d6fca9

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkImkAAoJEG8/JgBt8ol8ZpcQAKMK8fcsZcNGw9yUoJujvdP/
Io08ZSP2Li6avleDegjnxy4xFuveItZrMQtnRU/Deu4A26XlnyRGvVvFl1JPkXv6
X6RyuQ35k/xWCz3mzLxqLoo7QShDU0U4kkCoqPzbYQy5q/g/+X/rcz35zfcjixe8
pT/9bHgw26KWhBou4J2IUyPHO6Yh/QGRwvU78KEMpK4yqFvdZfrBnp+cRBc3oel3
KGgGXdVhdvx5YFc6wTG52ZMkKuyE2FHbpLJ7onHDsUayOx0v6FJFlQMltsiGI3ee
GfZe0FYCJx15DBt+8mrCDvNBocvpjGM4l143i466bWO7XK6TvP2tvzlEfwKieD9a
/1Hdk7A4ClKEcmCeui0THYZmWRAQWyE0C6FZ1+ZrTfGHHZ6SXOZMGHY8vLiGewGn
D5sFgVao6+PVRg7FdgfLHQ1m9I4wBlU3rsaJiTHqZaQMypUB2ovEZZBNMCCARZ+X
MV2XeSn7+c3ejaxF0jhCqaWEd6L5dyaVIk1kNJ0M4Crp16qfqe7S6QmL6aqMNkFm
sPj07WiTZ2KreJgC5NlrPDl+pQ+UKt4dirQ7/19fO/ccsbeIQtGon2+hDUE7un25
+DDlQ7UJgBBq5qaMyWObeWR5JAmshgJukt9VstLn7aHzWAbgkLAXgnaMrX9xTlP8
EwDnS4BmVFrft7zaj5XS
=AFja
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--
