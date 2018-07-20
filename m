Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403471F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeGTUGe (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:06:34 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40710 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388257AbeGTUGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:06:34 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so5032582ybm.7
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xFlJx2NgDAlAAQSh+KrO4AaSs3s1KC2KTzeIiq/NTJU=;
        b=iQDqtdCP7DTHqDiVM0RoZ5rs38ZN2w0rX/Jn4ATPAuIUad3cRojAsUaM1o+cPGWmmW
         oftBy3YY85C1bde3jhIobT1Ot0Foiw2Ud9wOrhpDTyVfmbBZyyOrv1HdL0d8FC5y9dOu
         NKxRswlCaI5/cKu+QJ4C0L2wU7KgLI2CDBag/2h45ZE/6mTs7+j94OFewJvLdavnNP66
         3wH+Cr47z/TVAeVy0+OKx3cqJM32DD+vWupcVJyfGRC1UL/l70Adu19gkeHjJsM+iCX6
         Bq6LI+U+sZXPTjf9VI3JBUZy89ldHl1zh3RKV5ZK/ZArcSQS916xBE6hkh8yi4pMVSWv
         ktpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xFlJx2NgDAlAAQSh+KrO4AaSs3s1KC2KTzeIiq/NTJU=;
        b=jmLQyBiU0Ahu+gcrLbjqNYEug2M5k4hvs54dG8N4mbodrg7iGQLgbDnTbXrVTgEmNf
         puOB1lVYXuOxnBJYt/LHWO6CLWEfpNyuyhQvUPZQwoTm9re1s1jA9tjMwOwWLLfxrSNz
         mn26kVWAywBADdkN3h7/gPUNgbZBAQ3zfTpRgxm2C9Rauphh0YncE2zdeHhlzG0wQy9o
         Eey6UdjpQe/DIgxdO/8RgrIK44A30ssOVvV531lrzzm4dgdarJBKZR+nXpkYGMY0udDX
         atIHj/YZReto4zYzNY7yibtJQ0tetfBI8ni7ClpobHPSRpmlMSeDlidBFVzVagnoqOcZ
         yKVA==
X-Gm-Message-State: AOUpUlGmihv9D1z1rr6i4Flic3MQ9MOVPpgvLdXTgVRvaZ0m/mXC+qpF
        aEe/DbIiOriDkw7cGBsZboY6bI6+tU1+MVyE5qetEd9alEbLLw==
X-Google-Smtp-Source: AAOMgpe3o7xEH/0z1w5GnqMbhnPEYyuyd4SIE8qYT8uH882Y5MtvrRMQbZmm1O+JAn7h8VRPRlwK8zE5RL5VKSFT/Mo=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr1829785ybm.307.1532114215642;
 Fri, 20 Jul 2018 12:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com>
 <CAPig+cTnRi=HuyZy+bMKeU9qutZb3K5C4qTb7gCQz7GyGN=FRw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807171306380.71@tvgsbejvaqbjf.bet> <CAGZ79kaft-8pHGwyqAK0yNL3p5sP0VyKNn29dxoZ0wFGWGEHPA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807202052350.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807202052350.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jul 2018 12:16:44 -0700
Message-ID: <CAGZ79kZzHN+HKYeezyeNwfe2+dTGHnOzs3okJTVrfm=AFwPbnQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] range-diff: adjust the output of the commit pairs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>     1. To roll again.
>
>         A player who rolls two sixes can reroll the dice for an additiona=
l
>         turn.

This is where I had my AHA moment!
(Consider my software development process as chaotic as a dice roll
So rerolling is really just rolling the dice again to "get my patch
accepted" ;-)

>     2. (programming) To convert (an unrolled instruction sequence) back i=
nto
>        a loop. quotations =E2=96=BC

We do not have unrolled loops?
This was good back in the day where the cost of each instruction weighted
heavy on the CPU, such that the JMPs that are needed (and the loop
variable check that might have had a bad branch prediction) for the loop we=
re
slowing down the execution.

Nowadays (when I was studying 5 years ago) the branch prediction and indivi=
dual
instruction execution are really good, but the bottleneck that I measured
(when I had a lot of time at my disposal and attending a class/project on m=
icro
architectures), was the CPU instruction cache size, i.e. loop unrolling mad=
e the
code *slower* than keeping tight loops loaded in memory.
https://stackoverflow.com/questions/24196076/is-gcc-loop-unrolling-flag-rea=
lly-effective

> Noun
>
> reroll (plural rerolls)
>
>     (dice games) A situation in the rules of certain dice games where a
>     player is given the option to reroll an undesirable roll of the dice.
>
>
> You will notice how this does not list *any* hint at referring to
> something that Junio calls "reroll".

We have undesirable patches that were 'rolled' onto the mailing list,
so they have to be rerolled?

> Footnote *1*: https://en.wiktionary.org/wiki/commit#Noun does not even
> bother to acknowledge our use of referring to a snapshot of a source code
> base as a "commit".

When Git was a content addressable file system, a commit was precisely
"a database transaction, [...] making it a permanent change."

Side note:
I was just giving a talk to my colleagues about diff aglorithms
(and eventually describing a bug in the histogram diff algorithm)
and we got really riled up with "Longest Common Subsequence",
as the mathematical definition is different than what the code
or I (after studying the code) had in mind.

Naming things is hard, and sometimes the collective wisdom got
it wrong, but changing it would be very costly in the short/medium
term.

Another note about "rolling things": At $DAYJOB I review changes
that are committed to the another revision control system w.r.t. its
compliance of open source licenses (hence I am exposed to a lot
of different projects), and some of those changes are titled
"Roll up to version $X" which I found strange, but knew
what was meant.

Stefan
