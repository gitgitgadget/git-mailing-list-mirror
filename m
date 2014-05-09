From: William Giokas <1007380@gmail.com>
Subject: Re: Conforming to pep8
Date: Fri, 9 May 2014 02:44:02 -0500
Message-ID: <20140509074402.GE9051@wst420>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
 <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
 <20140509051623.GB9051@wst420>
 <536c815ee0b9c_182dd0d3104b@nysa.notmuch>
 <20140509072820.GD9051@wst420>
 <536c8546ed6fd_182dd0d3100@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 09:44:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WifTn-0001Lz-VY
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbaEIHoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:44:12 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36900 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaEIHoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:44:08 -0400
Received: by mail-ob0-f177.google.com with SMTP id gq1so4242919obb.22
        for <git@vger.kernel.org>; Fri, 09 May 2014 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=A8VeRegbFXUp0GyOy13ibYftY0Z0JYzpSd5wbv9b+o0=;
        b=UHt5h/fWgZgiQW+2QZ7DGMZ2KUCsRXkZOmqsQtciWzzG/DinyvqCa6+qXvx5EJyu2M
         5fGwQ0ZYD1MRrSJcLR3Jtuzh7v+eP6v9dtQGgnPLZbn67Ee3hXqfVtKsbFuRnfWpaBUI
         nJ7Yh6C1twedRm1HmoNAwWOReSkoyYdKNlOs2T9y0aV2xBgJaKfFL2VtSn6hoaAp56qo
         Asv4HGq/Zi/IaO9ZEKfj4uKbEf45dM0Zor9tYc5++jJz+u/vIJ+7+OGVkqm2kzHGNpdf
         eXUi95NkaCY/o5zLrJf9R4r3/Nx7lcE/thZcNuUSWQFw6ChoD/+zdg8akGU1NxY4U3lZ
         y6OA==
X-Received: by 10.60.161.101 with SMTP id xr5mr9956496oeb.71.1399621447992;
        Fri, 09 May 2014 00:44:07 -0700 (PDT)
Received: from localhost (cpe-173-175-117-154.satx.res.rr.com. [173.175.117.154])
        by mx.google.com with ESMTPSA id bh9sm1751242obb.7.2014.05.09.00.44.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 00:44:07 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <536c8546ed6fd_182dd0d3100@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248526>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2014 at 02:35:34AM -0500, Felipe Contreras wrote:
> William Giokas wrote:
> > Yeah. In fact, for the mercurial stuff the `from mercurial import chang=
egroup`
> > line should be on the same line as the other `from mercurial import ...`
> > line.
>=20
> I think the line is too big, it should be rearranged. But every time I
> add something to that list I say: I'll clean it up later =3D/

Maybe a time to use something like::

  from mercurial import foo \
                        bar \
                        baz \
                        ...

Would make that import into quite a few lines, but would help organize
things and let you easily organize things in the future.

Thanks,
--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbIdCAAoJEGkCBthzzQnPPA0QAKR0Ijz0DcFLPQYngtJXUZQs
TU5nukpeSjakg2MWJco5H1KWQuiit1P4BdhXtJkfe/gJy420tOtCjaOTTF8bQbPA
6zQnc6s7uvNgARIu6tQ7/prkX4t7hpFku0Pb5OMYJVKi/fhx8AaS61olURFZEFVI
kfj5RwwfuyZa7hLktl6gi/WqAQkqKyDjDhAF84UzXrC7l0Fs34o7rAeoiroKvxzw
DBGCUU7HWcST9Vgs4iu7aSjSLyWYaB04t1DW3Sj2OAZIy3yvOJ/8V1glGYG4Qs2Y
6iakkbdm5Hvj6vkQa8A8w9T10E+C1MVuqT868AB9jzO1PJPYRBBek0gNyrFqQzR3
hNqXLYVWNi10s21G7T+2Vs42/iW4h0/E1hw9DFHGUm/msvxQ1G+QLDruSCE1x3Ck
1/yfNNbHVQ98JS14T/C9AjmlkL08GdUAO+yMdJdJPm3Mqz/Qlbsa2tUtv+dld2HD
PAWYBmKuJi4T3R4sZbuh/GQKE0v1NxpBDRDqOq2DJObp/+maGuFuU6lLem9+ruln
ZsaH7Pwkm5Ot0jWgCNumyOGG1z1tGXmm80Vas8FghQjaCCeKbD3C49mDR0WrrzP+
nwrAysao+8CKkd9Mf3MQF7ykJwzb2ctwjAVR607l9dDU5HTmeBiZkLQfyg7YGeKZ
hNdNbBDviWf1f5gGVqGK
=9+rq
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
