Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC3D1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 14:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbfAPOE0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 09:04:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:37859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbfAPOE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 09:04:26 -0500
Received: from [10.49.55.26] ([95.208.58.177]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw1vh-1hJwPg3SF3-017mc2; Wed, 16
 Jan 2019 15:04:22 +0100
Date:   Wed, 16 Jan 2019 15:04:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
In-Reply-To: <xmqqo9biigod.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901161503121.41@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com>        <pull.31.v2.git.gitgitgadget@gmail.com> <xmqqo9biigod.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r3pxvVcGRXGcuCmI22i3TA7lpnPsJkpEc2xmUFj9X9ZCSY2I1it
 z8wMFKb8WyHerrXPYT9SVbwqb1CYTBnl57emm34LFmVoB8pntrG59qgUZPrLmM12IWFEvLA
 L5LchxUe1+eAAkT8kWQcKBbceFO0KeRXIcWNFEZgKwxyxFu/VrKtbM3oILIbp9Deojh5QNj
 FDTDffMxmXhenI5NQt+5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q2qscQZaB0o=:HkLqtNsML3NsD7NIA7TLE7
 9J7YKAPqT6dBvt/+/V7CS2uqufIMum/tPJsZYp5IOz3OIk3naLk7mkVBZ+mkPQp1Pf/n0ka2t
 sM6df6wH5hUI+vfaaqqP0Z0VTdAWRkKKuZx3sGx4akZIZ946LwIX7OFqXUcIzhfsH+1mEVsve
 fG+Xqkxq1FbCRRq4si5wAcw9poyXgBJk5KWvNv5vldIcQzO78jiU35vbQD2+ECIHuPzq73sVh
 F5o9vhGJxeKdEqjp8cyUAYrWFpmyuoBE2JShHjLkEH4160+5gm57f5C7PfIWTMbxgLTmzeMPB
 k9Mc3iefVYoNTvoUDGZesN8SaJ/6wfaWpfxDgY3qtxAEtct7btEPBBQ74Ru9BYMaDbAdU4QWT
 2B6JudjLRXaOG9dYLwzpu6dKrVbT5Se6EWw2fwSXnk3RrixjHsWuqykGceIOgn0gN0oMkxkuf
 nHca2Zaq+xQUsdKFV0cjrjzbso6vc30Vr7gJ9BD4w97FtJ4BBGCmOIeGtnK636nNj8J5nBN3G
 KhF5yzRQBzCvkh1nXrT4CTsqQ7b64dJN1DYVdIBtVZStuv4oy1bpOZQdVoGV5/AH+ni4ofVdp
 NTOIrON6OsIy6Pr3hIrGkx6f/8CBKcjYS8zcO6KLi/4xPeVKXuUNdMhNjdjK/qUjvSbt0txtg
 hPUxox9ImPFPUn7lNB14+wl/TL0ADgiL8KXX1UO9SDNKKmeEiTrUhSPuylj5toHjWIKlE3pcj
 ssoGmLSDnvjRAXYTIZmcIuCfVttbmF7coCQM3sppC2+du4sTv2wGRH7sxgLedcVWP7jnsr89y
 sf+pgHOSlhd3NvI0xuKZCceuUYnkVyklfFo9STehBBInC61Ds4bDgnXU77duXWxMJqiFfGR2m
 EqwR5Iiqd8kV+WKoooJgqewAO3YvLdCnwm9jk0cKRQGHAKW3JIOKPa+2xiivMhx6yxApkJVW8
 5N6teU7PPMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > For a long time already, we have Git's source code continuously tested via
> > Travis CI, see e.g. https://travis-ci.org/git/git/builds/421738884. It has
> > served us well, and more and more developers actually pay attention and
> > benefit from the testing this gives us.
> 
> What's the current status of this topic?
> [...]
> 
> The topic was marked as "On hold, monitoring discussion" and it seems
> that discussion has quieted down, so the next step is to see an updated
> series?

See the updated series:
https://public-inbox.org/git/pull.31.v3.git.gitgitgadget@gmail.com/

Thanks,
Dscho
