Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA882202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933427AbdKAWSH (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:18:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:53550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933402AbdKAWSG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:18:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZG7-1djJgP02YV-00RIeG; Wed, 01
 Nov 2017 23:18:02 +0100
Date:   Wed, 1 Nov 2017 23:18:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2017, #01; Wed, 1)
In-Reply-To: <xmqqvaiutuyw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711012317390.6482@virtualbox>
References: <xmqqvaiutuyw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:02q4K5ZhNpU8jY+WhXzX/pIdbC4PdMF2gMyu9/cU2JRRmSK0Op0
 43oPmIiwvxAy0yqQgJUPav0Zh4nPYUrgWJrYiBG+rdGddxgG0mJA8frAEfTzbR9cznCdozc
 DLi1SKO8W4FhPOcCsLwrbd+dOVs609T9QaxcedBkwPU7WUhjwBTzUArRKBVOccu+D0KzU7d
 7Im/dsbGTYzzE+CG0HExA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xWJj6vys5Fw=:jjdMHGruDHqaQD1QefL2U7
 Ps+QjcQjhYK0yhqBIP3pZAXxr2acTOvipfAe0KjZchVgVaTSw5Mve+8MV7GwY48G+cVsok8wV
 1e2uoNeQHNXjJ3PuMqHQiuIMoh/A4Z7zN8/XyJ5rr1+HH/Vmin0QipYCDzDjSP+6+Sc6PsjvP
 Uc0vZ3zvMSGUHQYPqOtObpRaq3/ivKx3c/74QsmINgpLOEq0LTLTouwnq6TQc1fKi7k6qmne4
 +7rfKzYsTZnWz7g6nfoJ2RWwayxrVCV3e4XiGkkt6xwb0CAImItRR1Y+uEWyzIDeOzoUJoEO8
 dMyDUeCKPgr0BZXOetXGUXrDgYxR7DOriYjFGciD9GWtvhACOnxE+GdWpBgM1+AmY2Qvd2cxj
 YivpTJr3QunaL0Ick0oPaE5HAH8BMf9B2ZJQLeIsVyIqLy/9el89OL/D0bakeIw9rnWpCf0sz
 O4McT+9nuPSRwkEjRaf3d2buPgHnF1xbw5ASd8HpmrAF8z4ZJfLX3tlMGLf8jn+SV45MaL//5
 /VL9pxMRz0Mmzh6LdOUzaQeZkpovQUyizMwNPqqvXzMNN0Qau7E5zGmHwPNJxkHeKoENOsbFq
 D80fKThLtYa5+nPinF3Cd4nQhJTJVGAIfxHxDVINTd38iJQb0TLBWOuHi89R/6aCR82RAU1Ry
 xj+8sa2sfn2x7gNY/y8VBYTbPA2cNAO0xKjl2sFoTDoE51lIffg1blB+KUJd0N0FoRRyHAVPy
 dB0m0f+RulCyxKAytUp8G+4RHvDWzPRC27mkzOYog2Sc5Ymbhp8EPiGtYzjRFSf3tLSGA2lhq
 LMi4Rn0K4EZCYmmHCVT/rifIRvnJG7o9vvBciPgJ4HmrqgtX/w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Nov 2017, Junio C Hamano wrote:

> * jk/rebase-i-exec-gitdir-fix (2017-11-01) 1 commit
>  - sequencer: pass absolute GIT_DIR to exec commands
> 
>  A recent regression in "git rebase -i" that broke execution of git
>  commands from subdirectories via "exec" insn has been fixed.
> 
>  Ack from Dscho would be nice.

You got it.
Dscho
