Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0553520954
	for <e@80x24.org>; Wed, 22 Nov 2017 15:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdKVP3G (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 10:29:06 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:45998 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdKVP3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 10:29:05 -0500
Received: by mail-wr0-f181.google.com with SMTP id a63so14856211wrc.12
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=46EXmqPCurZSy+tRjbqTcmlI0eF6Z4u5FTjv7xixoCc=;
        b=C2vIowJ5OJZ6FGdEjK//mHGxCq5ZykS+citReuIwZy9mr7nXRsHYdommL5qjphu3pC
         LVOxF5JNQYbWqk6ygdP7FTQaLZDp6VNH4IyPrwT0OT+Hjua54QfOgFyWd9hY/+Gl+1n1
         +E8Durpuu1BOJs2Sk22u9X4SaCH665qVMH7HfZKUIe3mzww4a6VQ8OGd4Fh5RgPlo+mT
         zrHTaJRG5qJbM7gsKg4s0KVeHQt225v/dFrT62GHASNulb2FAbvR0HlcHsE75wg6jMf1
         8b7SOhHSJd9jbtmEbyQXW1VhfFF6kXJS00jStCja1rq3mkppqq9Ub5AxsYBHvMC/v4/8
         MRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46EXmqPCurZSy+tRjbqTcmlI0eF6Z4u5FTjv7xixoCc=;
        b=uPdCLyr0FVVVRCgPk522ExfwPn8UgJ0X6E/Lq0s+Q5kjzcuKKmXKXg7Yk8BVcjbgGV
         Ek72viO0kQNdf3dpBEwagfqjlMzo5AVdkeb/4QdDv28Cz+SmtwFBtGYm3YT+zvy1Bsd4
         vaTKYxsk0GYemo9l6tM2aoCkauTrXTzmODWi//StDeWbwh/cmhMj4CN0mZ7Di/ChFN2n
         sMPr1pZnnBQ/Oevedbfl9HG/wUEPG5xpnZq9l+LxuUE1XQV5K/BSNP0XZ4qLYWoTFgc7
         /OBtiJgU5xmfrs+klPMpiSYbnPXoHVWDbKiYD5mIXykgn4VxWwTzAVZPRZylpnVUm5s3
         18bw==
X-Gm-Message-State: AJaThX62uFlMw8skkH+u0PcvzZM+Cf8lgnePbXAUdZAtF3yPcn4Rgjyx
        WH7b6sCkmOsBOUa4k5hbTaKKqw==
X-Google-Smtp-Source: AGs4zMYBjbI6AZjhvf8ZFORyynyLAzz2eMd1k83u1O022itTavF4h4xApcFYkwneTK0gjTYEjLAR7A==
X-Received: by 10.223.130.47 with SMTP id 44mr17047161wrb.59.1511364544463;
        Wed, 22 Nov 2017 07:29:04 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-144.NATPOOL.NYU.EDU. [216.165.95.144])
        by smtp.gmail.com with ESMTPSA id 25sm11541167wrv.8.2017.11.22.07.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 07:29:03 -0800 (PST)
Date:   Wed, 22 Nov 2017 10:30:30 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Nathan Neulinger <nneul@neulinger.org>
Cc:     git@vger.kernel.org
Subject: Re: git status always modifies index?
Message-ID: <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d7ksg7k6inuu2ill"
Content-Disposition: inline
In-Reply-To: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d7ksg7k6inuu2ill
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nathan.

Do you mean git-status writing an index file? What would you suggest for
git-status to compute which files have changed without modifying an
index-file? Or are you suggesting git-status to fail if the index file
doesn't belong to the user-id who invoked the command...

Thanks,
-Santiago

--d7ksg7k6inuu2ill
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAloVmBIACgkQRo8SLOgW
IpVChA//Zdt1iVUCpjr7R7l1JcBDXgEGSDODy/cVQDurCVJpNSbgiMHf2qiw+zUx
AjGkpkOnEQgqY3KYK0jbaFrx4UyvgrfdZR5sJvXh4fuici5XBRw7ehfBWPMhIF7b
BZPsdHWQvuVMozfBIiUzYbAv5SJgRm2hxbnRlHt21L5LcQ3v4CGxl/TETA30xCDa
qaMPRKktHsTD9nKTARrgSBNsuzk3B4ZpTTnYDTQdVt9cjIZCbHVRFPeUB+IwKGS2
/0Oju5v1LhhDx1yUf/GTr/VYmEa8mEJm7LiTKvI/HRyJtursndGDTTM0K95NJE5n
Ke7jpuvRcw5IidoAc0GRbCaWxq9J00GX4G6WZAYkOvGJeE9xP+vhhKOxTqMLrfSD
60DixUDdBIhU91mRSTRqE5oLjw8nyfDIuC3rPVgCbW/FpRw6IK93C0CsUS+VVhes
fIbXJf5M0gA6gpNh03026TpiqZsesW1cWtlP5ZgwWe+hti0EeRiB4fKfBix5tOn8
p1NRI33BlmgENABRtFRJjub8v5fLworYkPQMMOssWXYcRrflNkJ3zk7WsLL67HFQ
oEVTh7FnRo0mdyDr3zF8X+P1YZX6w1wmC+YqUSuj+ws4Ez93M9yGjkYeYGNgQhdc
cwdywy6A+8Harli6c6zwbq/BGbgJDB8gyzHwmedLEWXJoLaLmBk=
=xk0G
-----END PGP SIGNATURE-----

--d7ksg7k6inuu2ill--
