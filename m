Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0492202AA
	for <e@80x24.org>; Tue, 26 Feb 2019 19:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfBZT7L (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 14:59:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:35607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbfBZT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 14:59:11 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5IdH-1hDCna0lsF-00zUJ6; Tue, 26
 Feb 2019 20:59:01 +0100
Date:   Tue, 26 Feb 2019 20:58:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
In-Reply-To: <20190226173542.GC19606@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902262055260.41@tvgsbejvaqbjf.bet>
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com> <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com> <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226173542.GC19606@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CgYzC0U6YDefSno1Q6M0be4GAqOIENnbvB/143r0LC4jaxweGkL
 DcIH7rEzu7d8A1IVN5m8ORqCVi1tHG3jjxDDmWefNz4LZwX2CNYGnGnWhA4JChxxUgLOmSj
 vrQrUoEyT/s0hDOQEMwCY0oZHRVZo7dPPf7A6mOfRlI2FnL3fdVxW8544v3yzmimoqs7DlB
 n9vCC0Sc+IJtKrZolU+Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9gu1AQfAUzE=:YHcAvlPadXU55+w0BrNbiV
 puvxFCfIh9hv3M4PDT2zo2KOAGgQtA7nu6LkWQbYpCm0CrfWw8a7U0fEvG3E36P0htP3qRXDt
 ZFs3env5kkkowdVhAcjjgr0/OEZrIo7KJ44upPbS7IIr8CVRKRjP2cVSWiMZyEOTBqqpk60ue
 iH+sWFfUooGjlgOMu1IKbhCNLKZFkSIAa8C8C5xJJsHJ2VD/8yUCYmLHn5Binyq3uTm91XfVH
 9NIeLsqRWWCKzfei+dXG2LKprEsbNDzy+RHKYyug7rGp1K2r5SJxzOCegT0ZtFHal/uzRpfs8
 dcSZ2C2rS8ImgtzFF0dXbGzSxN3ff+ka/qLaQUY0Wcaex0WGxLz1GzRGPJ6CO4+kxLmC7sAXB
 FUQXdmPqf1j8SWoKh/dDsc57fahNpQKS+bDK4wB5pFWp9MVk01IDrmXMRciRqFuduyHYLdZ9l
 of7DpDFdcekELRy8SzOLKgTucLze6+N9GF7MLgy6QVFMOcVBHd5bjYIZqHxg22gdxCK6a49iy
 rf+l2TAfCNAyRImV/bLvHnousabAiP7WU0sHQhUYIVTTUbNtOMKf9vvnIspUNYKr0ARu3SeqP
 Oo7fyEsvg9lB1l4kFsv0ZlS3brYLoDsjEzBSbImaa0nmtOethVsSxRCQRmVP9aTt7pp3EGtkv
 CY8CzH0DKIlQjPV3R1AX843f7+oKgdWkEA7SMD4I7uXgr1ahd1cpFtD+ruNx6JfBSW/6lo+As
 mCIKZh4XxIzcIqUJfQXe3p8tRYoZmlfsNGTyHV/9uOCGtMwhdsB34HSx2DyWVb/j0Yy424YgX
 stZyTljDRX+g9qQrC0A/PPttEFMQ9zR9TG6SAaQ5t19F4L2CBiMphy/jFQW9khvgX/IPzF1+i
 mpnrSb/D6EBv7t2wAMfaP3954CDAiUqQgOMNgbK4bevAh+DhQzZN2ciKBVdkLpd/BpMI7CFwt
 mVXbGK4z1Jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 26 Feb 2019, Jeff King wrote:

> I had a vague notion that there was some reason (portability?) that we
> preferred to have the wrappers. But as your patch shows, they really are
> just calling "test" and nothing else.

Let's also not forget about the fact that `test -f` is actually not all
that intuitive an interface. Whereas even somebody without training in
software development (let alone Unix shell scripting) understands the
meaning of

	test_path_is_file this-file.txt

And even for a trained eye, the trace of `test -f` is sometimes hard to
read, as you do *not* see the exit code in the trace, so you have to guess
from circumstantial evidence whether it failed or succeeded.

Ciao,
Dscho
