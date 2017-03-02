Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09341F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 14:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbdCBOvr (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 09:51:47 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34143 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754163AbdCBOvM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 09:51:12 -0500
Received: by mail-wr0-f195.google.com with SMTP id u48so9819435wrc.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L57tXdPItJcrc0uG07w6eR49GSNNmThT3NEJBgxNczE=;
        b=Vo1VhNrV9FCn5zsG8Ye6uGcXnRPAiV1Cq+8CPmcdYsW93VXfFfOW+KD0VnLQE9PLE3
         TPGTvodUR/SwNfyo1Dukq96AaImETCO3wtY7/4hxyhJtux/Ehs2Jxh04I0IVN5tWunOx
         TUtVHvR2cQPqzXEIa5RuI78KU0as+OWls7H6bggq6vuBweUHZikJWEMbmodhiTlCZIwh
         iac55sAA4As375QU22YpjnVw78n7EojkFWmwktemmiA6hvQCxbw9xHnWSQMJTBaj03kK
         CJpXeZpqd9cV72PNkCqnPzSssbyWjkQMQBqK7elYdZFtmRCklhiUfa/FMmB6gOi9CT0L
         2SEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L57tXdPItJcrc0uG07w6eR49GSNNmThT3NEJBgxNczE=;
        b=s6Cewvadp5QfJD4Oc4CPTQGRqTEpTgs2aXhyJaHnTVzEh8jEXBxdGxiDH/QhWGpELY
         8baijYG0kslLvUPGKzZvKA1KBF8bPZ24yIoXN1DBKYZWudxX5j0ZPIITzJALmTu3NCNy
         +WYTCSTrbQttvzGJ8aztAU9q/DRltsJh/FV7cB6rFjUgT8o9oG8WcTKM5wxvrlJ6O665
         /icgOgkQzQoT6phZt348wupoc1RmkCkzZ2QkmVQJFUVmcjJTelY+JIdHkyQszSvgubrn
         MK+IdtmYuqRDNRTb2Gy0aqFzE31oZGuMxayVDuNnq269hBu8bfXHMZrWNPv8DbMH2BYu
         mPdg==
X-Gm-Message-State: AMke39m5HCx/+HsIFclcOytoKtBfcC08UXz15MC9rDjKeccWtpbCwpRezvnGU6fB2R720w==
X-Received: by 10.223.165.17 with SMTP id i17mr13225355wrb.62.1488454728365;
        Thu, 02 Mar 2017 03:38:48 -0800 (PST)
Received: from birc4gyqf2.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id j80sm10895751wmd.14.2017.03.02.03.38.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Mar 2017 03:38:47 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1703021210170.3767@virtualbox>
Date:   Thu, 2 Mar 2017 12:38:47 +0100
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de> <20170302105157.59791-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703021210170.3767@virtualbox>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Mar 2017, at 12:24, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi Lars,
>=20
> On Thu, 2 Mar 2017, Lars Schneider wrote:
>=20
>> The patch looks good to me in general but I want to propose the =
following
>> changes:
>=20
> I know you are using your script to generate this mail, but I would =
have
> liked to see v2 in the subject ;-)

Yeah, sorry. I already had a "D'oh" moment *after* I saw the email in=20
my email client. Now I am wondering... is the next version v2 or v3 :D


>> (1) Move all the docker magic into a dedicated file
>> "ci/run-linux-32-build.sh" This way people should be able to run this
>> build on their local machines without TravisCI. However, I haven't
>> tested this.
>=20
> I considered this, but there is serious overlap: the `docker pull` =
call
> and the `docker run` call *have* to refer to the same image. It's very
> easy for them to get out of sync if you have that information in two
> files. Maybe make that an option of the script, defaulting to
> daald/ubuntu32:xenial?

Right. I missed that. How about something like that?

      before_install:
        - ci/run-linux32-build.sh --pull-container
      before_script:
      script: ci/run-linux32-build.sh


> BTW speaking of Docker: it would be nicer if there was a Docker image =
that
> already had the build-essentials installed, to save on startup time. =
But I
> did not find any that was reasonably up-to-date.

True. But installing everything just takes a minute and we don't need to
maintain anything...


>> +set -e
>=20
> Is this really necessary? I really like to avoid `set -e`, in =
particular
> when we do pretty much everything in && chains anyway.

Agreed, not really necessary here as we just invoke one command.
Out of curiosity: Why do you try to avoid it? I set it by default in all=20=

my scripts.


>> +APT_INSTALL=3D"apt update >/dev/null && apt install -y =
build-essential "\
>> +"libcurl4-openssl-dev libssl-dev libexpat-dev gettext python =
>/dev/null"
>> +
>> +TEST_GIT_ENV=3D"DEFAULT_TEST_TARGET=3D$DEFAULT_TEST_TARGET "\
>> +"GIT_PROVE_OPTS=3D\"$GIT_PROVE_OPTS\" "\
>> +"GIT_TEST_OPTS=3D\"$GIT_TEST_OPTS\" "\
>> +"GIT_TEST_CLONE_2GB=3D$GIT_TEST_CLONE_2GB"
>> +
>> +TEST_GIT_CMD=3D"linux32 --32bit i386 sh -c '"\
>> +"'$APT_INSTALL && cd /usr/src/git && $TEST_GIT_ENV make -j2 test'"
>> +
>> +sudo docker run \
>> +    --interactive --volume "${PWD}:/usr/src/git" \
>> +    daald/ubuntu32:xenial /bin/bash -c "$TEST_GIT_CMD"
>=20
> Hmm. Since it is a script now, it would be more readable this way, I
> think:
>=20
> sudo docker run --volume "${PWD}:/usr/src/git" =
"${1:-daald/ubuntu32:xenial}" \
> linux32 --32bit i386 sh -c '
> 	: update packages first &&
> 	apt update >/dev/null &&
> 	apt install -y build-essential libcurl4-openssl-dev libssl-dev \
> 		libexpat-dev gettext python >/dev/null &&
>=20
> 	: now build and test &&
> 	cd /usr/src/git &&
> 	DEFAULT_TEST_TARGET=3D'"$DEFAULT_TEST_TARGET"' \
> 	GIT_PROVE_OPTS=3D'"$GIT_PROVE_OPTS"' \
> 	GIT_TEST_OPTS=3D'"$GIT_TEST_OPTS"' \
> 	GIT_TEST_CLONE_2GB=3D'"$GIT_TEST_CLONE_2GB"' \
> 	make -j2 test
> '

That looks better! I'll try it!

- Lars=
