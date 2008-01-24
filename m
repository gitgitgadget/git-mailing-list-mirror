From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] HP-UX traditionally has no sys/select.h
Date: Thu, 24 Jan 2008 19:36:45 +0100
Message-ID: <20080124183645.GL30676@schiele.dyndns.org>
References: <20080124175300.GI30676@schiele.dyndns.org> <alpine.LSU.1.00.0801241758130.5731@racer.site>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bmlge7Pg4VPvffji"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6wy-0006rr-BD
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYAXSgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYAXSgt
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:36:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:9920 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYAXSgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:36:49 -0500
Received: by fg-out-1718.google.com with SMTP id e21so322180fga.17
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        bh=I92L6nrwsDK/qr+5JmcLQR8dfd0qEEKDBJ6VISBwJBY=;
        b=WNDD/t2DkSljp1ycABLORDbOPjvulAOtnYPRBbopuUV6l8Tngjj38DSlOfR6+5c6LXR7KgjA4AuzijQBwPz3wxWdMqw+0dUh0VxeOHZ9y6xgM+z0tmjCDQkT86/2+LdXDHyvvY7fx6z16bp/PQzvaImFzQ6Yyi27p3LlwSmEFPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=Ec7AjuJsh/1QvqnRB2bZTS95kLxPmkHTndgOb6olNgYgSiN1zkqP1BFXOPUnpx3sVO7gaThXj7wScLi34ZkxKBA0Q8zNTPvgBXy9KUTerEdSuPClWoM+D2JV6DCtbVmucZDF2a/bb3BV23n6fKfxLAgB7nos465NRoGJ1vHdycY=
Received: by 10.86.84.5 with SMTP id h5mr882609fgb.75.1201199807535;
        Thu, 24 Jan 2008 10:36:47 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.55])
        by mx.google.com with ESMTPS id 3sm1644572fge.7.2008.01.24.10.36.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 10:36:46 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id E8FFA2A8CF; Thu, 24 Jan 2008 19:36:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801241758130.5731@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71646>


--bmlge7Pg4VPvffji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2008 at 06:03:14PM +0000, Johannes Schindelin wrote:
> We try to avoid using constructs like this.  Rather, we have a section in=
=20
> the Makefile which sets things like NO_IPV6=3DYesPlease,=20
> OLD_ICONV=3DUnfortunatelyYes, etc.
>=20
> Later in the Makefile, dependent on this Makefile variable, symbols=20
> are defined. In the source code, we check for these symbols.
>=20
> It is not only a matter of being able to reuse the same symbol for anothe=
r=20
> platform/setup, it is also a nice way of documentation.
>=20
> In your case, I suggest NO_SYS_SELECT_H=3DUnfortunatelyYes.

Ok, implemented it that way now and also made HP-UX support in Makefile in a
separate patch.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--bmlge7Pg4VPvffji
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHmNq9xcDFxyGNGNcRAq8oAKDaYFE7BuS1BDsk06v1iuz1KUWFzgCgyc/p
j1yuI5CrNCgP2soL74cfRiQ=
=JSYk
-----END PGP SIGNATURE-----

--bmlge7Pg4VPvffji--
