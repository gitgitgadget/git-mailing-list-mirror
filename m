Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9101F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdCBMTf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 07:19:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:55090 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbdCBMTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 07:19:31 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lee2I-1bwekj1vag-00qNtP; Thu, 02
 Mar 2017 12:24:31 +0100
Date:   Thu, 2 Mar 2017 12:24:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
In-Reply-To: <20170302105157.59791-1-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1703021210170.3767@virtualbox>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de> <20170302105157.59791-1-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kT8woxBax09lt6G073Djsx7pUe07xLwAD/sXaFCu4DUGT6MrmCy
 1rvclJCMmOewmSJ0qpCEnH6t6lpnQ7tRhANXiBS5zw+mb8TI3cMnL2dv1ZXwz2Kf+Uo5XWF
 PU4wAyaCPE6+fTZGvkAPLYLPOKbknVrnwowwwLLOLyylH3kc4u99Ln9RyPgR/O97hbTAyHZ
 PXDESOwqhiXPpyiHYYIZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RBiau4g4eFU=:fHpzLckUIeomlNG2DtnOf1
 MoLUcELQeOzIXW2u0x4OhedcY/wpcUcBSD1HHUBPMnujLReHmsxEJ03mpARdF3/7eTh8FtP1H
 kQvdd4eLuNDykEMxDRVgnpSg19ACu0XhDk6wvQo4pqEocZigWgBwFgqLu/7iYVGbYXP3nqGrB
 0E2YVI1FPmI0SySIJQy2XMOZA5FkVMavzIIHhtuw7oVKfp72+kLpaAJctUK3PbRp5eKOMjE+g
 jDuFvvut3OF1SHcFCwax0NiTlxYSgAs0NqbbFk8WlPrBD/vvIGPjtXQBdP2AlLcgwtepaHt+s
 SrX+RXAY8BxG6RouXyivCAT/SIz8JGQe0fgUlZjQawFlVQ7X1PVQ+KQt8H9PYLYmZhtc8QjzD
 JUSvA9pJJ4eJpuJ+CvI0tDGplOgKkmur6GywStvunWBJ6FiCS70SEctwzVxWsNBBVPKWaGODQ
 Av/7YLcD2wyCNbYc8rvYccDBvqRtPViUwM8D4Bq9N2oiCavFK0qC2Z2xBfK1cpxbrz392TEw/
 9tEyXF8sYVU7Hv1zT8r3p1UIvcJuxIL+iB3U9r2P1lP1iCV16xs8ESDWgxQCRg/vwa2WyI8NI
 rNw5K+6wIRmQRcvh0exGkYILlJ3V2QOklAdkgPMofGH0TknKhkhsqhs7Bmu62PU6M2QGYFyM+
 rrIdUyJLRQcmzODB/1q/FBjNWAByNAUU0Fr6IWPue0XTrjYyWbKlRrJhJ7M195BySXnrnIMF+
 pEYqVQy4RDFTWBN3juUq9aRnwYIjLfYaB8uepiO+wlUJPbRPuHym4RRpVn4oo9jzK2T4dBgm8
 8hxpK8Ds1wFlIQE9k6EU1wBMgu/xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Thu, 2 Mar 2017, Lars Schneider wrote:

> The patch looks good to me in general but I want to propose the following
> changes:

I know you are using your script to generate this mail, but I would have
liked to see v2 in the subject ;-)

> (1) Move all the docker magic into a dedicated file
> "ci/run-linux-32-build.sh" This way people should be able to run this
> build on their local machines without TravisCI. However, I haven't
> tested this.

I considered this, but there is serious overlap: the `docker pull` call
and the `docker run` call *have* to refer to the same image. It's very
easy for them to get out of sync if you have that information in two
files. Maybe make that an option of the script, defaulting to
daald/ubuntu32:xenial?

BTW speaking of Docker: it would be nicer if there was a Docker image that
already had the build-essentials installed, to save on startup time. But I
did not find any that was reasonably up-to-date.

> (2) The docker build command inherits the Git test environment
> variables.  This way we use the same environment variables as in all
> other TravisCI builds (plus it would use *your* variables if you run it
> locally).

Good!

> (3) Silence the apt update/git output as is it clutters the log.  I did
> not silence stderr output!

Also good!

> (4) Remove (to my knowledge) superfluous "compiler: clang" in the
> Linux32 job.

I copied that from one of your experimental .travis.yml patches ;-)

> I added my sign-off. I hope this is the right thing to do in this "I
> took your patch and changed it to suggest an improvement" situation.

Absolutely. Thank you for taking it from here.

> One thing that still bugs me: In the Linux32 environment prove adds the
> CPU times to every test run: ( 0.02 usr  0.00 sys +  0.00 cusr  0.00
> csys ...  Has anyone an idea why that happens and how we can disable it?

I have no idea.

> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> new file mode 100755
> index 0000000000..b892fbdc9e
> --- /dev/null
> +++ b/ci/run-linux32-build.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +#
> +# Build and test Git in a docker container running a 32-bit Ubuntu Linux
> +#
> +
> +set -e

Is this really necessary? I really like to avoid `set -e`, in particular
when we do pretty much everything in && chains anyway.

> +APT_INSTALL="apt update >/dev/null && apt install -y build-essential "\
> +"libcurl4-openssl-dev libssl-dev libexpat-dev gettext python >/dev/null"
> +
> +TEST_GIT_ENV="DEFAULT_TEST_TARGET=$DEFAULT_TEST_TARGET "\
> +"GIT_PROVE_OPTS=\"$GIT_PROVE_OPTS\" "\
> +"GIT_TEST_OPTS=\"$GIT_TEST_OPTS\" "\
> +"GIT_TEST_CLONE_2GB=$GIT_TEST_CLONE_2GB"
> +
> +TEST_GIT_CMD="linux32 --32bit i386 sh -c '"\
> +"'$APT_INSTALL && cd /usr/src/git && $TEST_GIT_ENV make -j2 test'"
> +
> +sudo docker run \
> +    --interactive --volume "${PWD}:/usr/src/git" \
> +    daald/ubuntu32:xenial /bin/bash -c "$TEST_GIT_CMD"

Hmm. Since it is a script now, it would be more readable this way, I
think:

sudo docker run --volume "${PWD}:/usr/src/git" "${1:-daald/ubuntu32:xenial}" \
linux32 --32bit i386 sh -c '
	: update packages first &&
	apt update >/dev/null &&
	apt install -y build-essential libcurl4-openssl-dev libssl-dev \
		libexpat-dev gettext python >/dev/null &&

	: now build and test &&
	cd /usr/src/git &&
	DEFAULT_TEST_TARGET='"$DEFAULT_TEST_TARGET"' \
	GIT_PROVE_OPTS='"$GIT_PROVE_OPTS"' \
	GIT_TEST_OPTS='"$GIT_TEST_OPTS"' \
	GIT_TEST_CLONE_2GB='"$GIT_TEST_CLONE_2GB"' \
	make -j2 test
'

This is completely untested (pun intended ;-))...

Ciao,
Dscho
