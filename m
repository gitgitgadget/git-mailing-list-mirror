Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9AE1F462
	for <e@80x24.org>; Wed, 29 May 2019 11:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfE2LmR (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 07:42:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:43991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfE2LmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 07:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559130130;
        bh=u2aaamXSNMWtbcRBG9dsznOKzCrUUvyxqF7x0jpT/fw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HYFcAri7AwYhUPd40jSd5D+O2RkqHFp7ZJ6P88M03sboDv+Q8uvnn9IGoYkCF4hqi
         QyPjxajdcRbEAZgrkLFlxmoD1yn/o1NT7jAJ5gCYSGLi6Emk2Tq7Dd4/WIJ5NxLigL
         jlBE/emzlFBnYt3FrnSynXQlUufFMJ3iAvf0fiDk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1gdZzw0LpO-00sh0F; Wed, 29
 May 2019 13:42:10 +0200
Date:   Wed, 29 May 2019 13:41:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Mike Mueller via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mike Mueller <mike.mueller@moodys.com>
Subject: Re: [PATCH v2 1/1] p4 unshelve: fix "Not a valid object name HEAD0"
 on Windows
In-Reply-To: <xmqq7eaa1fjt.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905291341060.44@tvgsbejvaqbjf.bet>
References: <pull.183.git.gitgitgadget@gmail.com>        <pull.183.v2.git.gitgitgadget@gmail.com>        <5e89d1aceb9125231797a355e9465d1a41a1741c.1559067344.git.gitgitgadget@gmail.com> <xmqq7eaa1fjt.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l7IDD9ibngfvM8xDMYYvC8ruaCNgctJduTVNSh0VvlY4voIIfkp
 ui+0k2YdmQDzu2Uig32W9V/xZ3jZKyqprkhKXNEF0wsfd6K0NOEJm2rjh65vTiUh4WPNew8
 SWGCG7ja+OXo/wvvTx8RW2a9sSQQGATi3G8d6BJ9GzcNg+JuiXxLbYrkVYmcx37Z7Cnf3tC
 vI5XP3+s+MBLCD2BSGxhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FjZRPyb7gSw=:5ht6BsOWyhCSvDvtWl9RZO
 3ff4rRVdibv/t4aA//NAWAdLcWokpVPa+HwKg2/3sgKIBJ2Rl1bMTuv7TDN+gI556JJIMPwlI
 zdwuaEQkK2QySJcAKDrcnr2gSUWD6lSzI17dFin5JMdutYAqj9fvkOOyUsj9+NcHEc0XXFwGV
 QQUZw/TVxmHNcXS64DTtn2HQmdH5FLMWIDjGkflBolQ90vY0xmkI4ydpx+r1bZR3PKvlJ3Qkh
 0DMTf8MxpHST2bEy352MHRi28qXVYDNWNW5JNu7lvQzDaxQ3/BmNzFRYYOEISOLj4BuZzOylU
 jiEilndQ3g5Ann8ijFh//gYhjCTNBs48f8pOU2HWo0GZXgwZQqwrnFIIfBOf5peL+pT1gVr1r
 UBtY2RkxEPlCFRvlgukF2dunDTWKX5jtrISq9nCfGEvRfXjcQFZsICt57vNn4PFPK31A0pkQ6
 CxWg1pTWJ0aZLHniXojpymicYLbqlSFfqqldj2ekOj6rayEJ7eEecGYw0uTWwkmzxkQ1fyt9+
 6KOa06UyiZIUi6apwqpN3blv4Zex1oaGfnI+MPLcEcgzXF2wuQh50q2AWyn1NmDY1GTfXwut8
 hdNLzgdp6FK7p/eOylK+1CyV+FISZCFnbcsfdGnmp32bWU/u4wJrOdsy3Izsyu2itzWrO3bhf
 davTAkdN1WKaJmbH9QIcfEnfeVs5tL5p2SNBJ5VKBXkCbrOjcLqWiqJOkMbBFDhibuLXMAeeg
 HaOdCdh6w4GoK4BaEOvcSkzJbWp8MPMMY4bgRssPVKGn97BuOecd6LbrdvMomTW5WjBzrXlo4
 5V4vsBNpThm7mofv2zAT7Y8PkLV59rx9BnKPWgab+oDwOLJ5NTNCz+cCNS+f9ysfmrUUPrJDT
 Al2wD45eDsWBAzFYreFBVx/rFs3dMHBloIk40mzKp0x4/w9L6RrXR/I6oCTdmDw8+aj7ps6Xe
 l/tVXdQBV3mk5o7Ln1J0HWwtMJQKFn/B+vAvJ6WHUaHk2a3eyk3MP
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 28 May 2019, Junio C Hamano wrote:

> "Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Mike Mueller <mike.mueller@moodys.com>
> >
> > git p4 unshelve was failing with these errors:
> >
> > fatal: Not a valid object name HEAD0
> > Command failed: git cat-file commit HEAD^0
> >
> > (git version 2.21.0.windows.1, python 2.7.16)
> >
> > The pOpen call used by git-p4 to invoke the git command can take eithe=
r a
> > string or an array as a first argument. The array form is preferred
> > because platform-specific escaping of special characters will be
> > handled automatically.(https://docs.python.org/2/library/subprocess.ht=
ml)
> > The extractLogMessageFromGitCommit method was, however, using the stri=
ng
> > form and so the caret (^) character in the HEAD^0 argument was not bei=
ng
> > escaped on Windows.  The caret happens to be the escape character, whi=
ch
> > is why the git command was receiving HEAD0.
>
> In the output from
>
>     git grep 'read_pipe_lines("'
>
> together with a few hits to harmless constant command line, we find
> this line
>
>     diff =3D read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (sel=
f.diffOpts, id, id))
>
> Would the caret we see there cause a similar problem?  It would end
> up running something like
>
>    $ git diff-tree -r -M "HEAD^" "HEAD"

I think you're right!

In addition, I wonder whether we would want to replace the `^` by a `~`,
which would have the same effect, but does not need quoting in Bash nor
CMD.

Ciao,
Dscho
