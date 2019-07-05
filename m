Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846C81F461
	for <e@80x24.org>; Fri,  5 Jul 2019 19:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGETrz (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 15:47:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:53943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfGETry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 15:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562356067;
        bh=MTTgFSVsn8GksetLHyHLpWwEtkDhRKt6pe2uY6+za94=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UqU0Ow5ZBdMqTqK3SuXaqtyE2CzJovvrhs1M9vDzbEK6D9DfPZ2IlzqwtOh28uoIT
         DqKFYgFJreqhGMl5kSc9KQfKVXTE4ucLUkfKIbI0b2KEqL+8jCfcIkTS6+A4Vgxgoz
         LI2EkkxPQKCAbiqdjJQfXD+64GOYFpsR0QLRkO5o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeMOx-1hsdun3iaF-00Q93w; Fri, 05
 Jul 2019 21:47:47 +0200
Date:   Fri, 5 Jul 2019 21:48:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/14] output improvements for git range-diff
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052138370.44@tvgsbejvaqbjf.bet>
References: <20190414210933.20875-1-t.gummerer@gmail.com/> <20190705170630.27500-1-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ib0EEwkJX+230vN7F/UiKB4F+LqckQAF6Jb1hVh+fTwNy+MX3F9
 Zji3HaOkbTgLl17kMzEdLVLyE9kcH0H/RqL/UllcLhOHejBoDtRKZjydai+EGGijWsuUBmk
 p9MyJnC2f41zGS/ohd+Xa7FbG7C+CTNI9Jlf83Y+4fTQFfLQewBBHz79EIYkoZpKwoa8od6
 ZO1B5ZxAkCGEEwKFjYrFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jT0a2XWDrQc=:sPXEnRc+2tF9Vn6hZi+qoE
 95iiB16cT82KUPMcrs/JLyabdcN4cL3vFb4b7jvxzzX3q1JzM5V1bYZN3NEOGdINRiGgS7IAK
 /ZmSp4TejrEXCQAB19v9W0j0yLNPjugdh7Y4/gd3RIuXnTQAjOmUa6ZGfWhWuy2SSpyjSfP0M
 LTMYDjicUZlGDOoV7jxQL6kPX6Olni/n+gTmRWkk0SiwQej/BD87UAVGHva2KvyZQAlKAd+V9
 +9TGopDaG+i8XOjX4cEF5bG+WeSIERZtDzo2De/jjYsyZIlpvMbzEk3evgftyBgKzh/410/j6
 bZLu/mH5ILkwvo90jG5WDqIB0cLUn3F9gJ5mK02f2OK2SDqGK5zo7ed8IdODdkdpE5bnsJtoD
 13lwEELve3Beflorlil87eCHz9C81V/2oBbnBVNFwfUzVYgeP04SHYN1RFSmQIS5SZ4xx0QAT
 sPfSpUtdVg9rAgya+aRRAAU5QmfMUab1z3gH979F26xyuh48IVOZ4KQrSpyPzFY+RJfjeUR6i
 0HOt/TzEje6rvo7v2Uep9I8nG1+pMHEUuXCorUS/uQOs0nk6PB23IN51gpH9Ur53OrMJEiom1
 Uo7/80vCG/OgKvwdkiqeLBNH49RGVKtXGNQdc4G7HkkePAxXw+/9P+/AlueGlKwffovls59WD
 OdZe/O+8NtG4L+EfY0IXKVPCbY++m8ohBtzYin96GuWGnRjgudxxJ+2Ubhsu3YPfaFyvW/3eX
 U+8JQS8yE+j+ycg2X+iVWSU7jw/PYPksAAoRAh5pUDb+LA3XFLVWm94a/ArMBxe1OR9TLNiG0
 8qlAcwZ325iriZ9QlqWw/0K4Y/IYfBEM8mSVM5nxWg89C0ab1Fg+rdMVIKvS6up9+LAnqxxvG
 jcoFFmCKC7ZYsfZfF+zqY7Wz5wDJARyQgmGT4VhmA46Hc3ZdOOWdIjTiPG57h5XCNVMT4L5n5
 SQWU+DMWHyLP/qi4G9VG29Ey/sqRZV6oDhE2f3jCY+VZbdHf+vMWtc3iWgzaTN6xGk4+5igUr
 P7O/VkDIiKjKX1l/BVitb8GeuYGmAX+CAF7JijV/JTL2pfIDqer1du8DbQrmvwtDSY3dKv4DL
 dS+ui3BNLz3LMbDWWrAiiQ07YuxFlxOqV4d
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, 5 Jul 2019, Thomas Gummerer wrote:

> It's been quite a while since I sent the RFC [1] (thanks all for the
> comments on that), and the series changed shapes quite a bit since the
> last round.
>
> Since it's been such a long time, just to remind everyone, the goal of
> this series is to make the range-diff output clearer, by showing
> information about the filenames to which the current diff belongs.

Thank you for that reminder ;-)

> In the previous round, we did this using "section headers" that
> include information about the current file and adding that to the
> outer diff's hunk headers.
>
> In this round we still keep the section headers (with slightly more
> information), but in addition we also add the filename to the inner
> diff hunk headers.  In the outer diff hunk headers we then display
> either the section header or the inner diff hunk header using a
> userdiff pattern.


I like this idea!

> In terms of code changes the biggest change is that we're now re-using
> the 'parse_git_header' function from the apply code to parse the diff
> headers, instead of trying to parse them with some hacky parsing code
> in range-diff.c.  This way we are sure that the diff headers are
> properly parsed.

Yep, very good.

> I had also considered just outputting the section headers directly
> from 'git log', but then decided against that.  Parsing the headers
> allows a future enhancement of range-diff, where we would allow
> parsing an mbox file [2].

Thanks you for your consideration; I still would like to have the option
at some stage to compare a patch series from public-inbox.org/git to the
commits in `pu`, without having to fiddle with finding a valid base commit
to apply the patches on.

> I split the "only pass required data" commits up, in the hopes of
> making them easier to review, but I'm also happy to squash them if
> people feel like that makes it easier to review them.

I found it very easy to review in the current form, thank you for putting
in the extra effort.

> An added advantage of this is that we're also getting rid of things
> like the similarity index, which are not important in the range-diff,
> and are thus not represented in the "section header".
>
> One thing that did not change is that the new/deleted strings are not
> translated in this version either.  This is similar to the regular
> diff output, where we also don't translate these.  We can still
> consider translating them in the future though.
>
> [1]: https://public-inbox.org/git/20190414210933.20875-1-t.gummerer@gmai=
l.com/
> [2]: https://github.com/gitgitgadget/git/issues/207
>
> I'm including the range-diff between this version of the series and
> the RFC, and a diff between the range diff and the range-diff without
> these changes below.  Probably not useful in reviewing the code, but
> good to show off the changes made in this series.

Indeed!

I very much like the idea, and the current iteration. I offered a couple
of minor suggestions, in the hope that you find them helpful.

Thank you,
Dscho
