Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8299B20357
	for <e@80x24.org>; Mon, 17 Jul 2017 21:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdGQVmp (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 17:42:45 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36418 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdGQVmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 17:42:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id l55so321693qtl.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ubembzeh2eeftUuHw1zGUaTgHubTXNC9KkMuaRj1qmk=;
        b=v+cfBprv2w7mXsNwYVE+4VyDAfMFVyTTQElLmj5MaOQmeNEqEZdcnL+bwHpPCriNHA
         3kdodIsXkHKljBdFr1IYcO8kpXU25krPDGPyYHBvjUwvV+7l++z0MbX0Wx4q05mS8b4u
         JSg6H49T4lFnEi1hHNtSfXPIDxFJHcYJNxw9t13+k6FcVIBmCEgs/PHKEsh0etA87xcD
         vlYvMOpCgw3wG1/x/DarqyLxbheuM0Ix+jqXQ48m51jWdve/mr0X9zKJpefoC1p206Sc
         RlVzrUAWSxHm5Fkg+rEjdSpRH9PHuGaoLMkI0hPqhyriL/BMDcNDISVGYiOJUgfNYR9e
         woXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ubembzeh2eeftUuHw1zGUaTgHubTXNC9KkMuaRj1qmk=;
        b=V7tqzMQ354zdkFFqMFRDWcez4IqCODKOt9CsEm0ffpw/9Lli26kd2SCiUTeUgp0/Zj
         GYr4kzsK7YtAKyTXky8Uq1hVEAURX028OserSYn/7rJAplmhaOLLtP9rfTeGXv69aXID
         KtulR5FnkCiXrXMSZQsuagnce6l56rZ6zRyL5s2AIdFBfguMNNm/2mb5MgXt88/M78qZ
         pQkdDtxLY4dVMoLIv7aDA88BW68snBjWr8Zz+py63bmPf1SZcRqXTk6XsccNFkisZGsp
         Wqkd+X+87Bq0UQdEhcQnN2Nc3hpBjco8TW/qCobbymaBGyP0DzADqfq7m9JH56ZVv6aw
         8KDQ==
X-Gm-Message-State: AIVw113KEtRs8TLuAwjNJbqnkzh5Y3X6ux6EdIx4o3T4vK9Y9IzLX3zS
        LB38uWpsRWMQJSpBeZA=
X-Received: by 10.237.47.230 with SMTP id m93mr31922168qtd.103.1500327762831;
        Mon, 17 Jul 2017 14:42:42 -0700 (PDT)
Received: from LykOS.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id w46sm287079qtw.28.2017.07.17.14.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jul 2017 14:42:42 -0700 (PDT)
Date:   Mon, 17 Jul 2017 17:42:41 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
Message-ID: <20170717214241.yui75hywg2ddkfsb@LykOS.localdomain>
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
 <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
 <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
 <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
 <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ncshigyuap3inwu7"
Content-Disposition: inline
In-Reply-To: <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ncshigyuap3inwu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I'll dig into this. This sounds a way more reasonable approach.
>=20
> Thanks.  Another thing that may help, if it turns out that we do
> want to let agent run when it wants to

I did some digging on the reason as to why this was happening. It turns
out there is a bug on gnupg. As of gpg 2.1.21, all operations require an
agent running (BTW --no-use-agent is effectively a no-op now).=20


Given that on versions 2.19-21, they changed the way sockets are
created to be stored on /run/user/UID/gnupg/... deleting the $GNUPG_HOME
directory wouldn't flush the agent socket, and would leave an agent
instance per test running, possibly forever. E.g., make test would
result in the following:

    santiago at ~ =E2=9C=94 pgrep -a gpg-agent
    632 gpg-agent --homedir /git/t/trash directory.t6050-replace/gpghome --=
use-standard-socket --daemon
    1192 /usr/bin/gpg-agent --supervised
    2939 gpg-agent --homedir /git/t/trash directory.t5801-remote-helpers/gp=
ghome --use-standard-socket --daemon
    4656 gpg-agent --homedir /git/t/trash directory.t6300-for-each-ref/gpgh=
ome --use-standard-socket --daemon
    5427 gpg-agent --homedir /git/t/trash directory.t7510-signed-commit/gpg=
home --use-standard-socket --daemon
    5898 gpg-agent --homedir /git/t/trash directory.t6302-for-each-ref-filt=
er/gpghome --use-standard-socket --daemon
    7747 gpg-agent --homedir /git/t/trash directory.t7003-filter-branch/gpg=
home --use-standard-socket --daemon
    12922 gpg-agent --homedir /git/t/trash directory.t7600-merge/gpghome --=
use-standard-socket --daemon
    13572 gpg-agent --homedir /git/t/trash directory.t7004-tag/gpghome --us=
e-standard-socket --daemon
    14521 gpg-agent --homedir /git/t/trash directory.t5534-push-signed/gpgh=
ome --use-standard-socket --daemon
    16563 gpg-agent --homedir /git/t/trash directory.t5541-http-push-smart/=
gpghome --use-standard-socket --daemon
    17853 gpg-agent --homedir /git/t/trash directory.t7030-verify-tag/gpgho=
me --use-standard-socket --daemon
    29858 gpg-agent --homedir /git/t/trash directory.t7612-merge-verify-sig=
natures/gpghome --use-standard-socket --daemon
    31100 gpg-agent --homedir /git/t/trash directory.t4202-log/gpghome --us=
e-standard-socket --daemon

Other projects such as notmuch opted for a solution that's simlar to
what I had suggested[1], but I wonder if it's even necessary to do.
There is already a fix on the master branch of gnupg[2], which I imagine
will show up to the next version of gpg2.

I don't think it would make sense to fix anything on our side, unless we
want to be extra sure the test suite is not leaking agents for all gpg
versions (including these minor versions).=20

What is your take?

Thanks!
-Santiago.

[1] https://paste.debian.net/976970/
[2] https://dev.gnupg.org/T3218

--ncshigyuap3inwu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlltL08ACgkQRo8SLOgW
IpW84A//Q6pvChU6oFh8FVnH3and6aNDxWa2I09LrfY3aZILvMmaVicCfd75aRyJ
fsLcbGU6nw7cfMf84UbitlIcc1OV+H4k8PukO7lWA87U8nMaD/r2wuyFCOwK89g+
4LzfecgpWeM6gX1Zg0c/VimrMkrkcXRxoLncDoAfQ5oQoYwSmNbcxlhK9KzszHeQ
NoJVt2OZpVKgKyb69m50WXHh5QR1/P2Es9HTrjbFONQbPW5IMF0kSZzdu7eqL9HX
1yToSeFUd9TybHkoCnVvsEBLRComZQMqnW1+0PwlYjBPeHg2n7FYRNCLrLh8EiB6
ucpJaWA/uryWlKJ/KfmD/5f/kZSB/G5reICyjMVJEMcFd48pHeL3jvRu+WAf/8Iv
eA3oQZRA7vhnA9SXOAKRaZqHCDnxh6BHCVHsl/GClZZgqMvSP3sTvdvTLmjg6Xkm
YVTkxk9QRyB1TCeXzyRZWJsEVu9r5W2I7EoDxRrZ5Hx1gBa8KrokwZj0/2jY/BrZ
trorgaytT6jmayEazjew6gqQA3+dJt/aKwiF7eiWIRPOa0IqyQHVfnA0VaVaTKZ2
zmPKED3iNSW9icBi2fFAuDx9Os4wACu0ucFckVBcOF/cBIKgqsIu/AXZwP/Nw86S
nlGP6QTgRRRb+GcTHFuwvkqoHMPxas2VpNUsE3ETuQ33KqJE1UI=
=l29m
-----END PGP SIGNATURE-----

--ncshigyuap3inwu7--
