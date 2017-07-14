Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E862027C
	for <e@80x24.org>; Fri, 14 Jul 2017 00:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdGNA17 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 20:27:59 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35239 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGNA16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 20:27:58 -0400
Received: by mail-qk0-f182.google.com with SMTP id p73so782833qka.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7IfPTP/JECZpOnPsVMkt6NIZTj1LS5zqewx2h0qM3k=;
        b=yGRd4ZbPbxjVfbmLODzHDVTi/sRyZhfYHQY29DuECaXd+zLT5DtxVqKUJIpw6sqUyJ
         Hml2xdzT2XL9vjznUVhaNAvjJZxYrKGm5HLsTraZOtS+oOOpzI1y1V/RLPYnelaKYA29
         /DdxOENDAqH5s5CEToUyEKcsuLixyAZr4AmS3LGk3GL6Bi9E9bYyB02wVdnLgTscvmsu
         /gUiErKGd50fNreVbhRRu0cMjT7ponKSlljVLNjgH4hM6zWx+Vh0J0p+OBLAGoah3Rw8
         8sHXDng7a4kCtMyRwfs7+jjmCvcp3Y0nIaiwyihvEAc+MAAh+M2BtCSznO709enNlo3n
         gOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7IfPTP/JECZpOnPsVMkt6NIZTj1LS5zqewx2h0qM3k=;
        b=I13E0JHS7HPl08P6yUDa99sKxMfI/uD4R+Meaf/h/mK0btDZvX+NoSFDqQ52eirlP5
         JxPvzjck3kkkM8LWaphYwnTaafBSRghHwwsOhfkcDpcvO9w53NagT+0C09XJ6BqIEenz
         loqtC+52x0yuyL5+ZwjX+Dk6FD7cKhnZgw4FFm5f41ZrF6GANZ9tfQV4W9tK63UNPoYO
         jWGXY6pqU1PLI30IOXSSwHTzeI4h4TmziR+AARs0sdxNGbToNNhgVsY8Ddq8k/4Wzjgr
         BwxgF0z6yotZmIQQETeWt4mykcBYFar3s6Y+vOrL5uIHlcNcs7ue7jwokAVoXkQjShz2
         kGAg==
X-Gm-Message-State: AIVw111x1FlC53YcsFN7xp0cvdOAGvrkM4h59B/qtibLQxglq0gdd8mH
        rEKOdqIGVNS7ss16BoQ=
X-Received: by 10.55.159.21 with SMTP id i21mr7774831qke.27.1499992077359;
        Thu, 13 Jul 2017 17:27:57 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8209:6800::8])
        by smtp.gmail.com with ESMTPSA id 143sm5043624qkf.8.2017.07.13.17.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jul 2017 17:27:56 -0700 (PDT)
Date:   Thu, 13 Jul 2017 20:27:55 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
Message-ID: <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ql7zjgn7jl2gbzt"
Content-Disposition: inline
In-Reply-To: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3ql7zjgn7jl2gbzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Here are the topics that have been cooking. =20

Hi,=20

I sent (a patch almost a week ago) that would probably[1] be labeled
as "uninteresting" (as per the notes from the maintainer), but I wanted
to make sure it wasn't lost in the noise -- I see that theres a lot of
active development lately. I checked the latest iterations of "what's
cooking" to see if it was going to be discarded or so, but I see no
mention of it.

Thanks!
-Santiago

[1] https://public-inbox.org/git/20170707220729.a3xrsju3rf4guyzs@LykOS.loca=
ldomain/T/#t

--3ql7zjgn7jl2gbzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlloEAoACgkQRo8SLOgW
IpVLgg//QqlSVfv3PYtaq1JP+7/Lr9HbpsRgPOcRPHGyHWiAy4mOyDx+XdfFRGiz
fBz/0b0rAR2Ok/Smsv1ylhNkQVIubkfNbZdIocaPnW/6ErKKFt2Cj+8ysYMB9BQO
c7JX0NdYbEpbNrsJCd/sPcyEbMZHO4G/+CJkxCyFYc2VAJ4ybJboZWLQXVI/OXyU
vQnT7tX8FQHHrzyGA/ovnR22qIO3Ckgy5ByfsjdhcTzNNinRLQiIrUtej7pqc+6Z
jHbmVousapd49hnbL4mb/4TO4YNuMHLs3W8ZVLAlLg6AmgnzAECkwmlBnj5PgHtV
OsgIfiupW0sNNt9R1mr22+p3vomaXGvnBFNsTdV2bZB6M7y4uVKetb4GChVJAsKY
CEryh+VUEVHqhrpCIqGIt4IZ2j7GDhu0AtGfWm/S9+zPx2UfErQ3fECaVHPMKUKQ
8PHdDC5hGGnjzmcCPwT7vH/0rhT1iHIK7T/mzUpYDZGfJTRmSEkHInxAvrThbBrJ
0ECZsw0lc1XdUR/R1BXlco8zw7G6ME5WkuawFnCYsdQsvxXEEvfP0lx0iy1gtJ6D
b281cDpTu24rw9+kB12aZSeMS8gV1EOoCAPF4WaF26n2x6+avIQrW4sOIcGihZos
AZ+DZausiNxKJ53F5OQU7v6ng5lVXQp/wsEnka2kyfRUQco0m3M=
=1n4G
-----END PGP SIGNATURE-----

--3ql7zjgn7jl2gbzt--
