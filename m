Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A7A208CD
	for <e@80x24.org>; Fri,  1 Sep 2017 03:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdIADLF (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 23:11:05 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34925 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdIADLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 23:11:03 -0400
Received: by mail-pf0-f171.google.com with SMTP id g13so4332995pfm.2
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0R8w5gNEQ/qR8kK5oxVbfNq+AdCsZL3kEAd5XtLpkUk=;
        b=ud4h6mRmXSczXx0RiU2kIozPdygQm6Tb5ZHkAXj3JdppzHRzQBWWIZGRQGpd/BnCVq
         Y1nqlfzsUEkU00XO+b1v2EvwPRrs/Kp9hFP3fpU57g+NYck5bXquCh/XGLl4yl6uWC8O
         6FHHeAC/cD8xQlQn+MBCNtklXjJza3le0GJKNJKGEB9kgcNV1okM0BLy2f/WAJVWcIkw
         81B0/vQXEj2m6zAM/bYqLsle7pqDxiLaqd+uImefeq13QrWAPnGd1xUIy1dAbNHEb5wP
         JSPn+IgWwxqJp+1g8+QLmWBT6J9dMvTvegM3h1uJSPrN8Ba7GOHpnxqPCaYIjfMdaiH8
         eR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0R8w5gNEQ/qR8kK5oxVbfNq+AdCsZL3kEAd5XtLpkUk=;
        b=ah/RQ0yLb9M8nNDL1VOx53qM2kiUWccIy/607jgms/LUuOHPKBCVeBPBOsPlpPpj8U
         usxxDaWbhRGLxWXCoy9uTjGkxjySy/FZFaPvz0Wcex5ph5SLTjAe6yy3nt3yk+fwLd6x
         0niOqZZAX1vds50a4FGl8e7zFCRVwDAsjVSY8WFFDJih8ld11Y7k/0e1ombHUY40trCW
         vwxGZyBB+iaRefbCcLH6bLwUI7kyGIICwYSke807CIZVRqABWz5V6bsyzlhacxdITXYa
         MtkwFJMR7WoOgomHvUUv98oR2VsDrkSO6feSjs0P1C61clsmnhk+CEjhhPdyFuRvl90X
         4aPg==
X-Gm-Message-State: AHPjjUi9P7PfNQrkKV/Ky817W8au8Vg1TDycp/uBu4BnBeJ9wZVaMXWz
        GUfwj9JFynUBew==
X-Google-Smtp-Source: ADKCNb6JXEeL/cUx8sSiZhVNScxg7MRjTprHNF2gX97kef/oPaKI+DOSlwFaLi0pgsLbibBqACmcyA==
X-Received: by 10.98.192.92 with SMTP id x89mr714292pff.176.1504235463180;
        Thu, 31 Aug 2017 20:11:03 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:709c:64f7:8b5:b601])
        by smtp.gmail.com with ESMTPSA id b187sm1185155pfg.133.2017.08.31.20.11.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Aug 2017 20:11:02 -0700 (PDT)
Date:   Thu, 31 Aug 2017 20:11:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sonny Michaud <michaud.sonny@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/1] Add stash entry count summary to short status output
Message-ID: <20170901031100.GI30568@aiede.mtv.corp.google.com>
References: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sonny,

Sonny Michaud wrote:

> Any assistance would be greatly appreciated; I just wanted to get
> started by hacking first and asking questions later!                         

Welcome to the Git project, and sorry for the silence before.  Getting
to see what people are working on is one of the nice things about
being subscribed to this list. :)

> Subject: [PATCH 0/1] Add stash entry count summary to short status output

As Junio mentioned, this subject line may discourage casual readers.
In a one-patch series like this one, there's no need for a cover
letter: the patch's commit message should speak for itself anyway.

See the DISCUSSION section of "git help format-patch" for more details
on sending a patch for review.

You can put [RFC/PATCH] to make it clear that a patch is still a work
in progress and you're looking for early comments on it.

> this patch adds a header in the same style as the one provided by
> the --branch option when the user supplies both --show-stash and
> --short.

For next time, this information belongs in the commit message.

[...]
> This patch extends the functionality of the recently introduced
> --show-stash option to the status command, providing a header similar to
> the one displayed when using the --branch option.

Can you include an example of output in the commit message?  Also,
can you say more about the workflow this fits in?  What information
does a person expect in the output, and how does this change help a
person do what they are trying to do?

[...]
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1619,6 +1619,11 @@ test_expect_success 'show stash info with "--show-stash"' '
>         test_i18ngrep "^Your stash currently has 1 entry$" expected_with_stash
>  '
>
> +test_expect_success 'show stash info with "--show-stash" and "--short"' '
> +       git status --show-stash --short >expected_with_stash &&
> +       test_i18ngrep "Stash entries: 2" expected_with_stash

Interesting.  The idea makes sense.

I have the same questions as Junio about how this affects --porcelain
output.

Also, could this patch also include some documentation in
Documentation/git-status.txt about the new behavior?

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1827,6 +1827,15 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>         fputc(s->null_termination ? '\0' : '\n', s->fp);
>  }
>
> +static void wt_shortstatus_print_stash_summary(struct wt_status *s)
> +{
> +       int stash_count = 0;
> +
> +       for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
> +       if (stash_count > 0)
> +    color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## Stash entries: %d", stash_count);

See the "For C programs" section of Documentation/SubmittingPatches
for some formatting hints.

In the "pu" branch, there is some experimental support for helping
with that.  If you merge in the bw/git-clang-format branch from there,
you can test your patch for style errors (or for errors in that support
:)) by running "make style".

Thanks and hope that helps,
Jonathan
