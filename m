Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74401FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 15:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbdBHPiU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 10:38:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:49603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754234AbdBHPiR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 10:38:17 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDm4o-1ceBm71Hna-00H68I; Wed, 08
 Feb 2017 16:06:21 +0100
Date:   Wed, 8 Feb 2017 16:06:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     David Aguilar <davvid@gmail.com>, Git ML <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] difftool: fix bug when printing usage
In-Reply-To: <xmqqd1etzrxj.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702081604420.3496@virtualbox>
References: <20170205201751.z4rfmy5xxaqg472l@gmail.com> <20170205212338.17667-1-davvid@gmail.com> <alpine.DEB.2.20.1702061716120.3496@virtualbox> <xmqqinon2nnt.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702071220290.3496@virtualbox>
 <xmqqh945zs3c.fsf@gitster.mtv.corp.google.com> <xmqqd1etzrxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y/bt0uAuFNPiIYe7cQtMZ5OPlIdQ4O+xvXF/qadLPFaKQQDR9CY
 OjJC2euuM4ULnY1g7fYARvRN7s3L6OU35LIw05Hx6m/ow1J6IHF/S6T+9VhAfmsYUvdHu7/
 uS7i99nDH+4PUVUhfgVJzhi/1GPAE2/5Mk4KhukqoZTyql+RrK+EldH4yDR53CvvP+QVjj0
 NqgREs7hyhNuxBzl4AQHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y4f3bd9qjjw=:f1qyt10D2GTaXqQq/vC4+5
 i9idlzjCEFJfv7x5vkHgJF9F5SEMvZVH+w+1D9ESMOQb7l/BiDq++yyPlCJdDvYUoj++bt3We
 9NMM6fj3yKE5wRWD4dSO/lGDpwyxi6gxrNCoouQ1etc5X7bT+w04dEVvDFoDv1MBHUKBiFX3N
 WhMrmZtLXXx2A086Jsp48/6n5/sIVivI+QgUb+Rb41affzRI+X0Z15k+b69d3aQ6F2SblP8HT
 kzG5jBax9wVaqD0IK0FucUJNbxo7ETkr+F7EyBleKU7StNb9rL2gVgJGN+g+JUNoBoMzKHf+S
 VNVNY+FpAWzZlLWJPATtomI7oo4CrCQWM2g0BERDIu19r+b2RlovURdgEZ4Uif51O7SPUQXlY
 flGhv1Uz8lpNkGF+r/qYLb8tcDVhYIF+T9FeE+qMRpIMzYaiSa2CpVCL9gXoEtf1eEhDzx/v/
 zGkgsMrkjM6CXm8Gj/EE6U8fnAbwyrSCDzVvEaVOfujQUX15Bx1gG71uQDCCN9LjIQCzCHxae
 Uu3lEFVj9s7VgSyuvBx6NyaJO43gv5gCUhcx1nLtCA834UFa+4nc75JeCdrM1p7ps3lSN1LM7
 Ke8CuZLDGZLQ0judyMLHNAvq4xLnCbegIagflU0zLBrO4Dn7QPQBoMZf7uePr2u7RQPMtrtwr
 mrwC7BMc88wr+XWilJHw+W9dw678iqcdT0fJ6BdhuH3ffrcgFllK4bETWSmLoamTPcCwBg5H5
 VdPKjE6H+PA7k30zGx5CPaNnMNdCyYhkN33UJWIDZjBtgjAwKbJNNfTaCdFdocXYPqna1N46C
 KGELnYH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Feb 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>> > Likewise, this would become
> >>> >
> >>> > 	GIT_CEILING_DIRECTORIES="$PWD/not" \
> >>> > 	test_expect_code 129 git -C not/repo difftool -h >output &&
> >>> > 	grep ^usage: output
> >>> 
> >>> I agree with the intent, but the execution here is "Not quite".
> >>> test_expect_code being a shell function, it does not take the
> >>> "one-shot environment assignment for this single invocation," like
> >>> external commands do.
> >>
> >> So now that we know what is wrong, can you please enlighten me about
> >> what is right?
> >
> > David's original is just fine, isn't it?
> 
> I've also seen people use "env VAR=VAL git command" as the command to be
> tested in t/ scripts.  You can run that under test_expect_code,
> methinks.

That is exactly what David ended up sending out as follow-up patches.

I did not mean to be critical, I just found it to be more helpful to
accompany "that does not work" comments with "but this does" in the past.

Ciao,
Johannes
