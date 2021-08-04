Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A033C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474D361040
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhHDVra (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:47:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:59113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234108AbhHDVra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628113624;
        bh=ce13z1NyJTyLvGORWb6aonPvna/WCZ9uNvL/z0KDCcA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bC4ezduQ5diBx9cmvjszcTrKxYrtqh4ad27e155YZYkryTBfniSBA+T6fcsUpE2nd
         lZL/2W+0IOrtkrcyBh0wFUpe0ZJGokZ8Vamp+S2qut3WojyqgcM6x4jDlPeozQK3JG
         F+GUi9MzFUmt7a0d/9JbyrqtJ0YQaLRM6cgIz+YI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1mwba92MA9-00q844; Wed, 04
 Aug 2021 23:47:04 +0200
Date:   Wed, 4 Aug 2021 23:47:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/10] Documentation updates: merge-strategies
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108042346230.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CBvkE9i5sJIJkJBIVsD25ZE0xw9P6h/cs/O2LzeV8gVUflGwT/v
 Z24ObOL2G9IZHwgbO3mzPUKsZ0E/k+voqo1+HzMVZkKbgECo4usPgvVIn7DjHghwNslY58s
 844ZyQZJ7RzIsnuIlrJ8Dn+6Bq7orC5GLlbk5AsxrVhiU/XGUVespsRj1arn7wbdNDXeeRi
 hQRGco8Hut7WRJ3bejh3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mQiE7gSv+3M=:rjmN84abjXtkfY2CaEGE+y
 ugW+Hvfu0TxCiKSFdwNlwVgA25zTbzGlKxYqDDZS6qeQ6hrIzIjf/RVSVxnztSsuQE/lm+j1K
 n0Rj9oFMfS2ntSYVNHgVo/E62aS2XL0ck4ux5qntaAP8++1WDCxIQ0FImhYg/Za4nXRqJVK+s
 u9V3MX2QSZHYBDaKnGeqSFROlih8WhEAiMvwwQVzIxE77eiJRVV2EL/zzKVzGBTGcgg9miuf7
 FAiYA3uwdriROki6BBEtPuVKTx8+mp/dyEbLeRocMnChngXZm4UIyyZGixzmrLDOhhuftiE6u
 ZEPhaRo8jLJ+mKz4cR2LLlAowR8/pNzotkF6fhD2nzK3BoNQFtnUwUz2dpsm0UItvxyUQKQtB
 t5XpM+0ciiayfeeMfVm1FgWcwTtbBmB/VJCmaFzX5/HEV9W9C/OFgGAXz06avuMaqBNt7pLfD
 3TIVWEVERRZIPd0BdUAqRYrPb8txpZ5nCV6lJUfGzBrssvIWkQgwZvzRy1drB3NbQpVAqVS7u
 rHrL1hZCAW8V6qiO4aJp2ApYoF234bvoR3miIIx576TdDut1FqOHrBVMlsl+zNDOUMI16TXP+
 e+1FVyqlHaLEZGF3H+eIc+V2fHrNs9jQhuCRzGuIvlAAmyKePHkZsssTmMGO0oVAHByHqwkPa
 gEeMI9oi+2k8hz4RmDrGbC7Wexi78yuFiAO4iwgNbb6rjMlIk0T0BZkBwHV69734nX/CT5F7Q
 YXIH6u90Qo+aobSuaSa/2evwenhqvr+Lsv3oUf4BybEPyKHQfIjil9I6LgVFpbmpVExUl4NZe
 43tF8UlS6cp4NLojuRJ/Bwai4e/8pJ5qrBySwKVHrOK6+G5yyB2kHHEd6tnNy0PDeh/D/9gNm
 IMsVW2SXBZrRkyTxJBZBBYSbBuCl2ng4DwuYWMu9AjVHlLNCHGQuPozu37Fbxp6NkVXlVSAr8
 g4W8nKjJ5WHbJeJl9YYz4ea0QOkRdayvK/LmTapAChCV2DPW4LVor9x7p16nSicIuZJtq3q+4
 CjlKXiHvxQ4eYW78NvpvrTGvCslQKEmVq8NlK4+Gl7CcYhbqb+4bVUWEa6fypak64GoRiO6eG
 JLKaLzpN96ycw8S5QbSyHjIFoxQtBRjUNUG+8ifDIxvBT38wyUY/X/ePg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 4 Aug 2021, Elijah Newren via GitGitGadget wrote:

> Range-diff vs v1:
> [...]

This looks good to me.

Thank you for making this a very pleasant review,
Dscho
