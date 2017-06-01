Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF2D20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdFAVGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:06:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:19742 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbdFAVGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:06:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3wf0JN4RHTz5tl9;
        Thu,  1 Jun 2017 23:06:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9064E434F;
        Thu,  1 Jun 2017 23:06:27 +0200 (CEST)
Subject: Re: What's cooking in git.git (Jun 2017, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ebe29db6-45ed-81d7-2a3e-24437406eb08@kdbg.org>
Date:   Thu, 1 Jun 2017 23:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.06.2017 um 09:44 schrieb Junio C Hamano:
> * nd/fopen-errors (2017-05-30) 14 commits
>   - mingw_fopen: report ENOENT for invalid file names
>   - SQUASH??? use test_i18ngrep and add it at the end
>   - mingw: verify that paths are not mistaken for remote nicknames
>   - log: fix memory leak in open_next_file()
>   - rerere.c: move error_errno() closer to the source system call
>   - print errno when reporting a system call error
>   - wrapper.c: make warn_on_inaccessible() static
>   - wrapper.c: add and use fopen_or_warn()
>   - wrapper.c: add and use warn_on_fopen_errors()
>   - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
>   - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
>   - clone: use xfopen() instead of fopen()
>   - use xfopen() in more places
>   - git_fopen: fix a sparse 'not declared' warning
> 
>   We often try to open a file for reading whose existence is
>   optional, and silently ignore errors from open/fopen; report such
>   errors if they are not due to missing files.
> 
>   Waiting for an Ack to the SQUASH fix or a reroll of the tip commits.

ACK!

See also 
https://public-inbox.org/git/2899d715-a416-1852-4399-28af0a3e9b6e@kdbg.org/

-- Hannes
