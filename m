Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BEE1F404
	for <e@80x24.org>; Sun, 31 Dec 2017 11:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbdLaL2A (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 06:28:00 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39067 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdLaL17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 06:27:59 -0500
Received: by mail-wm0-f47.google.com with SMTP id i11so54098942wmf.4
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZQ+Qt4N5/9AFgCjGiBHKO8qpPjaaSd22W4391bXLKkw=;
        b=Pf2bN26X+f4yPo4C+C4vLIWkk35fL4pq26khBbvzdAvVpYLv1/U3/MBWjtdsoK+SWT
         wp1R59Tok3x9HvNu0ET2Sz9buYEnhratRmoap/ywjuzZQbTzzZ6947WekDtyGwwMrhJq
         vTlkHOvxwdQUvDBVK8J0EERLNwiY1qKxvpdr5KI42aflEBXtvrxDq3IJtLtBciZyNTue
         11o6UgvrbAO9H+eWU8X2atgF/V+/6dsysGNFib9hFtOoHtB1pULGTZI9drSde5HxQccz
         qYtg6QAKGdjSWFRvQp51B2PeR5HWR6Wam6MHUwWLUMK4A+VR6ArrcxDwVPqTWTTEpbEM
         ic+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZQ+Qt4N5/9AFgCjGiBHKO8qpPjaaSd22W4391bXLKkw=;
        b=Gz89/JkRc7flYcPZnFjPTLGhC4AQwSsl+uCLdnOEr6eFEHnW81FcFZE/2vKA5rDLf4
         ttJ7AAtkYUOBXqpIktvc4c1k4VySSg+jP9IcpCOWqcwZVLBQhyYOyhuoCyQcSGY98baH
         DbJQc+HKfMTEuSRXn1iErKbJkSq+Ruxnjxb9AB+lL5FrDNCYywn7SCTB8W9BAMNXILqQ
         zEyZ4j4lstF14+MXn95zlSp4IYdn4yHtA3QCbRFNwDUAUW9xyZnfKbBVtmY4XrN73YCj
         FwFJFOQDBCKiXU3XW9FIwqdW6RMG2XKjmxDVx1JnW8zkcqXVOEleIYwVNLnnSiq0dsn9
         MpUg==
X-Gm-Message-State: AKGB3mKclIYDSHLArGPXxY/WjelB+pAi6SEwkJZ9Xx+09k1rAPquhPC7
        IAi6kJzxQ3UWVE0Q4fbZcozia08k
X-Google-Smtp-Source: ACJfBovy/TYoe8x8ZsTWaADJ4JiaPOGWMqYl1A7fxjPfeujW+ttHqNOZJk7hc36KIUW1pv83n1JWvQ==
X-Received: by 10.28.63.16 with SMTP id m16mr32618003wma.19.1514719678086;
        Sun, 31 Dec 2017 03:27:58 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB57B0.dip0.t-ipconnect.de. [93.219.87.176])
        by smtp.gmail.com with ESMTPSA id m134sm24400849wmg.6.2017.12.31.03.27.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 03:27:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHv2 0/3] Travis CI: skip commits with successfully built and tested trees
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171231101205.7466-1-szeder.dev@gmail.com>
Date:   Sun, 31 Dec 2017 12:27:57 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A70B41A-92D5-48D4-8550-86F56C4DF74F@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171231101205.7466-1-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 31 Dec 2017, at 11:12, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> This is the second iteration of 'sg/travis-skip-identical-test',
> addressing the comments of Lars and Jonathan:
>=20
>  - Colorize the "Tip of $TRAVIS_BRANCH is exactly at $TAG" message
>    in the new patch 1/3.
>=20
>  - Create the cache directory at the beginning of the build process
>    (patch 2/3).
>=20
>  - Limit the the cached good trees file size to 1000 records, to
>    prevent it from growing too large for git/git's forever living
>    integration branches (patch 3/3).
>=20
>  - Colorize the first line of the "skip build job because this tree =
has
>    been tested".  Green it is (3/3).
>=20
>  - Removed stray whitespace (3/3).
>=20
>  - Updated an in-code comment, to make clear which code path deals =
with
>    a non-existing good trees file (3/3).


This series looks good to me.
Nice work!

- Lars

