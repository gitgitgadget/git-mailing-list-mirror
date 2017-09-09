Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383461FAD6
	for <e@80x24.org>; Sat,  9 Sep 2017 06:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdIIGEk (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:04:40 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62189 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbdIIGEj (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2017 02:04:39 -0400
X-AuditID: 12074412-1fdff7000000748d-cc-59b38476c3cd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 37.37.29837.67483B95; Sat,  9 Sep 2017 02:04:38 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC859.dip0.t-ipconnect.de [87.188.200.89])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8964ZxU019290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 9 Sep 2017 02:04:37 -0400
Subject: Re: [PATCH v4 11/16] revision.c: --all adds HEAD from all worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
 <20170823123704.16518-12-pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ee8f9da9-3743-b8a0-d8dd-ec6a3d6f2cbf@alum.mit.edu>
Date:   Sat, 9 Sep 2017 08:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-12-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqFvWsjnSYMkuBYuuK91MFg29V5gt
        uqe8ZbTYvLmdxYHFY+esu+weCzaVely8pOzxeZNcAEsUl01Kak5mWWqRvl0CV8bqB22sBSfY
        Klpu/GBtYOxn7WLk5JAQMJG43HyPqYuRi0NIYAeTRMPnNawQzjkmiZXbjjCBVAkL+Ei87NnI
        DGKLCKRJLJ78Hsjm4GAW8JKY97EcJCwkkCIx5c5XsHI2AV2JRT3NYDavgL3EmnXzWUBsFgEV
        icn3n4LFRQUiJPreXmaHqBGUODnzCVgNp4CFxKw/W8BsZgF1iT/zLjFD2OISt57MZ4Kw5SWa
        t85mnsAoMAtJ+ywkLbOQtMxC0rKAkWUVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5q
        SukmRkiIC+1gXH9S7hCjAAejEg9vxfZNkUKsiWXFlbmHGCU5mJREeS/Ubo4U4kvKT6nMSCzO
        iC8qzUktPsQowcGsJMLL1wiU401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh
        4FCS4LVuBmoULEpNT61Iy8wpQUgzcXCCDOcBGt4NUsNbXJCYW5yZDpE/xajLcePh9T9MQix5
        +XmpUuK8nk1ARQIgRRmleXBzYKnpFaM40FvCvBEgo3iAaQ1u0iugJUxAS0qebwBZUpKIkJJq
        YGSt5i36ECMTnxjhldBax3d7iXTlpq5pQol64eaScq27ZjH+8/zo+EV2TZnz94YXXHUdVZ8e
        nlL+ozOxNtll7o5bN57/D5I0LPh9xnP/dUvNCRHXJq/nluVkLHm69tym9pLZR1q1pnoFvDmx
        t3oBkyWjomrPloeGzd8uX27Ncd0cpBtW2vetUImlOCPRUIu5qDgRAPODS6koAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 02:36 PM, Nguyễn Thái Ngọc Duy wrote:
> [...]
> diff --git a/revision.c b/revision.c
> index 8d04516266..0e98444857 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2133,6 +2133,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
>  	int argcount;
>  
>  	if (submodule) {
> +		/*
> +		 * We need some something like get_submodule_worktrees()
> +		 * before we can go through all worktrees of a submodule,
> +		 * .e.g with adding all HEADs from --all, which is not
> +		 * supported right now, so stick to single worktree.
> +		 */
> +		if (!revs->single_worktree)
> +			die("BUG: --single-worktree cannot be used together with submodule");
>  		refs = get_submodule_ref_store(submodule);
>  	} else
>  		refs = get_main_ref_store();

Tiny nit: s/.e.g/e.g./

> [...]

Michael
