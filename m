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
	by dcvr.yhbt.net (Postfix) with ESMTP id E75CB1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfGAMdy (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:33:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:47867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfGAMdx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561984432;
        bh=MRnZk/BTGEygyk83jTP09N1e+0Z4x+6OJubyQVtE+xU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kNHvd5VeXNsapT5FaFJIwKrBKSwxB+KEfdWPdBs5JJ9hMegBH0aqXQs3frDw2xUrx
         5pNPUsxoevKskf6IhOd/tiVukaOfEmbBX5fjnNoTRM4H5bfAfYw0Uxdh4e9m/rzSdx
         WciQ24e0XBFLo5zczBm9TNC0j9NrpbXUGnVvQQkw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1hytd00Nzi-00LSMd; Mon, 01
 Jul 2019 14:33:52 +0200
Date:   Mon, 1 Jul 2019 14:34:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mateusz Loskot <mateusz@loskot.net>
cc:     git@vger.kernel.org
Subject: Re: [Git 2.22.0] git submodule foreach now requires quoted
 command?
In-Reply-To: <CABUeae90FQnxS1FCZLo+5LgMPD9xWQv6w7p7ymCtLdBoOijcRw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907011433531.44@tvgsbejvaqbjf.bet>
References: <CABUeae90FQnxS1FCZLo+5LgMPD9xWQv6w7p7ymCtLdBoOijcRw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0NYwkMahd3sZlnvAXkBy7pn9cam7LhQG1O78qHn4iSnVqA7igQ7
 ZsaC0pRz5kKrN8xZoULH3RPP1JTHA87b2ch0apLnn8V6tDJmMifpPxLBZZuZxUGwMyMxBW1
 lC3B6TFEBBTbW1xFnXry2jf6P9LgI153rai32/1hho6uUliEJQmT3kooSD0DHW8C4HUoiGS
 rMdNkMe3+oushzk2vvEBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RiBALuo4MmM=:nZv83uwaMMcj73k5hkrUxc
 SzoxT5NYdglITkKAUCudE5YFzRmJf+PbdCZ7nDkBVjX4xhlxV3sVMyVdMBd12VmcnGHCalQtl
 9S/CwmINgoHAgtkx2GaAarmNWKkLIa/9RkOCh4SFGGBTSL7TjBSW/X5Ni1K8ArVOuqOeagdFw
 nvgaxPRXmxlZXnJ6zwOFzffVhi3V5ocMJAbL7ermK+ddsITTVhyp2vo+Kp+9JDcLlBtIInAZo
 Oz7s5+6bfDN7v0PjrSenvSYBhg1XqnrUlSWRzWTLV6QhEqza2cX1mde/xrmMCeJq/efGAS/ER
 FuaRGXQXuwNw3A35jg/7qgOMi7RljlgdtzDOxdUwWJS2LHH51VF6vpapfOmfyNt18++ff8oOo
 cAXolwKnGoT3ZNtk4zC9oKs5ULkoy9J2Oe6HNAjKvg2yO6ukii3XekJEj2VAwCdDB+LM6G15+
 FchLXy42wp0bkmkzaqyg/W6UfZJTXIiQZChWMXJ1azApsyM1VYFpbjGGfPiXKz3O3QmtCW1CG
 O/9tX8p0pyduvVMCjU+RJ+4lpLG28GHgcEFh8EBS9Fszo9Qrpih1gzKiU0J84sWTZmz0X2Xrl
 5NK48wkRn0MU2G9B1u1eP/tKtuquy+nj+++9hETex2H+o4xs0uNUHwzNDSz0U9eXLowo6LZZJ
 qNn8+hK9IlIfalMQ8ffPjK3LRMMg7Va8ODjc0cWUTGwuFNudcu9Aj+cMQtZTYPKK5Hi84ETEv
 t54eV5+5vMa6et3c+Db/IaT1cUDph2sQkFUQLm0eFMrVIAI4/RCGLkQcmqYrYAu5/B4IFGhJ0
 S60s/wyXSw6R3V7ZSOh+Cg25OWXRNe+zEVA1NsBwbiQS/vb4xtpXBxDd9nS0gR2UKRY6zbBfA
 7YMSEafMuprCmrud440zr1ydyxozm9i/40V1Ui3bIxn5L23/ny6Ogym7MPBl9USqPU1nCned2
 AW1AyKr5lwpJKBE/a0XZluNO3KmjnhOT0KsR+/Rn2+EqL/AWkLdmBwyXewy8Mpe6xiLK9R6PD
 bunon2k/mUGTD/pdKuzhkpHXoGSj2lhYAdu9aB+595Sxs4AEbH9Ppo3pv734r1li1UZrLapol
 ggib8dmRAOIQtHPXm6hHgzrw/4sux4VWKOU
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 29 Jun 2019, Mateusz Loskot wrote:

> I have a script which I have used for long time, with numerous
> git commands and one of commands is this trivial:
>
> git submodule foreach --recursive git clean -ffd
>
> I updated to Git 2.22.0 and noticed Git started to complain:
>
> ```
> $ cd /d/boost
> $ git submodule foreach --recursive git clean -ffd
> Entering 'libs/accumulators'
> error: unknown switch `f'
> usage: git submodule--helper foreach [--quiet] [--recursive] [--] <comma=
nd>
>
>     -q, --quiet           Suppress output of entering each submodule com=
mand
>     --recursive           Recurse into nested submodules
>
> fatal: run_command returned non-zero status while recursing in the
> nested submodules of libs/accumulators
> ```
>
> Apparently, I have to quote the command to avoid the error
>
> git submodule foreach --recursive 'git clean -ffd'
>
> Is this expected behaviour?
> Could anyone help me to understand what has changed?
> I can't find any related changes in the release notes.

Probably fixed in https://github.com/gitgitgadget/git/pull/263

Ciao,
Johannes
