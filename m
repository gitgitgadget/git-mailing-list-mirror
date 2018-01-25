Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A6E1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 17:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbeAYRSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 12:18:00 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:40484 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeAYRSA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 12:18:00 -0500
Received: by mail-qt0-f175.google.com with SMTP id s39so21029853qth.7
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z/E9WO2/adby8LipI7NENWPzOeOqeIWX/ahOQHg11TM=;
        b=zPyupiSe/P17V7XtS7Olv7IyTeNcs7EDxGjGHs6Dfgw81EHd63OZxAq/EVY0gKcM4Y
         RA0C2yzpi15IWiIqUztNXO2nssX3kPbhl5mDT5ryx3zag8JoHJZsOIxeThdlkAdQjgiy
         pfYBV8lDv86dV5sTBZQCciRbVxVUQQvii34HLsyF24Jg2yPAxY8Ruom1OScWCNTmdyJx
         wZR9CaNH8nJxIas1WXnAZFqzhveAMAsPHKOXSXUp8cUgwgS6OX8Ws5Xm34J6s8FOyWXk
         n2WAOeEXeGbbxhE/56r3oAdv4iC+5v9jxKlXMYjwPbkiuOYe5Y2mEtelZng6L1pfiv84
         D0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z/E9WO2/adby8LipI7NENWPzOeOqeIWX/ahOQHg11TM=;
        b=Bg7oqV8ImzSGiOYWpPIcuZft2Q7ZwFzyUgYyANLvyYg6ciDycjsWGyGEr5TlteIm7c
         4ceRdmmBEVrt9dWPpupE4HpwgA4AyJRVStDqiA0dLux3V45U3P+UOPIaoZq+zapNJ3M9
         O6eRgH1qffgRB5YHm0LRU1qK0/2GmYte6LvyOY8FU6PWsO381HUquvEiJjaTn3Tkju22
         8ZMiE9XU2r61yHWFWvvNqzAsJ/o7EvvYcPWNSbVa1HRqzeyYZCxaRI3PBQvexaR360RW
         IramYoD/PuzZaFZurhC2hyscvDz07TDZq4FMKgPAaiEYLuTrkkFyVqn5A2Ep2AfFtcRx
         rfoQ==
X-Gm-Message-State: AKwxytf+IkgTw6D2/9XqA6z6CY48IJ0nxMYp+4coNH6vL7Qk3ZscSLRm
        nLeCZaiRs15U9oZccIMNFQzXjA==
X-Google-Smtp-Source: AH8x227fHA1ioTTppwmW4Oh6mh2WidDOrvzOMqNL5lWUVX8Uf1Q0uDmGB+z/NmB2jcei2gaqUHeZow==
X-Received: by 10.237.42.165 with SMTP id t34mr17171496qtd.60.1516900679308;
        Thu, 25 Jan 2018 09:17:59 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-178.NATPOOL.NYU.EDU. [216.165.95.178])
        by smtp.gmail.com with ESMTPSA id w12sm4201446qtw.78.2018.01.25.09.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jan 2018 09:17:58 -0800 (PST)
Date:   Thu, 25 Jan 2018 12:20:58 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     christian.del.vecchio@zurich.com
Cc:     git@vger.kernel.org
Subject: Re: GIT 2.3.1 - Code Execution Vulnerability
Message-ID: <20180125172057.ie3pvhxx5egpil35@LykOS.localdomain>
References: <201801251702.w0PH2YFI000707@b0d0p4a1.rz.ch.zurich.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w743utwebd4bi553"
Content-Disposition: inline
In-Reply-To: <201801251702.w0PH2YFI000707@b0d0p4a1.rz.ch.zurich.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w743utwebd4bi553
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Christian.

They are probably talking about one of these[1][2]. I don't have access
to a solaris machine right now, so I don't know which is the latest
version they ship, but they probably backported patches.=20

Here we can't do much more about it, given that the packagers for your
solaris version are the ones (possibly) packaging 2.3.1. I'd email or
open a ticket with Oracle after making sure they 1) haven't backported
patches to fix these, or 2) don't have a newer version in their
repositories.

Cheers!
-Santiago.


[1] https://security.archlinux.org/CVE-2017-1000117
[2] https://nvd.nist.gov/vuln/detail/CVE-2016-2324

On Thu, Jan 25, 2018 at 06:02:34PM +0100, christian.del.vecchio@zurich.com =
wrote:
> dear Team
>=20
> I am Christian Del Vecchio,and i work in the infrastructure of Middleware=
 on Zurich.
> we have installed in our system Sun your product in order to connect to o=
ur bitbucket repository.
>=20
> we have followed the instruction provided on your Web Page:
>=20
> https://git-scm.com/download/linux
> pkgutil -i git
>=20
> the version installed is the 2.3.1, and actually it works.
>=20
> but last week our security team informed that this software didn't pass t=
he check control due: Git Server and Client Remote Code Execution Vulnerabi=
lity
>=20
>=20
> please, is it available a newer version that fix this problem?
>=20
> our system is: Sun Solaris v10 sparc
>=20
> best regards
> __________________________________________=20
>=20
> Christian Del Vecchio=20
> Middleware SME=20
>=20
> Zurich Insurance Group Ltd.=20
> bac de Roda 58,=20
> Building C, 4th floor=20
> 08019 Barcelona, Spain=20
>=20
> 64402 (internal)=20
> +34 93 4465402 (direct)=20
> christian.del.vecchio@zurich.com=20
> http://www.zurich.com=20

--w743utwebd4bi553
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlpqEfcACgkQRo8SLOgW
IpX0gxAAggBoDJQbiAs8kURVKjm8PAkHZUbogmQfTIHTDN3eUl4q/JcKu+sVO3Ui
CGl4JIPkFxILcD9uqForJD6PwfTrehOM0y0+lGMDW0LZPWPVdX+xhvvWmZ2JaC/H
ZDAUU6SWYFunLEuTW+vorzECyxikwnChUUVGSTjd+QR+ofITcqsMBfFBH86CT3/B
3235FLXczk6wlFlI55X6IEEyy0kSKgPSKyp938GPZp/Kn6ElDivT8tRNqrGgQ7M7
oY2EifM8lcqkFyaBkHKrqpfEtlizA17N69dAlNtm/MVzJwSWKpL0nXqaAdpZAnpq
RAsJNoG0wtw0rs7T/Gt9nxWsNuCa9FaJoYcSnSxNQPk4WLln+RFMDNLugUmC8DY8
tHe4uhnAQlaKaQ0GK1sFAtfwmm3FgJ2L8dYAXMcaLZt295M++Q5PuGNHPt5LDpXQ
Kb9kX0J809GPe8CS2eK3oE05/lBMBv+ME1uBVykL2iZXmydcMZ0Z7gPX+Yh2J/iw
q3/cjYjJffcGNZdFozmkUMz54NOTr5jXDmozvDyTnAt1ajAJD3F6muU+W/ZKgJPa
H59ZFRUVq2ZOTyhMX89h7l19W4N8Dp5fayoIUq6VbG7y/A0bC8Z7mOJO/XEKeZMS
aUtANTUPMSwkwwTiiWVX0A9cvzGEKXmriHvi9bgWMv76N+Z0bJI=
=IT/D
-----END PGP SIGNATURE-----

--w743utwebd4bi553--
