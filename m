Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94BB20288
	for <e@80x24.org>; Wed, 19 Jul 2017 13:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdGSNZS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 09:25:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:56975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdGSNZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 09:25:17 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMCSP-1dYcBf3gEf-0080Ek; Wed, 19
 Jul 2017 15:25:10 +0200
Date:   Wed, 19 Jul 2017 15:25:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
In-Reply-To: <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com> <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+KW3doQr5xw2GbNY3nnUxGSCFX8GbnPK8NSZS/rSRJhaqjBg/LG
 pjMdLM3rnpV0SvM6Im2IkUizkdGq2h+lYlfY9LzhHDOksZm32ghhS2z9fjjEXeLOPVilhKn
 AV3wPS3Z+fI6PCXvneMC9JaevV7hj+QDvDhSZG0Szu6NeliL7wnaeijWC6fxF1YiobEkIDn
 coVw14s532xgb/gxak+Og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q+wElywEADQ=:XRaCjDkSyqEGkTKWaoA6ZJ
 N4aUOVkXW/3Nt+3U+mNnrar59R3kfkg5WCTplHbuuoILT/L7Z9HnDQkA3Vve0/UwR/v+Z5PdH
 mFC49SpscIoVizux1R0xHI9WtRwszSMGgBcXHyNcjhYdfgL1/soYJbwwvv5EShE3EEYcsXA51
 rbSbNdPaC7kkCfccogz0xxhGAtR9iHiYmg+I7oGMcNPUIbO6dd2uK99mQAb1xqkoVll/pOSEE
 ++tbeGomr2W8YsGGeWTX5xxyzZg1UjjHGa+MhFTGNkDoRHG3xRbNVXLPJmbQqGkAkGiTGxRTE
 XFtedvT3351Pxk/GVcl7mKqr3qF6XkaBfiQ7YvGbCNpfSp29BbPeKU49HCSgB8YLSoLVzjuep
 vCEcQuAlGaexiN5k6HD8KvqcF3oNF3zbKXgrtnTjMZ/UDWf4656bIzRrXIkzl2w4RhdiTWqHg
 +BmEixqDb0o5GnzlkB6/rrc9Js4vAW7JAhx92BO9TdK1DMm1fK67UsYt5JhD7L6wG7uAf2YC1
 UJPwiMQpsmnDSc2ml/BSmCzGsVDe6JtO1drqweckW0PP94et9TUpJHR4FgOiNiGXMdMCkdlOR
 mGAhQ3HfZFG7XHxn+myLwKLz3Vk9qZt9rCBtYABJhyfW63mDR+kziTFVbxMUSP0juSpbngGR1
 w92qja5GS1vmvdJd+BZ1eSOTfCQJiBqzGo0DrRtI8mxYP3fHyyOwg/D4PmeA7XrgvTZBt+cYZ
 lc+YIys1kHm1uQ55d/32Tx9pmse+s7WcIQwVWf/ie2XDmPuVXW/UH+G5Rcz1PIj4epzU74dPd
 FD7sPR03Qh3CNlBQ0CSm8j+c1411QXIPdTYsnkYSwrFk7cu3Fc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jian (or is it Xin?),

On Wed, 19 Jul 2017, Jiang Xin wrote:

> 2017-07-19 1:35 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> > Jiang Xin <worldhello.net@gmail.com> writes:
> >
> >>> Two potential issues are:
> >>>
> >>>  - After this patch, there still are quite a many
> >>>
> >>>         printf("time is %"PRItime" ...\n", timestamp)
> >>>
> >>>    so the burden on the programmers having to remember when it is
> >>>    required to use format_raw_time() becomes unclear, and makes the
> >>>    change/churn larger when an existing message needs to be marked
> >>>    for translation.
> >>>
> >>>  - The static struct strbuf here is a cheap way to avoid leaks, but
> >>>    at the same time it is unfriendly to threaded code.  We could
> >>>    instead do:
> >>>
> >>>         void append_PRItime(struct strbuf *buf, timestamp_t time);
> >>>
> >>>    to fix that trivially, but the damage to the caller obviously is
> >>>    much larger going this way.
> >>>
> >>
> >> I wonder if we can replace the original %lu for timestamp with PRIuMAX
> >> instead.  PRIuMAX works fine with gettext utils.
> >
> > I think the question can better be answered if we know how gettext
> > tools special case PRIuMAX.  One thing that may be problematic is
> > that timestamp can later become a signed type and use of one level
> > of redirection in the current code via PRItime and via timestamp_t
> > is a good way to keep such a transition much easier.  Reverting it
> > to use PRIuMAX would make such a transition much harder.
> 
> Gettext handles macros such as PRIuMAX in commit 8b45c5df1 ("Add
> support for ISO C 99 <inttypes.h> format string directive macros.",
> 2002-07-23 12:33:13 +0000).

Wow. This is ugly.

If I understand correctly, then this will not even work correctly for
PRIuMAX on Windows: I highly doubt that the gettext library will interpret
%I64u in the format string correctly to be what %<PRIuMAX> in the po file
refers to.

But there may be hope. Since the character sequence "PRItime" is highly
unlikely to occur in Git's source code in any context other than the
format to print/parse timestamp_t, it should be possible to automate a the
string replacement

	git ls-files -z \*.[ch] |
	xargs -0r sed -i 's/PRItime/PRIuMAX/g'

(assuming, of course, that you use GNU sed, not BSD sed, for which the
`-i` needs to read `-i ''` instead) as part of the update?

For all the reasons Junio mentioned, I, too, would be reluctant to change
the source code to cull all of the PRItime mentions, as it is pleasing
from a semantic point of view that we know what the heck we are talking
about here.

BTW *thank you so much* for your Herculean effort to keep going with the
translation.

Ciao,
Dscho
