From: William Giokas <1007380@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 16:01:58 -0500
Message-ID: <20140513210158.GH9051@wst420>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
 <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
 <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
 <537233CC.3050904@web.de>
 <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
 <20140513184800.GF9051@wst420>
 <53726e0355875_4aa4b312f892@nysa.notmuch>
 <20140513193911.GG9051@wst420>
 <53727f93801d_7146f9d300dd@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:03:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJrd-0000GX-HF
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaEMVDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:03:50 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:50707 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbaEMVDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:03:48 -0400
Received: by mail-ig0-f174.google.com with SMTP id h3so5739571igd.1
        for <git@vger.kernel.org>; Tue, 13 May 2014 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dD9/PUwz9h7ddlK0/VB9sQO/+yddVTdnH6sH8aQj1Uk=;
        b=Ktxi+j/DWDFWTEjl6SPczMGiQsU394l4fH0D4MiVINAS7KAqVktlFzJbiT+G0K8viP
         Ms2NR0l/SIE05CKjUa9ZSt6heA2jC7XOqezOI4P52orv5we86kRSHHHqqKQwa+f+Kkg9
         Vqnsk+Iz5elrFKYjPdOhrTGiOZwBf/wfUHs5zs6ZKJf3Wyr4ALV7opA7gWentzkPnd6K
         Iq6KXNAc+O0iUk9XzJ14DI3bmWGGn3W6jRVXc57nP7FniKi/ZkTvO7jx6dcii9sSdBd+
         cqpEBf7RoJ1r/lt3X/aY55S/gSbgTF5i3M02cYi/ZqNdATAg0/lJ8iuq1CLHt/f3HFkJ
         3oBw==
X-Received: by 10.42.119.138 with SMTP id b10mr1818623icr.31.1400015028243;
        Tue, 13 May 2014 14:03:48 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id s1sm32674615igr.14.2014.05.13.14.03.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 14:03:47 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53727f93801d_7146f9d300dd@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248852>


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2014 at 03:24:51PM -0500, Felipe Contreras wrote:
> William Giokas wrote:
> > On Tue, May 13, 2014 at 02:09:55PM -0500, Felipe Contreras wrote:
> > > As you say, it's perfectly OK.
> >=20
> > But wrong. Yes, it works, but it's not how it should be done when we
> > have a code review such as this. It should simply not be done and makes
> > no sense to do with an 'if <check ver>; else' kind of thing later in the
> > application.
>=20
> That's exactly how it should be done. Maybe this visualization helps
>=20
>   from mercurial import hg, ui, bookmarks, ...        # for hg >=3D 3.0
>   from mercurial import node, error, extensions, ...  # for hg >=3D 3.0
>   from mercurial import changegroup                   # for hg >=3D 3.0
>=20
>   if check_version(3, 0):
>       cg =3D changegroup.getbundle(repo, 'push', ...    # for hg >=3D 3.0
>   else:
>       cg =3D repo.getbundle('push', heads=3Dlist(p_revs)  # for hg < 3.0
>=20
> Eventually the code would become:
>=20
>   from mercurial import hg, ui, bookmarks, ...        # for hg >=3D 3.0
>   from mercurial import node, error, extensions, ...  # for hg >=3D 3.0
>   from mercurial import changegroup                   # for hg >=3D 3.0
>=20
>   cg =3D changegroup.getbundle(repo, 'push', ...        # for hg >=3D 3.0

No, the way that it's going to change is that the import statements will
change, not the 'if:else' things. It would work exactly the same with
this, however the things that are used only in a specific version for
this are stated up front. Maybe this visualization helps for what I have
set up::

  from mercurial import ...                        # for all hg
 =20
  try:
      from mercurial.changegroup import getbundle  # for hg with
                                                   # changegroup.getbundle,
                                                   # regardless of version

  except ImportError:                              # for hg from before the
      def getbundle(__empty__, **kwargs):          # move to changegroup
          return repo.getbundle(**kwargs)
  ...
  cg =3D getbundle(...)

When we eventually remove support for mercurial that uses
repo.getbundle:

  from mercurial import changegroup, ...           # for all hg
  ...
  cg =3D changegroup.getbundle(...)
 =20

That should make sense. You could even just remove the try: and except:
bits and just to 'from mercurial.changegroup import getbundle' and not
mess with the meat of the code at all.

> The fact that at some point 'import changegroup' was not needed is
> irrelevant.
>=20
> Primarily we want to support the current version of Mercurial.
> Secondarily we want to support older versions. That's why we add the
> repo.getbundle() code (as an addendum to the core part).

So I use arch myself, and I am very used to the 'rolling release' model
that it employs. I do agree that we should concentrate support for the
latest release, but for a project like git the other versions of hg
cannot be ignored, as this project is used on so many different systems.

> > > We could try that, but that would assume we want to maintain getbundl=
e()
> > > for the long run, and I personally don't want to do that. I would rat=
her
> > > contact the Mercurial developers about ways in which the push() method
> > > can be improved so we don't need to have our own version. Hopefully
> > > after it's improved we wouldn't have to call getbundle().
> >=20
> > Assuming that mercurial <3.0 will not change, then this should never
> > need to change.
>=20
> But it should. Otherwise the code will keep having more and more hacks
> and it will become less and less maintainable.
>=20
> That's why we don't have code for hg 1.0; because it would require too
> many hacks, and nobody cared anyway.
>=20
> Just like nobody cares about hg 1.0, eventually nobody will care about
> hg 2.0.

Yes, it can change. Eventually hg 2.0 will be defunct and no one will
use it, but what happens if they go back to the old 2.0 style for
getbundle in hg 4.0? We're already good. What if they switch it back in
4.1? This works for all of those conditions, and doesn't do anything if
we're able to get mercurial.changegroup.getbundle.

> > Changes in 'getbundle' upstream would require changes either way.
>=20
> I doubt we will see any more changes in getbundle, at least not until
> 4.0, and hopefully by then we wouldn't be using it anyway. I am willing
>  to bet we won't see those changes.
>=20
> > > Moreover, eventually there will be a Mercurial 4.0, even 5.0, and at
> > > some point we would want to remove the hacks for older versions. When=
 we
> > > do so we would want the import to remain unconditionally, and remove =
the
> > > 'check_version(3, 0)' which is already helping to explain what the co=
de
> > > is for without the need of comments.
> >=20
> > The same exact thing can be done with this. In fact, it would probably
> > allow us to have better future-proofing with regards to new versions of
> > mercurial, there would just be different try:except statements at the
> > beginning.
>=20
> No, your code doesn't show that this is for versiosn <=3D 3.0,
> 'check_version(3, 0)' does.

That's the whole point. This did not change the instant 3.0 was
released.

> Plus, when we remove this code my version makes it straight forward:
>=20
> -    if check_version(3, 0):
> -        cg =3D changegroup.getbundle(repo, 'push', ...
> -    else:
> -        cg =3D repo.getbundle('push', heads=3Dlist(p_revs), ...
> +    cg =3D changegroup.getbundle(repo, 'push', ...

Because it is not there for things that are <3.0, it is there for
systems that are unable to import mercurial.changegroup.getbundle. There
is no reason to apply a version number to this, except for the fact that
hg happened to change in version 3.0. This lets people that are using hg
versions of hg to work through changes.

>=20
> Not so with your code:
>=20
> -
> -try:
> -    from mercurial.changegroup import getbundle
> -
> -except ImportError:
> -    def getbundle(__empty__, **kwargs):
> -        return repo.getbundle(**kwargs)
> +from mercurial import getbundle
> =20
>  import re
>  import sys
> @@ -1036,7 +1030,7 @@ def push_unsafe(repo, remote, ...
>      if not checkheads(repo, remote, p_revs):
>          return None
> =20
> -    cg =3D getbundle(repo, 'push', heads=3Dlist(p_revs), ...
> +    cg =3D changegroup.getbundle(repo, 'push', ...
>=20
>=20

Hope that made some sense, at least.

Thanks,

--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcohGAAoJEGkCBthzzQnPEfIQAJ6QLAEhOG/iy0wllvDEhQJq
fJ2abjACHLWAQKNZdqiBqITqVEuPov24sxo9CTtRmlYMWhTd6XOYT4pTgpp572/O
3N/Wemkm/qpfrVlA2i47VSGdOQt4PpX5J/cH2CvKA6At52q/rRqcuepMyQpWNBCZ
UL0NA7S/G20tNzFr6p1qGYR1N300GpmJXLFl8fXMc28Mzzu1D1Qr7ASBfmY4o4GV
RbuIArX3qwmS4+8Rv7uVhVaqu/UycaIkVv/or1aO435V1XgtH0Dog5qwFknxzNul
DwSSQXNKjaxhoz0WGCqGccH2cfbRBc0vsZ7wgblzyGdDHBrz+TesKE35V+sMcRAM
wdcdMRg+H83CJbwXQ2h18vXAysrhwooWYTOTGmxV3dqXxMUndMIVaWNw+BwFY4nN
EPnvT2oDeUeFRic2kvtuJCvG4tm9nEL35eSLsvomJtaHpYPEal8tCJSe8bl4/NdU
rkzaR0Ima77jAgF/nzDlE/8Cjr74XHo2KZTI2yqTrqaeQPZYdkCw1kfao7i0wMy8
QAEGjQGc+IUaCE5y3hyh/Be2EoaU6rOT1tApo97eNs2VtZUhOa4MHrpHCF93BpfZ
gS4wvzXaOPwtUNZ2ZoaY79grAoOYnfRb1eJh1g1/osmpsexQRnUngswK1z1e0Qch
l/355H0z2xOcAeN4Mp9g
=E098
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--
