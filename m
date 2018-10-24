Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E351F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeJXXtX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:49:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:37805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXXtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:49:23 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtJ5T-1faK2H2s4h-012qHE; Wed, 24
 Oct 2018 17:20:38 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtJ5T-1faK2H2s4h-012qHE; Wed, 24
 Oct 2018 17:20:38 +0200
Date:   Wed, 24 Oct 2018 17:20:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stephen Smith <ischis2@cox.net>
Subject: Re: [PATCH v2 0/2] Work around case-insensitivity issues with cwd
 on Windows
In-Reply-To: <xmqqin1rmynw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810241720200.4546@tvgsbejvaqbjf.bet>
References: <pull.54.git.gitgitgadget@gmail.com>        <pull.54.v2.git.gitgitgadget@gmail.com> <xmqqin1rmynw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+s813kz+7UjPrRjqkfEaiHoDN81OHmE9qA6InQwB1mJcQ83VjcM
 XeyQy04tb0BJCdlq1N+5k+U2WL/JbC+HQ7AiH/DxbrimbEg2JTkrnnWWI+sArmr+fxj52Cl
 SSlv57WReCAlsZ0O1F0tiT3OOkmn13m5tL7USMM7R7uPGcsXSx3ZXcEtw0dT3qrtKSzl2Cu
 8Y0USdRgSxzX0QS8jpcyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5RjqHVIAbX0=:E7CbMc3lfbaFQhua5cr5Bp
 Ez8F18mN8hOsUDRiAT9NN9WQo+P/6HpuvnFjiD/6W0oYvYS/10HgOCT1+9+UD2EanSh2VPD8R
 W22xAJXMycFfKaJEeMnmMSYliaxHq9HDmf8kZq9/wQ8n/bN4j6bQx7eu/eMPro5WsQjx9d01m
 ajogIM7qciUnlxF22GY/hPUH5ySEdiFTM4ke2165Znv1ZH5Hj/eTM2jQfksD9wCLEKwwqFuMM
 z8DW/GdJpmF3PvXcq2gp/Oowsxtn+hWl+bVVP7QsbG+urnNHBb6fiwBYkwytFS7S8m6IVxWYH
 5bdA+MhRdzpav5LaqdIvLi3g5oPl11gI5J2jZuXr1tFmygxhPE3CZvzSzVUjv2qXWUgGtaD+R
 H1OD9h59kvDrK0TXnsl5HUtVtd7JZn5Gp1SWaDOicTM3xAqLNHuqF43bXozP9FGtOe6DP1xui
 xQDbolBtz0qJN90IeXzt+WoPOo81lin34CkUUuBbn/uJCzHWuWnWX1qLZTS7qKHfT2AEByqJT
 JxowfFve+9P+jVFko41g8mtC/EM/ZfYvos4byTV1GyE0KAbOPvfLwVSBO5+vkBW+1HxTv3mVL
 gz0mZ+PQXWENllAgbf8Ig6TChKL5Lrq66jDSsjEKFmFxFPwkmQKMqd2SriEJDGu80uzH8V7BM
 0aCr+fta4VTDwMgEN0limMhjIke9fbnmMkqZwEgc/HORyQ9n7owp1IGSzN4oMBqGTAbbGHbd/
 KcIZGwpqgOTGkRI8i0MciCyZCM8Ic/uZfmC/I8VVV21/IxS74odxFAEbK90fyOzWDDQisWr1D
 1IfIF7I+8rTSHjCqKKPE3LbesJZSmRS5WhosFQtrddSJ5AT6pM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Changes since v1:
> >
> >  * Fixed a grammar mistake in the second commit message.
> 
> Thanks.  I think this matches what I earlier queued on 'pu' with
> Stephen's typofix squashed in, so we are good already.

Perfect. Sorry that I forgot to check.

Ciao,
Dscho
