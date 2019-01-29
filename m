Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCD41F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfA2OQT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:16:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:42159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2OQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:16:19 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMBiP-1gngyA1DGH-0080sZ; Tue, 29
 Jan 2019 15:16:15 +0100
Date:   Tue, 29 Jan 2019 15:15:59 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: en/rebase-merge-on-sequencer, was Re: What's cooking in git.git (Jan
 2019, #04; Mon, 28)
In-Reply-To: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291513500.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c1MmM53tpTZupoHTOqOp1yjo7nzVgTLI6VFRvYAnWQH71sjg1rW
 /SY8+ARWfWef3xd8sTlyUKsYJ5LhkLBr30GdOT3+P7gioyvXqiqG87Ia8hwHM2fXDRKx5v8
 ohKng2mRlheFk/rUGZePbnzH0rrBA0sKO0/+xpI/n8zTdvOPFOUM0LaJbxm4vNlMYu3FObS
 ILNIV3lcMPZBVXVW0pE7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:25btrSKHxl4=:YAhdnxsCoOCY4viAsRZ/2o
 xF8fjdWHIrBBcUrxWtY345FwRfsEy9KkZCxD4orc9DYbtg7Y6BVn7LOQehXIggpXragd/LBLH
 snmm1tUCvb9tSiRd9pCQCzxemVd+nBsbyYF5FrrtA7EiSQ/6bbPy2xtBAPZZ+tnZTWJH5mOo1
 XmiNW4R3fHPWOVWy9ZW3U0sSXjkt1yjVrTByiOaXG5KwCKp36L28pAlHWntcc16Q9ItDwOQp8
 ovMnBa/qtAQr5PAeb2C9G+ZzoQNNVFUbJVXQOFCE03Po0H7S7ZcJYhQiXNLt67hK+akHnzt+8
 mkc448KCuQDzFt7aE4WdlMBajoLGHVJPf+Gp3/aodlqTma8TOQB8hqDR0Jb4Vh9M0qAJReqZ8
 WS5CTqgZJiiG5EWRKCtF1n94SH/mj05QxHXsCAMP6vAaSm/Dh0sDTkdEQmP2p18kCoNwMkoZv
 d8ZK6oQNn+l9qucnOUhGSUOfRm2qvu8VBukFqpG6UQqM5/wKZBBoDxIKbvXqXiMYqY/6LbvQ+
 2E0aXUisKvNY60nCQX0zIEcuwxIhpW/jHE/sxhCrg2bcgvZnF1XJMj211df/H91vO1giZv4J3
 W5t4vetuAGnunbBm66i50CHeucfAQ8n0/v7TzHTD60tp7fuytkN9oTXokz4JUiu6D98Z47luY
 GRuubBq4DykLPs3wg13XrVH7VcDwaoZue9FBXVE5Da9dB9t88uFtSDf78juNbtl5ZfR5vadBt
 HjiyfXKzUWhMuuvBZnmQyRwN6YYJCb05/VkqjjAF6BvuFuR2QWJ1fdbhs3EnO31WHBzKqeOsZ
 ZnXkzYOtdkZ5sox5KsvFrT1PZvTEuXKQnHCNZzl5H3bzQzoYQn2fi7gG9c2TTk42bdbHIkg67
 PQ57A1SvtmvNOEV3NFmdOf3Xx1sOnXuzitKJP3CnzqbdEwNkDf7/RDmeIse2tUjMpmXxOCdd+
 3rmd4dh/E3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> * en/rebase-merge-on-sequencer (2019-01-07) 8 commits
>  - rebase: implement --merge via the interactive machinery
>  - rebase: define linearization ordering and enforce it
>  - git-legacy-rebase: simplify unnecessary triply-nested if
>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
>  - am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
>  - t5407: add a test demonstrating how interactive handles --skip differently
>  - rebase: fix incompatible options error message
>  - rebase: make builtin and legacy script error messages the same
> 
>  "git rebase --merge" as been reimplemented by reusing the internal
>  machinery used for "git rebase -i".
> 
>  On hold.
>  cf. <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>

Wasn't this resolved by you mentioning that you trust rerere, in
<xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>?

In any case, please note that v5 was submitted:
https://public-inbox.org/git/20190129013945.17336-1-newren@gmail.com/#r

Ciao,
Dscho
