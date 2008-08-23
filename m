From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] Makefile: improve customization for supporting HP-UX
Date: Sat, 23 Aug 2008 23:02:43 +0200
Message-ID: <20080823210243.GB7185@schiele.dyndns.org>
References: <1219520484-7712-1-git-send-email-vmiklos@frugalware.org> <20080823200928.GA7185@schiele.dyndns.org> <20080823202601.GF23800@genesis.frugalware.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 23:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX0IV-0004WX-VW
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbYHWVCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 17:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbYHWVCs
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 17:02:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:32870 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYHWVCs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 17:02:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so576044fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=rDFwnFBs99GEIPte5rDuofL8NiT/LG2ogfgOAmd4XZw=;
        b=cdppxeN5y65G8OG66oyKHaLcsdHMWWRS1J3jO+xDHTn3DtTdZ3wth5iEo8Mx2pEPN9
         cPcvU06CD8aiFj+bal+boJ0ejYipCrccxKfnCobkzRzTPk4SEcrCHqzEO7RmcTfVTp5p
         ixw9xYhhDhImjC7ayXZWHVwuUv/xMw3ZJpPVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=JnldGwoEDZLJLXANMJ/gc/gXpuCshwi/FxJLlTQ0p3qbuyQwhvOWQyjXxGvDsQvc9P
         5JaQqchplL+HIr3BZQMyTvxZYqr7ckUmbL8Zpy97afosRrhQfzixqAmUK9XuYbGTz9B7
         nMknVGUfQ4/ur7BDcwOBDl9x/6OVqQqA8Kl+M=
Received: by 10.86.26.11 with SMTP id 11mr1967425fgz.71.1219525365152;
        Sat, 23 Aug 2008 14:02:45 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.169])
        by mx.google.com with ESMTPS id 12sm2871493fgg.0.2008.08.23.14.02.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 14:02:44 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 7E16516052; Sat, 23 Aug 2008 23:02:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080823202601.GF23800@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93489>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2008 at 10:26:01PM +0200, Miklos Vajna wrote:
> On Sat, Aug 23, 2008 at 10:09:28PM +0200, Robert Schiele <rschiele@gmail.=
com> wrote:
> > The systems I build on are:
> >=20
> > 1x HP-UX B.11.11 U 9000/785
>=20
> This is the same version I'm using at the moment.
>=20
> The NEEDS_LIBICONV is simple, the linker fails to find iconv symbols:
>=20
> /usr/ccs/bin/ld: Unsatisfied symbols:
>    libiconv (first referenced in libgit.a(utf8.o)) (code)
>    libiconv_open (first referenced in libgit.a(utf8.o)) (code)
>    libiconv_close (first referenced in libgit.a(utf8.o)) (code)
> collect2: ld returned 1 exit status
> gmake: *** [git] Error 1

Huh?  Where does the "lib" prefix come from on your system?  Do you have so=
me
custom iconv header file in the way?  On my system I see:

[13] % nm /usr/lib/libc.2 | grep ^iconv
iconv               |   1255080|extern|entry  |
iconv               |   1255112|extern|code   |$CODE$
iconv_close         |   1254800|extern|entry  |
iconv_close         |   1254832|extern|code   |$CODE$
iconv_open          |   1255208|extern|entry  |
iconv_open          |   1255272|extern|code   |$CODE$
[14] %=20

> The SNPRINTF_RETURNS_BOGUS is not something you can notice compile-time,
> but once you try to commit, you get:
>=20
> $ git commit
> fatal: your vsnprintf is broken

Ok, I see that as well.  Obviously nobody ever committed something on these
machines.  But since we use these machines mostly for building people need =
to
be able to checkout stuff only in most cases and this is most likely why it
passed unnoticed.

Thus I think the snprintf part of your patch makes sense but the iconv stuff
seems to be something flawed on your machine.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIsHrzxcDFxyGNGNcRAsTWAJsELpNDjj6RmvER2Kytd8kjvysBzwCgu/13
pPY6nlms7bPDwYURAEbPmuM=
=yewF
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
