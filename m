From: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
Subject: Re: [PATCH] Highlight every 5th line for add -i
Date: Sat, 14 Aug 2010 19:58:13 +0100
Message-ID: <20100814195813.2ef163ef@snowcone>
References: <1281703569-8833-1-git-send-email-ciaran.mccreesh@googlemail.com>
	<4C6670FD.9010100@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/T6Ft3H6dT5/YHQz/mXMsrst"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 20:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkLwA-0006Ul-7G
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 20:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab0HNS63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 14:58:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62402 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab0HNS63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 14:58:29 -0400
Received: by wwj40 with SMTP id 40so4505148wwj.1
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type;
        bh=yPyEqPXuOHLcs/fOlArvu7fl+m4PwYIBjAw6oHijiuE=;
        b=C6e2zp/3YCEI0uHcAu7FnJdSprYV/5EJSKcKqL2FbgXmVBpV6GxIT6daSLZRfvSBsJ
         ZRz7wRGlWBIMsgDQpFrPDk0iIlObyKl60FmWwtobMSNZvupeIhayQUGovbx8Piyypenf
         tPYVvz3ikcWxgaiN01KrhyTOG7XqDpDQR9Xi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type;
        b=mmgNPHEzGg25E64+2D+70OIXRVgTjAbPAb2xvWVKvFT0/pksWlmy286yNDSSZD30zI
         soBTU6fU2JLlBhyT/4qQv9UgxaI4pXH23kycDGNrCiuw23jBl8MZmkouKszrCEvLXiUu
         lAuQ7Atboqs0Vv/T991iJwTzc1rCsV5bsblCI=
Received: by 10.227.128.147 with SMTP id k19mr2913292wbs.52.1281812307702;
        Sat, 14 Aug 2010 11:58:27 -0700 (PDT)
Received: from snowcone ([92.16.77.174])
        by mx.google.com with ESMTPS id p42sm2309350weq.36.2010.08.14.11.58.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 11:58:27 -0700 (PDT)
In-Reply-To: <4C6670FD.9010100@gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153572>

--Sig_/T6Ft3H6dT5/YHQz/mXMsrst
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Aug 2010 03:33:33 -0700
Stephen Boyd <bebarino@gmail.com> wrote:
>   On 08/13/2010 05:46 AM, Ciaran McCreesh wrote:
> > It's easier to match up numbers to filenames when there's lots of
> > output that way.
>=20
> Interesting. Maybe it would be better to reorganize the listing so
> that the number is adjacent to the path name? For example:
>=20
>     staged    unstaged   #  path
> unchanged     +5/-2     1: git-add--interactive.perl
> unchanged     +100/-2   2: builtin/log.c
> unchanged     +49/-2    3: builtin/add.c
> unchanged     +0/-60    4: git.c
> unchanged     +5/-2     5: help.c
>=20
> I'm mostly concerned that the highlighting (boldening?) is going to
> be confused with selection.

That's also good for me. I don't have any particular preference or
opinions on which is clearer.

--=20
Ciaran McCreesh

--Sig_/T6Ft3H6dT5/YHQz/mXMsrst
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkxm508ACgkQ96zL6DUtXhFoJACgkz96htIVXvjZdYVIPnKm/ZLY
Z5gAoIexJSvZl6WP0Z14cxBszbmN1PbY
=w4kI
-----END PGP SIGNATURE-----

--Sig_/T6Ft3H6dT5/YHQz/mXMsrst--
