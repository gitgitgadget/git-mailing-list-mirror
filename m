From: William Giokas <1007380@gmail.com>
Subject: Re: Conforming to pep8
Date: Fri, 9 May 2014 00:16:23 -0500
Message-ID: <20140509051623.GB9051@wst420>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
 <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 07:44:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WidbX-0001fs-V9
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 07:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbaEIFoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 01:44:16 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:43260 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaEIFoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 01:44:15 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so4288600oag.20
        for <git@vger.kernel.org>; Thu, 08 May 2014 22:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9xZJIowoByWQIy6UvulrwrR9Bj4QcFGWSzrfg+g39X8=;
        b=D5Ok+Gqurph8GjO03qr/EiVBXxjldTSaOcXY5keQMcKtNzeTgUJ7eq1eH8dvvLMjkW
         kmXovuHtDT9bGOm1urnxs3c9Rdhm9sy06lF48FIk8QGp2h/VOV2Cf+ppZ3wPVmDdzz1d
         vcI3U5pcNx8WBFesmXWnzZdK9y37kR2MGHEUyHfPFxI5BPfZ//K7o2v9fO74Au5y+04n
         FfDTgTmGEDsl2TexwuX1bjPOqqt+ypjsthYsPAdt9ALL1T3hFNsA+j+L+Xdm0t1qjpD9
         MuG0GOm39B/TM8NSfAkhv533OoQyL25zSO6Y3reXyEDVKQwtPTlHQGOLewARna7dwsJq
         6Pwg==
X-Received: by 10.60.145.171 with SMTP id sv11mr9727235oeb.64.1399614254781;
        Thu, 08 May 2014 22:44:14 -0700 (PDT)
Received: from localhost (cpe-173-175-117-154.satx.res.rr.com. [173.175.117.154])
        by mx.google.com with ESMTPSA id dg2sm1277965obb.17.2014.05.08.22.44.13
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 22:44:13 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248514>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 11:36:29PM -0500, Felipe Contreras wrote:
> William Giokas wrote:
> > E401: Multi-line imports seems like something that would just be
> > changing one line
>=20
> Yes, and make the code very annoying.

It's 1 extra line in git-remote-hg, and 4 lines in git-remote-bzr. I'll
even send in patches for the current version you have in your tree if
you'd like. It would make testing removal of an import easier, and the
adding of imports would be consistent. They can still be grouped, but
having them on a single line kind of limits the ease of manipulation for
testing and possible packager patching if needed.

> > E302: Blank lines don't seem to be that hard to do either. That can even
> > be automated quite reliably. It shouldn't detract from the readability,
> > juts makes the file a bit longer.
>=20
> The problem is not that it's hard to do, the problem is that it makes
> the code uglier.

I would disagree, but this is one of the less important things.

> > E20{1,2,3}: Extra whitespace is something that just makes things more
> > consistent and readable.
>=20
> I don't see how this:
>=20
>   {'100755': 'x', '120000': 'l'}
>=20
> Is more readable than this:
>=20
>   { '100755': 'x', '120000': 'l' }
>=20
> No strong opinion on this one though.

It's not so much that it's wrong or less readable, but there is
inconsistency on this one and I'd err pep8. Again, will send a patch to
your tree for you to review, though it looks like you mostly fixed this
in [1].

>=20
> > E12{6,8}: continuation line indenting is another thing that helps
> > consistency.
>=20
> I don't see how.
>=20



> > >   max-line-length =3D 160
> >=20
> > The standard states that this should, at most, be increased to a value
> > between 80 and 100.
>=20
> And why's that?
>=20
> This has been discussed many times in the LKML, and the end result is
> that we don't live in the 60's, our terminals are not constrained to 60
> characters. Going beyond 100 is fine.

Fair enough. At the same time, it'd only change 14 lines in the current
git.git tree and would probably increase the readability of some of the
sections. I noticed that some of the changes in the referenced patch
actually fixed this on a few lines as well.

[1]: https://github.com/felipec/git/commit/12374c0e09a84945a202bb5ba7981a22=
3d233d0b

Thanks,
--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbGSnAAoJEGkCBthzzQnPkkAQALCVQnQNQQfz2QNgMf6P3M8W
WX/pdufbcKAmzWcGERjO452yWVevyaYqalILKFipF48v9xHyUzbT5r+JE34YdqRP
kPvf2rA3RDSbnR0AxPTIarOJB4dtXXFsKOpsKWSAqYjnlh4KWvrpPiGHiCMUx0qh
VcM1JeN2s8cGrzTwkIiaIjU23UCAHzoADU3tq4XTgSsZGRW1kjU2Cxs1OH9nYXlp
A2imx3UXQJxF+vejP+JWD4G6C/Ct3JnZPkPjpqnY+4Mt+sM3LZos7XqmKI/gerWM
tBXUBcdNnV1iliKfJ/92qeOOHrFDk8YS/vJm3nl2kWoYkZ4wpMjKBHF0Cw1wy5d8
s3rErGB4x3om1+/hojNTP7ZbwzvarPpRda1wv9qKlRwE+PTyHEmEIyu9yp4tpKaT
+TPRNVnGQtRZPCVnaJrnTcq5McJ1SbDLmVR7k/7yARySDKB3Vlov5EqMaBKa8Epn
y11ZTrZRTZXlfizG1qE4MD3cDsVmPQ8braqIR2y2nhR2WFD9tTlsLXIhGZwEd8Ii
bkVNqI3DLsYnxBmdSn1jkd0EW73wPreTuwYWhHauq9z2ytof7AIUb0MyWygCx8Jb
SMkyX3XtA/fduY1GEkyge9R11/zhW3ZWK0f4QMZoMkJsVk6amMB0jno/9agCVCTe
ulE0ly9Wbu6il3jy83VN
=JQ1B
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
