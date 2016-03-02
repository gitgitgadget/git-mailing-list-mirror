From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 10:51:19 -0500
Message-ID: <20160302155119.GB8064@gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	sarah@thesharps.us, viro@zeniv.linux.org.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 16:51:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab93k-0006vM-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 16:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbcCBPv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 10:51:27 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36332 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbcCBPvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 10:51:23 -0500
Received: by mail-ig0-f171.google.com with SMTP id xg9so44331411igb.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3G2J2dRMcKMk3v16rUCNWzSor1vIX+ZHdZDyCMNw4KI=;
        b=N8KVLhRk2dEs62hUimHRxyvwaFEg76zRjdLwRDojUnaJR9s+zW5KGvk6Bi35SBRpy8
         T6Tfd1dbJRQgxXO/gz/dFmu6bMy/2YjCRDUTaaN05JiKKUsvq86EItm8UK+Z3gY5aZaw
         focV4pP3SIr3pFW1W5DLJ3rGflopElSLJp+zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3G2J2dRMcKMk3v16rUCNWzSor1vIX+ZHdZDyCMNw4KI=;
        b=aAemw+nVgCIbLiUDRrjccweAdiQDOnFzR6Zvvb/S2X1M9vwmyynFxigtpE+OotEI2J
         hsMDy5T0K+uIF1J90Iug+pbqS48/Wyhy74Ziyq9TjNnCWQzEcOncO08UsmZ0XvFYJy+Y
         GdBjYuF8g0wKhz04x7V359IcV+ztWcx/o2hL4hc+IlVLUApAS7d0Bp2gDf6gF5z/vGEm
         x7HEu1onEKrFc8fRGSYyW7W22uNrbXIzTFBbG7bKSjsL8PEdtIus4R8WioMeaE5olIFW
         Ymzju0S5eaERG5nnLCg3kjz6LQVqJ7l6uT9W/sHpg+b+8IHos4mOtbS3Gsp8lVk2nC95
         CJSQ==
X-Gm-Message-State: AD7BkJIfb1NVO2XNttbFlNmYobEt6G8bzQvFLBAe4zni6B4NhMYsymYriIokgNR6JdXuFvfb
X-Received: by 10.50.178.180 with SMTP id cz20mr643715igc.44.1456933882617;
        Wed, 02 Mar 2016 07:51:22 -0800 (PST)
Received: from gmail.com (198-84-251-213.cpe.teksavvy.com. [198.84.251.213])
        by smtp.gmail.com with ESMTPSA id z15sm1853423igg.9.2016.03.02.07.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2016 07:51:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288126>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 12:41:20AM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
>=20
> > If you clone a repository, and the connection drops, the next attempt
> > will have to start from scratch.  This can add significant time and
> > expense if you're on a low-bandwidth or metered connection trying to
> > clone something like Linux.
>=20
> For this particular issue, your friendly k.org administrator already
> has a solution.  Torvalds/linux.git is made into a bundle weekly
> with
>=20
>     $ git bundle create clone.bundle --all
>=20
> and the result placed on k.org CDN.  So low-bandwidth cloners can
> grab it over resumable http, clone from the bundle, and then fill
> the most recent part by fetching from k.org already.

I finally got around to documenting this here:
https://kernel.org/cloning-linux-from-a-bundle.html

> The tooling to allow this kind of "bundle" (and possibly other forms
> of "CDN offload" material) transparently used by "git clone" was the
> proposal by Shawn Pearce mentioned elsewhere in this thread.

To reiterate, I believe that would be an awesome feature.

Regards,
--=20
Konstantin Ryabitsev
Linux Foundation Collab Projects
Montr=C3=A9al, Qu=C3=A9bec

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1wv0AAoJEDS6uAr58ke4rf0P+wVouBu/8pBe1eBDCbY7c8YC
ruzBgJcAcLc5de0/xi2V4ygXuf99BrGgZuP0qlk/w7sCEE/ULEDY6NK0gvZgKr3c
eWQRA98stec7H0MBOB/6CHPDyUMFSVjD1nBkUagv2j5JvHzrNheLSuDOT0lPWuy6
cvEJ4bgux2JBGGB6/QkWoZ+dsfyz32jj2xBT5XdmtimhTry0vu4tmVOJbifOn/We
Q+owLPJ05nnhS7lHjkFt0phk4bq4V3gAQpiZ2mq01RkQbCNYMrKBC+OG4IAcMF1t
ZuOnkDvePvWUTGUc5C7A92/NWbALaIMG8IRdj+wjI4+eiqQwpYfaBoZHoI2XyEAF
5CmIESrisnezXdQxObpNGJlbjIqFll3GT7nHGqal4JLFHnn9Psoaxky322uIwnop
Gqjg5c2b+Lb+LoGjJ/MHDJklYXxkNyxZpspvTdyW4g2pfUZqJ0WcWJugaJlhPT4u
jJdgceX13SIbplTAczdrmcSeOeIxbCXXuT/X0uoIEXj55kYBzo02PMOlUOkWzZBU
x+H3oHmgGtp+jg6qtAYyMjlCvU+7C6VhcfczyilluyJav7IyPWB7S93CmH2MEwOY
vn+zYyZkU29sxSnaL//FbqYS2xfOKh6BCTmyBy+RFoK3DHtAr3/By4O3soRv7oLb
BbnWGhhjLj9DAm31cZjk
=GIOc
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
