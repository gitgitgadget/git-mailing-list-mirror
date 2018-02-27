Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13871F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeB0VdT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:33:19 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35770 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeB0VdT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:33:19 -0500
Received: by mail-pf0-f193.google.com with SMTP id y186so119203pfb.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j5w3Zg4zhNWxje8n0PB0wfEEiQRfjPs183/+bHDiqwc=;
        b=HRQYQHqwIWRAXQjJMXqK9DeZy3hWV37POtP9ANSCr/ICP6iKn31pT05R3tnZhGFKwb
         VfWIktdHudclYWA2Uefrkdqz7Z4Qthotf2QIo0GkT+OeV47YxHU/HQNw/gHnagR2CAFk
         9JwbpZmVvK8QC3JRikQjazDgWmr14bkMYUM4SjqgWblg+r98Hh0iZQu27MJqsy1NdvRI
         Cs5GECDvtkc98A2OkyEeBjxF8JYzmHV943KHzbothX6Le+lB/gEQKSB8oQgQ3UAH08eb
         HLXqnEnaGX9jaM939p8SIrj+lZoLaJfndGfbJFSYL3fpaU1ysGl8cCJE4H5GHX4jm9UK
         Lk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j5w3Zg4zhNWxje8n0PB0wfEEiQRfjPs183/+bHDiqwc=;
        b=hO9Lzg5YkAC4sQqJ1TJWS2S5a0L03SXaRlmjqLAMlqe1h9QyVu6m6MbyPtmDMRuYQu
         5sbYS/4jObfoQcfwERAtzzx/TXtO6wSgYhN26U/JTWPxe48VRGHDdAqsye3w0vSLvMF1
         MdbRVsC3GAskDpUiZ0y6vNR+LpWONfh0AR/FodMb1sxq/UOAsscAfHqBhhyOSZZhQekI
         BX5rORKmfhl1hCht16JKHEh1MXv//RCOaN5RzjGH2w2PCT49yVYOWjbDg1LJZjLDiNRq
         9xn7zcubZYA7UtkA+NtFW73dc6YiNNjcryTTPyg8NlzXl/AUd8BnD3NWcKjLJD2pypH8
         41+Q==
X-Gm-Message-State: APf1xPCh+6yUsGL5N3ynCT3qwUCHZWVZH8onlRFHXHeJ1kIubzKjvmgG
        ZzaCCcpyKtN8yclADlhC7tL0wSdig0Kq02i+Sog=
X-Google-Smtp-Source: AH8x225NczDNoafjIZHEBs+wTBh1AhZ60AlcfzsxOfh/qRKjmeJrdIYC0Crb0yDH57zpMY/woYH/eHLPGELIKCOyVD8=
X-Received: by 10.98.108.65 with SMTP id h62mr15522153pfc.32.1519767198463;
 Tue, 27 Feb 2018 13:33:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 27 Feb 2018 13:33:17 -0800 (PST)
In-Reply-To: <8ec3a73dfdc76c503d50e34e5fc8b8a3d5ea7dd8.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de>
 <cover.1519680483.git.johannes.schindelin@gmx.de> <8ec3a73dfdc76c503d50e34e5fc8b8a3d5ea7dd8.1519680483.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 27 Feb 2018 22:33:17 +0100
Message-ID: <CAN0heSpCiHxGDnWyafTQU4+++73JGRW9w0Bq1nd2LcqgMqOnzA@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] sequencer: avoid using errno clobbered by rollback_lock_file()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 February 2018 at 22:29, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> As pointed out in a review of the `--recreate-merges` patch series,
> `rollback_lock_file()` clobbers errno. Therefore, we have to report the
> error message that uses errno before calling said function.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e9baaf59bd9..5aa3dc3c95c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -345,12 +345,14 @@ static int write_message(const void *buf, size_t len, const char *filename,
>         if (msg_fd < 0)
>                 return error_errno(_("could not lock '%s'"), filename);
>         if (write_in_full(msg_fd, buf, len) < 0) {
> +               error_errno(_("could not write to '%s'"), filename);
>                 rollback_lock_file(&msg_file);
> -               return error_errno(_("could not write to '%s'"), filename);
> +               return -1;
>         }
>         if (append_eol && write(msg_fd, "\n", 1) < 0) {
> +               error_errno(_("could not write eol to '%s'"), filename);
>                 rollback_lock_file(&msg_file);
> -               return error_errno(_("could not write eol to '%s'"), filename);
> +               return -1;
>         }
>         if (commit_lock_file(&msg_file) < 0) {
>                 rollback_lock_file(&msg_file);
> @@ -2106,16 +2108,17 @@ static int save_head(const char *head)
>
>         fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
>         if (fd < 0) {
> +               error_errno(_("could not lock HEAD"));
>                 rollback_lock_file(&head_lock);
> -               return error_errno(_("could not lock HEAD"));
> +               return -1;
>         }

I just noticed this when test-merging my series of lockfile-fixes to pu.
This `rollback_lock_file()` is not needed, since failure to take the
lock leaves it unlocked. If one wants to roll back the lock "for
clarity" or "just to be safe", then the same should arguably be done in
`write_message()`, just barely visible at the top of this diff.

Perhaps not worth a reroll. The conflict resolution between this and my
patch would be to take my hunk.

https://public-inbox.org/git/cover.1519763396.git.martin.agren@gmail.com/T/#t

Martin
