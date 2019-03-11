Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23B620248
	for <e@80x24.org>; Mon, 11 Mar 2019 19:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCKTdh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 15:33:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:51843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfCKTdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:33:37 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvhC4-1h00QR0psS-017VXf; Mon, 11
 Mar 2019 20:33:31 +0100
Date:   Mon, 11 Mar 2019 20:33:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] rebase: deprecate --preserve-merges
In-Reply-To: <CAPig+cSTtn6ON3rMeno+0ikOER6gq2bF=ktC-ehcaCo1pMd3MQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903112032540.41@tvgsbejvaqbjf.bet>
References: <pull.158.git.gitgitgadget@gmail.com> <6407430da7f75cb2385d243c9820ac8c2ea7fee3.1551952855.git.gitgitgadget@gmail.com> <CAPig+cSTtn6ON3rMeno+0ikOER6gq2bF=ktC-ehcaCo1pMd3MQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jq6+HTyxoSx0/ohUeNBedujHw6zmoSAAXebX/KirNSZ8fweyiH5
 9v1IWjpvtDO3tmZr6RgsFGzu06Jh/bl8ds75/Hw/MygvO/L6ixv7foJupgXgBXutXz6ocd3
 rktFYcCQcmb6VkR8Cphih4kSK4rKq9pYhwDG7XZ+/Y8jfcjpjKv4xM3//SJg8beqZ7VLU/W
 PDrWeKxCeMuSDpTNIEoDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:75Lo0rEcu7Y=:h5EmIPi8RGsuV822iqREQM
 FgSh+9eFkC6QTOum5Dn9q5ZZYghSc2BPWHmGD00JwwO/7evqmGyYR02VXaYOiC6/4wA0SRwrB
 d63XHmbtSDaEE88wy1/9niulodM+lEiKWTTfBeI7BAr6RSa9OFHzA3snUHbfnXc52XrrMRpzT
 YP9jreebGm9ms4AVvNCJyR2wL3hKYwkFmRNakvYKEl2rcrU6dExk+HtiFErvnMk4Skax4ZgY5
 jy0/8Q6BZMrqkXGeINZG8sng6LTLs5n1C4W14UWBuNHUiUcS8kN93Rr2EVqOsWXhUCdz2IyfM
 ZuTxYX4tPfmh0KwNkFtWdxoQDfcEuRJs1WHEJGh7dFSAWNtdD6OcXLStvJyeNz1j7Tv0aBOp+
 Z1PLmBpyXideJ6mN1MmDAWWUJtsZwxe1GOmITmIZAjBfVBsSdpBKyUeTRPI5WTDNCac20XTEx
 xpvCV3GSX9xLAh10d6YzaN82IqRrSRb6CYt20ncWdNQU3XqCX0Ltzjc8H7JIL0itg8yrxmwtk
 4kqavrKI0XGdZoJGrGULou1v/EEGAT+LcuNqBQuR0wiOfBYmzTzlkEA9CFIMBahXG1RbmcOmv
 oMTVZ5yATl6BI4CBlfqxmectLyuEWXa+tZoteFltvPMYhmlEA/XJQ3SEVSRevwCSmqIcxQtVB
 GAJjmGFnvT61DDxb7I8MlMU54wLTf43UfT8/hj69YbNxtJ/JP0Cuno/fx49pcB+2PxnKqktVL
 gSZkMLDn7EsN1MfVvB3WIMI5UucEBMNmNTwIevRZ/YtE2MJB9yUaxmZTTGgVsl7FzvFMrWvkX
 HFc0VqmFBoYRthYzizHKXCOXR6hkkherJWIFdW25nz0dJLJVwQLdEEtq8OkdSUIx8aAiuFd4F
 nEJJpsO/A6IM/9qh5NXqol5T3/i1V5htTqziAOYE1EFH0XNSp+oDs7yigOCvJrE8ML7sQuaEX
 hSQt82GCyWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 7 Mar 2019, Eric Sunshine wrote:

> On Thu, Mar 7, 2019 at 6:11 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > We have something much better now: --rebase-merges (which is a
> > complete re-design --preserve-merges, with a lot of issues fixed such as
> > the inability to reorder commits with --preserve-merges).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > @@ -427,9 +427,10 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
> >  --preserve-merges::
> > +       [DEPRECATED: use --rebase-merges instead] Recreate merge commits
> 
> s/--rebase-merges/`&`/

Good point!

Thanks,
Dscho

> 
> > +       instead of flattening the history by replaying commits a merge commit
> > +       introduces. Merge conflict resolutions or manual amendments to merge
> > +       commits are not preserved.
> 
