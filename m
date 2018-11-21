Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71A11F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 22:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbeKVIvu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 03:51:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:60445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387621AbeKVIvu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 03:51:50 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtlG5-1fOSBS1MN3-01189Z; Wed, 21
 Nov 2018 23:15:31 +0100
Date:   Wed, 21 Nov 2018 23:15:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] rebase: warn about the correct tree's OID
In-Reply-To: <xmqqefbf82aj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811212315000.41@tvgsbejvaqbjf.bet>
References: <pull.85.git.gitgitgadget@gmail.com> <xmqqefbf82aj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rn//ATGPxvM6L1OfvCapjRUAGrZ52+MVdUeHn4+SF2pJFnUMfuQ
 N/OYeKgzoJE91esge89DQmjo+iZLBU2uDfCbwQpyM15ZEp6OJ1w6XN2a6bd84F3uHC6GVI2
 PLyQ05nc5LHSYdmnhMrurxqeGmaN3ENg/kckXZVVteQEgvU4soG5ENmdfKjwyW1Hxgkqb5o
 d0ejqWG/Whe3d74/arwIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2V476ZEUZsI=:IOcfBEs4lq/j302B8ZbxEb
 GexvhRTOe5NKB1qs2Od8xjUxq170gEm3i7lkCn4zUTU3cyq//M6f3iDOUFZELy+WE7w+1s7ij
 +Fu4d9512nYrPs0qGG44/dfd5rCy1HOZYTGaC5ITZzGnUgLhf29aCbW8WlPVdqKyfOHrWc8c3
 9E3Sm6wSfLhXP5Gwgy9AQ5ErlJltJbkG7V2GudtJ8fuciW9DeUPLzzCujRp6YrivD4M6Fd4+a
 NarU2vTU+em8xMNITjEbi5hPG3MalN3aOVONUIqSWsB2pi0LIEPbZ5wtni6jmynOKnhnO5XOl
 WtXGUd/3x4LEqFzLyWsQJJIexgSl/JQKqM2IOI1ThK+WNtF466gPC+gJsQB+F2Oh54WUEo1Nr
 YGa4Rfnw5hRm6xJWq6YFJC8VsrOjYG2W1+ixCZ62S3Z6AHDTEVMsWDjiUNsTIPYFKhRXvKijn
 hWnquWLPgVEvPn01CWseAKmskLjKroJOwXqlm/VCIjMm0SijMU9qxGDL3XFQn2yIfI0RLfZsl
 LD/YhLAftzDNKDTm+KoJN5GYp6QeIMMUOYpNquPOKD+YkrChb0KTdfX+OzrlHS4tpgkMi9GDQ
 qKmwXZVGM3eAFuzKfHWq4t/JIb580ihAM8gl/5Pguwow1b9itirdx38zpeWER53rV34FtegVv
 qo5lfzKnWWd/7DN1Lz7H1s5SWmRjOx0IByGhM9o51JZj472WCGqtrBJBhEsMNqoOh3Wbs5w6y
 RHS1FxABMgi+ek4fVsNJpqIfUMemu7a7A01A+vFnv1MIIGnV9/yaungU/cCxbRHQeVaiK+ntn
 oIJckgtpM84+3OjIhtamh1EjnXOAJJVMbxK68XR6SUH2vX2T3llCaP1gjzWQT4O8zeChbo03J
 y0Zvuenr0jP2uQknbO14CdL69xDBfbsqc/bv4bwqpPYmXBCRvvgfLb1OMXjE5Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Nov 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > A quick fix for a recent topic. Not overly critical, but I would deem this
> > v2.20.0-rc1 material.
> >
> > Johannes Schindelin (1):
> >   rebase: warn about the correct tree's OID
> >
> 
> Yup, it is kind of embarrasing that nobody caught it, but at the
> same time, this typo is at so tiny level that I would not be
> surprised if it survived for many years.

TBH I am quite mortified that it slipped through *my* multiple
pre-contribution reviews.

> Will apply.

Thanks.

Ciao,
Dscho
