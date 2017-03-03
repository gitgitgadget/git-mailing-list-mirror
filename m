Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A344E20133
	for <e@80x24.org>; Fri,  3 Mar 2017 16:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdCCQI2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 11:08:28 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43579 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751981AbdCCQI0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 11:08:26 -0500
X-AuditID: 12074414-807ff70000002bfd-42-58b993c5aca1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.4B.11261.5C399B85; Fri,  3 Mar 2017 11:03:17 -0500 (EST)
Received: from [192.168.69.190] (p5B105007.dip0.t-ipconnect.de [91.16.80.7])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v23G3DP7003247
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 3 Mar 2017 11:03:14 -0500
Subject: Re: [PATCH v5 20/24] files-backend: avoid ref api targetting main ref
 store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-21-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <07b603ad-386d-56a8-8f0b-9721006313c7@alum.mit.edu>
Date:   Fri, 3 Mar 2017 17:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-21-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1D06eWeEQcM1eYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZaxbfJOx4BRPxZyr51gaGJdwdTFyckgImEh0XvvL2sXI
        xSEksINJ4vSsZmYI5zSTxN4/+9hAqoQFwiQutVxkB7FFBNIkFk9+zwxiCwlMYJQ4fjobpIFZ
        4AajxKWJH5lAEmwCuhKLeprBbF4Be4mmWYvABrEIqEg0/ewDaxYVCJGYs/ABI0SNoMTJmU9Y
        QGxOAQuJy3sOgsWZBdQl/sy7xAxhy0s0b53NPIGRfxaSlllIymYhKVvAyLyKUS4xpzRXNzcx
        M6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIyTcRXYwHjkpd4hRgINRiYdXw35HhBBrYllxZe4h
        RkkOJiVR3kMFOyOE+JLyUyozEosz4otKc1KLDzFKcDArifBqTwTK8aYkVlalFuXDpKQ5WJTE
        eb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8LZPAmoULEpNT61Iy8wpQUgzcXCCDOcBGr4BpIa3
        uCAxtzgzHSJ/ilFRSpz3D8hWAZBERmkeXC8sHb1iFAd6RZh3N0g7DzCVwXW/AhrMBDTYTwZs
        cEkiQkqqgVHd0lLnpYD4vnt3Lkis9TPft/LOGTVxhYt33+rG2mmI7ckODNDd1x6ZuGT1I9/j
        p+ffFW1w754YWxH6/uQOVXt+A52z2szBdsqaczgU2Td3LdqswLnZvtZg/8pdhb7njC5YsGcW
        mKbHdfW0aDXJT46+/PC7+GuDad0Bft9sNDM9X2yr+n/jqxJLcUaioRZzUXEiAG+MvuEiAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> A small step towards making files-backend works as a non-main ref store
> using the newly added store-aware API.
> 
> For the record, `join` and `nm` on refs.o and files-backend.o tell me
> that files-backend no longer uses functions that defaults to
> get_main_ref_store().

Nice!

> I'm not yet comfortable at the idea of removing
> files_assert_main_repository() (or converting REF_STORE_MAIN to
> REF_STORE_WRITE). More staring and testing is required before that can
> happen. Well, except peel_ref(). I'm pretty sure that function is safe.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 85 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 49 insertions(+), 36 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index dafddefd3..09c280fd3 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> [...]
> @@ -3873,8 +3883,10 @@ static int files_transaction_commit(struct ref_store *ref_store,
>  	 * head_ref within the transaction, then split_head_update()
>  	 * arranges for the reflog of HEAD to be updated, too.
>  	 */
> -	head_ref = resolve_refdup("HEAD", RESOLVE_REF_NO_RECURSE,
> -				  head_oid.hash, &head_type);
> +	head_ref = (char *)refs_resolve_ref_unsafe(ref_store, "HEAD",
> +						   RESOLVE_REF_NO_RECURSE,
> +						   head_oid.hash, &head_type);
> +	head_ref = xstrdup_or_null(head_ref);

If you combine the last two statements, you can avoid the ugly cast.

> [...]

Michael
