Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4796C1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfFLSes (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:34:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44891 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfFLSes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:34:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id w187so10993772qkb.11
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZtMyka2SMHmZpbKhbBu1aKmLbbAMkI7kTnjbJpN+Vio=;
        b=QBOITL8s+qdoAB4rM5XzLvg+okpY3xIIWxZYDIxIqlP3Rtj5r1oxnjHG2APnkaQxQB
         /OMl28LqNZYp2Q4lQP8zSKEYtKprtywdAiyAuYVPlwqlae0cL2MRME7Jw+OAp9UlHswQ
         O4UzX28lLdkWlYtBIDqsWlMeyy49GvtLjZ5WH4BmxaHJGR0LEQv9CTDM27ohD8tRV+VG
         knS7GDi6Znu/WjkPW+RyIYImYPYsb8QpPjJGolAWdQxg45MKkXYUrJvABzxHJ2f/fkoZ
         fpcfxQI2HTncaGlJa3bze0Nr1Bc89zHhPXAcz8+LwLwE1jdm7qDQAB4MgcGbCKuc+0IJ
         4+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZtMyka2SMHmZpbKhbBu1aKmLbbAMkI7kTnjbJpN+Vio=;
        b=bt1487nCP25NebilppF7kqHrBAmjOFXWE7JNQUyOzPjpaYefRKRCWQqbmxG116PL6d
         GoS6rMjL0MQur0TiMxd10RawY0UKUTHfvwGytG4GDkyt0gTElEhpTftDTIstsv8XgafF
         BVWvpCNUNgw7QwpLiTDT6fLYCvPjrz7ryYvw32JxHJDWASJCJs5hwe98lrSPQaT+JtKF
         ttE2wHcNpQ1LTfm4Xsz8dM3KWxo5zg2tG97BhMv7kvnXFAvISrJE6iBXFR+PpQhEkEKF
         QXxjwFxoTe47j5IX1NKJWtdwDFj0uIOBFi7QeNTSGL2s3KmtsRgBXL/gCugWprpgk6ka
         lQjw==
X-Gm-Message-State: APjAAAW1ZjyUpFynixZ3eUJhVZbGAJgrqlXMxMr08kuuGmqZg6OmGgwN
        gExK7RxJIEkWQMjHFJFmmHoPZhKOKjc=
X-Google-Smtp-Source: APXvYqw7CnVEjPKn4TVXL3LyPP4zccUHHuCCvfyDeuAsINR7WkNiBgYpIKSEckkIiWHbnJF8Pbcccg==
X-Received: by 2002:a37:aa0d:: with SMTP id t13mr66919982qke.167.1560364487139;
        Wed, 12 Jun 2019 11:34:47 -0700 (PDT)
Received: from localhost ([165.227.200.42])
        by smtp.gmail.com with ESMTPSA id u26sm394865qtc.33.2019.06.12.11.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 11:34:46 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:34:45 -0400
From:   Brandon McCaig <bamccaig@gmail.com>
To:     Allen Kinzalow <akinzalow@uda1.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Pull Hangs
Message-ID: <20190612183445.gsyjrmmqlckljybu@test-chamber-21.localdomain>
Mail-Followup-To: Allen Kinzalow <akinzalow@uda1.com>, git@vger.kernel.org
References: <6d09f626-631b-f6a2-8df3-37530fc62d50@uda1.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="irghrivcnqy3y2xl"
Content-Disposition: inline
In-Reply-To: <6d09f626-631b-f6a2-8df3-37530fc62d50@uda1.com>
X-PGP-Key: https://castopulence.org/bamccaig/castopulence.asc
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--irghrivcnqy3y2xl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Allen:

On Wed, Jun 12, 2019 at 08:35:44AM -0500, Allen Kinzalow wrote:
> Hello,

Hi,

> I have attached the output of a "git pull" command. Suddenly we
> are unable to pull or fetch anything from our repository. It is
> temporarily fixed by deleting .git/packed-refs but quickly
> starts happening again.
>=20
> I have attached the output of where it stops execution. We are
> unsure as to why this started happening. The only real solution
> right now is to reclone the repository. After doing do it will
> be fixed for a longer period of time (maybe a week) before it
> shows up again.

The output looks like a debug log rather than normal output.
Also, it's unclear if this is stdout or stderr (or both). I can't
really make sense of it. It looks like it tells you what it's
doing, but not the results of those operations. If an error
occurs it doesn't seem to be in the attached log.

How did you install Git? How long was everything working fine,
and when did the problems start?

On a side note, the repository URL yields a 404 for me, but
perhaps that's because I'm not on your LAN or VPN?

Regards,


--=20
Brandon McCaig <bamccaig@gmail.com> <bambams@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'


--irghrivcnqy3y2xl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6A+1JeuAGnMhPkN33afWAiLlk/IFAl0BRcIACgkQ3afWAiLl
k/J8vg/+IUp+aiINN0nSb+iqtNx/+FfhPH5fpX4QOZ9MEEkOb157Q0GI2twkzfp9
LxMVt+VM5t1R8bPEu5aEMAk6gqRUBOuUnhVfP01d6Po/h/kzXwiG/L9kFZPV2FMy
cjdFjlRlJFktsdkkqzC3PtKgyxyW6maLd0cZ019S36GWt/DcS8zpj6EwbgPfAU1+
xsScpxMVQMq1Yxw9KJ/CNDobh3v3zj9oY94U/QXUOu4RQ6IijSzduacaQaJ8j0vd
gHGQdSHLw5dz29/H+09qlo075yzI79guEhP4E2iyH1lXV85LReIwlZptekHWkQRJ
R64fZUcrOeXs45MqWq7Iu72ktPgnxyr8zar8N4mpMRpxYyEuA2D0K5SouDwGIBUv
CZW4O4MAfB2C90op3UmSf0LQpDf/qmIW4mcOtbShHbXQp3Y4LOPe5C+gc2VeLUAu
FHYzA/JZ45eBqaWLmDqZbbdz4jxi08lQe4aa2c7PEwIS/7AkfPaBQAYhPumUyNdM
Bl1Xi4wdMuVSrZvRwITQxhpHRd29BjyL1pUvOKipyd3AOI1tYutfxd0C7uTBJKrh
D15kqTaLs2AlJ2hU+Zhkv64ZY6Zpy8qmRv26QFX6HsIOX4NjBr4Cg1jmZi4wziTG
jVG1eVnXQqqQTB0RFtxqUN8QVsqSZeGy842yYuTYdakvBqOx2dc=
=eMgU
-----END PGP SIGNATURE-----

--irghrivcnqy3y2xl--
