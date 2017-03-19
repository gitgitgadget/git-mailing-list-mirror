Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8079720323
	for <e@80x24.org>; Sun, 19 Mar 2017 19:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbdCSTRe (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 15:17:34 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45283 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752357AbdCSTRb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 15:17:31 -0400
X-AuditID: 12074412-4a3ff70000000b04-95-58ced7e232bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 39.DC.02820.2E7DEC85; Sun, 19 Mar 2017 15:11:30 -0400 (EDT)
Received: from [192.168.69.190] (p5B105D72.dip0.t-ipconnect.de [91.16.93.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2JJBRLf014057
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 19 Mar 2017 15:11:28 -0400
Subject: Re: [PATCH v6 03/27] files-backend: delete dead code in
 files_init_db()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-4-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <fe71b052-d0ef-061e-4adb-405cc87428de@alum.mit.edu>
Date:   Sun, 19 Mar 2017 20:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170318020337.22767-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1H10/VyEwdEFKhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyvj2TragkbPix8mfrA2Ma9m7GDk4JARMJNo+WnQxcnII
        Cexgkjh6SqqLkQvIPscksXXTETaQGmGBIInbW5VBakQE0iQWT37PDFE/gVGi5wATSD2zwA1G
        iUsTPzKBJNgEdCUW9TSD2bwC9hLfPjcwgtgsAqoS585MYQWxRQVCJOYsfMAIUSMocXLmExYQ
        m1PAXGLLu+dgcWYBdYk/8y4xQ9jyEs1bZzNPYOSfhaRlFpKyWUjKFjAyr2KUS8wpzdXNTczM
        KU5N1i1OTszLSy3SNdPLzSzRS00p3cQICXOhHYzrT8odYhTgYFTi4b1x6VyEEGtiWXFl7iFG
        SQ4mJVHef+pAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8aqeAcrwpiZVVqUX5MClpDhYlcd6f
        i9X9hATSE0tSs1NTC1KLYLIyHBxKErwfrwE1ChalpqdWpGXmlCCkmTg4QYbzAA2fC1LDW1yQ
        mFucmQ6RP8WoKCXOuxMkIQCSyCjNg+uFpaFXjOJArwjz6gCTkhAPMIXBdb8CGswENHjZjTMg
        g0sSEVJSDYxOchWyPRbvmhR/yPsvrpJPt2Fkn/J1wRyHeMkXdfJxEo0MGyMuZj+YvXG6uQK/
        ttmBsrN/DXPPRR5LOea2aXPqBdYdv+M8im4eq7Zdf0J/x4T8fW/chavTbuTf/nnwjsg85Ud5
        1s/2NDzu7F52/7pyrgvP9c8X+HqbbJbGB6movnA+l8s+YY0SS3FGoqEWc1FxIgC1zpLAHgMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18/2017 03:03 AM, Nguyễn Thái Ngọc Duy wrote:
> safe_create_dir() can do adjust_shared_perm() internally, and init-db
> has always created 'refs' in shared mode since the beginning,
> af6e277c5e (git-init-db: initialize shared repositories with --shared -
> 2005-12-22). So this code looks like extra adjust_shared_perm calls are
> unnecessary.
> 
> And they are. But let's see why there are here in the first place.
> 
> This code was added in 6fb5acfd8f (refs: add methods to init refs db -
> 2016-09-04). From the diff alone this looks like a faithful refactored
> code from init-db.c. But there is a subtle difference:
> 
> Between the safe_create_dir() block and adjust_shared_perm() block in
> the old init-db.c, we may copy/recreate directories from the repo
> template. So it makes sense that adjust_shared_perm() is re-executed
> then to fix potential permission screwups.
> 
> After 6fb5acfd8f, refs dirs are created after template is copied. Nobody
> will change directory permission again. So the extra adjust_shared_perm()
> is redudant. Delete them.

LGTM. Thanks for the careful research.

Michael


