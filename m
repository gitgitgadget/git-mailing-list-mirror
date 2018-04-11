Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32E41F404
	for <e@80x24.org>; Wed, 11 Apr 2018 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeDKPf6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 11:35:58 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:59377 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeDKPf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 11:35:57 -0400
Received: from [192.168.2.240] ([92.22.12.182])
        by smtp.talktalk.net with SMTP
        id 6HmqfzLNalWlT6HmqfJrD0; Wed, 11 Apr 2018 16:35:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523460955;
        bh=6R2/DxSSVXaSykEgel2q80iG6sjls3TaNQdpr26CAFo=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZrKbkZEtV7iUYqlNQgId6FNi827GEAEpbg9/eXlFQXuPInRDN7p+GVDQpXerWIjMe
         aGHeb4uzyqPOlBC6E+/x1dSJi1ZTkYXdRgRftj+m5ip/V0wXS6m/1nt7vFYrBCuBGe
         6ymhnrcAqCFF3Rvx0QPJtNPc8oMjKzU3XmW9yp6M=
X-Originating-IP: [92.22.12.182]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=6E9tJQHDO+z314HI75mSew==:117
 a=6E9tJQHDO+z314HI75mSew==:17 a=IkcTkHD0fZMA:10 a=HYe2jzysrml7t87iaG4A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the
 man page
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de>
 <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
Date:   Wed, 11 Apr 2018 16:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL5ppxwtlVh06dRT/EN5K5ehmnUEokoFPJJFZfbUEH9eh+Br2TY5ruW2cOrykR3U5bWZzYT1k2PuflqWNzLhtO6zJaga/ZfP8LWWQMVpCFMsxFCnrXFv
 iVNNw3SkkJY2s+qFuwbWrCHbU3E50vRT4eQbN2r3peisrltZEWehPQ//bXjdwtTbUSjKDXcS/oSXkr4lfBTurstdOXY/MLCte55LbscL8Z+dNvvzzbjQzukU
 8dDZAFCSb9B+aODUgEFokLNn00TYpJZl9Qyw7d/033kBdo4pRMW38NB03dXch3EJOyl6suQP5FaamVv8L1w/7+jvDpMwJ5AzKQ2S8IXbYBk2wShcbc6iWsyl
 9aspJpUrNNNMZVH+8wWreN9PVHgOtkFg8siTVehDsplsB+afmFx9pblu6zsI3hpYfFqXIKpjUT1/a2ILpddJBHrB5PNUzn0SaxOKCFJAnFS1RnAxwEaSBR1c
 7zN+KfNkRbyrfvQiTrYePgxLmR5rvBGu4oxwLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04/18 13:30, Johannes Schindelin wrote:

Firstly let me say that I think expanding the documentation and having 
an example is an excellent idea.

> +
> +------------
> +label onto
> +
> +# Branch: refactor-button
> +reset onto
> +pick 123456 Extract a generic Button class from the DownloadButton one
> +pick 654321 Use the Button class for all buttons
> +label refactor-button
> +
> +# Branch: report-a-bug
> +reset refactor-button # Use the Button class for all buttons
> +pick abcdef Add the feedback button
> +label report-a-bug
> +
> +reset onto
> +merge -C a1b2c3 refactor-button # Merge 'refactor-button'
> +merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
> +------------
> +
> +In contrast to a regular interactive rebase, there are `label`, `reset` and
> +`merge` commands in addition to `pick` ones.
> +
> +The `label` command puts a label to whatever will be the current

s/puts a label to/associates a label with/ would be clearer I think. 
Maybe s/whatever will be the current revision/the current HEAD/ an well?

> +revision when that command is executed. Internally, these labels are
> +worktree-local refs that will be deleted when the rebase finishes or
> +when it is aborted.

I agree they should be deleted when the rebase is aborted but I cannot 
see any changes to git-rebase.sh to make that happen. I think they 
should also be deleted by 'rebase --quit'.

> That way, rebase operations in multiple worktrees
> +linked to the same repository do not interfere with one another.
> +
> +The `reset` command is essentially a `git reset --hard` to the specified
> +revision (typically a previously-labeled one).

s/labeled/labelled/

I think it would be worthwhile to point out that unlike the other 
commands this will not preserve untracked files. Maybe something like
"Note that unlike the `pick` or `merge` commands or initial checkout 
when the rebase starts the `reset` command will overwrite any untracked 
files."


Best Wishes

Phillip
