Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9CB71F461
	for <e@80x24.org>; Tue, 14 May 2019 12:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfENMhw (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:37:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:53935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENMhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557837466;
        bh=Gld61BGofGHPrpFgqmlQLEY/YGiJNTZGdGJ/z36XBak=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=enlIehzyLknzcpe+CZp6sOesZ1U8gwjQsPB2ERoFsTtD0lxRl0H3cRmrVzK+wxE1w
         /Z87mLta4YYcCoyiXMfaiMYUul6KPfYOqfUrkHSPLnaaWNTLIYlBy6TINsU66TlNpE
         WpV98CD068YyzAHH+TuTS77tpH9D7GHPU9bYr8NU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlXnX-1gs0gX0qBD-00bM8f; Tue, 14
 May 2019 14:37:46 +0200
Date:   Tue, 14 May 2019 14:37:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH] tests: add a special setup where prerequisites fail
In-Reply-To: <87lfz9wexs.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905141434040.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet> <20190513183242.10600-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1905140945220.44@tvgsbejvaqbjf.bet> <87lfz9wexs.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1665868500-1557837466=:44"
X-Provags-ID: V03:K1:yeSbqBMLM1lsG/YUkv1flurR4sb5ZWLhzHzhRnjfJFthNjsmb1F
 wMFmX3Wwr+zEjjDrlA9kcHj2obh0DNKUPZlFrXdSaTIsKjgQOG8f2SQaCfEIElP/7oN35KT
 YiCQQF3c+sH6NFtb4vHSG742FDMDIoxMVD1IgyYXT/D7LOr7vkbnMQxQXiPA9un0QbFaRvV
 XJIUyqqzCoyzPgM2PBuqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NY6to3Q2f20=:gDX/BxATFbp+CuMkD50EnW
 v2fNCPf8ZXUYy6QHQIhpDOZVHNWuRqemKTP4YuOSwlAwdhEoQM3PeIE+jR9jCj2faE35Q/b5u
 B6VEfekADgWo84wbSIyepb2fLxY1zHrLQ3m6Gcc4V4LbUh+90mg1j1RJIqpy8nvxHx3PZUjbV
 k+/qC2rQazZ8SGahMbN2oTITVBFPYfRKklDVcppMzxtPY+QpYf4rz09qyAdfEFlQsPJgZa37Q
 vd+HkK7RcstYRbTAYBIFvD/zV5/sfByVHzDyxq+YEIL692H20w8cdCBc6TNeaXPZyWVV2TZi9
 dBpQWf3fBNIj1FcLlElb2tyTllUYDpnPHfcR7tXiu/iBXOUzPmYxYlV7CHoTl0ocHxcMLGbNN
 hKC+rBlYgyVXashdq6VtbDgoAvHWRWbq6WjOG7tvGMXf9pkOr8ntpYUJLhv9Ry1fjKfPqLU7m
 39Webgc8zbVCIlXrK/7pbnnW21/aUHYw6BRWpTeRKCL0x/xszH6ztfcGJGTDvO76Rz4+THYha
 /BEXCt3gesPGTnvUKSmWaWBBf3K9LQ7ckFe0a9MDai0SdEF7OBfceQy4CyvJ0sYmHprQc3+Nc
 FfimbJRFfalvIcwCG2N8y9btj6xnPFM/eAPR/05JGx0jz7kT4qjixs0X7LHb4btOrMaxNpqHx
 9etlW5I+Y4NJBr3iuPEMGwTb+57q0Y44B1QlVWC/GzGSWQAyeeedJ3zF3fnoGEHR8o1iGFBrs
 AuZ9Kov0juDlusUBrsSaYbFn2Afsvj2MGRZ77cFM37QC9KlG2WNKjRPACWTK9zJ3Am75nS6pm
 i9mIRn3yK8qEpBwDa7JZ4sECc1ys6umfdaUC0FuEHdnGrjODwvS5Co0jSJk+fh79rnRy415Y/
 5z03GjyIWWs6xUL+1wdgwWz6Xwsg+pCMs6oeCLkFQPMFZ7s3HSK457XoY5hXA7AuSZ4eYMdyu
 uoa2HKY0scQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1665868500-1557837466=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 14 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, May 14 2019, Johannes Schindelin wrote:
>
> > What would you think about a mode where random test cases are skipped?
> > It would have to make sure to provide a way to recreate the problem,
> > e.g. giving a string that defines exactly which test cases were
> > skipped.
> >
> > I am *sure* that tons of test scripts would fail with that, and we
> > would probably have to special-case the `setup` "test cases", and we
> > would have to clean up quite a few scripts to *not* execute random
> > stuff outside of `test_expect_*`...
>
> I think it would be neat, but unrelated to and overkill for spotting the
> practical problem we have now, which is that we *know* we skip some of
> this now on some platforms/setups due to prereqs.

I understand, but I am still worried that this is a lot of work for an
incomplete fix.

For example, the t7600-merge.sh test script that set off this conversation
has two prereqs that are unmet on Windows: GPG and EXECKEEPSPID. On Azure
Pipelines' macOS agents, it is only GPG that is unmet. So switching off
all prereqs would not help macOS with e.g. a bug where the GPG test cases
are skipped but the EXECKEEPSPID test case is not.

Ciao,
Dscho

--8323328-1665868500-1557837466=:44--
