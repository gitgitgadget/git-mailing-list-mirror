Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF7A201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 22:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdBXWxy (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 17:53:54 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36502 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXWxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 17:53:53 -0500
Received: by mail-qt0-f171.google.com with SMTP id r45so28378860qte.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TqZn6SHtq7LPfG0L4D3DXaBv2MxA3edsVWBgV+HljLU=;
        b=cGXtGnxndUZ62Wo6/cgmQvxcWXJ/2oJaBL+S4L07tnnSs8GDf1yf0M6Zx6QRRmQGAV
         UcH+vTLc+PsTRpct6FafxIAB3fRIVgqLXi5enkxyxuq3TtkD0+sGKOiaG/L8OdBQICL1
         w3CANUcptOKCCI/Cku2nnvKUVyew+PTFSpBxreRa6lvbXBHIJmVxXhfgmRN2YXmOsp1o
         w52y1tv0wpcQo3dGUXkw4QRnsYtz98w6Llsw33fm6T6c/X0lshUTx6D9Bg6cMDny1jIN
         eAPUpMk4FJSwfWhWJJ/HGQD55U3dHqdfzuHLOkDBi7HYQpxJV/kiExyk+K981tEDSkg6
         +ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqZn6SHtq7LPfG0L4D3DXaBv2MxA3edsVWBgV+HljLU=;
        b=cBNyjJFXHwWBqSEOVXQlYvVkmm02XhOEQR3soXLhnrh/nflKiAbOMKU5c6IG/m3bE1
         0CFcfmNPy/fW8bcnViVJBEczKtGFiw3X5jJLKpLvb4a0/+LsWyH3j+5e3pGeC3PYLwwX
         pkQYoWzm7k5lDdtQJ8jGquiZDN/AShkSNGkArCWfSUSBE/xuWtrGjLfFICd7rzdRxzdg
         fFVzZmDZfRfk+BzoqTLVeDTq6LyoHQDAuEsVsCMgnBpN+rUM/cFS4p70CUkUQqUsHT9C
         FVa4Z40Kd0LTZEkbHXkDlXEiPT4XoHBhE1Z0FK47VhJHJ1fspGfg0SfsIzvE7sVk43t7
         ej5w==
X-Gm-Message-State: AMke39k4MlMLIAYkjz4ys3tQ2QLcEflJmjHOZHvd2bADc8+sHpY8FpMAiXGsLKrTErxnl84q
X-Received: by 10.200.1.72 with SMTP id f8mr5213602qtg.271.1487976832323;
        Fri, 24 Feb 2017 14:53:52 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-03.NATPOOL.NYU.EDU. [216.165.95.74])
        by smtp.gmail.com with ESMTPSA id z139sm5683414qkb.29.2017.02.24.14.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 14:53:51 -0800 (PST)
Date:   Fri, 24 Feb 2017 17:53:51 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170224225350.xb7rudyhowmsqdbc@LykOS.localdomain>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yyvrct7o6m4bhgw3"
Content-Disposition: inline
In-Reply-To: <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yyvrct7o6m4bhgw3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 11:47:46PM +0100, Jakub Nar=C4=99bski wrote:
> I have just read on ArsTechnica[1] that while Git repository could be
> corrupted (though this would require attackers to spend great amount
> of resources creating their own collision, while as said elsewhere
> in this thread allegedly easy to detect), putting two proof-of-concept
> different PDFs with same size and SHA-1 actually *breaks* Subversion.
> Repository can become corrupt, and stop accepting new commits. =20

=46rom what I understood in the thread[1], it was the combination of svn +
git-svn together. I think Arstechnica may be a little bit
sensationalistic here.

Cheers!
-Santiago.

[1] https://bugs.webkit.org/show_bug.cgi?id=3D168774#c27

--yyvrct7o6m4bhgw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAliwuXwACgkQRo8SLOgW
IpXA/xAApjGcw7KSa2Ay0auN3E92ojSbaJbvSLn2jOk0VvYoXp83M2i5UGM+QFm/
Jv785Zcb/sgW/A7yqwyZJ0AZm0mjHIK6v07hk8f5nAKEzTvUQeEX8P94jHr+IqcB
Azs68gxPxBTmJYJoYuma3C2noJLbtl5uFUM3XDEDMvDYtj6OITYhov5iryixPzUA
BcTwflgYAM7YpwknW/93l1Lgw7nsamowcfrrCOPsefRvZJL9kT6SMn4jrmGBakAe
w8gJI1K+Dct7yvblf0CI3K5AEHVgT8vn3ybtVnA9e4nomQOA6C6jf4Cgkx5fQoeU
1R/o4eCq+obdup615ood4HTWgWyyP4tTppdwwOEIhL3MuFOzBI3VlqSl2L+6Y1lH
bY1DviQKWkUPK9yMv3MiDd7B0vV6WQLmOIP4FdSOt4TgoZlqUpUjRl9ilUoJaw1f
7VFw/5J6s8IcLLefky2oh8rSvzqlv/RVP4R3hr7rMK4iJhGDeJvnkFoJ01EiwHsN
j/waGJjHIFRfiCS6Xx1JcBOEIWcAEZHJZLBvw5tuALmUPK6dR3XCnuH/lgCYTN44
c4VaCF4sCXs+vZ+h7idCKG9/iia6lwU66UT3s008b1xCXhkDdATiIt+dgm8QnnI5
SD3HhD059vdh+0hJhWno3eB8aRfZRJyMe53+TmrVPJEMUWFYbFI=
=fyND
-----END PGP SIGNATURE-----

--yyvrct7o6m4bhgw3--
