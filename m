From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Wed, 8 Jan 2014 16:03:38 -0800
Message-ID: <20140109000338.GM29954@odin.tremily.us>
References: <20140106160202.GE27265@t2784.greatnet.de>
 <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
 <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us>
 <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
 <20140108010504.GE26583@odin.tremily.us>
 <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 01:04:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W136T-0008A0-8d
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 01:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535AbaAIADo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 19:03:44 -0500
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:45327
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757429AbaAIADm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 19:03:42 -0500
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id BVzi1n0051wpRvQ58c3ilg; Thu, 09 Jan 2014 00:03:42 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id Bc3f1n01S152l3L3ec3gr0; Thu, 09 Jan 2014 00:03:42 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id EF1B8EB41C1; Wed,  8 Jan 2014 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389225819; bh=5SHWE63NaMxcYS4WTz+QdocZD8M/2ItIOOaTzwYFOw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VwuipDs/duqQs55mea4gyXXzkbGhaH+/YS/bmnGWSfjnQo0Ev7Cg24NNeFS+yIsAJ
	 EifMiM2AOR96cwDeyNyNvCx8L2ogIMQ0SEb4jlV4QvR33S+5tjubnSnOjzGmX8sYpE
	 hkT+t4dR19nNJ+FUlOan6jh4uakBsreMdbMsQSVY=
Content-Disposition: inline
In-Reply-To: <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389225822;
	bh=PKTGyC273z3AL80nEQxNe/zwnTv03b7dpPszt2rSLZk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=lYhTXXIARmsmHJi9T3ej9SK1WvySxbUaiaLw5PsCqMN2NP1AQPnfoLy30RHBbPJ1H
	 xIckrCsHcIdR164KZXTRsI3/YW400zeTTcRQHMx4o1PeiA+gzc5HJ/AjuFFi2PQSU2
	 H8L/qUTyU3mDuqpEmDt8vzStUBdrQXm675rbSby3CMSlcSF3OKP7yllXEcb7tL7APv
	 peoC9dyN/6R49DjHavESW0EiWZ//6NnkmEUlE2A52C3DSHrl7ujCeimtZcCruTfG1V
	 R0GvhaqYOsDNFr1hhaWRdeAZ5e0X7aHZMDH/9YSeupBbpE++ZnAFxLzzgk8iNhIPIX
	 d4RZeWZb0opzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240232>


--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 12:07:56AM +0100, Francesco Pretto wrote:
> After long thoughts, I think your idea about a local branch with a
> differently named remote branch looks interesting but I would be
> extremely cautious to add a ' submodule.<name>.local-branch' now. Do
> we have a similar mechanism on regular repository clones?

The default upstream branch is currently configured with
branch.<name>.merge.  Earlier [1], I suggested we piggyback on this
for the submodule's upstream branches, and only use
submodule.<name>.branch for the initial setup.  That would allow
developers to configure upstreams on a per-submodule-branch basis.  We
should probably fall back to submodule.<name>.branch if the submodule
does not have a branch.<name>.merge configured.

However, submodule.<name>.local-branch has nothing to do with remote
repositories or tracking branches.  It just selects the preferred
submodule branch for the superproject branch.  This will only work for
in-tree .gitmodules configs (since the contents are per-branch).  I
don't have a good idea for where local overrides would live.  We'd
want something like
branch.<superproject-branch>.submodule.<submodule-name>.local-branch:

  [branch "my-feature"]
        remote =3D origin
        merge =3D refs/heads/my-feature
        [submodule "submod"]
            local-branch =3D "my-feature"

and I don't think Git's config supports such nesting.

> We can clone and switch to a branch other than "master" by default,
> but can we also have a different remote by default?

Sure, the existing submodule.<name>.url defines the remote repository,
and the existing submodule.<name>.branch defines the remote branch.
The existing code even sets up remote.origin.url and
branch.<name>.merge (to the matching refs/heads/<name>) in the the
submodule's config.

> Also, I think you fear too much that this can't be added also later.

We can add submodule.<name>.local-branch support later, but I see no
reason not to add it on top of Jens and Jonathan's current submodule
checkout work.  With increasingly robust submodule checkout support in
the core, I expect the amount of update logic stored in
git-submodule.sh will decrease significantly.

> I think you should pursue your initial proposal of "--branch means
> attached" to get it upstream first. It's alone, IMO, a great
> improvement on submodules.

I can resuscitate that if folks want, but Heiko felt that my initial
consolidation didn't go far enough [2].  If it turns out that we're ok
with the current level of consolidation, would you be ok with
"non-checkout submodule.<name>.update" as the trigger [3]?  I think
that adding a halfway step between the current status and full(ish)
submodule.<name>.local-branch support is just going to confuse people
;).

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240164
[2]: http://article.gmane.org/gmane.comp.version-control.git/239968
[3]: http://article.gmane.org/gmane.comp.version-control.git/239973

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzedWAAoJEKKfehoaNkbt5BcP/ingyu1yJoZE6j5sbYDRza3+
EoukEPKjzycTV61sKpwu0tn6GiUPxbXWiwWfd8YLr8Qu8vNTBVajSx4LLpNqf2iG
0otLeziXjBDO7RmNrhBmqWFwJLWvtBk1Lf7gkuZWjrpCRvn0riZ/9GLmvYlLZwUp
aoaxzPDdQ10/LfQbznya2temDxlPUFIYGdWNbkD2y5iy+ryBjCdMZ+C/7zhls7+b
O9JcoEtZ9MVjyzEmcEa9+bGSv20bjrtrG8pzXsLAW7QfXfCsuKVrIqrt2U2Qqc3b
Z7Kr9A3HzIS3782x9FCvBxv/ZFTSY4vxNr1P6nqbSEbeME3LGzcSv22kiMZLI9XQ
n5FJPb/udJ4GbyU8jeSwrj2lhMiDc6IwBW08HtB8mf6t9Q12tmH6z6wcnWIVjepg
37Ya0n3a6wb1Lan+aC8nUoUsaHcU3a2LwSjkdVQb+j197jAj3W6SWuGqPmna/gTi
OhKAX6t667Y6I5iZf6t1NX8I4ndztTY9hd00n1eBygfqiDT7gdZVAfRpMBxfivsd
NXau0nPqt/KxD4VdJckDHImpAwJ8ullskUIrgsSIeUa2oPZV4Lelhq2qrOwpFRhR
xHY7B7027dajhA5tK+02VM1Ll3AM6noB62YtVyjNJWEAqXTDnmFxDfd0tsNmFNrd
lNc40qBVP2VCBV07ZW+Q
=NVpF
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--
