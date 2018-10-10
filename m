Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BA21F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeJKECT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:02:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:38483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeJKECT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:02:19 -0400
Received: from [10.2.0.3] ([217.235.88.178]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxMgg-1fcquO2rgA-016xJ8; Wed, 10
 Oct 2018 22:38:26 +0200
Received: from [10.2.0.3] ([217.235.88.178]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxMgg-1fcquO2rgA-016xJ8; Wed, 10
 Oct 2018 22:38:26 +0200
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <9af709dc-6565-da5a-7c4e-0abe730bf18c@gmx.de>
Date:   Wed, 10 Oct 2018 22:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-Provags-ID: V03:K1:2jBg0xiGcyiDlHNADbrafGeR6mnzPslFqT5iH++nW2pjr1O+j3U
 7LQYnlJIEQ1vZrO4/UpI7L7ZrJ78AA7Z9Jm5mNoK4OIsAsakjIZdBSFe9fAf1W11nsaD+VM
 iyK6GPRAIREtEJoigJWuh2r+cI896scOzTMaLRsLku4ufk2cUVRj17DbN/xTHwdgA9KC8yM
 k6IlB9vFIEnwLALwY7ERg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hDbF55GJzxk=:qHi81tj8JSKEgLBTbKIuII
 6kuALyVY+E8TI+LToS3AKTNdszNCZQmJdgg+1RPQGPxHPPqiIMv7tfa2RwWMcSjn5wWYr2KXD
 sD8in7oEUGzncxbnEc426JmsXhewgQpNhxZxyPD/FY8Lfyw7CicIuIlYjIEnf/Hv5L2aC1dpX
 x7qHcz05yvzkS1jzAvVAJG4Nx1/Weoftc+oVYVaQmrBtOLsLP+etneGydP1mAAtHjDLhxwlKH
 8gqHQ1QaUJ24Mp5NkpoZgmUktSBh3VzlT1CyTQQVFlRSRlzE5gJj+0l6yndReSsqOFjBZNihj
 FBxHq2IrOsb41ByAyL32Cjo4Lv4HBhJdoU53eq94ctv/tT+z1Ly16V2TQgZs156k8R/s1jQma
 03OxOuqmD99FCSL1LIWrnRRVxncV7OMiFT5Jxv+Eh6dHR6mXAjCb2kYfC9dszI1yDb9YZ0enp
 CN3xpJX4zxqluAyODY/7YkLcP204qKxGxEsPqs+N2c7VjlJNzG1WFxQj5bTXhJpMkbC09CUCM
 3LeD8+NGPT9wnZ9IlapdCbt2wxqRqq2EGhkwwsVdDRLIXFamXO1eUIEdD2lamSwMN1jFYRya9
 W5M0Kny/mGup8UcgPtrPWsB67Gli6dfHRtZP6RTJl4/q0wcsseVGmoWIxQEEpRwuzeIdAqVYe
 pZYxGZYnjPLuLZ/hIR0V/F+y8P//vjqN65hfvguD0eVNDiChkyWA9q0EaQ898BqxuGvUhx4lh
 zoUNHWSqtsvyj/WfY1trtGhDWXKrWfDXnCCIdzp7J4x8wwI/pnaWEHRlhE4/cfywbNa4TfHVq
 BwsdTorVraRF1aBhneLdRxOQurqzORVwR4TqKrgKWo7FrtyHN0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.10.18 07:43, Junio C Hamano wrote:
> * ts/alias-of-alias (2018-09-17) 3 commits
>    (merged to 'next' on 2018-10-09 at ac19b4730b)
>   + t0014: introduce an alias testing suite
>   + alias: show the call history when an alias is looping
>   + alias: add support for aliases of an alias
>
>   An alias that expands to another alias has so far been forbidden,
>   but now it is allowed to create such an alias.
>
>   Will merge to 'master'.
Oh well, I still have the changed comment stored locally.
I guess that has to wait for another time.

Anyways, thanks for pulling this in.

PS: I hope that this E-Mail is formatted correctly. Thunderbird
received an update and now it doesn't show me plain text when
composing an E-Mail.
