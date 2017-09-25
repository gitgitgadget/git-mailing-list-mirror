Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4910202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 19:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965745AbdIYTWB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 15:22:01 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:56401 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965005AbdIYTWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 15:22:00 -0400
Received: by mail-qt0-f177.google.com with SMTP id l25so8034953qtf.13
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xbHlEFrTG1Bu+Yh6rsQ72I5b/h4OitmTqnzGtxrZdLs=;
        b=yrWRQewsU2XP5Rzb+Gfi/MeI7I6O+UGY7eMpvg+2hkD2CkU6NLlEtSYXESVxSIXgXr
         PqXt/2Ex0wOaHP0BUcNXHRnIwyaXa3+t89ERIBrHF3mkFYj2bz9zFd1h12nLqOC8nBdK
         bBebmravk7+0ePAGcGFLVwdv/NFim8sGAJyIhk3rmkr6Zlz3GR/+eJu3lERMXmIugfN1
         8A0r9UL+2K0Qjwbdk8+PUxP5IAJqlsUMv0aoQdcozpCg8jckbmVZuqCsiAptG2frQt1/
         sli7G/eBa1TJyL4U7MF7BB3fAr1VRTpr8NA7QaFyAgWbBckte79OwWEUs4fabaNzflnZ
         lzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xbHlEFrTG1Bu+Yh6rsQ72I5b/h4OitmTqnzGtxrZdLs=;
        b=ZRO2LhA1SZCLZmQ66jfvDPQu8OGR8CdyIwmOTuOhslSXsYwcipXGVD/iFBgwaLFHCW
         7C5jw1MT0Pf2MYRjVp4XtScpmC+335edeHzn5M3mInC78gVYnbN+qjCPSFx6XkXeG44B
         F8SmItQ6MdzOa4/dVtuzFwz0x15zTXmuCs4q7P4ftYDDTNfY6wFFTumlpehtQXj1T2tH
         7fl5ErnEA62+rdt/z/L9N0qR+yNLbpffdV/bgoFRyVYaZ72c+ZtJ4o/cqPLmXasnQ4gv
         kUfqbuydjJq8sfTx4RGE9LPw9DzJ8XGSLDxUwNMHWFh4jDjDFOFm3jExt1c8ng9cxMsW
         wZuw==
X-Gm-Message-State: AHPjjUg4TyTkzJY6n81BMUY2quiMtDdRS0lbiuoSBz9ksS+bvZDRj6rx
        hm7NPl2GMczdA7UkkT/Q32fNnQ==
X-Google-Smtp-Source: AOwi7QCXxfgQrGl3VPa7+QvthTpyQeqjMfEdEUz4jCqa0bd0udeDphz67maNpmzZOtYv6Pn5cnDyig==
X-Received: by 10.200.46.209 with SMTP id i17mr12930918qta.235.1506367320135;
        Mon, 25 Sep 2017 12:22:00 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-139.NATPOOL.NYU.EDU. [216.165.95.139])
        by smtp.gmail.com with ESMTPSA id z192sm5303991qka.91.2017.09.25.12.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Sep 2017 12:21:59 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:22:08 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Roy Wellington <deathanatos@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git ls-tree -d doesn't work if the specified path is the
 repository root?
Message-ID: <20170925192204.hmhgejhzsj6phqlg@LykOS.localdomain>
References: <CAF5E6=pqGZt_BUDRDeN2uAQK7qBTeO+zcR8NsvSPg-rLjbsqdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="66gbeuxz2lkvfyrh"
Content-Disposition: inline
In-Reply-To: <CAF5E6=pqGZt_BUDRDeN2uAQK7qBTeO+zcR8NsvSPg-rLjbsqdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--66gbeuxz2lkvfyrh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=20
> Is there some reason for this? This behavior seems like a bug to me:
> it means that prior to calling ls-tree I need to check if the
> referenced path happens to be the root, and if so, find some other
> means (rev-parse?) of converting it to a treehash.

Hmm, interesting.

I see these four behaviors:

[santiago@LykOS bg_daemon]$ git ls-tree -d HEAD -- src
    040000 tree 238a62ca62527423fd3190d00917ddfef0d254a3    src

[santiago@LykOS bg_daemon]$ git ls-tree -d HEAD -- src/
    040000 tree 767beaaf0927f89e630c52830b6fbac138ec039a    src/bg_daemon

[santiago@LykOS bg_daemon]$ git ls-tree -d HEAD -- .
    040000 tree 238a62ca62527423fd3190d00917ddfef0d254a3    src
    040000 tree de12675d1023b1e743f7e11c2276fc417b3650a6    tests

[santiago@LykOS bg_daemon]$ git ls-tree -d HEAD -- ./
    040000 tree 238a62ca62527423fd3190d00917ddfef0d254a3    src
    040000 tree de12675d1023b1e743f7e11c2276fc417b3650a6    tests

IMHO, I think it'd be more consistent if . returned the root treehash and ./
returned the treehash of the directories in root.

I don't personally know if there is a reason for this...

Thanks,
-Santiago.

>=20
> Thanks,
> =E2=80=94Roy

--66gbeuxz2lkvfyrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlnJV1oACgkQRo8SLOgW
IpVkkw//fZFBhbd/QT82B1TzYWnxTPF0H+jn17a9McphcxtLMpxUqdwsuaETBDKw
oUVz9VO4Sisa9HDmtwyyhMWMLUNyY8/YxHZPvHKG8nDW5lgNjwE7sa6MHQH+RSii
M49P1u3C/7sW2Cz1anxcer8iaWvNwZeD3g+CVnjsGMz1CICggTkNm+bk431QuTCX
BfTocjyFwTX249MSayAL1Fa4XDuz6k479ae1dB0UW9Bgg/cwo9HUIp6YRd9GwnPR
y9/KujFEoCNDmp/yaqNCQV0W/NXSu2t+bbxbKINumPaUZp1Gc2WeMk9/Mvs+fjE5
XFRlllcy5TgWjskst/Lu78cdMxGCWxndJPDtmkUU563YYl2+b+Jc/bUEsTNufDT0
uNtBAtay9D1pBWuqpR6JAbl4yr5BK1/IN78OM8D4PlW0wHp+LOr7C5Im/cHEyah1
PqoKxa9xlnqr70fEqtbHi06a8NPZsWBhvtitN3cJXDi7DKOBfrunk5+WzEmKwfnX
MPBi0FlzII9hiuvALOyyNKLTy7iWeiWWlgbGM9sOFSs47aeU0eYzAOkTKyJ9uAWC
ngowf970Bv/Q4D8geC1AxRl54enehfgE4y5Vtwbq/Jk/ONET8Qzxmt6dQkVfBfZl
cq5FlJgrFGoENzWfdGd9SHDUvs5yMNyovifzb5sqgihDz0g7c6U=
=sGvH
-----END PGP SIGNATURE-----

--66gbeuxz2lkvfyrh--
