From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 14 Jan 2014 14:22:31 -0800
Message-ID: <20140114222231.GA2647@odin.tremily.us>
References: <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub>
 <20140114214608.GB838@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 14 23:24:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3CPX-0004iB-0H
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 23:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbaANWYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 17:24:36 -0500
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:53866
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751068AbaANWYd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 17:24:33 -0500
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id Dpsv1n0061ZXKqc5FyQZkl; Tue, 14 Jan 2014 22:24:33 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id DyNX1n00K152l3L3hyNYAh; Tue, 14 Jan 2014 22:22:33 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 6D0EEED1E0B; Tue, 14 Jan 2014 14:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389738151; bh=HafGTSQO+EoWJIA1FbwA5AvKjKhfI1PZYrROVHPw9N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PD6QuUU4ktWTb4xdk0c+3lyTdgspfPrOfkD1dUelIVBh22x4R53QhxVF1ynN8auLi
	 tFtEQCz+yRJe1E5fhOG7E0aVm0sUYVrlhLlltkRDeRRLg3OfFfFkn1ksro4G4etcIy
	 EdxIapZ+rlSkMFX6idn60bZbTlD1k5kdeg1i4NfE=
Content-Disposition: inline
In-Reply-To: <20140114214608.GB838@sandbox-ub>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389738273;
	bh=GJczqDFiV4aC7fmPNp3+QxsbxnySMFJWVbTKtvyL/OQ=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=K3fXh7Fmc3gV7pKR/C3fs0/8yTq6JPlmgta2eZN5qL5yaVFJlNxL3Nj9zsno0CFfk
	 IXKnjAfOCCERug6OKXmHuLnUsKBHdEQXYD6zAW494iJnML9H4zXS4UkIKRdGO5zUSt
	 ft3UqBJuhBmaL0FLXZgtu6d5dtCB9pFPPzBv4LWXUtq16naR9ROPswm581AMx0Vlwi
	 1qHGif8Mhn7NgL4jRQp9glKJXt8ToSWZZPqs/+mDq9XDUhtQNFMhIc27lonS8NKQmq
	 QQPCVqovLjrgJidPZOJtCRvmnh9W0ENKgrs74qaoEuJg8xki46euo4o+W+BT2DnPY0
	 /NgTfR+0/KMpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240418>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 10:46:08PM +0100, Heiko Voigt wrote:
> I would like to step back a bit and get back to the original problem
> at hand: Francescos original use case of an attached head for direct
> commits on a stable branch in a submodule. How about we finish
> discussing the exact solution of that first. AFAIK that is already
> solved with the following:
>=20
>  * Trevor's first patch[2] to create a branch on initial clone of a submo=
dule

v1 broke a bunch of tests.  Are you ok with v2 [1]?  v2 still needs a
clearer commit message, a test, and a possible transition to
triggering on non-checkout submodule.<name>.update instead of
non-empty submodule.<name>.branch [2].

> That should be all (and IIRC Francesco agreed) needed for that use-case.

That was my understanding [3] ;).

> Lets not implement more than currently is needed. We can revisit the
> ideas once some other real use-case manifests.

I have most of a real use case already.  I have a repository with
submodules in one branch (master) and a subtree version in another
(assembled) [4].  The *tree* is the same in each case, so I have to
'git rm -rf .'  to clear the submodules out of master before I can
checkout assembled.

  $ git checkout assembled
  error: The following untracked working tree files would be overwritten by=
 checkout:
          modular/README.md
          modular/shell/README.md
          =E2=80=A6
  $ git rm -rf .
  $ git checkout assembled

That leaves some extra stuff removed:

  $ git status
  On branch assembled
  Changes to be committed:
    (use "git reset HEAD <file>..." to unstage)

          deleted:    .gitignore
          deleted:    .mailmap
          deleted:    CONTRIBUTING.md
          deleted:    LICENSE.md
          deleted:    instructor.md

so I need to check that out by hand:

  $ git reset --hard HEAD

Now I can work in the assembled branch.  Going back to master is a bit
less tedious:

  $ git checkout master
  $ git submodule update --recursive

Luckily for me, I don't have a third superproject branch where the
submodules are on a different, so the submodule's HEADs are preserved.
As I understand it, the new recursive checkout functionality [5] would
checkout my submodules with detached HEADs.  The fact that they are
only accidentally preserved now is not comforting ;).

> Also we (Jens and I) would first like to proceed with the recursive
> checkout / fetch (for which the plan is clear) as the next
> complicated step.
>=20
> Once that is done and people gain some experience with it we can
> still extend further.

This is quite reasonable.  Given the need for backwards compatibility,
I just wanted to make sure my ideal UI was clear before we went
forward.  There's no need to break fingers twice ;), but if tight
binding with localBranch is too big a chunk to bite off now, I'm happy
to kick that can down the road.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/239967
[2]: http://article.gmane.org/gmane.comp.version-control.git/239973
[3]: http://article.gmane.org/gmane.comp.version-control.git/240139
[4]: (gitweb) http://git.tremily.us/?p=3Dswc-boot-camp.git
[5]: http://article.gmane.org/gmane.comp.version-control.git/239695

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1bikAAoJEKKfehoaNkbt3pkQAJSr4KEgqaVDorISiBJfUSpE
iObo1lkMVAuOWHt9uYNze+Yb+PVyqDWyNy5E43XzMnexuuvmg84GZShwKshmtnRF
Buex51Sy0h/C3++mMRJVYOg33MsYqphuCCbMiMKT8WGqtULMiXFaRgF/FSsN/kep
i9R6R7qEh4BhrHJ6536DDRRIPfQnyiDGnfm7KtebL/AbvbU+lOnz64Z6TQjjl4qO
47PDAQPsYVoLbIBKLbyJSYzpmaui71P8xAe/aZ+B5eZEdI5SvrC1pumQeX/wTMSY
bQaMwaTwA3FUzgKx69Rt24Ssg3muo5ByJD3x5myU0U4VDxZpX9doNcGhL/s7PE3H
OqGukhm/GOtRswwpILWKHnYwxIRD7Q0EEeF8PPULlgCyu9CK5FRyIgGxJAXhVLcn
2xE9r9FtaghUL97gKZPKC+haDYDPOrrZWGc5auPTG6hOIMmEFjqSWOgsSEd2dqVL
zpgTjSzozmXSq78YXsFXaxYTDd5XneaGimit0q8GZalUuSwlQtKwY0f8TB6O4BBV
U/xZfOD1TZo0O2dSd2MHPptuU0DDmWyTZMgFx4vr883IvsOupAVDPzogDnCuIMrM
YXan88LEu2vziZlIUWEzmfRPxcYABX5TUKuYWx1bcvUaCVD8XaWW7dsbCVcth3e7
/ZvxwxPZIlEOcULdJCGB
=wIvG
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
