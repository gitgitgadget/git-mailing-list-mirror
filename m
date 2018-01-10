Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76321F404
	for <e@80x24.org>; Wed, 10 Jan 2018 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966326AbeAJQgX (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 11:36:23 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:46576 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965887AbeAJQgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 11:36:19 -0500
Received: by mail-qk0-f177.google.com with SMTP id l64so249552qke.13
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=70u1+PLFkwAbUW/I+s5cz7hgcmLNkIqn9eAoTrmdlUQ=;
        b=Hi3LfSg/evTON0JM9eLbdabfKVKXahRziR07+Iz48r9BP/kdJTMGMFdhAtotVfVv6K
         nN9d/0Xp9nZ4VcRQkEMYbh1o0hzRh9WlTHc3azYwEsXTVJ+6UPnX1aRub/1OEl33XM7e
         BNkUQYHms++abymcaujlDE8VN7bR82JFrqsj3RvOcwVGbstQ+9ieQ+hz3I9DkwU5Y8w3
         KpyjelALnmBKVx7uWjgtJ1f4I6i2iOnQMEKt+frmD1loC9X3h0gs3UE/v6OBu0aQb3Fi
         jLXsLpCuZAFv9t7L3Sh4qFXUHv+XIcytBOXSuA9FYVkCU1RNExbaPLRe3wbWjuVxegI/
         OFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70u1+PLFkwAbUW/I+s5cz7hgcmLNkIqn9eAoTrmdlUQ=;
        b=aMj+SmDw5WrftJ43aPwDXNEMXTDS+jlpFDssGXSjgWU3NYtNHh2gHr27JudA3FR4JE
         lUbNex++yDWF3eesReVxGmYOM3wa48FgrDLqnVfd+UwuBSgbxknsCujl2hUOczj2vzKG
         LeA4gwZN2uVfj5vcF14lIhT+SL/1KlnJO2vD3SO80KDMfBBcWpWtMQqYVOsVoqvDemDU
         uuPZEeHfbnK3IbtdaPVaPHAsDl7X2ZWUjKxzQVgyN8Teh6+NJb5oe00Pb9P2PILK8RK3
         VOtnxrHRLjCQ8/vj4KPOPtpWFGRpU4t3TdVeOJ+9vyorLnF0itDnXhbELhTQwYPLGALh
         2dow==
X-Gm-Message-State: AKwxytfYCfQLfvcGcTqqpJj8QM0P4LbyXYmDdA/kXsQRHNF77nIrwud5
        lA9pSjTROKGVtkcUuW4i0OyIJQ==
X-Google-Smtp-Source: ACJfBosbFWeL1+wyfPD5HqopHFhvoMz49aKf3OrjLi8CNcjc+sxN1VAJ82pvmdWHhx0C+i/X9EU87A==
X-Received: by 10.55.219.10 with SMTP id e10mr19047442qki.301.1515602178401;
        Wed, 10 Jan 2018 08:36:18 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-136.NATPOOL.NYU.EDU. [216.165.95.136])
        by smtp.gmail.com with ESMTPSA id i35sm10980447qte.96.2018.01.10.08.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jan 2018 08:36:17 -0800 (PST)
Date:   Wed, 10 Jan 2018 11:38:57 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Colin Walters <walters@verbum.org>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
Message-ID: <20180110163856.5uy4lbon322ey3ns@LykOS.localdomain>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
 <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
 <1515465051.2895186.1228754952.0036D645@webmail.messagingengine.com>
 <20180109180933.jbyidmmv5xpsjuae@LykOS.localdomain>
 <20180109203849.GA30468@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5paapvswm2cmqbz"
Content-Disposition: inline
In-Reply-To: <20180109203849.GA30468@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o5paapvswm2cmqbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > push for hash-agnosticity. I don't know if git-evtag is hash agnostic,
> > but if it is not, then we have two transition plans to think about.
>=20
> I don't think there's even a question here: Git has to transition off
> of SHA-1.
>=20
> In that context, Stefan's comment is a welcome one: once we've
> transitioned off of SHA-1, having a separate evtag feature would make
> git more complicated without any benefit to match.  To put it another
> way, the gpgsig-sha256 field described in
> Documentation/technical/hash-function-transition.txt provides
> essentially the same functionality as an evtag.  What's missing is an
> implementation of it.
>=20
> I'm happy to help in any way I can (reviews, advice, etc).

Same here, although I'm a bit swamped with other work...=20

>=20
> > Full disclosure, I published a "competing" solution a couple of years
> > ago[1] but, in my personal opinion, I think push certificates can
> > achieve the same security guarantees as my system with very little
> > changes.
>=20
> Work to improve the usability of push certs would also be very very
> welcome.

I agree. I personally think that at least the sample hook work on here
would be a good candidate for this[1], although I don't know what's the
status of it. The way they are right now, they should at least warn when
push certificates are not enabled on the server side (i.e., there is no
hook to handle it).

>=20
> Thanks and hope that helps,
> Jonathan

No, thanks to you :)

-Santiago.

[1] https://public-inbox.org/git/20171202091248.6037-1-root@shikherverma.co=
m/

--o5paapvswm2cmqbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlpWQaAACgkQRo8SLOgW
IpXyTxAA1tRbP9i/SR9Of71aLTb4ovGwB9iYgdqlDqA3aP0JTbD5Bpq3gcFfHolL
n12oxUy8eSJjRYU0CrDw1ujXZJkyJwEzcYfi6Es2RppTWhTgKsRLHQ8u+njYv8UB
xwtG1EFsb49gGIlC3feR5HTXaeF8oi4TMvNYq+4ooL95gIhaa1GOqVEgJc2PjK8J
iJuSctknUWarWfY3cLxyL9LFP5RfKN5CPBkL4Zrqr8rlHF3mTPxLUDkrxeiFX0i1
qnhqGOWhuo41LdFdKk9aVHnqoO+BgBA6aC6kz1gjlEZ+uB5xcG41afiCQej7OYYN
2/d/nbBcaC2HeeAdpC1HaXBHZwU8K+5OlIUguv4CVa46IVdq85MybX3ljYuFt3Gi
qB6GgJOVCSMQsRsnFtjpda/yjxxKvMgBKoAddMSitqRE5p6Cm54E6CzY0E1YW7Qu
zv89EpE551VUWu8x+/0MUjFJWQQuW4GE1rItyjzeIPyOt5pUCsOeqkdzT72RPSZv
+zX1CyPJB2KHqoafHm6lzRoM/H3QvNCRcqfMraM0hAjxOFGXmHP+ci8n7TEJN96z
UwanngptWlmGUysqTBndIAsWGGVyNFo8uGmgZnir06N3Mgba6q7jtwhy1of8LPI6
mMm78zSDXUtAtAjZd7CoS7eXuKIW5cA4qyWI8DowyzrqtoN27ak=
=q+QC
-----END PGP SIGNATURE-----

--o5paapvswm2cmqbz--
