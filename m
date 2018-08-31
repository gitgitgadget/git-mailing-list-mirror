Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A070E1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 09:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeHaOFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 10:05:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:47641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeHaOFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 10:05:25 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvQkh-1fnOgi2TMh-010cYl; Fri, 31
 Aug 2018 11:58:27 +0200
Date:   Fri, 31 Aug 2018 11:58:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Jann Horn <jannh@google.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
In-Reply-To: <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet>
References: <20180830070548.GA15081@sigill.intra.peff.net> <20180830070932.GB15420@sigill.intra.peff.net> <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:J1eOuLDtgoPfia+NcHSuMk+Z36tAneqzJiKdKGsGOuwseYDltAD
 S7A2cdOrcwa4F9ZooEAKlgvh4v2PKoMTbe1qgLyq7TbYFfxkau8uNXNmFK7Mi8P9v7HoamX
 JriRJEMaNrDy++kLrHRgtpcHEgAUvSZkLwylrLvpDkH+1IhQhkWBU46eNEkiSggJIQEO66p
 J8NklloYfwQ9R114vXYJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:okce+CcOeu4=:Zgf+sYD3H25r9u5Yut2G2O
 5MRQKpsXnNHUm9bkITZe6KtsnfHfv8AH/PJAvEPspZtEyQcGU9/nvPjdujGcQOHDzAn77b7vX
 qKMCEkEU4qu8QvrqumTZJrnzfhd+w9zwYFV4oUzsxFySVvY4BnehC8F4s+xjOaUhdmVAmwwhR
 unsX5zNjFX2indvGTPJihWkaCfjw6f9+VrFXSIR+W3f6BDLV5QV5ZnHeRYJ8qG+IzDXPwTYKL
 dOQkPeZ7tV5iWFF/XGT3ltyKdyFmJdYHnaeB+3N6vJiHvMKCshMlxkWTrk/sSoBJtfq8K8zJe
 x+/fiCfnsD5TPVliOKOrHezURAx7jE62vTGs2xv//JDtkMb0o56bgQCi+R6sXm5ySaGAIAvG+
 Fr6uY4TeeaH1UA8Ft/4xJev6sxIhqAkuU+IF8rw+T8XLwWv3C6muU/v+x34RU/mWjWvSbQZ53
 n8o6VwabgjK2VFc4e4BjzKa4NkHEjaMOpYv6IMJE1L5ZqXiFcTudkrMcupWrqo3Ub/8frDTIy
 QH+z9mVPw+qFv/+cdJ2MyUxca4G5Z67XY3eg1mtKsJiwy+k8mu1u6qgVVSgBjLSIrLfCTw9WM
 LueErfWlwzCkG4FvvCaJ7+mECaOvzF3sNOpMty78Up08bN6tXlWr+Nk26hpANCDhyYC3RWaLd
 sgZgTXAQbqGLyBUGTvlP/yu+BbfcwclGQj7eUdEh9396oSxMo6IqLBckwU7ggxhVfToI0lXvk
 p4x9Lucl6KfdXT/sR1iTVDJ7f/H78YDC3ckCNBPSK8zZHAxavPpvaF8BZ2RTf+Ll4u62ZrExu
 TqiScJL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 30 Aug 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_expect_success \
> > +    'apply delta with too many copied bytes' \
> > +    'printf "\5\1\221\0\2" > too_big_copy &&
> > +     echo base >base &&
> > +     test_must_fail test-tool delta -p base too_big_copy /dev/null'
> 
> Would "echo base >base" give us 5-byte long base even on Windows?

Please note that Unix shell scripting is a foreign thing on Windows. As
such, there is not really any "native" shell we can use [*1*], and
therefore we use MSYS2's Bash which outputs Unix line endings.

Ciao,
Dscho

Footnote *1*: I keep trying (and failing) to find the time to work on the
pure-Win32 port of BusyBox, which would give us "sort of a native Unix
shell". That probably *would* output CR/LF in this case. But as there are
still parts of the test suite that require Perl (which is not included in
BusyBox), I think we are still a loooong way from running the test suite
in a pure Win32 fashion. With all the time tax that incurs for us Windows
users.
