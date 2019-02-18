Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA081F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfBRUOb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:14:31 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:33366 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfBRUOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 15:14:30 -0500
Received: by mail-qk1-f179.google.com with SMTP id x9so10752893qkf.0
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 12:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:openpgp:user-agent;
        bh=IznwJ0jkjz/WF7XQmEjiX6vQVhkqI6h/f9GFABwbW7c=;
        b=AT5QpOQaHwXA4m8lT4h26EOvc6ER0nBkvisYxU+4ZRz9BhkYbn6G/VjMC4q2uB+u10
         E6eSo28nFALm9wM/Yok+LaCboZpTlprHwtG9QpImUUT1BD0ymgToufkKW0DhDms2sGhf
         8nnvUPnWxQnRIKE8QoTwvWFxgskOpWl5CiGlHUJK2TcyKLO22rooXTxPdxEJmV4BXmtc
         x6T0ztL4fom/srVtarZByuU8dIAeoxaWw9D0PTm/q/zm9UHMnP0wF2bl9/ml5v+61Fmt
         G2Hmnsc9sU1VIEfw8N1zblINGhQ/wVJaPH11O5TmlZpbKY29VBjEuQVUk05nkUZCyuuL
         cYeg==
X-Gm-Message-State: AHQUAuZ34OOON/NbxyxrdKH5tQdu/OBV1mU5fjconbaGkwpKQJ3/wYPW
        xHsBQBu3ZlEE9JuLQFDijfjzFTRWYPk=
X-Google-Smtp-Source: AHgI3Iatxv4Ljmw0YPMLPPZj3AD+cKHNXGXw91ZDg8Vyvz3MDSnl+mEubLZLDwIu0CU4jevig71vvw==
X-Received: by 2002:ae9:ed17:: with SMTP id c23mr17176564qkg.295.1550520869646;
        Mon, 18 Feb 2019 12:14:29 -0800 (PST)
Received: from sirabella.org (pool-173-66-112-10.washdc.fios.verizon.net. [173.66.112.10])
        by smtp.gmail.com with ESMTPSA id z190sm8008324qkb.9.2019.02.18.12.14.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 12:14:28 -0800 (PST)
Received: from localhost (unknown [164.106.75.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sirabella.org (Postfix) with ESMTPSA id 203D41206BB
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 15:14:28 -0500 (EST)
Date:   Mon, 18 Feb 2019 15:12:32 -0500
From:   Marco Sirabella <marco@sirabella.org>
To:     git@vger.kernel.org
Subject: default gpg signing key
Message-ID: <20190218201232.pqyy3kws75zduq7g@Ridl3y>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkcffzyf5feq6x2b"
Content-Disposition: inline
OpenPGP: id=814C92678D24FC4AA24366ED4CDC0A30858D94F0
 url=http://hkps.pool.sks-keyservers.net/pks/lookup?op=get&search=0x4CDC0A30858D94F0
 preference=SignEncrypt
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zkcffzyf5feq6x2b
Content-Type: text/markdown; charset=us-ascii
Content-Disposition: inline

Hi all,

When signing a commit with git, the newer of two signing keys under my main
master key is used. This is even the case when `default-key` is set in
`gpg.conf` (`gpg --sign` uses the correct key).

Is there any way to tell git to not use the `--local-user` flag when signing,
and just let `gpg` decide which key to sign with? Or is `gpg.signingKey` in the
config the way to go?

Thanks,

-- Marco Sirabella

--zkcffzyf5feq6x2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEs3QU5t4vovA4Fux3NQziPvsg0acFAlxrEbAACgkQNQziPvsg
0afQaAgAimP20Gvls8sFmyYh7b9/yvUAF/DzPnJL9woYsJpiZd/2JrggTRJMJ3GC
Be7srhDBNcFxAjjc4ob9PuxZzwnrAGmJGuIyVbfDFywMo7/oUzEw0CoyAugYRN0G
rlsuCJ6lK9ZDQrBpXNqViyS4sK7YhRN6gmcjwEFwwoXaT2YpyE7xKXh93wmjuP+L
9SLm1y/pm9CXAlDfAYW6TQGoFk4gf1G8Wl3VVUgBKAl+Y8/59EaV8dbMRHPGs1pe
4CYUjUKMrK112ldBzR2teNW6SsrhbD5FhlUtMWZzaFbZAGM99cPa5IzCn3oTa5E3
JkCeI5D46jGOqS/YAM67ay3fxdeU8Q==
=EhAd
-----END PGP SIGNATURE-----

--zkcffzyf5feq6x2b--
