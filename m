Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE175202A0
	for <e@80x24.org>; Fri,  3 Nov 2017 11:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdKCLvr (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 07:51:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:61400 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbdKCLvp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 07:51:45 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4y8-1e1p5F08fI-008pU7; Fri, 03
 Nov 2017 12:51:37 +0100
Date:   Fri, 3 Nov 2017 12:51:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle
 redirection
In-Reply-To: <xmqqzi84p1ue.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711031251060.6482@virtualbox>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de> <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com> <alpine.DEB.2.21.1.1710311807420.6482@virtualbox>
 <xmqq4lqevbmk.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011726030.6482@virtualbox> <xmqqr2thsby4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711021819430.6482@virtualbox> <xmqqzi84p1ue.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l9WGzcVtQpNjdBgS00IPW958iMRoE/2n770mOoXsOO9PT8h1F76
 TgVEC4KcrGiLGZ+ceOxyEPEl2AzlYJJ89A2pPlfyOxf5nMVhLUIA/kgH6pfjW3GLCJiWDdJ
 p1A9ZRShd3s2v1vUL3J70ZJO94t3b35EXberJgF5SAI5nvgQ/cQw5ucbk4Yx4ZWlU6/ynKi
 rIV9IHFyFpDAxUHWUGcdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uhzwL/ttbxc=:yIGiOR1g/imZ2npkpaXtfg
 xyKDAwU55GY7qzOCpNcmqWVCnP8GSJGOFytVrYe9hPOeIDsnfPa5Hk7NAb/A1gRDLbMYRBKYS
 hDsSgkBZeHvkkOU0psv77eYZu4ExGkZv0ECs09bVyEBDvUn8DM+WVMoG3Exr4KM4xdAR2zGdM
 ssTzZNrdsij6gPhGnLL/ziUrD+L92CLROskbJ9ZJKBo1ZO2J8vJu9r6ZJe/U7fGbTa2JNbmyE
 +5PaXSWb7K+0FJVubv/IiO+R0R/xTO7Kv7nf9LZ7e85YqknSDIThr1sntQ2yuYCo2q1ffBC9H
 DmbX0z/RXQvIZOkvP5Y8P8Yztv9ClHSaQ/aKAhZu/Mk22jjcA4C+ozLJqvrWdEap5O/Fh/JFq
 PhpWr9Cdnv/g4eoAHiEeqQZmTLaV8PGZr1vBqcy2wWZBCfOmi1KLMoEITADTqTqhuJzPrsfj9
 aBvu+Z2YTtE3Eobm44Zc/8cch3oz9/N8suFyLGXMk8ZS1VozeQT3X4W6OOfod0ff0s62Yxdru
 jsMFal9nfpHRzUVdafYjQVknpBvZ84f7JZXZQ9fiN0rBNGErY/TjeH/jEsydOoRQeH0x5Hfwk
 my+kzZ49yaFuwpnSUeY/5i2gU0Z2CtcC4d8IqkZgDjuR4QkUFLLz3Pp3VGjuRmY5DgjsIuZbo
 IZOzTLM6f4w5KzQYHccIRalvfAHCi9an1aVWGeuzUZnf4/UQ9G/MavFJM0z1Af88Y7FePkgRc
 eqRSPlx+3VklswB5Jnz1936Z/V4QHHUrj/BSFpgb1hhIGtgUmt+sQgfjNlXJGOck7d8NpQRVr
 CgmwRrAMJq480XpZAQuwGWfgi73Y+f4SHKwZ1hAcKTKJ9tgXKs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Nov 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> If I was correct in assuming that "2>&1" is just as foreign as
> >> ">/dev/null", then we should be shunning "2>&1" just like we shun
> >> ">/dev/null".  That was all I meant to say.
> >
> > Did you know that `2>&1` works in Powershell?
> 
> No.  And that makes me curious if ">&-" is also there to replace
> "off" ;-)

No, it does not:

-- snip --
PS C:\Users\me> echo 123 >&-
At line:1 char:11
+ echo 123 >&-
+           ~
Missing file specification after redirection operator.
At line:1 char:11
+ echo 123 >&-
+           ~
The ampersand (&) character is not allowed. The & operator is reserved for future use; wrap an ampersand in double
quotation marks ("&") to pass it as part of a string.
    + CategoryInfo          : ParserError: (:) [],
ParentContainsErrorRecordException
    + FullyQualifiedErrorId : MissingFileSpecification
-- snap --

Besides, we're really getting off-track here. I do not *like* `2>&1` as
quite cryptic placeholder for `redirect stderr into the same handle as
stdout was already redirected`. It is Perl-level obscurity.

Adding even more of those "let's string together non-alphanumerical
characters together and declare that they have some special meaning that
nobody would guess so they have to ask us and thereby make us feel smarter
than we are" is definitely not anything I want.

In my opinion, `off` is kind of a compromise that is both easy to
understand and hard to confuse.

If there was a short, succinct and easy-to-understand textual
representation of `same as stdout` that would not be easily confused for a
real file path, I would rather use that instead.

Please note, though, that I am again very reluctant to change things for
less than really compelling reasons at this stage. I have just burned two
days as a consequence of Peff's decision to take my --no-lock-index work
and turn it into something different enough that I had to put in more work
to adjust it, only to introduce a bug in something that worked without any
problem for over one entire year.

It is quite a bit ridiculous just how much bug hunting time I have to
spend lately on stuff that used to work and that got broken on transit
into git.git. It adds a whole new stress level to my work.

Ciao,
Dscho
