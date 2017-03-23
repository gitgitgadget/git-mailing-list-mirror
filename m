Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C63720964
	for <e@80x24.org>; Thu, 23 Mar 2017 14:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755514AbdCWOoW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 10:44:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:51688 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752909AbdCWOoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 10:44:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LskKv-1cAoHR15ir-012Hlf; Thu, 23
 Mar 2017 15:43:36 +0100
Date:   Thu, 23 Mar 2017 15:43:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls
 commit-msg
In-Reply-To: <xmqqefxpkwjf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703231541180.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de> <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com> <alpine.DEB.2.20.1703221704500.3767@virtualbox>
 <xmqqefxpkwjf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FhOqs+zlQD3fwLymPvjxCrPed10Fqik5ZXpPM2cK9aG4uVxmAox
 ZlmsqWLgNd2F2H3uPaQLA0whnfUO7ZfTC4/wojma5Xs0/+/U858cJNpwSN+zFfEjJilehWJ
 t2v9uF4hgNzNkbitipjZGS3Hn/oKPC2PPQY3XB91IhEce+3mNUne/3flCgUidUokMqqHt54
 cXz7/VsuT23z+KmPoZOIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FULqT3WWI0U=:I8ADH1h6uchKWM9UAhNcyp
 zbIxYKvBGI01Zx3nB3v8xG/Mjhfa/iDbzZtUmSOzIMEhl6/BIKHxZ4TaxTXFY8C1n0MOpxsAL
 bxQshZ1Or3lXqmAYbTKPY+NOgIk7t4ce7q/j9uKYttd4qkJK3aosKT1A0243R+UqUTyq7B3H7
 mOQCKFaZ2LX+bedgsK/p0yYt0ByJ60A0Xz7HvLrjUReUv9veIzViTjsdBZ1rDmSqm7gip0dWi
 utvEaFMBtbsWei9E/uL7PxEdhIc/LHlLdhDtP2bvayfAvCOK0vXfO7CBS+NLruaetR8ewMWMH
 yG0anaCu+TPpaivr2m3bhquJJOVfM7DQ4IV6MYnFPa/R2Z8hvjdsVo4SaMYArQLSPg8cbtR+4
 ygc/Aon3cThQatXCh5nV01f4fifLLb5YiOck4WHEgmrSVml3/gdb5m+QH9w214oUOHhHkY0m4
 N9xBi+gyg28fHxS3lNqWmMb8tyJUQ6KesyE/Br5jF0gUiW8ExxDJd8AGUb/rVoN/tQXmOHqAU
 PPdNy2MMcWAQvSR2Hq2gcGXnMz/HJR/7Hje2V/HB1xya/pTL9Yq4wYbz2YrTGCFnPsr9IGM3E
 6b+4rEOu0BLQIGI/lpopuER26NIfKveW78eGD9kM4PNKD5uqq/x27BBXKMiUj1YYtliuz0eoY
 aBmUongPFeE3t7Mwbkqta2nyfZ9vU/DdBWLenrgeB1ac+nLffA74+KNjMwLo6thJoYqapa9jQ
 lGL4lXCdBi1Lri5pqjJkmmH2KYzu1FPwHWhwhZeXIe07rNq9uPnHHbVdJnrPqsZZt92Vooui+
 mla/cMbYsNCOvpURzwoDZxpExX4vA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In any case, this is *test* code. So I'd prefer to have the changes to
> > the C code scrutinized a bit more, not the test code as long as it is
> > obvious what it does.
> 
> [...] People have strengths in different areas, and those who can spot
> issues in tests better than the C code should not be discouraged from
> suggesting improvements by getting scolded like this.

I know Sebastian well, and I would hope that he lends his substantial
competence to making sure that the changes that affect end users are
correct and that I do not introduce another regression.

Besides, he is German, so I tried to spell it out clearly what I wish him
to do in return for my addressing his problem.

That was the entire reasoning behind my "scolding". I am sorry that you
understood it to be meant negatively. It was not.

Ciao,
Johannes
