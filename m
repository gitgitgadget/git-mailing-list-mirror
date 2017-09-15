Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA1A20281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdIOTXv (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:23:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:56106 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751860AbdIOTXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:23:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBVwM-1djYpQ0f6E-00AVyd; Fri, 15
 Sep 2017 21:23:46 +0200
Date:   Fri, 15 Sep 2017 21:23:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
In-Reply-To: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709152122360.219280@virtualbox>
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wsX8rvYE6/qileSnEzsi25TVe6uiRO+xQRyojuqiopia6G8j3In
 at4A/oBLm2uR2Shz35U8Sjy6ALViCnCj23/WuJZ2iGCeP0/ITRM7RUhO3WrA+nCNXizFRAL
 i23WFEVW+idefT8/pXP534mBiodSQM3oRjbkUIcrMB0loXjTLgetk5wAS0YaN3yHFs8DxCq
 3C5npqQQi97J//CIORGFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sMs4+r9HnKE=:aQzyL5KIzKiSRp3zRX8LrW
 3wZOAAQpF3lzsFMdbsKpHaik11Rty5py70FSYtcr0JY/w51KAPANHredYAD3xaQJfzOn47VE+
 xsl7qJh6yPfDQxiX2DeowFOKo6NwpDC2ZAowd1oVT2xG1zmzignUo8Y+WbTA64DfHW/H4qRqn
 gHqVi478MsIEHPp2ZBO/LcCimbg++v2e/fkwWyflOPeR73KEAIlsNtCWSA3WxfZOk1dVaIJZx
 YoX81G2cz5Cpwc5tU8UbPWdkJoI7APC4AWZkyLXFJBi0ncqr+pq/RNUYcDJlouHadtRIPPrP5
 iytT1FnaJJeWMS0Qnx2XBFO585oVraPvX7LSBqzjXZKZh8UUN+6SQaVeS2EIbJCGgvnLJNvji
 XtlROdACxFuPoz9JvcqPzc7pK2bze/Juu+x5eT0T/1iICKEMzvFCDlT/nY70hH8ry91AQRRJk
 khN38gcQo4otyzWU56aVnpJQj34NRuSAFiSvdL7wpBvqozBx/MHMAfWFrZKB99IoUSFdJebpB
 TSUX9FJial7PVJYBKa2bRHm0MA592dydDlUL22LCT1k2X0+/Y8YnDyeW8lshQQpNMjdF65/0Q
 09Mk+MVRS/S4U5b7YqpPpeEiXDEq6rcJHb8BNPeunQX1Ws+Wr8GrXwUDk/yu051ekYcIIZLDa
 Jcz3I12OfRXHVpx2sWEOOFluXKiNPK/CmZ2SSEhE5L7ri6QXEYdqtEYKLJDr24lV+RwIbeBGW
 Awwbc3lO/bNdNLDxhMHb39/QWEZPPC7N5h/vKr9qQCgcOVkjMJAttI3du6hurLeKiPWQH2r+i
 QXFmMjvshhwUhwrLEecZQjigRVh94vHo2z+TUIBb9yvC6iIPy0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 15 Sep 2017, Junio C Hamano wrote:

> --------------------------------------------------
> [Cooking]
> 
> [...]
> 
> * mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
>  . diff-delta: fix encoding size that would not fit in "unsigned int"
> 
>  The machinery to create xdelta used in pack files received the
>  sizes of the data in size_t, but lost the higher bits of them by
>  storing them in "unsigned int" during the computation, which is
>  fixed.
> 
>  Dropped, as it was rerolled for review as part of a larger series.
>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> 
> [...]
> 
> * mk/use-size-t-in-zlib (2017-08-10) 1 commit
>  . zlib.c: use size_t for size
> 
>  The wrapper to call into zlib followed our long tradition to use
>  "unsigned long" for sizes of regions in memory, which have been
>  updated to use "size_t".
> 
>  Dropped, as it was rerolled for review as part of a larger series.
>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> 
> 
> * mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
>  . diff-delta: do not allow delta offset truncation
> 
>  The delta format used in the packfile cannot reference data at
>  offset larger than what can be expressed in 4-byte, but the
>  generator for the data failed to make sure the offset does not
>  overflow.  This has been corrected.
> 
>  Dropped, as it was rerolled for review as part of a larger series.
>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> 
> 
> --------------------------------------------------
> [Discarded]
> 
> [...]

These three topics are still in the wrong category. Please fix.

Ciao,
Dscho
