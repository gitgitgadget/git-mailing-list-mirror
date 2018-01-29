Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962E41F404
	for <e@80x24.org>; Mon, 29 Jan 2018 23:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeA2XG3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 18:06:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:51610 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbeA2XG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 18:06:28 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MF5C3-1eYqmH3ayx-00GIoF; Tue, 30 Jan 2018 00:06:18 +0100
Date:   Tue, 30 Jan 2018 00:06:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] sequencer: run 'prepare-commit-msg' hook
In-Reply-To: <20180124123422.10637-4-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1801300004350.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com> <20180124123422.10637-1-phillip.wood@talktalk.net> <20180124123422.10637-4-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1JDWmOevxx1hO37GmpltHIk5QXoTO6sJpPvDp2GzUAI3Ez2CboW
 sZ4zTZ8zHeihL2kwr5ye+BG49rHLxgNSDKlDRGOwhxBPZBH263GO6/RXHV03MkYDKpFlCFY
 6ltQkwtaMUPFf5anSM+WO29ttV4446XaVGWjFHHDTSAlpPLJWLYHG6RgOkjQzVNVNfJmRZm
 ftEtNEOuSzjAyTF7j9BwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pmc/dhHxF0k=:DTIPJnSp8HfrsttU37JEzH
 VSDd4+qF4aaiXmscSyjVZIJw4KiLR51b8f1ef4RwJWq9KYnAlCwT+fclmuIhXUd84EkqyM+ml
 xIwr7UGLvhhjlNrHIhE0s5n+kHq/G/+rwa282lTM8trHg42CJEZ1NYDjLm6baNW8sMWRSk3ho
 BRVPWk1mxJRenLHLXuAyA7DqHeT+TsE0iaS9sGf9SIN0Bkxwl2ozrqO4VpR1ZmJbhvPIHCc1s
 hXixYtQdBqQLXQpK1vuFs6Q9BMg6isZpKQJQFCEqKHhfzFFbYvF9nmTdSV56lDwB4JwkhRAP4
 F4piWAOkIpRR/pTJEEJp3SVw8x+/T32uxOndQSHoJc+MmtUpndfLLzHj4LvcMYKxYr1wrFght
 KpBr8tPqdx2+U6XpeiHqxnOn+QNBgohmxyVl12QePJsExJrPUj9Fiy1du3u9WzLPpeXbD9pjX
 JBT3guBcmUr5PDA2RX+B2ZZhVnaYrL0iTIU5sTMFTOTfGWLzlbQatMZBKHixVTMY+WcsqcIJj
 SXIKfkCaYUnrnBslbUMlS+UW+S4QVpyuYraTxjcWs4A4qFxDJy7F20IzwZtcqF0W99PRtiV5W
 SCrYyQ9J+t0BrvOAR2lYw3+DgMVzNzuZR7tcFXC7bCTriqoKSv25qpDUwmdpHrFD5qh4dS9m/
 7EFsYK7GTYF2CFQS3NuzVnyEL96EBAbEOkfXsk96Z1ACsnFq4W69PNrcYSfv0XkApN+WJvK8u
 O2wqC334sgI6oaeZ/ml2tSLBIsLIvJJCLXdhPGtLjd9NAdGumGcFN5Aa8m68E6CRMSRRs+H8T
 FNPwngBTAPgNEguVp9qAdwu/dNJ21MFIPoGfdgwqLJZ7VV9r8+kSDPuUprUAZtKiHbqaH58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 24 Jan 2018, Phillip Wood wrote:

> diff --git a/sequencer.h b/sequencer.h
> index 24401b07d57b7ca875dea939f465f3e6cf1162a5..e45b178dfc41d723bf186f20674c4515d7c7fa00 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -1,6 +1,7 @@
>  #ifndef SEQUENCER_H
>  #define SEQUENCER_H
>  
> +const char *git_path_commit_editmsg(void);
>  const char *git_path_seq_dir(void);
>  
>  #define APPEND_SIGNOFF_DEDUP (1u << 0)

I would rather have stuck this into `commit.h` and `commit.c`, but it does
not really matter all that much. The rest looks good (if a little verbose
on the test front, I think testing just the cherry-pick would have
exercised the code path enough).

All three patches are Reviewed-by: me.

Ciao,
Dscho
