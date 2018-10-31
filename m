Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDFA1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 15:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeKAA3S (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 20:29:18 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:40180 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeKAA3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 20:29:17 -0400
Received: by mail-qk1-f181.google.com with SMTP id f18-v6so10144490qkm.7
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MsrseBM42eOUn+UqjJ/z0m9z5SlL75itDOh63DM0C2Y=;
        b=X8UF7ZLphpugUu+aIUqboBnG8vozFcMTMzJ56fjQOFzhFUkuwx0S6L4UvDDbXG6hOI
         iEkm+cqitWR4/7Zm2BBKuhn7XpyGF+Ic8dU3PIhNedRH2YSlKuLYxZGrLjwkb5+l0r0R
         1CWVJizQMP/lss+/vAoAd9a2zuZbzIDMNUI1EXyK9LXBzgNQwAsAUOVNbA7oTmPlvC4P
         5w+0xG1dFonKZUuDcOI5Q4YK6ZqJtLp0gqt/U+8EDQhNbefvM+F/F5LlJX3KmYSq+V0e
         Og6IKNHciyYnuGzUaQrMK+m+3xR6PF2Lwaqv80+b2hV+7i1w8vkB3Ih3RuwsiNTVPTcY
         EFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=MsrseBM42eOUn+UqjJ/z0m9z5SlL75itDOh63DM0C2Y=;
        b=IudenhDvENcdjtdbBVEmdOFmrVVzXUq/H+rxHCvbY6txNe+uTaOfyiwku3fppBssVV
         6KLAfTSVWugAOgjkDr2k1Z6Xke7ugTLVqb0KxcQzOn+xlmbxICDqrKG52jYKUeo4xlWP
         E40Vzy8/6v9m3RN1WVyCuEqwNPyRcJxc4GucxAx38WZJMjJFSXd5BSDk34V91GPBLRKa
         ANHDBq5wiEI9uWsEdO6iKGpHgCTNZNS/HHTn0C+x+V1CmsEuEjwGwfkAthJ9g9XH4EHI
         WIhuMshIfvcO2JScrofMkxo57s9kvGn7JyItHCMtGc4gTXKRz6Jts4Xd+TdnHFFFHeF4
         CzDg==
X-Gm-Message-State: AGRZ1gLt1HGp5vxqiGvlMr+sduaZxAWeq5fC+VORiVCaDHbbHprwhHig
        pU2fCCm+1fEcRJITR/9uEas=
X-Google-Smtp-Source: AJdET5cTsMWPB/pQHJLMaJOJTgpb5ABupi0bD+Pag8+osazrlT/gP0i+MYXGMpaEfBwpFjKkD01N5w==
X-Received: by 2002:ac8:4302:: with SMTP id z2-v6mr3010399qtm.295.1540999847585;
        Wed, 31 Oct 2018 08:30:47 -0700 (PDT)
Received: from localhost ([165.227.200.42])
        by smtp.gmail.com with ESMTPSA id d7-v6sm18783172qta.61.2018.10.31.08.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:30:46 -0700 (PDT)
Date:   Wed, 31 Oct 2018 11:30:45 -0400
From:   Brandon McCaig <bamccaig@gmail.com>
To:     Gray King <grayking.w@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Lost changes after merge
Message-ID: <20181031153045.iirgzwwncogxgwlu@test-chamber-21.localdomain>
Mail-Followup-To: Gray King <grayking.w@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
 <20181029141804.GC17668@sigill.intra.peff.net>
 <CAP1N1j7AbiYLfe4EiFn-4zdBd-nD2paXx1hZhqiUCOq4iLh9zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abmy3e3cfvexg47v"
Content-Disposition: inline
In-Reply-To: <CAP1N1j7AbiYLfe4EiFn-4zdBd-nD2paXx1hZhqiUCOq4iLh9zw@mail.gmail.com>
X-PGP-Key: https://castopulence.org/bamccaig/castopulence.asc
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--abmy3e3cfvexg47v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Gray:

On Tue, Oct 30, 2018 at 03:46:28AM +0100, Gray King wrote:
> * Before merge run `git log --format=3D"%h %p %d" -n 20 --all --graph`:
>=20
> https://cfp.vim-cn.com/cbfq6
>=20
> * After merged run `git log --format=3D"%h %p %d" -n 20 --all --graph`:
>=20
> https://cfp.vim-cn.com/cbfq7

I also cannot see anything wrong here. The two commits you
mentioned earlier are not in either paste, as was already stated.
It might help us understand if you are more explicit about what
you think is wrong. Maybe verify that your pastes have captured
all of the necessary information to understand the problem.

The only other thing that I note is that 6d6ed669d1 and
3c792ffaf0 appear to be merging the same two parents, so
logically they should be identical (unless merge conflicts were
resolved in different ways). Is that related to the issue? Was
one of the merges done incorrectly, and you're trying to fix it?
Or are you just confused about how you got into this state in the
first place?

Regards,


--=20
Brandon McCaig <bamccaig@gmail.com> <bambams@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'


--abmy3e3cfvexg47v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6A+1JeuAGnMhPkN33afWAiLlk/IFAlvZyqIACgkQ3afWAiLl
k/KJIhAA2Ht3qusZVdiDP4+4kJ/kMJ8aHIogGz5FNtMwhcgbOe2T45+nWD+NhFQB
yOz3G0gqCcWRkUPqW3RauX0iZE+orBmuuBCxefIt6/xsPGmxt9mvYuwuQDTrwySW
KV9vmeJmcgem9hMnnRXpfwDASpXoPljkqEdY16VeCDsTctH4CXsFVrxELHP76AiK
9p3ksjHaShHQ80wX4+nJowFBAdU2EsmPDWJYhHe+XFSVvvhUGJ3EkcpIYqziEzK0
tdGaE1Dn7an0BzDv0lE8jr8w8u4K57UdXSVlkozCuymdiy+8zJ/P7IZ9Uzhp+395
vrzIOuG18zzuyDtgj7YiOqdPhbsQ69HIXDr3/QWYVNH7RvCxhpV2PszW3eN4LXKB
fCngROTGdzSBjxlPx42fCvLEJC7XCcEOR32qzeBsxBtSq/lEsITpFVpVlYT0UR9s
6273gydXB6koy/mXD6a2qdtmku2dAN914kW0d4gKdw8sjcYayyqg17yoXwpBoOIA
ApS+NIbKvsHCpkY3jcaHkH5spXKlnSt/WnDrfAxGh0JgCUSwqLy/+l8Iv9LOZyEh
6ZhiIk0S47fQnoThcuGsyznZ1kxIml6Y/RRJBdNZSzRU3xcUbluDoxF2KFeFxEhg
R1Uul4CZTgbYSlIrW7QihmI2upZPZGFH3h2TOgd/kXrIQw+k/l4=
=2jO3
-----END PGP SIGNATURE-----

--abmy3e3cfvexg47v--
