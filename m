Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163A11F404
	for <e@80x24.org>; Thu, 22 Mar 2018 22:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeCVWqL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 18:46:11 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:43905 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCVWqL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 18:46:11 -0400
Received: by mail-lf0-f49.google.com with SMTP id v207-v6so15580307lfa.10
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=10KySsnRY7SXvhy6jbDOLyVZcv7K+NWq0GZheIAuHZ4=;
        b=Hjk6RhWO9Dbgb9ieRSKTfsUm7QLWRsmKLlkKvjD2+n7vDu9zNtg9/JZi3h+vtYWr2J
         aKhdQz5riPWrwGrTemZG0Und9pCs//F8Wdh2KffHivFd6rYz43tr/2ynzNj1TDo2qonf
         fRCKy0K4yRLSnpfCwwPqSKcbGUBx2EdIAAhJK2UfkedNEIhrZHnv/hv3RaKF0fXR3ICK
         xzxyF5Dp0D5e8NBODtFlP+S27QUS7Zg7szkMnZeB0nEYQ7ua25JdXZCu6/fJeH8uZaao
         2iIRba74y2Jt7a9oXY6LVvpmQnzoJ/BI226ORMxVp9FLCKkmJh+OW7fAnDXxV1oQI9nt
         CvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=10KySsnRY7SXvhy6jbDOLyVZcv7K+NWq0GZheIAuHZ4=;
        b=NTX+H95GWJ+MHSOup8B6CCJzqEGoYOBGWIBumasJxteoKI0CGtgdSN4QE5lgaFiHZ0
         Z+RhqkDMbk5VQH9zAk4TiSiyWPrsfHypBdKWWOszUd+eCyiVCVINDOMsa9sBfGkYvg/l
         k4jV0VrjVbfH6zx+s2CpMBMvQ38wDIwDm44DvoV7y6U6r6rWsDDvFsuvqq0LouoOj8tU
         xlY6AL5it2LyHpo0bpuj+JLn9k8jdPFUGdUHpQBCRFXpXD8MZOA9RqUcnlFhX8/H5EKI
         cKLgU+Fx+Jw6AThJwsqBAGVlpDzpSYpTRJ4Fx7zncV0y0vyKBL70Vwba+K7EdInfDBuH
         +6SA==
X-Gm-Message-State: AElRT7Gva8cYOcNCMlvWVuaxePD+7EwjxKZoFZ81LZf58hx9CwzwAI2B
        4SeDh2rD8HsUpf2bmCb2u0PPUQOC4ZeksGCAbMmPBA==
X-Google-Smtp-Source: AG47ELvqrcgh7kW11i3F3/QiLCNPbyCziuQUH9Q3sxieH5OOtbpEpSAqscJBGdl2U5N3pdMYTvc2OcmFLNQqGWrUD5o=
X-Received: by 2002:a19:4f5d:: with SMTP id a29-v6mr17359825lfk.97.1521758769211;
 Thu, 22 Mar 2018 15:46:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9a93:0:0:0:0:0 with HTTP; Thu, 22 Mar 2018 15:45:48
 -0700 (PDT)
In-Reply-To: <xmqqefkbltxv.fsf@gitster-ct.c.googlers.com>
References: <CAKk8isoL--f1gt_p5XZ99ybN+xts=0_AKBo52Ej=n3SMPoMq3A@mail.gmail.com>
 <7ce3cfef9ff3ab97ac8292fae94a0024a1d85505.1521748846.git.wink@saville.com> <xmqqefkbltxv.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Thu, 22 Mar 2018 15:45:48 -0700
Message-ID: <CAKk8isrLrE+sC0Rfv6WUzjziSqGzRgk2xTOh-OKCeEpdxsPfkA@mail.gmail.com>
Subject: Re: [RFC PATCH v3.1 2/9 2/2] rebase-interactive: Do not automatically
 run code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> At Junio's suggestion have git-rebase--am and git-rebase--merge work the
>> same way as git-rebase--interactive. This makes the code more consistent.
>
> I mumbled about making git_rebase__$type functions for all $type in
> my previous response, but that was done without even looking at
> git-rebase--$type.sh scriptlets.  It seems that they all shared the
> same structure (i.e. define git_rebase__$type function and then at
> the end clla it) and were consistent already.  It was the v3 that
> changed the calling convention only for interactive, which made it
> inconsistent.  If you are making git-rebase.sh call the helper shell
> function for all backend $type, you are keeping the existing
> consistency.
>
> This is no longer about "interactive" alone, though, and need to be
> retitled ;-)
>
>> Signed-off-by: Wink Saville <wink@saville.com>
>> ---
>>  git-rebase--am.sh          | 17 ++++++-----------
>>  git-rebase--interactive.sh |  8 +++++++-
>>  git-rebase--merge.sh       | 17 ++++++-----------
>>  git-rebase.sh              | 13 ++++---------
>>  4 files changed, 23 insertions(+), 32 deletions(-)
>>
>> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
>> index be3f06892..47dc69ed9 100644
>> --- a/git-rebase--am.sh
>> +++ b/git-rebase--am.sh
>> @@ -4,17 +4,14 @@
>>  # Copyright (c) 2010 Junio C Hamano.
>>  #
>>
>> +# The whole contents of this file is loaded by dot-sourcing it from
>> +# inside another shell function, hence no shebang on the first line
>> +# and then the caller invokes git_rebase__am.
>
> Is this comment necessary?

Removed

>
>> +# Previously this file was sourced and it called itself to get this
>> +# was to get around a bug in older (9.x) versions of FreeBSD.
>
> ECANTPARSE.  But this probably is no longer needed here, even though
> it may make sense to explain why this comment is no longer relevant
> in the log message.  E.g.
>
>         The backend scriptlets for "git rebase" are structured in a
>         bit unusual way for historical reasons.  Originally, it was
>         designed in such a way that dot-sourcing them from "git
>         rebase" would be sufficient to invoke the specific backend.
>         When it was discovered that some shell implementations
>         (e.g. FreeBSD 9.x) misbehaved by exiting when "return" is
>         executed at the top level of a dot-sourced script (the
>         original was expecting that the control returns to the next
>         command in "git rebase" after dot-sourcing the scriptlet),
>         the whole body of git-rebase--$backend.sh was made into a
>         shell function git_rebase__$backend and then the scriptlet
>         was made to call this function at the end as a workaround.
>
>         Move the call to "git rebase" side, instead of at the end of
>         each scriptlet.  This would give us a more normal
>         arrangement where a function library lives in a scriptlet
>         that is dot-sourced, and then these helper functions are
>         called by the script that dot-sourced the scriptlet.
>
>         While at it, remove the large comment that explains why this
>         rather unusual structure was used from these scriptlets.
>
> or something like that in the log message, and then we can get rid
> of these in-code comments, I would think.

Updated commit message

>>  git_rebase__am () {
>> -
>> +echo "git_rebase_am:+" 1>&5
>
> debuggin'?  I see similar stuff left in other parts (snipped) of
> this patch.

Removed debugging :(

Currently I'm not rebasing the other commits (3..9)
to reduce the amount of work I have to do in each
review cycle, is that OK?

Also, will you merge commits 1 and 2 before the other
commits or is the procedure to merge the complete set
at once?
