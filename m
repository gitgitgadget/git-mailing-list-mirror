From: William Giokas <1007380@gmail.com>
Subject: Re: Conforming to pep8
Date: Thu, 8 May 2014 22:57:59 -0500
Message-ID: <20140509035759.GA9051@wst420>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 06:02:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wic1N-0001Wk-LZ
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 06:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbaEID6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 23:58:11 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35564 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbaEID6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 23:58:11 -0400
Received: by mail-ig0-f179.google.com with SMTP id hn18so662197igb.12
        for <git@vger.kernel.org>; Thu, 08 May 2014 20:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v+xvtaFa2iqPServm6kY/HRqbQaZs5erEZd0KlcKzIs=;
        b=H1JRWqc7xG40l5lTm3hJkH2UBfS/dZzqn1zd5mG7bGuxIE+J69EKeCm0IdoxAv+jJd
         R7cG5n6qFiOQNet2XWYtlvz85kBVcEWyN5TbUMlYQows4FehoZUPO0E/+iyl8IP0Vg/K
         KiF8V2W2Ad0K3r/aBPuvEpjtEMmgedNcdonT4tOqmy/vQ+0qLF21+MR+E0uFIRKkW6nf
         sM154uFJOu/ijcXW/NcUlRFMkyqcUwIsHHa6VfWQBHaEwdlAVgDCyRjBjaAh8Jgf+a0X
         6SZtGKKmrOVS8rwzoah/kC9TxCWS2IV7BycG3D4QAuyJT+8V7RkR2nwZ5wTdIbSz8iId
         vanw==
X-Received: by 10.50.147.9 with SMTP id tg9mr3747925igb.31.1399607890639;
        Thu, 08 May 2014 20:58:10 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id x13sm3840777igp.0.2014.05.08.20.58.09
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 20:58:09 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <536c3911ea173_741a161d310f2@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248510>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 09:10:25PM -0500, Felipe Contreras wrote:
> William Giokas wrote:
> > Which is a whole bunch of errors and warnings thrown by pep8. Is pep8
> > just getting put by the wayside? I would much rather have these
> > scripts conform to that and have an actual coding style rather than
> > just be a hodge-podge of different styles.
>=20
> Personally I try to follow pep8 in git-remote-{hg,bzr}, but only to some
> extent.
>=20
> I do this:
>=20
>   [pep8]
>   ignore =3D E401,E302,E201,E202,E203,E126,E128

(So I haven't looked at git-remote-bzr, but I can comment on
git-remote-hg)

Is there a reason for these?

E401: Multi-line imports seems like something that would just be
changing one line

E302: Blank lines don't seem to be that hard to do either. That can even
be automated quite reliably. It shouldn't detract from the readability,
juts makes the file a bit longer.

E20{1,2,3}: Extra whitespace is something that just makes things more
consistent and readable.

E12{6,8}: continuation line indenting is another thing that helps
consistency.

>   max-line-length =3D 160

The standard states that this should, at most, be increased to a value
between 80 and 100.

Note that I'm not trying to yell, but these are just things that are set
forth in pep8 but don't seem to be set at all in git-remote-hg. I really
think that git's python 'bits' should be able to pass a default pep8
without issue.

> That said there's a couple of issues present that I didn't notice.
> Thanks for checking.

Hope to see some improvements! git-remote-hg is really quite useful for
me, and I hope it can be as good as possible!

Thanks,

--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbFJHAAoJEGkCBthzzQnPlh8QANYxDE9v355zdELsmFv/6UZd
HlaUcm3qX7tYZy0XbT0pcmPRl23A1APjkClb+ShnuGrqvUzpjB2sKACNUZbiEoq9
gnsPeUTcxo/oPE/GfIYekGpBubIKUoL6UVRh+jTe47rnKUXZiguK3Ghqrr10thgi
outpT0aGRwytcBIbFMmL3IwVbP8bW4SgPFbuS08FIOq8t4lD/L8z7SsGKFNX1BLS
52hrzerFSLMuovAzqWmL70R3Sm6tTA3v1Vr/aG3n5riepLJn1feEvQRJrLxQmzkH
VvIa/gb55hacoNyrZKPrHIr91nbCj10mdHXhq5kNgoIZunII5or7W3/r4Vldh8ln
UJOWjtJEpMyBge3oMU7PYYgfILx5eAVDn1M+02gSdjeVr7Ah/kGVZN7mCRl1LmUA
i68lpFAIvbaqxRRAiUUe0vqTcyzoeA0enhPTihjGWlP0h6CE67S2eyw/AEdD6+bY
hEFiwuhWQRsXh8jAdTXPsAAHZ7hlbPlIHN+45Q6BWzcKtEAHwBoFhKyY9VfmuLM0
qXJSBVFWLoxh0KhwQsj38e5hbaAS+Ac+fqz8tsnvxsIJZYSzOnma7/BQidUORmQ6
PoOzUuZJas5fn6oKLk5hB98yx0fgAxh/JV8SZsjwTuHDMg9mjZJKvDVIcuCElxC+
r3lAz6upxSe4S5dDFqPl
=2dRH
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
