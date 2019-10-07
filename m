Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC321F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 21:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfJGVvf (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 17:51:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:38513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbfJGVve (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 17:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570485090;
        bh=extxRXbbuzjOzsZB7h2ir6aj3mkQagU2uDAGTlCFCgg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UD7riCJ0c1gxvu0c7hsrJwq5CI2jA3W3aPoAYSJGPVeTcHJeYhc7L4SYr7zyiEVhd
         7nLVck9lqugzTT1YLBdSuBrDm+GVQy7k23TO5RSp/noV/OpidH2IoANPv2ofIbPq9n
         5+dJ1zyfUYeSG0i9S08lKVkxxlspZZdejQeP65I8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1iKZzA3cqb-00GpC0; Mon, 07
 Oct 2019 23:51:29 +0200
Date:   Mon, 7 Oct 2019 23:51:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in
 our Azure Pipeline
In-Reply-To: <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910072350300.46@tvgsbejvaqbjf.bet>
References: <pull.288.v2.git.gitgitgadget@gmail.com>        <pull.288.v3.git.gitgitgadget@gmail.com>        <xmqqimp26808.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>        <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
 <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:unmIsTWGWe+IfTUQKK8rii+MTyqT5SpvXS4wmLJIVqEhcvI5D8C
 mRkvgUEiglRRcNS9RKrBaayMv8Qjj6txyBYTBci4ajyXrafHDot0W71GsUVeXyAVQ35w5Iw
 vguohuuP1rhi59pt9ujJRmUIN8HxtyDplF/xQfkVtk0jKrJssKm/9jF8gM1MHArM7ut871I
 AQ77jCLJlTWSxI93zq/GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G2fvGVT45mQ=:tZ9wq5Z/jmCxNg81PmAsGD
 PmNQUCFnLRFaay4g/9xF5jaTlXseExtKFJAQiNA/UU93loirVNNhhufhlbiculB6vqEF8njw5
 uI5SSE5nRuH5vdQN5UBAcEqmMyIRs8m9hnr7V5XYjExZHlHLa3I1UztC7AOcPY2QcQwKpDQJo
 6znZR729Bu0mvkqDFCz1mbIswJmTuZ/8ZdlJ6D9hObhwmYyfkDUogjGxJ1F6xkFXnTMFyQht3
 2yEQ6qimwppgNpQtrhTaaxETavO9wlenfsAYWLizAIyvmBCXLCDy5WBZKWbKTuvNWToDhBlXz
 5VcjNN4cTpfjCmyPNHRkqymtmOOmb7DfQMmxCwTczW9Qkr1Uf+B88KoXOqmCcjk/beC+yozXd
 /22BpD48Xxp4koNbyCacuSowtOJXT+N4+OHaWcfdpm2JrTPDooyTnAqbp5mA2SPCw6221/lA9
 2VPlY5LNeezFi4LTrRlhsbLJ2mjm+/7ElRcy+H6orgKs/dbNzvsUTuvlOPRbwdTa9hFilBYYo
 0sQa9z6VeOJzbu2/eMloAfT47QHH0vGwoKB18eXB2CyyLaHzLsrWMcuveIn1sj/Dsfq0YwBgh
 lGeBMsjmTJzZP8IOEGa+ydj1nDcG0G+93O1cDuGkpcsrGTQsCq1X1ZoPUfkylO56CHAHknie4
 +snq3qS4l4I7NILMlBUcJf7+mGDn3nfLL/N4PwZ3vP0+87G3hZpjKPJQgni1VGe15CheXHB3L
 Vn+6rnow7sWDsGF8B3hcOJsTK7QyYa15Go8RKrLrD63yHzzx9eRKQPDgjil1xN8QyU0rP237J
 myAdjAxhtMBGHUtahikiUpWm643IF5DvPykW5rhQSLSZ+MjyOOx/FEluJUloabtp09kQ4PvfD
 Z8ZKp6ldKeU6OTa8OuR5Hc9TNX4YbRD7VOAr+t4BZcCgBgxyhVkUCRo6flxyNv6O/DJJwmz0t
 ks542XRBuuWn58bl5Tao6lmDxNEBcnBIZL7jiweMRzrYwEDnrrdu36wvr32803U7LTYkTsgkh
 HVfb2l8jmYYc50icQT8IeNgHyaB9anVYl9J15b9E937cN3VG7+sAj6dm1/yS+iszDuxNpO+TD
 Op2/UwUyzmul9/ACYJXtxJ5q6z34CCcs7CnBwR9FK21jmJ5bPAsISUAp6QJPGoo0WYMwa2ZB1
 eavaJTU75GfX547e653BHq2FlJqfXPOfuRq9AXBIqHqvuwVvZATPSU7TfcPg8fkFB/iRueIGz
 Ws1OQtYLvzFltDCDUZLhv2CPK+kiD0Zkm1Hy7f2dUcQTjRPHgddLi9oKLKGU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> I just implemented this here:
> >> https://github.com/gitgitgadget/gitgitgadget/pull/128 (it still needs=
 to
> >> be reviewed and merged before it takes effect).
> >
> > FWIW this is now merged.
>
> Nice.
>
> I didn't quite understand this part, though.
>
>     The default creation factor is 60 (roughly speaking, it wants 60% of
>     the lines to match between two patches, otherwise it considers the
>     patches to be unrelated).
>
> Would the updated creation factor used which is 95 (roughly
> speaking) want 95% of the lines to match between two patches?
>
> That would make the matching logic even pickier and reject more
> paring, so I must be reading the statement wrong X-<.

No, I must have written the opposite of what I tried to say, is all.
Sorry about the confusion.

Ciao,
Dscho
