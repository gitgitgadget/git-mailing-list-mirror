From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] Makefile: enable SNPRINTF_RETURNS_BOGUS for HP-UX
Date: Sun, 24 Aug 2008 06:33:35 +0200
Message-ID: <20080824043335.GC7185@schiele.dyndns.org>
References: <1219529275-8194-1-git-send-email-vmiklos@frugalware.org> <7vabf3w7l7.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 06:37:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX7Lm-0008GP-Vq
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 06:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbYHXEdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 00:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbYHXEdk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 00:33:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:44908 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYHXEdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 00:33:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so639911fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 21:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=Kvawrmlhq0iFcQsUEgGpqTo21jMm1ZOGIR3rLQ8I67s=;
        b=TQvNDy6igdjCkGRa1Jo+EmcgTIfM+fzlDcUzgGv/2KqEzxmhvFH2Zi9XfxVm/RhZ5N
         imeFv6qKXexHk3fb001XhhLUlMuwzX8f/SXNY1QTgLc2mmfoK/w0dTBJ9Y0DFRBzl78B
         90gOCLzFkRNSUiA6M3VxUfvzH0lpGKLGwT/z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=ErXg2cEdaIkoi979xsrGT0ly7fXIpvKd6XPm7pYnNA8CPBjGiBzA56ucV8AB0tcOWU
         ccL8QQ0SEn8Voj3Tw74xxx5nX1/C0lT39P6+elixAAFsoOyEGIF7k4dbboUKBxlZXxSa
         tkJlfCt+ZQt0lNt4MZ6BhtD7qnDV/Q9npBqRE=
Received: by 10.86.80.17 with SMTP id d17mr2214577fgb.33.1219552418250;
        Sat, 23 Aug 2008 21:33:38 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.124.107])
        by mx.google.com with ESMTPS id 3sm3142803fge.3.2008.08.23.21.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 21:33:37 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 09E374ECAE; Sun, 24 Aug 2008 06:33:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabf3w7l7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93516>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2008 at 06:00:04PM -0700, Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > In 81cc66a, customization has been added to Makefile for supporting
> > HP-UX, but git commit is still problematic. This should fix the issue.
> >
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
>=20
> Is this missing "Tested-by: Robert"?  I do not mind adding it myself --
> just checking.

It is tested by me, yes.  On HP-UX B.11.11 U 9000/785 and HP-UX B.11.23 U
ia64.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIsOSfxcDFxyGNGNcRAn1fAKDvxtc34xeNJ8u2gPXMCQP2BuMRogCfUax9
5z+c/K7EPMFjxFm3oRmWr50=
=hm5x
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
