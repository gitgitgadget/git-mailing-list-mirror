Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FB120188
	for <e@80x24.org>; Sat, 13 May 2017 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbdEMNUj (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 09:20:39 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33054 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753617AbdEMNUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 09:20:38 -0400
Received: by mail-it0-f67.google.com with SMTP id l145so7418539ita.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vdl6VCycsdplw32hOeybpNQzjmnWIyjG2ywzBf+Br0s=;
        b=njCiwm3V5pk0dDOkHOsnq9qcJzcOaWvSkGdmKd+oOSIFiyTR5zJwE14boPSNYJoLAs
         /NNgqE2x6LHgX5hXWoPc0oGUbF84gdLQqQ7wxULEOTUCE6cX8XgpEG+apo09NQhE13mq
         MSqJI6uXRWD/OwgNao6OkuHncHtERom1iO9seO0pGfwy3tyn+qBw0I6tMZYekoPTRAMy
         wUdNGTHWWvWfhYLDcOEHY3/7YO+MgvKLm7N9OXvcM0ynqsgrwHrtVuubkcQ01e9PFbw4
         8EhRLO8UQx8BXJAdtmNydYxsVBf7NvDqjsYXGAON9cADDSMpI3+5nYZ988kYr4dzQMjC
         Bj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vdl6VCycsdplw32hOeybpNQzjmnWIyjG2ywzBf+Br0s=;
        b=X4qd0JanKLTzyGCI/DfDSXxZqTUq+yXp28FtOaXxAlkStRtd0rT+HGcg1bNR5Pzvvn
         QczqeHne4VUYFmPhw6kR0z21huyC5kzDZW1wFaZgv/3o7aDl9baVMGtLBSl8TungvFqL
         JGBB8aaK/xZL08xmgiEgUsbApf1AmIBQEx80rxoxLDGXVKDiPGh1AxcjUDytyd8/P0QG
         Xd97dx9AE5XWUSWV4SBKHnLjbVHHV2gR7YC6QuN41YjeIIiVUuAQwqG3bqKV6sXZ9Hte
         9ZwM2w0oZm+lBRrb5SblRLqGfFFRbOrC1FUaDUQ7n8rwKmZk1f7ldzxVBijn5vgjP3i6
         3DfQ==
X-Gm-Message-State: AODbwcBpjqd+Jh9aWXPVG9JPx2jEhJFlsgnZdQVJpxkhmWFWmNO/lVhF
        4tbDnUgtIXzuTuFirLlRRJ/NN9JeMA==
X-Received: by 10.36.53.2 with SMTP id k2mr8510962ita.71.1494681637994; Sat,
 13 May 2017 06:20:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 06:20:17 -0700 (PDT)
In-Reply-To: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 15:20:17 +0200
Message-ID: <CACBZZX7MXh_9mG1EROZVEEGapBwjzRWzr3S57f6rWLnQe9L+XA@mail.gmail.com>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style
 options & config
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 12:50 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On Windows, `(1|2)` is not a valid file name, and therefore the tag
> cannot be created as expected by the new test.
>
> So simply skip this test on Windows.

Thanks for the hotfix. I'll fix this in my v2, but do it differently
in such a way that I can still run these tests on windows.

I.e. the actual test here just needs these odd characters in the
commit message. It's just an unintended implementation detail of
test_commit that a tag is being created.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/exhaustive-grep-tests-fixup-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git exhaustive-grep-tests-fixup-v1
>
>  t/t4202-log.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 36321f19061..6f108e99b7b 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -296,7 +296,7 @@ test_expect_success 'log with grep.patternType configuration and command line' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'log with various grep.patternType configurations & command-lines' '
> +test_expect_success !MINGW 'log with various grep.patternType configurations & command-lines' '
>         git init pattern-type &&
>         (
>                 cd pattern-type &&
>
> base-commit: 3760a479060228867a31eed443334b30124465b9
> --
> 2.12.2.windows.2.800.gede8f145e06
