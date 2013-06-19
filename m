From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 1/2] Documentation: Update 'linux-2.6.git' -> 'linux.git'
Date: Wed, 19 Jun 2013 15:47:10 -0400
Message-ID: <20130619194709.GQ15550@odin.tremily.us>
References: <7vtxku112r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=DMLl6fZPX8o7hGmc
Cc: Git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 22:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpPHw-0008SW-Vf
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 22:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935181Ab3FSUr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 16:47:29 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:62804 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934971Ab3FSUr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 16:47:28 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jun 2013 16:47:28 EDT
Received: from odin.tremily.us ([unknown] [72.68.88.168])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MON003XQOAMQQ50@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 19 Jun 2013 14:47:12 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2F3E6A3B4FF; Wed,
 19 Jun 2013 15:47:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371671230; bh=vUXGk4zQDP98ZUs5fqu2vV1t/KHLWP7FfhDMWfm2EjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LvPaXEk1u3hJIIojmZHr3SpkxlIm6YqVZa2UEXf0rsjicZrUWzOYPizPbw71HPrxi
 Cx8iU1zitY5UBMidCy4TPAG2mGZYuLXLb7yULfzfGA0Kuplb82NrTD4QBoM0hLQLut
 CQi/GrHJlXl6jr+ejV21KWF/MLU62uBxJZkNF7Q0=
Content-disposition: inline
In-reply-to: <7vtxku112r.fsf@alter.siamese.dyndns.org>
 <20130619114823.GK15550@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228423>


--DMLl6fZPX8o7hGmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 10:07:24AM -0700, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> > index a0727d7..8e5260f 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -274,7 +274,7 @@ $ git clone --bare -l /home/proj/.git /pub/scm/proj=
=2Egit
> >  * Create a repository on the kernel.org machine that borrows from Linu=
s:
> >  +
> >  ------------
> > -$ git clone --bare -l -s /pub/scm/.../torvalds/linux-2.6.git \
> > +$ git clone --bare -l -s /pub/scm/.../torvalds/linux.git \
> >      /pub/scm/.../me/subsys-2.6.git
> >  ------------
>=20
> Aside from s|subsys-2.6|subsys| David already mentioned, I think
> it is a lot saner to remove this particular example.  Nobody runs
> shell on k.org machines these days, and local borrowing "-l -s" is
> already shown in another example.
>=20
> Also you seem to have missed another "linux-2.6 my2.6" clone in the
> first example.

Between the nfs-2.6 examples I mentioned earlier, the my2.6 clone
here, and the:

  $ git clone --reference my2.6 \
    git://git.kernel.org/pub/scm/.../linux-2.7 \
    my2.7

example listed later in git-clone.txt, I think we're trying to push
linux.git examples too far ;).  However, I can't think of a simple
example for --reference that doesn't drag in a longer discussion to
motivate shared object repositories.  I'll hunt through the rest of
the docs looking for other examples I can reuse.

I think any doc rewrites should be outside the scope of this patch,
which should just replace references to linux-2.6.git with linux.git
(as it does).  Further cleanups to remove references to the NFS and
my2.{6,7} stuff and replace them with alternative examples can come as
follow-up patches in v2 of this series.  Does that sound reasonable?

Should the size updates from 2/2 (user-manual: Update download size
for Git and the kernel) go into the reroll, or have they been picked
up in a separate branch?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--DMLl6fZPX8o7hGmc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRwgq7AAoJEKKfehoaNkbtYDUP/3a0HQhCmyzU+l9Euc6KZ9z/
KSgQ1PtVq4OmZfgmJT25lJo/TjMwB9KHt9v2Rovjt+N95ix9ko/EWXWu/KXqTOrR
2PNK/IOlT9xcIjgrLwZp0s9fmX0x9e6SnImBOpxt9MSoZ/1uuD4uIRPM7jWpsa6y
VUcbJg7+DruH4G0czJhgcqD3lxBODatALZyzB1Fi5pJWKoCcRl8xk/IrdWT7YIXM
CjXBu7quLp4jJy0XQyCmHqeIroZ93zmXGGsbLPqHiilwWtOjxXqW7wWiGG5o8mLu
S79Q+wbp2HKcbm4c9sjGxWdNJKg/vp/VMD1AJQqlAuVMcDpQkKpNydmGsaYRHou7
E90ja8heoMxf1Tj3OMJhSdnh47CCKvubjZ1XuKSH/MxeemaGhYH8EeArPEAyFyiB
OZfH1Dy6TP30iN47U0VkQK7n8fE+ImuQGO35MLFwCOdYZdpLTJAX3LJAVGG2cG9K
DxeOROH3t0vBtVUVmeploWyq2Y1jee/JKSI7hZEb+yFhGU9hJeCnuakcNTBTinn8
AT4DTzMEo4/eoTXeBx8qHE9UxRbDuz62B0snh+HzJc5SCcHD60Bz+CFgpv1cQQT1
p4AY8JV+lRsJc66LbPd3uFiaQdkfo65H/qvpr7bR0D5GbKpfQ+F4wgmyzYhoWtd4
VJfJctoFxESjmHg5j4QZ
=65Ij
-----END PGP SIGNATURE-----

--DMLl6fZPX8o7hGmc--
