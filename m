Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A348920248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCUOJ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:09:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:60935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUOJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553177397;
        bh=a4YjhJtNBGP3G1GRz8JXZF/R0PGm8YkGyQxTUG8PcFU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FMFuQB4G55O2Nqwy7nE9dbVb56AFptZB69eaC3FqvSJHH1E1/hUqYzIEEgFlg6v+O
         FDo+Q4xxAufdKTTnwPDqQDOLJLIGWkwbQbY48NiCWKMOOmSFBr+kOP3lzTuiOsVZir
         J2UCU/624/Yl2bxfNs3nBjfk5PC70O5XODcfhHDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcja-1hFFqh0Vdq-009RWu; Thu, 21
 Mar 2019 15:09:57 +0100
Date:   Thu, 21 Mar 2019 15:09:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Richard Hipp <drh@sqlite.org>
cc:     git@vger.kernel.org
Subject: Re: git-fast-import yields huge packfile
In-Reply-To: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903211503030.41@tvgsbejvaqbjf.bet>
References: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8KgEWLgw2CUM7h7cStl+ZEID33vp90yz7WiOZEtSJyrU8o4jdwq
 VzrzLMS3CAXMIvlsaYg+lsobboWMQOizufrwgI7y00rZRERL2vUc8t8PClVlDYPmhwtVsio
 zIpPNVoGvVhJgjSLWqh5xglkcygRsd/+lw+BmCVXA88PFM4FhBY38F69gf92BIzm/IsYf9Q
 qaC/PlmRBGnsf1ortCdJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IoApvuDzSNU=:m4wI3ghPYxzpBi5cKdnKcQ
 IyEivu7MOrsVZu1+0IcOF5FqLVZN1NSBJmL6eAwQ8MBoc5PBINhuzKFKmVmI9qd6pgrGQ4fxR
 zWiz7QSecAnGSz3od2Pc1x5v9ntWcLt5EmvPUkH5L8xCeyYxW5CZ2JcLihA0oRv4DwLowZcaW
 PRmXrE7RYc8woSYQjp/8muYaCfIuvl3sX+KXM9+hvYJGckloYgxdWcCbyX3PjGXnuRlyAeQ6j
 f0mEhUd1HVjsJxK7G1sPon/HrVwZVo6Vaq8P0A63PKzKswTrv4EspeA69yQBkPbMzpWIicX/J
 Zw3z6auEYoYr5mXyKxqz6kDm0GxwABB3wfo5xPiEt8adpc4qbJFJlOOPACziaTUnWMT5/Reju
 TII8WjvRiERq7dZ2IxGMkLPr4uLh89AM0bOsiGjr7Ju3Lren1EbfXsGlWLeyG+RPFZqlAIbUe
 U/qZPe8RNozAZ5j1BCpBtb/XbHpJvYO2V+L7mxjTB06DBcNn8FOROW94tLo0BvoPXKaL8Wol+
 3jbJtBpJt2ZKex/gWolQ/TcHMtS/jxVJlROy4lhn5Ajx5GDij9cgKoxSnrA6lBLxAcxBzasZq
 l/bDq/NW01nNOgiZXSmIGRqNHpIqmO6OTVgol8Imt9km5naeG3ZzHVUIMycPeasUHfCQa32+k
 YRB9Rqq9qOHqu0EJ30ZwHnW0wzFmRDJoqOwo7czqyfTlPvgDvZHnJt/L0Gv1sdCV7BtmIVRLE
 riEO5gIkC+MzYSX0v523rYT64WUFuVdG3V4vPXzyIzVL8Fk/IayvAyzcK71hc0EpH75lQn4Ou
 2QS8570UUdL7yLras1uMJw0cjZI0+vq1YIGF2/L2tZ9R9dg75Yba6PMYoo/xxXMcfRuoNBGuW
 7tBPMUWNrqQm972koUGc6eNkgJV8exwbsyU8EDX6nQWsxsdSflUqNMeg5kQrNglv7BefW5+O4
 oHZhpcUQbuw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Richard,

On Sat, 16 Mar 2019, Richard Hipp wrote:

> I'm trying to transform a repository from another VCS into a Git
> repository using "git fast-import".  It appears to work, but the
> resulting Git repository is huge relative to the original - 18 times
> larger. Most of the space seems to be taken up by a single large
> packfile.  That packfile is about 967 MB which is about 1/4th the
> total uncompressed size of all 41785 distinct Blobs in the original
> repository.  The source VCS is able to compress this down to 52 MB by
> comparison.

I feel your pain, as I had the same problem back in the day. My use case
was mirroring an upstream Mercurial repository to a Git repository. This
use case went away, so I do not do that anymore (and there are more, less
happy reasons why I would no longer work on that git-remote-hg project,
but that's off topic). As one of the last rem(a)inders, Git for Windows
carries this patch:

https://github.com/git-for-windows/git/commit/b91911ff8d3e2cf279b4708be89d=
e2e3bc8e9e87

Essentially, it *always* runs `git gc --auto` after running `fast-import`.

Which is a lot more high-level advice than the rather low-level `git
repack` hint given elsewhere in this thread.

Now, I wonder whether we should integrate this into `fast-import` proper
(with a knob to turn it off), maybe even offer to run `git gc --auto`
every <N> imported commits?

Ciao,
Johannes

> Maybe I'm doing something wrong with the fast-import stream that is
> defeating Git's attempts at delta compression....
>
> Are there any utility programs available for analyzing packfiles so
> that I try to figure out where the inefficiencies are cropping up, so
> that I can try to address them?
>
> Anybody have any suggestions on what I should be looking for?
>
> If anyone would care to see this oversized packfile and perhaps offer
> suggestions on how I can make it more space-efficient, it can be
> cloned from https://github.com/drhsqlite/fossil-mirror.git - at least
> for now - surely I will delete that repo and regenerate it once I
> figure out this problem.
>
> --
> D. Richard Hipp
> drh@sqlite.org
>
