Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA411FDEA
	for <e@80x24.org>; Mon,  8 May 2017 11:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbdEHLNU (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 07:13:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:65332 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751333AbdEHLNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 07:13:19 -0400
Received: from virtualbox ([95.208.59.245]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lkx9B-1diOvO1R4f-00alGI; Mon, 08
 May 2017 13:12:51 +0200
Date:   Mon, 8 May 2017 13:12:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
cc:     git@vger.kernel.org
Subject: Re: git and the Clang Static Analyzer
In-Reply-To: <5696a8a3-0a17-18ac-8da4-4556586acee7@aegee.org>
Message-ID: <alpine.DEB.2.21.1.1705081250550.146734@virtualbox>
References: <5696a8a3-0a17-18ac-8da4-4556586acee7@aegee.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1071489964-1494241971=:146734"
X-Provags-ID: V03:K0:hXbscFbhKY0iFG71Ccz2WruHewbmD8c5+z0YOuXiLS1TG2sz6x3
 kpFnZxhORPxcUjxQUoRzCOvIzPFh8wMlQczoI/kFw+IX9iXXTr9Hthc7IJRdXrD/tb/3OLB
 Ad62rlQ1f3CoY/oCIaB4wvr0nXrq1hWKDFljJW8TsUX5w6VcDv1dUNzIWVOYH3Vr9pDfNQ6
 c0DZqUPA6REJoNEiV62fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7yp+oUj2cw8=:Qd+dTuK1r03UJGHsNrvwIY
 A8GunAUmkq05OFoy/B5357SmGHsFY4t+/SwPOMvLU90erT+MvAjJZdgHAYgn0E4RJA34FpuLe
 GPUMRIZipq/jqSCukK9t61gVWFufrF5OKa/Iwb54dV9zc/jVD5w/KzaePmLolGFYk325oEJWT
 KKIhAIaNeLGt5ZZ2OxoQxkXeVDQuobub6New8OBpn0Q8L9GA8m71a0b5K7NAqLJ3xRQUH6owO
 iRM1fds26GUtrBMmXrAgR3+eQIQR1GYTS4rtRm22swVRnSkJhUKNub5ciT90njDy1AVCu0eV/
 mYKZ6H/z8DULQ9L1ULfe5LQhofXOrA+fhVqP2QiC2cw39bx0gyS3EZIHvy3ndWptmMzh6IA4k
 DxC9ubEO0GQXOZ1gokVBeQOx4gLQnARJ6cGUU95ASAUK3oRobIJ/1eYxClcBV4jl53EdQLjN9
 sO0bWaPbiNs463JQhlocg/ifGUs8tlN5eueLHjbMhDyylf3c7wORzAtKbyR5ZdEyN/KHotaUO
 4d6ieSFz2Vs+P0CoZc1QrIXkrf7XBKpblrlSdpyArDRXChljH1YpBeqI51U8d9OD3u3YMZyC0
 79U+VB57TQWWPJ6PiHqZyZafeXRo6yMOFW0uGJJoJKnuyZk2OGDcd3NbaHkOEbTGi5lqVYelB
 VxC5x5Ex9yi5a53StrnJ2AdRMyfPhpUCjqe8dUbAXjk1UVwltXFhF3D9P+kqZyTUS7rj7mS81
 JiKkggLJPHfr11c5UXLrZxy9dBFBkyeRIQoQSZBvb/dQrpHROP9FG1431PUaXJL06z6Ou0iDR
 o9My32F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1071489964-1494241971=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dilyan,


On Sun, 7 May 2017, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=
=D1=83=D0=B7=D0=BE=D0=B2 wrote:

> I compiled git/master

=2E.. which advances from time to time, so you definitely want to include a
more informative data point here, e.g. 4fa66c85f11 (Git 2.13-rc2,
2017-05-04) ...

> using the clang 4.0 static analyzer with
>=20
> scan-build ./configure --with-libpcre --with-openssl
> scan-build make
>=20
> and here are the results:
>   https://mail.aegee.org/dpa/scan-build-git-4fa66c85f11/
>=20
> Please note, that the information is only about what gets actually compil=
ed,
> code disabled by #if .. #endif is not considered (e.g. when determining
> whether a variable assignment is useless).

So you already know that the report is specific to your setup. It may make
a lot of sense to actually state what your setup is, i.e. Operating
System, installed libraries (and their respective versions), CPU, etc.

> There are probably false-positives.

Probably. So why don't you give it a try and look through the report? Then
summarize your findings here. That would definitely find a warm welcome, I
would expect.

> However in case of e.g. builtin/notes.c:1018, builtin/reset.c:294 or
> fast-import.c:2057 I consider the hints as justified.

Okay. And those hint are...?

Remember: the easier you make it for your readers to follow your thoughts,
the more readers will try to do that.

> This is for your information,  I wouldn't have a problem if you ignore
> the analysis.

Thank you for running the scan.

However, I would like to encourage you to do better than just call Clang
and slap the report verbatim, without much in the way of a manual
analysis, onto some website.

In fact, I fear that doing it this way is rather counter-productive.

Instead, you could try to organize the report a lot better (see the many
mails about Coverity in the past):

- we already *know* that static analyzers have tons of problems with the
  way we specify "FLEX_ARRAYS": we define structs to have a 0-item or
  1-item array as their last field, then use a variable-length malloc() to
  tailor the allocated data to the needs of a variable-length array (most
  often: string). To have these issues in one category would be very
  helpful, as we could ignore those parts of the report easier.

- we also already know quite well that Git's source code often abuses
  exit() for a garbage collector on short-running processes: In many
  cmd_*() functions, there are "memory leaks" that are intentional (read:
  lazy). Again, it would be helpful to be able to fade out those reports.

- Likewise, our test helpers abide by a lot less strict rules, as we only
  use them in the test suite (and therefore it is not *really* necessary
  to, say, validate the input passed as command-line parameters). Here
  again, it would be very helpful to put those into a separate category
  that can be selectively hidden.

- there have been a number of patches floating about to fix one or more of
  the issues reported by Coverity. These patches may not yet have made it
  into `master`, but at least some of them are in `pu`. A careful analysis
  which issues reported by Clang would be addressed by `pu` would also be
  quite welcome.

Also: to make it *really* useful for other developers, it would be a good
idea for you to try your hand at patching the .travis.yml file in such a
way that the static analysis is performed as part of the Continuous
Testing, and to contribute said patch. That way, other contributors could
not only see how it is done (and copy-paste the commands, including `apt
install` calls insofar necessary), but also to see the reports on a
trusted website (Travis').

I really would like to believe that you meant to be helpful in sending
this mail. But the style does come over as "throwing a couple of scraps to
the dogs". I do not believe that is what you wanted, and I think you can
turn that impression around by at least some of the things I mentioned
above.

Ciao,
Johannes
--8323329-1071489964-1494241971=:146734--
