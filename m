From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] use persistent memory for rejected paths
Date: Mon, 15 Nov 2010 20:41:33 +0100
Message-ID: <20101115194133.GA3297@localhost>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <20101114130205.GA27560@localhost>
 <vpq62vymmsz.fsf@bauges.imag.fr>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 15 20:41:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI4vq-0003ws-Ux
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 20:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab0KOTld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 14:41:33 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40070 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757936Ab0KOTlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 14:41:32 -0500
Received: by bwz15 with SMTP id 15so5528430bwz.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=GpXOB5OJER2iHdADnKaxSpG4fzWlv9oQ/N8RZqoT6OI=;
        b=Ym16QrZLOUM45dgh6T0uv2Htz0A54v6Duqz5y0D3fSqLosuFCWTzlRFJQBqy8VbKx/
         DW9Sv3VnLISzli4jkS/DghRfhG/FQQrdFc3upPJ9kP53s0Ov02HFwKYeJ4f6M1cWEHoJ
         2xiDpYxYNDIfzHJ6j+tkR26KYFmczAN27/I0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=iNcx2Xo2hCcSj5+jv/qu0SeQyV4oU7N40SlsO3In7/BRUh7DQiwwqOna4UlOC+lJ51
         53Fsn+WSA+oYk+A4EwaSh9XK4foLgnLeeoVbdFgY7XZ7KEWmhD2mgmCMD7NZ71y0G2sT
         +Ca+788MslRLE8Co2738dnyf6PSmt33x8cElQ=
Received: by 10.204.52.134 with SMTP id i6mr6522233bkg.27.1289850091131;
        Mon, 15 Nov 2010 11:41:31 -0800 (PST)
Received: from darc.lan (p549A63CB.dip.t-dialin.net [84.154.99.203])
        by mx.google.com with ESMTPS id 4sm195039bki.1.2010.11.15.11.41.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 11:41:29 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PI4vl-0000sR-Ui; Mon, 15 Nov 2010 20:41:33 +0100
Content-Disposition: inline
In-Reply-To: <vpq62vymmsz.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161506>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 15, 2010 at 08:03:40PM +0100, Matthieu Moy wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
>=20
> > An aborted merge prints the list of rejected paths as part of the
> > error message. Some of those paths do not have static buffers, so
> > we have to keep a copy.
>=20
> Like Junio, I'm surprised by this, but I guess you encountered the
> problem.

You don't have to take my word for it, just try the test. It should
be failing nicely.  :-)

> Did you remove all uses of "struct rejected_paths_list"? If so, you
> can remove its declaration, if not, why?

Indeed I can. Thanks.

Clemens

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM4YztAAoJELKdZexG8uqMOoAIAIrTd8i6Zyeeah7t+rKqRMxM
j0SrwnKuN0v5kKofcQrTBVI7qZL3VpIdOHgaDSB9DK46Ji5LZLBlFtdmeAW1q6T9
nzPBrJNp0sQ8gIddgeERFN/XVCQitKhzfYnlf1saawlO5pQdHypMOgUP6Cns1t7o
yMuB3x4WEq7lEMUmNdo1gF1b6weNB/42inkx3qQvTBatjuxDd6QYseibBFKR/zLy
Nxa2XAvv2T2WIJTmBNibt4UWkrmLuaqhczmqUPC2tplKy+zDotd0O+JMEsR8jw2R
EKci5hMESMDuaViLDPccQf8eZhLYIbC3YBac53M8BC1DEexT45z9rd0V9ao2Dwg=
=Sibo
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
