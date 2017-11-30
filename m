Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FA020A40
	for <e@80x24.org>; Thu, 30 Nov 2017 00:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbdK3AVl (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 19:21:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:63039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753339AbdK3AVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 19:21:40 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcvy-1eSU520ucE-009Nfl; Thu, 30
 Nov 2017 01:21:38 +0100
Date:   Thu, 30 Nov 2017 01:21:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Robert Abel <rabel@robertabel.eu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: fix reading files with windows line
 endings
In-Reply-To: <d57e4cb9-b0b4-314e-370a-e0db58a2a7da@robertabel.eu>
Message-ID: <alpine.DEB.2.21.1.1711300100320.6482@virtualbox>
References: <20171128201818.4132-1-rabel@robertabel.eu> <20171128201818.4132-2-rabel@robertabel.eu> <alpine.DEB.2.21.1.1711291519290.6482@virtualbox> <d57e4cb9-b0b4-314e-370a-e0db58a2a7da@robertabel.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:STqpkgWgWd7SvgmjGDkUSkeLIQISYb7MT6eYP055NrG2KwX4uOb
 PEts7EKskJJCsOx+aV8gYPqh25ir4m0qCghfM+SXK5fEY6O2KBzwemUJ59+tp5U3cgRIg/x
 Vqz459acR+4PAscGT4ldI5H/9mNXP7RPIG3XSwAye78xz8JCfL0+ouuAis9T0LCZCb+YZ4+
 SEqPMTiYbKTbAKFg8/W1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QIXCcJCSS+4=:gN/kbmJf9zsqvb/aHm0Dso
 x7O74pOGprTsGGjrTv6mKUFDhrj47uNIIT1HJ9ZQvALoNHO3uV/odN+3UlZjdzBsfAIf9Odyj
 BUYaImYJB12jhbFBdcM23UI43In8ZfHDR1MzDwX0pTSNQ3Yu0WZxfSpAm1qaqdW70XTEa1fUz
 jeowTTgC74ki5c2+9bGiYQ4Dm9yOk8h5XCRGXKcbzEASldj4Rmc0ab8f/r4H2TUUrn7eLgmOB
 vnR3MKQp13AoYazY9adogGC7UsCvjH3nMo/66GSwWQ0uw0ZE7KYcausOrJ458TzseHTRxhPdW
 ISHnb/JnnLq/t/kV0nwTPkv4Kv1k0dwbMqwPZPZbJghtWknvE+ozhOb6jbKUdvUwo2E4Es3oA
 4A6qkVNYvA9sGHuU9EYhqgXjIgVy2klEVP+I7lc761EiymKz6B8wr2TYyLvPxbb3dzDcYoXW4
 yRUVl6Gdy9H/2pC6p/r1wPjxujpjzHtjj7WJZQNb+ETcG7LX0QWQ55ZGC75wTCWZLv2008zN7
 1XnTg+Z6SjeC5cHK3QhN9oBXbmP/xIgyqqIWGmOuLS1QjRMN2G6vF42BTbATCbEGb1KjPznUy
 xE+Bh+qK50gzkd40z19cawushV/d8Nop5T637BJAXnOwR1OXneBsDhsGOX6QSbbwExi39M5FF
 hed0ZbiGmLjIWsuqh4uFAW5Q4swOhspyvtK8MQcgWMIT9CxT3e2817ZFaXL+agRgMhVVWIRcy
 /qgXH6vZ1kjby4SMLL0FHYaxgQzYQpUrud8WJRqufOfAAq/V6XSi0mT15opWkNK1nwwtalfRY
 9mAV0cMtkoZBYWI57KglYTSGLj4+1qrmf2HfQyAnWvwbQpPoL0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On Wed, 29 Nov 2017, Robert Abel wrote:

> On 29 Nov 2017 15:27, Johannes Schindelin wrote:
>
> > Or maybe keep with the Bash construct, but guarded behind a test that we
> > area actually running in Bash? Something like
> > 
> > 	test -z "$BASH" || IFS=$' \t\r\n'
> 
> Actually, this got me thinking and reading the POSIX.1-2008, specifically
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/read.html.
> 
> It seems POSIX states that IFS should be supported by read.

Yes, that's what I meant: you could use IFS.

> This means that it should be okay to just do
> 
> > test -r "$f" && IFS=" \t\r\n" read "$@" < "$f"

I am afraid that this won't work: when I call

	printf '123\r\n' |
	while IFS=" \t\r\n" read line
	do
		printf '%s' "$line" |
		hexdump -C
	done

it prints

	00000000  31 32 33 0d                               |123.|
	00000004

If I replace the double-quoted IFS by the dollar-single-quoted one, it
works again. I think the reason is that \t, \r and \n are used literally
when double-quoted, not as <HT>, <CR> and <LF>.

Ciao,
Johannes
