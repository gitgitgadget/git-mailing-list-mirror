Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACAC20248
	for <e@80x24.org>; Tue, 12 Mar 2019 22:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfCLWtm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 18:49:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:34545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfCLWtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 18:49:42 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M34eJ-1goMlG3VUV-00srKc; Tue, 12
 Mar 2019 23:49:33 +0100
Date:   Tue, 12 Mar 2019 23:49:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
cc:     Anthony Sottile <asottile@umich.edu>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: `git add <<windows 8.3 path to file inside repo>>` results in
 "fatal: ... is outside repository"
In-Reply-To: <CAKepmajVk27nHAzbuHitowyo11HvqSNfwfcg3kOp9DXDLe8FOA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903122347250.41@tvgsbejvaqbjf.bet>
References: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com> <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org> <20190311175519.6lbppv5u44w2u4sj@tb-raspi4> <CA+dzEBm7fdrncnd_7tDu-q047qxt3CsHVQna3GRMagJetisQeA@mail.gmail.com>
 <CAKepmajVk27nHAzbuHitowyo11HvqSNfwfcg3kOp9DXDLe8FOA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <nycvar.QRO.7.76.6.1903122348041.41@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:BVL/lVrJh/tlkkNNTtz3nhGrgEnBk73MOtP3m6ETjk3JjYg1zxY
 tKGZP/HyVv75mdlHSL0q+hS27kvTIzAJu8b0bG4rrz1J9GTjW/mHXzRbpKTvK7idz2Zz6/4
 NpnjlWc2LPjjPpSY6gtloI8Vc0ta+r2UdijmY9wEU7AfOwcSc4loERI12MQoBlyp08N9Pj9
 jbswVCnmg2Bkv5nc/at3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/PB8q9XFaO0=:oKFdK6ncBTyHY50DsmWVue
 loZFPzHRjIl60BSj3Z/edoDE8pgDNJASOuMR7AT+0e5/9yPycUAd1udxGNrSxAMOHL+vFyFd4
 pCNsMb6x0M/oM7rIBIQd6/1MhevHqcZZT/5Ci79Ce6bMbuEzYrJ0gMEX4a7ZqlD+rK8RMhwNW
 L+TQCKi0bm+uZRX/lYN6UfsqCnFnnH1RJ/nhT6LkBWY8tcxM039F6c13gXIlCI3ZG1rqVemk8
 N1iFuoHdGBSce2RSckhEaYQpqIp4BthMMKdhFIiM9+Hjf33QlcuR9hL3xG/O0zEoa8Aup1nlg
 FFqPuZUsJ9tZloLWu+dIS8LRKBEPkzqvClMz8FS5ldXMnE3m2P5MMC99neVnfpfiR49mPQWml
 eEhqCt4U0PszPCv5DDA1XPHdp6tWGcczFZ9OSf9u5te8vZ+w8UjztDaCsg1w8fF1G1/EhX3tY
 wnRGPku0NMp93w7z99Tz7vE83gTbz4Epohyq1OpimPFhifNbm7f56O/f36y1bYVJeeS0NpgAh
 FiYcOp1u5YodVFxo63EiUa+gIlyuOiKYUlvDch2MbrFrCQC9zvBimd/mKm9mCPSIzGtbiy5Vg
 1M29XRw4dIawLY9v6LUjCUE7joMY3RCUy55TI0TjJNWUF5AN9RhK3Zh5423rbTjsdD9qIv6o3
 HKe7KOifMpVELWx0Hsc+coQkg20ix6PVYC5dJTsxeRtOAy4Czga2dLu7CKYjMHU63u0oOew5h
 rukk8dBSQ+gdmcQFmEH+vPvUriNv3V97P12b2ZKvcb1Sycy6PvGNEW93NXi+WSoFBXEWOotJ7
 Mu4dEaMqCDEZxnUE3B7AMz3F5iQH+d2R9DTzz6YO/knXVwqfC2YiXEmNT0BA2hv32NFE3YfRK
 97uuoV/AznopYr8jt0CzlACChrsCbBi3SkCdavAfG/QOm3Z84Bs1TohqqpDDGgZvvecD/3yM7
 ILl4ckKMH+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jack,

On Mon, 11 Mar 2019, Jack Adrian Zappa wrote:

> Are you sure that you have 8.3 active on the partition you are using?
> IIRC, It is not on by default anymore.

It is still on by default on system drives (usually C:), but it is
switched off on other drives by default.

Yet another reason not to use 8.3 format (unless this is your file's
canonical name format to begin with).

Ciao,
Johannes
