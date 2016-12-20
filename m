Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750BA1FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 07:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757417AbcLTH3o (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 02:29:44 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46714 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757211AbcLTH3n (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Dec 2016 02:29:43 -0500
X-AuditID: 1207440d-8b7ff700000009ba-d5-5858ddde8f5a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 17.84.02490.EDDD8585; Tue, 20 Dec 2016 02:29:35 -0500 (EST)
Received: from [192.168.69.190] (p57907272.dip0.t-ipconnect.de [87.144.114.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBK7TWCK024079
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 20 Dec 2016 02:29:33 -0500
Subject: Re: [PATCH 0/5] git check-ref-format --stdin --report-errors
To:     Junio C Hamano <gitster@pobox.com>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
 <561c0338-66cd-f806-7b3b-b422f98a1564@alum.mit.edu>
 <xmqqlgvbpyku.fsf@gitster.mtv.corp.google.com>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <21317fc7-c1fb-8be0-eadf-90fed9486a48@alum.mit.edu>
Date:   Tue, 20 Dec 2016 08:29:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqlgvbpyku.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqHv/bkSEwfcdXBZdV7qZLBp6rzBb
        rG5ZxOLA7PHt1CZmj4uXlD0+b5ILYI7isklJzcksSy3St0vgyui79oip4AFfxa1jJ9kaGP9z
        dzFyckgImEhsWjKNHcQWErjMKDH3UimEfYFJ4uQ57S5GDg5hAVeJty1lIGERATWJiW2HWLoY
        uYBKVjNKfPu0kQmkhlnATeLHyzyQGjYBXYlFPc1AYXYOXgF7iZ8FIFEWAVWJ3sYlTCC2qECI
        xOU5R9lAbF4BQYmTM5+wgAzhFLCW2HiEEyTMLKAnseP6L1YIW15i+9s5zBMY+Wch6ZiFpGwW
        krIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MULCkncH4/91MocYBTgY
        lXh4DSojIoRYE8uKK3MPMUpyMCmJ8u7nAQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4XU/BZTj
        TUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwigHjT0iwKDU9tSItM6cE
        Ic3EwQkynAdo+Pw7IMOLCxJzizPTIfKnGBWlxHn/3wZKCIAkMkrz4HphaeMVozjQK8K8W0Da
        eYApB677FdBgJqDBC7vDQQaXJCKkpBoYY/zP1hrYJu793yV88W2V/6GfbfKt8Rc+MDuIer0N
        sY7I3PR8lchLnoX/9ES0+2qvxvJ5lznucGmN6BSdtc7SeedlXysxrmcta0NvZ8z/WTHJ6ES1
        sW7IoWlvO109V9RmTFMJVNFOj3ig/eV4/Z3D39auTp71aXb6n3PMzRO4/Gflzm2df/CoEktx
        RqKhFnNRcSIAlr73i/YCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/2016 07:23 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Especially given that the output is not especially machine-readable, it
>> might be more consistent with other commands to call the new feature
>> `--verbose` rather than `--report-errors`.
> 
> Don't we instead want to structure the output to be machine-readable
> instead, given that check-ref-format is a very low level plumbing
> command that is primarily meant for scriptors?

Of course that would be the ideal. Let's think about what it would look
like. Given that the very purpose of the program is to decide whether
its inputs are reasonable reference names or not, it would be important
to make it bulletproof:

* It could be fed some ugly garbage
* It could be used for security-relevant checks

One obvious choice would be to use NUL separators, but that would make
the output mostly unreadable to humans.

Another would be to use LF to terminate each line of output, like

    ok TAB refs/heads/foo LF
    bad TAB refs/heads/bad SP name@@.lock LF

For the LF-terminated `--stdin` input, this should be unambiguous.
However, it wouldn't necessarily work for arguments passed in via the
command line, for for slight variations on `--stdin` like if we were to
add a `-z` option to allow the input to be NUL-terminated.

The 100% solution would probably be to support language-specific
quoting, like the `--shell`/`--perl`/`--python`/`--tcl` options accepted
by `for-each-ref`, probably with a fifth option for NUL-terminated
output. And it should probably also support a `-z` option to make its
input NUL-separated. Pretty much all of the infrastructure is already
there in `quote.h` and `quote.c`, and the option-parsing could be
cribbed from `builtin/for-each-ref.c`, so it wouldn't even be *that*
much work to implement.

Michael

