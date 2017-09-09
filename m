Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963BB20286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdIIGgf (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:36:35 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49250 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbdIIGge (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2017 02:36:34 -0400
X-AuditID: 12074414-0d3ff70000006ddf-ca-59b38bf14a26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C5.1B.28127.1FB83B95; Sat,  9 Sep 2017 02:36:33 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC859.dip0.t-ipconnect.de [87.188.200.89])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v896aU1E020612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 9 Sep 2017 02:36:32 -0400
Subject: Re: [PATCH v4 15/16] refs.c: remove fallback-to-main-store code
 get_submodule_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
 <20170823123704.16518-16-pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8e447d30-9306-9ac6-6e87-be8192a1c7f6@alum.mit.edu>
Date:   Sat, 9 Sep 2017 08:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-16-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqPuxe3OkwbE5yhZdV7qZLBp6rzBb
        dE95y2ixeXM7iwOLx85Zd9k9Fmwq9bh4Sdnj8ya5AJYoLpuU1JzMstQifbsErozvd7eyFRxg
        q5jYcZi9gXEaaxcjJ4eEgInEveeNLF2MXBxCAjuYJCZt+A3lnGOS2HNwITtIlbBAisS8a5PB
        bBGBNInFk98zdzFycDALeEnM+1gOEhYCKuk8NYMJxGYT0JVY1NMMZvMK2Escur0AbBmLgIrE
        7rdHwWxRgQiJvreX2SFqBCVOznzCAmJzClhIXJx1BqyXWUBd4s+8S8wQtrjErSfzoeLyEs1b
        ZzNPYBSYhaR9FpKWWUhaZiFpWcDIsopRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWl
        dBMjJMRFdjAeOSl3iFGAg1GJh7di+6ZIIdbEsuLK3EOMkhxMSqK8F2o3RwrxJeWnVGYkFmfE
        F5XmpBYfYpTgYFYS4a3qAsrxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBw
        KEnw5gFjWUiwKDU9tSItM6cEIc3EwQkynAdouABIDW9xQWJucWY6RP4Uoy7HjYfX/zAJseTl
        56VKifO+B7lAAKQoozQPbg4sNb1iFAd6S5g3H6SKB5jW4Ca9AlrCBLSk5PkGkCUliQgpqQbG
        KQX157asDTypxvzmhETV/3sfurraDL6HW3Lw8TrsnmR73MF5tfqZTgERhY++NVfsVliHL868
        VySaNHdOIufLh/d71vY+6f0y+2JWTcLP6q1KnLr7+e95vGe+sDP7YfSlux5Xirdd9WDjufEh
        9P16yTqvFcZlF46tzFHetO72gk62XZPT7GoalFiKMxINtZiLihMBQw7INSgDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 02:37 PM, Nguyễn Thái Ngọc Duy wrote:
> At this state, there are three get_submodule_ref_store() callers:
> 
>  - for_each_remote_ref_submodule()
>  - handle_revision_pseudo_opt()
>  - resolve_gitlink_ref()
> 
> The first two deal explicitly with submodules (and we should never fall
> back to the main ref store as a result). They are only called from
> submodule.c:
> 
>  - find_first_merges()
>  - submodule_needs_pushing()
>  - push_submodule()
> 
> The last one, as its name implies, deals only with submodules too, and
> the "submodule" (path) argument must be a non-NULL, non-empty string.
> 
> So, this "if NULL or empty string" code block should never ever
> trigger. And it's wrong to fall back to the main ref store
> anyway. Delete it.

Nice! Thanks for the cleanup.

Michael
