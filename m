Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FCC01F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 14:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbdCBOXa (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 09:23:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:62868 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdCBOWw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 09:22:52 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1clggm1j3I-00X6l2; Thu, 02
 Mar 2017 15:22:44 +0100
Date:   Thu, 2 Mar 2017 15:22:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
In-Reply-To: <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
Message-ID: <alpine.DEB.2.20.1703021519330.3767@virtualbox>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de> <20170302105157.59791-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703021210170.3767@virtualbox> <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+WibMEWv0jascHIWotzdY8nh3KaaVp4vvVsfZ6FTIgnq+PIylFW
 1wIk5oXvBOuMYRaiqE0e7qccX1LK/9bRJ/65fYeHsLKIbVZ1rcr/pE2V9NgJLRKYswM8Kjv
 3yptNelIStnk6yrFXzVKfq5jIzEVKITcfVYAmZuQ4L69lEscObtO5ZmzZFpK33V2NeczBm9
 RfkP/ND/npVDC55bUolyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+2dcXzyoByA=:ESxnf0ZKHyNw1v9R3/tych
 HBkU7bOpQ8JLJjjghQdg91BGL4a7Hrh9XJq96DGhmY+gd5X8j17xQFWyJtoZHry2qnvGc0We+
 mCyqrU5SRXiziPQ+ufbv0FEjRk0G4h88GAD3ZhfPDzBB47Xkdbihi4K1GLS5sGiMQBP3Boes5
 ny/xvmal/4pL21bwU/m/AC4kG9GkOmWpzpQCKuTUZB0W+1xHrkULyff0j/lad/vlqDnNagex+
 QhEzLR8kyoeTxhGbe2lmS6cXEO8NjDdPm13w0A44X/Hsa4aCN4fkyhmIFF+B2b74SNLP770AO
 kmB6mtDCL2m8xWHThlCA77apWEg+5NpNbeyotQxebRrCW7rnod+jR/VdRjxjn2vnrYXwKm2RS
 5TkXqLisLkD6cctspO9P3vLXK1VIPtFRo/nXGw1GpFK2GyhIuJzRl6E+695infpzj2Mva/YwR
 nJ26+w1zZxT5+08BnNMrkRuqTmVXDYqN31OOLjWDpx0uk7qUrfyexpRj8BTPC0ppi+qhQk5Ma
 ktxfdvCeTB36NhMPE7ntJnf479r2l75DfUOsE+GgPTFv+Um8A7umWmT8Hqe8FjGXvOJ9ajrk3
 6CJ1QIFZqy/xysUCc/UjnwHliJmZxlh0H0/fDClq1DM8PCVKpM71ESAFbapbv/wyasgJT5HeK
 ikxqrwkPWH4WPWkFP04WOoJgoCn2TVA2Kj8Ttgxeotg/v9pvOkiV/ACtek1f6261L32YO8dVs
 YR3I8hq7J0HD6seoYN11b/uF9pkZaDE5g9RA7LVrOZOkCLEErfpla2ijNId6ah0VyvAP/61tY
 ubRibgKmt1QJNCV9+tZbU+auFIHVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,


On Thu, 2 Mar 2017, Lars Schneider wrote:

> > On 02 Mar 2017, at 12:24, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Thu, 2 Mar 2017, Lars Schneider wrote:
> > 
> >> The patch looks good to me in general but I want to propose the
> >> following changes:
> > 
> > I know you are using your script to generate this mail, but I would
> > have liked to see v2 in the subject ;-)
> 
> Yeah, sorry. I already had a "D'oh" moment *after* I saw the email in my
> email client. Now I am wondering... is the next version v2 or v3 :D

Since there was no v2, the next one should *definitely* be v2... ;-)

> >> (1) Move all the docker magic into a dedicated file
> >> "ci/run-linux-32-build.sh" This way people should be able to run this
> >> build on their local machines without TravisCI. However, I haven't
> >> tested this.
> > 
> > I considered this, but there is serious overlap: the `docker pull`
> > call and the `docker run` call *have* to refer to the same image. It's
> > very easy for them to get out of sync if you have that information in
> > two files. Maybe make that an option of the script, defaulting to
> > daald/ubuntu32:xenial?
> 
> Right. I missed that. How about something like that?
> 
>       before_install:
>         - ci/run-linux32-build.sh --pull-container
>       before_script:
>       script: ci/run-linux32-build.sh

I'd prefer

	before_install:
	  - docker pull daald/ubuntu32:xenial
	before_script:
	script: ci/run-linux32-build.sh daald/ubuntu32:xenial

> > BTW speaking of Docker: it would be nicer if there was a Docker image
> > that already had the build-essentials installed, to save on startup
> > time. But I did not find any that was reasonably up-to-date.
> 
> True. But installing everything just takes a minute and we don't need to
> maintain anything...

And when there are network problems (like there were on Tuesday, right
when I developed the first v1 of this patch) then we have another set of
problems that make Travis fail. Even if the code in the PR or branch is
actually good. I'd like to avoid false positives, if possible.

> >> +set -e
> > 
> > Is this really necessary? I really like to avoid `set -e`, in
> > particular when we do pretty much everything in && chains anyway.
> 
> Agreed, not really necessary here as we just invoke one command.  Out of
> curiosity: Why do you try to avoid it? I set it by default in all my
> scripts.

I try to avoid it because it encourages a style that omits helpful error
messages.

> >> +APT_INSTALL="apt update >/dev/null && apt install -y build-essential "\
> >> +"libcurl4-openssl-dev libssl-dev libexpat-dev gettext python >/dev/null"
> >> +
> >> +TEST_GIT_ENV="DEFAULT_TEST_TARGET=$DEFAULT_TEST_TARGET "\
> >> +"GIT_PROVE_OPTS=\"$GIT_PROVE_OPTS\" "\
> >> +"GIT_TEST_OPTS=\"$GIT_TEST_OPTS\" "\
> >> +"GIT_TEST_CLONE_2GB=$GIT_TEST_CLONE_2GB"
> >> +
> >> +TEST_GIT_CMD="linux32 --32bit i386 sh -c '"\
> >> +"'$APT_INSTALL && cd /usr/src/git && $TEST_GIT_ENV make -j2 test'"
> >> +
> >> +sudo docker run \
> >> +    --interactive --volume "${PWD}:/usr/src/git" \
> >> +    daald/ubuntu32:xenial /bin/bash -c "$TEST_GIT_CMD"
> > 
> > Hmm. Since it is a script now, it would be more readable this way, I
> > think:
> > 
> > sudo docker run --volume "${PWD}:/usr/src/git" "${1:-daald/ubuntu32:xenial}" \
> > linux32 --32bit i386 sh -c '
> > 	: update packages first &&
> > 	apt update >/dev/null &&
> > 	apt install -y build-essential libcurl4-openssl-dev libssl-dev \
> > 		libexpat-dev gettext python >/dev/null &&
> > 
> > 	: now build and test &&
> > 	cd /usr/src/git &&
> > 	DEFAULT_TEST_TARGET='"$DEFAULT_TEST_TARGET"' \
> > 	GIT_PROVE_OPTS='"$GIT_PROVE_OPTS"' \
> > 	GIT_TEST_OPTS='"$GIT_TEST_OPTS"' \
> > 	GIT_TEST_CLONE_2GB='"$GIT_TEST_CLONE_2GB"' \
> > 	make -j2 test
> > '
> 
> That looks better! I'll try it!

Thanks!
Dscho
