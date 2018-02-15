Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14BC1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426534AbeBOQuJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 11:50:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:41623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423744AbeBOQuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 11:50:07 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0Lbujs-1eKhTj1HYi-00jHl0; Thu, 15 Feb 2018 17:50:03 +0100
Date:   Thu, 15 Feb 2018 17:50:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <87a7wazx8k.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802151748160.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87zi4edbp3.fsf@javad.com> <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xqKPbwt-KeYTKadM3bHDkU3m0WiezKeVu75TyftBSEYDA@mail.gmail.com> <8760718imo.fsf@javad.com> <CA+P7+xpg76nP8+KBrYWeYPcm8+0jS_MzL+B=LF6WPfBv44zrwA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802150209390.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87a7wazx8k.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UBGt9WCFIEZQyiaGShgtCta/k3mHv6gSSeUgrEkJ6ynfw2LrFSL
 mkPHe5RqfTe8g/VQSV4ZmRkN+RX8rt1GmuDEv5msi4Nu5dJ9iky8nrBRsQJn6O1qIYB7bat
 VLltQNv0vy48N8tOFUqpgukcWJ82vGgpagVi+EBO8/O36KxwY6QhnHxW0WFYiSGPaplCUOd
 hdZD5XC92jdpWTaWJTHqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TaemZ0dHU4s=:ysPPrkIWPDZbyw1wK4m+jX
 xDSDJ4+OdIeLwFNIiGGuUw/liLYT7LxJ+3GbRKDNq8ELSnb47ALE0z+onRFEj5aIXMgSGI71h
 9Je6pxutNTmm3Wap8UW4bYIPoeoteLDGeP0hw9VArAkzPj1l8xSnyDUzqeFV/BpBPBPSFFDaB
 EpE0pqtDCpqxl7wRM9CWN19OnvSzLHCOSu7rMAa1BOj7324zXRRXuVtx5zHbIJ0UuG9FcpFvG
 gmy3R9bgD7CFIFey28UuVhKr8EJ4M7sx4hWo6AzJQOpEr+vzXb+5wEEG3Z7sFMCca8AtvmTa6
 s7twDP8c0eO8yaOGHYWqCk//fSxjhDdWU3mXMHmHpCCXi8b8vC+CloCmdcWYvSVRU8elXhOhF
 RWMya6wVOaW2QAhEq5TlBj/C09qshIMtAPJYfuxNBTEWnu78JwzC+z1bvk1qZ3QhS9Vep3gQy
 qB0jQo+jw/gZnLl38ZW03BwMy4WHLECH6st/qLDQyG+BbppJSVTOz9i9e6cf20BgNz7dD0+ih
 7wMSF35OVrLSc0LuqbhkwJSiAWaKTuI3WE/vtGdlfWzJC/lCqjvFwgv3kM6OuUr0nuS1KZudJ
 H1oNtsV8p9MQ5ZqULgejketx59dDVIXT4XunkuXHzUf96ER1aJOEKc2IGkpC3r9KStqU2x80l
 yHyeU7XoQgBloO2hF4kP2Cs1mbyOATv70D2Yt+5+qYsQJ8RQZF1zHcnLGSOSVIc4M0QSgWvul
 9EXYoriiqqwNKtiO8lxQFC+MzZkFcYfhfg596HEMZgEhXlzUzMbpxuvnoXiRgQbilvUKbNgsa
 xmFJ5qbQq6IY6XO42yIG4LRsu1f7FCeytpJaI+TIS+o9PUaePM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 15 Feb 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> [...]
> 
> >> > I'd not argue this way myself. If there are out-of-git-tree non-human
> >> > users that accept and tweak todo _generated_ by current "git rebase -p"
> >> > _command_, I also vote for a new option.
> >> >
> >> 
> >> To be fair, I have not seen anything that actually reads the todo list
> >> and tweaks it in such a manner. The closest example is the git garden
> >> shears script, which simply replaces the todo list.
> >> 
> >> It's certainly *possible* that such a script would exist though,
> >
> > We actually know of such scripts.
> 
> Please consider to explain this in the description of the change. I
> believe readers deserve an explanation of why you decided to invent new
> option instead of fixing the old one, even if it were only a suspicion,
> more so if it is confidence.

I considered.

And since even the absence of this use case would *still* not be a
convincing case against keeping --preserve-merges backwards-compatible, I
will not mention it.

Just saying that --preserve-merges is not changed, in order to keep
backwards-compatibility, is plenty enough.

It probably already convinced the Git maintainer, who is very careful
about backwards-compatibility, and rightfully so.

Ciao,
Johannes
