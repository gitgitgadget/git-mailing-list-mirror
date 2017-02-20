Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626D7201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 11:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbdBTLX7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 06:23:59 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60514 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751232AbdBTLX6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 06:23:58 -0500
X-AuditID: 1207440f-129ff70000003517-a3-58aad1cb77b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 66.71.13591.CC1DAA85; Mon, 20 Feb 2017 06:23:56 -0500 (EST)
Received: from [192.168.69.190] (p579060C0.dip0.t-ipconnect.de [87.144.96.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1KBNqcO026232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Feb 2017 06:23:53 -0500
Subject: Re: [PATCH v2 04/16] files-backend: replace *git_path*() with
 files_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
 <20170216114818.6080-5-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <330bfd35-ec00-92a2-a221-c7be9f0199e5@alum.mit.edu>
Date:   Mon, 20 Feb 2017 12:23:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170216114818.6080-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqHvm4qoIg+XH9Sy6rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLXZPW8BmsXlzO4sDu8fOWXfZPT58jPNYsKnUo6v9CJvHxUvKHo8n
        nmD1+LxJLoA9issmJTUnsyy1SN8ugSujZ08XW8FsgYpZX++wNzAu4u1i5OSQEDCRmDbpEUsX
        IxeHkMAOJonNK9awQTjnmST+7zzIBFIlLBAqcWLJHHYQW0QgTWLx5PfMEEV9jBLTZv9jBHGY
        BW4ySnzdc5kFpIpNQFdiUU8zWDevgL1E59sdjCA2i4CqxKxnF8DiogIhEnMWPmCEqBGUODnz
        CVgvp4CZxPrnf1hBbGYBdYk/8y4xQ9jyEs1bZzNPYOSfhaRlFpKyWUjKFjAyr2KUS8wpzdXN
        TczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICXl+oOvWyxxiFOBgVOLhbZi9MkKINbGsuDL3
        EKMkB5OSKO+dJasihPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwTjkLlONNSaysSi3Kh0lJc7Ao
        ifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfBaXwBqFCxKTU+tSMvMKUFIM3FwggznARouC1LD
        W1yQmFucmQ6RP8WoKCXOOwkkIQCSyCjNg+uFpaRXjOJArwjzJoBU8QDTGVz3K6DBTECDb3qs
        BBlckoiQkmpg1P1apzlj8YnFmSdXSHwRixQ8qWaYuHPu8QWnAzkXfPy3QSWd26ptnUnYgokn
        3Dcn+u1fe+u0ROk9nTuar7/c+bVFRyx83ozoZy711z/4P/VVdNTi2j1/Oj+HcJ3XJ+vsN7n8
        73TCReR6nHsTGV73Gcee3h7xwslTSFn+zsxAHfZ1E3anxtXdU2Ipzkg01GIuKk4EAB0dR2ck
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/16/2017 12:48 PM, Nguyễn Thái Ngọc Duy wrote:
> This centralizes all path rewriting of files-backend.c in one place so
> we have easier time removing the path rewriting later. There could be
> some hidden indirect git_path() though, I didn't audit the code to the
> bottom.

Almost all of the calls to `files_path()` [1] take one of the following
forms:

* `files_path(refs, &sb, "packed-refs")`
* `files_path(refs, &sb, "%s", refname)`
* `files_path(refs, &sb, "logs/%s", refname)`

(though sometimes `refname` is not the name of a reference but rather
the name of a directory containing references, like "refs/heads").

This suggests to me that it would be more natural to have three
functions, `files_packed_refs_path()`, `files_loose_ref_path()`, and
`files_reflog_path()`, with no `fmt` arguments. Aside from making the
callers a bit simpler and the implementation of each of the three
functions simpler (they wouldn't have to deal with variable argument
lists), at the cost of needing three similar functions.

But I think the split would also be advantageous from a design point of
view. The relative path locations of loose reference files, reflog
files, and the packed-refs file is kind of a coincidence, and it would
be advantageous to encode that policy in three functions rather than
continuing to spread knowledge of those assumptions around.

It would also make it easier to switch to a new system of encoding
reference names, for example so that reference names that differ only in
case can be stored on a case-insensitive filesystem, or to store reflogs
using a naming scheme that is not susceptible to D/F conflicts so that
we can retain reflogs for deleted references.

Michael

[1] The only exception I see is one call `files_path(refs, &sb,
"logs")`, which is a prelude to iterating over the reflog files. This is
actually an example of the code giving us a hint that the design is
wrong: if you iterate only over the directories under `git_path(logs)`,
you miss the reflogs for worktree references.

