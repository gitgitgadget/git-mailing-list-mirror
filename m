Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244591F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfBHKK7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:10:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:38217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfBHKK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:10:59 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfHs4-1hTbr33snQ-00omnW; Fri, 08
 Feb 2019 11:10:54 +0100
Date:   Fri, 8 Feb 2019 11:10:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: make sure we build Git parallel
In-Reply-To: <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902081110310.41@tvgsbejvaqbjf.bet>
References: <20190207183736.9299-1-szeder.dev@gmail.com> <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com> <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com> <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet>
 <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nYzcUXY5yL4ibxYOU3corxryAutTmdBCX72uW1BB6AjfQfncqzA
 lUeJ2XCJSuW9+uzA8cULOiiyB5SbpY4X3LAdH5oaPXPFvZshFG31ANFW594WTtd99pUGQla
 LIFsBbVUIPci+aAZ+3FPbcNYIXrd0yjyvuMG9qh9Wl3nGamz+LaWmL0z3gyNgsZXFjWq7Nl
 vDhWnNn9Be8bsRHZ/dWoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7sxfxX+EhOY=:kn3ldbq/6wNfZjZH7cVKBW
 0V8gL9ug4tywT8KHBvIUeigxLwMX4UEFnRUoZI5bkEJbnukz/hRDRQIrf7izWA9+fcTki/DRh
 +y/2s3QbtvmOnAMUgRAxVIQjRuMx/4t0jLDFviekmJF5J56Gbg5aGGPoPAFhWtR8ymiLM7otd
 FV09gcX/rQD1RDRkbRRTeffLpWSDLxbEhx0+73V/mt4HS0jHcWfavxzts6HH0oRisiCl7cQoT
 Hra4Xbf0KXxEqkT1F3Pe8+T1SGRr1LfzalfNKRitQcKE+1W/0gxWgPvAImnfyVfu9QdGJqGbc
 pWEqGUWOr3Cuupdu/IAnJ2SVee8sHqNRgC/YQUF622raZXhByoVp7ITvIHzY9sv0nwAQwEYi8
 BK8plZ2w+vLHldNJkcJv3C4Gg6jyxeH0fwWY/n7h7ss42yELOni7ouduVzQw3bfF+5PH8TECw
 w2+xMP4SQGnQ/9H3DSNh8ZWhLMfsQA+Y9iN8uxzOcbK1ReGaZCXy8rELXL8XMnoFPcCTa1pPO
 vEvSUnkT+wLNiY18A/1rEahfDzvGndmKOdupYqrl3Uf0Ig5uuvnCBh02JK0OOBZaktPMoJfOL
 JLeoasAmte1RAsnF7vkgT04qzrHso4BSV8kvii6xyubaJ861zAph2vsEXDMzNxJmGDYlJ+2Pv
 20XjJ37TrNlZfESXdjstQZ7VQKX7zUodOQMFXgAGHtjq565xdOb7s+OjNQqCcM3kOIfQ1GUeS
 ML1bdM0nnFDxcxQ09n/L5zI6j7qI5/RGSFQMn7ue0Gls9inqf3hRBQWiRtrlio4OJ/Yw73ock
 kSUZHBNBcFLDRgG8F1pxtRPOjMhNdxrbxLeESO2NhsSSgiJuarU194YsnaaliDdvHFzf0sGgc
 1yqaH5wJe2RNIPJkMXDKg7Ti8tqKwpynjLuFiE1ezZ8B2/6JDfKfK5LgWPG71w94NBgPTxL65
 awwZFDkgcvg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 7 Feb 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  
> >> +# Clear MAKEFLAGS that may come from the outside world.
> >> +export MAKEFLAGS=
> >> +
> >>  # Set 'exit on error' for all CI scripts to let the caller know that
> >>  # something went wrong.
> >>  # Set tracing executed commands, primarily setting environment variables
> >> @@ -101,7 +104,7 @@ then
> >>  	BREW_INSTALL_PACKAGES="git-lfs gettext"
> >>  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> >>  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> >> -	export MAKEFLAGS="--jobs=2"
> >> +	MAKEFLAGS="$MAKEFLAGS --jobs=2"
> >>  elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
> >>  then
> >>  	CI_TYPE=azure-pipelines
> >> @@ -126,7 +129,7 @@ then
> >>  	BREW_INSTALL_PACKAGES=gcc@8
> >>  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> >>  	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> >> -	export MAKEFLAGS="--jobs=10"
> >> +	MAKEFLAGS="$MAKEFLAGS --jobs=10"
> >>  	test windows_nt != "$CI_OS_NAME" ||
> >>  	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> >>  else
> >> @@ -185,4 +188,4 @@ GIT_TEST_GETTEXT_POISON)
> >>  	;;
> >>  esac
> >>  
> >> -export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> >> +MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> >
> > Since this is intended to be run in a CI setting, there is not a whole lot
> > of opportunity to set `MAKEFLAGS` outside of the script. And if there is,
> > that might open a rabbit hole when debugging issues that somehow in the
> > end turn out to come from a hard-coded `MAKEFLAGS` somewhere in the CI
> > system.
> >
> > So I'd rather clear `MAKEFLAGS` at the beginning (i.e. where you `export
> > MAKEFLAGS`, I'd simply append a `=`).
> 
> I meant to clear it at the beginning, where I "export MAKEFLAGS=".
> Did your MUA ate the equal sign at the end, mistaking it with part
> of text/plain; format=flawed or something?

I could have sworn that there was no equal sign yesterday.

Sorry for the noise,
Dscho
