Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D1A1F424
	for <e@80x24.org>; Wed, 27 Dec 2017 18:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbdL0SrJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:47:09 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39652 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdL0Sq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:46:57 -0500
Received: by mail-wr0-f195.google.com with SMTP id o101so8792964wrb.6
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hOzaFgfOx/C7vmVDILRv+KMsXk8nlC3Ib7AzOTh7GLA=;
        b=FLj+nWGK5nzd3/f9wOCWEkZvUxXO48O99+JjpKSk6hl4GvEMWUd/m0kX9Wd6IkQgXl
         Dl/pRZeETRv9hpsQAfijjTzHM1E2VtfQ2w+Rl225I7cec3lDczjLtTqFOxuSlfJ2iRSa
         lUe8KEn5X87XmEojNMtB3f15ULm/dkTkR2uyScNXn7jl6Dj7pD23S6WnEq4JKpzjqU7Q
         xFsEfFxRF0wvhc9yMabw3haZWoec0fW9upAQ9QVzAbchoo7OWGtCMJl8yWHJM4loQTSW
         tzGqBZZpkjBCSCvfZvWXPQs7G5nNFYrACvDz5i9aH9fgAhAZ2UnJkeO1dbkR0UrqbV8N
         +kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hOzaFgfOx/C7vmVDILRv+KMsXk8nlC3Ib7AzOTh7GLA=;
        b=gNoeKvRSBDSh6pkCcYRByW1vcBzdZ9WrzeDx+2dzvRJpW9NhjrW6DWf3YcU0nykuHv
         3RQh3Fhmq7iGTXPgouSnciPD6lAgctpO5YYch2XdlYKyxfjqZCuLi98Ok5KaMqcoQPXa
         s1LNX7WNP+1hsNNDDzrhImc8/XTuNqG8lqB5Fwwef9pglakmRAIlSodpql1YQuFgw9VK
         jrUI9p0bXsZARW3iyj1EISyEUMVHtDoc8IhInE1fvhY92Itg5fYwzkF6JZDVvgyGbwP3
         0w46Bx+VK29OMoN11a75mlIYi+xRBMuBB7VnV0K56kq22qPQqqdXv8MaFrzbOPu6Gg2U
         OdGg==
X-Gm-Message-State: AKGB3mI6eGMTF11Q8FJp52gtQ6zKBb1ys/vxN5ZJZntvSAEoXGVz0WJP
        JylbSqvF14Jllmmn3YZNXc4=
X-Google-Smtp-Source: ACJfBou9kelVohtfaPRvxxWcUNPDDRwM27BKbB0fuc8UKBd9pHb9tN8ai9OVXJdzKP9XzqD5HsAaEw==
X-Received: by 10.223.148.194 with SMTP id 60mr25816727wrr.39.1514400416475;
        Wed, 27 Dec 2017 10:46:56 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5682.dip0.t-ipconnect.de. [93.219.86.130])
        by smtp.gmail.com with ESMTPSA id e197sm85882253wmf.4.2017.12.27.10.46.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 10:46:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 3/4] travis-ci: save prove state for the 32 bit Linux build
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171227163603.13313-4-szeder.dev@gmail.com>
Date:   Wed, 27 Dec 2017 19:46:56 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB47DCB3-DF66-437A-BF0B-4DF1838C2F7F@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com> <20171227163603.13313-1-szeder.dev@gmail.com> <20171227163603.13313-4-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Dec 2017, at 17:36, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> This change follows suit of 6272ed319 (travis-ci: run previously
> failed tests first, then slowest to fastest, 2016-01-26), which did
> this for the Linux and OSX build jobs.  Travis CI build jobs run the
> tests parallel, which is sligtly faster when tests are run in slowest
> to fastest order, shortening the overall runtime of this build job by
> about a minute / 10%.
>=20
> Note, that the 32 bit Linux build job runs the tests suite in a Docker
> container and we have to share the Travis CI cache directory with the
> container as a second volume.  Otherwise we couldn't use a symlink
> pointing to the prove state file in the cache directory, because
> that's outside of the directory hierarchy accessible from within the
> container.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/run-linux32-build.sh  | 1 +
> ci/run-linux32-docker.sh | 1 +
> 2 files changed, 2 insertions(+)
>=20
> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index a8518eddf..c19c50c1c 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -27,6 +27,7 @@ test -z $HOST_UID || (CI_USER=3D"ci" && useradd -u =
$HOST_UID $CI_USER) &&
> # Build and test
> linux32 --32bit i386 su -m -l $CI_USER -c '
>     cd /usr/src/git &&
> +    ln -s /tmp/travis-cache/.prove t/.prove &&
>     make --jobs=3D2 &&
>     make --quiet test
> '
> diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
> index 0edf63acf..3a8b2ba42 100755
> --- a/ci/run-linux32-docker.sh
> +++ b/ci/run-linux32-docker.sh
> @@ -19,5 +19,6 @@ docker run \
> 	--env GIT_TEST_OPTS \
> 	--env GIT_TEST_CLONE_2GB \
> 	--volume "${PWD}:/usr/src/git" \
> +	--volume "${HOME}/travis-cache:/tmp/travis-cache" \

I assume "${HOME}/travis-cache:/usr/src/git/t/.prove" would not
work because that would be a mapping in another mapping?

Thanks,
Lars

> 	daald/ubuntu32:xenial \
> 	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
> --=20
> 2.15.1.500.g54ea76cc4
>=20

