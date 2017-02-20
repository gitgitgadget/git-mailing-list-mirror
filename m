Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D0A201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbdBTMLS (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:11:18 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52708 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752118AbdBTMLR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 07:11:17 -0500
X-AuditID: 12074414-807ff70000002bfd-54-58aadcd93e5f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D4.81.11261.9DCDAA85; Mon, 20 Feb 2017 07:11:06 -0500 (EST)
Received: from [192.168.69.190] (p579060C0.dip0.t-ipconnect.de [87.144.96.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1KCB1I4028222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Feb 2017 07:11:03 -0500
Subject: Re: [PATCH v4 14/15] files-backend: remove submodule_allowed from
 files_downcast()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-15-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
Date:   Mon, 20 Feb 2017 13:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170218133303.3682-15-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1L11Z1WEwfF5qhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgypj4/RBLwUnuinMdG5gbGHdxdjFyckgImEj0/pjF3sXI
        xSEksINJYsm71ywQznkmid8NB1hAqoQFYiWO91xhB7FFBNIkFk9+zwxR1M8ocezWTzYQh1ng
        BqPEpYkfmUCq2AR0JRb1NAPZHBy8AvYSXV28IGEWAVWJq0d3s4HYogIhEnMWPmAEsXkFBCVO
        znzCAlLOKWAusbclESTMLKAu8WfeJWYIW16ieets5gmM/LOQdMxCUjYLSdkCRuZVjHKJOaW5
        urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCHBLrKD8chJuUOMAhyMSjy8GjNXRgixJpYV
        V+YeYpTkYFIS5b2zZFWEEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeN5eBcrwpiZVVqUX5MClp
        DhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErxht4EaBYtS01Mr0jJzShDSTBycIMN5gIYv
        AanhLS5IzC3OTIfIn2JUlBLnXQeSEABJZJTmwfXCktErRnGgV4R5X4NU8QATGVz3K6DBTECD
        b3qsBBlckoiQkmpg5OxRvLg5Msfd2lS8SXt629GnTK9kv0f7+SwIPfuopPjaRTFVt1+KgXd/
        8n9aP6sm4t9KJqOHR0IsTivxRJVV7Cq/e4r9V9ZTFm2GOwlO57SSxT7d4Snb7nwy3GujPDPP
        fMYk3sx/B95/26virzPrdJtlWpq6m4TCnH9OT+bmNF9/sGATk8keJZbijERDLeai4kQA6Juk
        /CEDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/18/2017 02:33 PM, Nguyễn Thái Ngọc Duy wrote:
> Since submodule or not is irrelevant to files-backend after the last
> patch, remove the parameter from files_downcast() and kill
> files_assert_main_repository().
> 
> PS. This implies that all ref operations are allowed for submodules. But
> we may need to look more closely to see if that's really true...

I think you are jumping the gun here.

Even after your changes, there is still a significant difference between
the main repository and submodules: we have access to the object
database for the main repository, but not for submodules.

So, for example, the following don't work for submodules:

* `parse_object()` is used to ensure that references are only pointed at
valid objects, and that branches are only pointed at commit objects.

* `peel_object()` is used to write the peeled version of references in
`packed-refs`, and to peel references while they are being iterated
over. Since this doesn't work, I think you can't write `packed-refs` in
a submodule.

These limitations, I think, imply that submodule references have to be
treated as read-only.

When I was working on a patch series similar to yours, I introduced a
boolean "main_repository" flag in `struct ref_store`, and use that
member to implement `files_assert_main_repository()`. That way
`files_ref_store::submodule` can still be removed, which is the more
important goal from a design standpoint.

Michael

