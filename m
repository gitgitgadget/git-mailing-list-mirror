Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839331FF1E
	for <e@80x24.org>; Tue, 31 Jan 2017 00:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754517AbdAaARb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 19:17:31 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35699 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdAaAR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 19:17:29 -0500
Received: by mail-lf0-f66.google.com with SMTP id v186so32667539lfa.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xz9KAt7iKkRe860VAsJztzd6HIBSENl4m6ocsDtmCa4=;
        b=gMzLrgPtZv1JUrXodt1hxxhv0nmEqfUmV7KkxPfQ+4PN+6wW2R9/1eEJxhcwegaAbD
         6E79wXjG4n43NplP0tlgfYHB0b9qQzMO2Lwp2qKKk1iJwfgEhnQgbNGHH/7lVznmY3AS
         VlDRRF9TV8CmTo8MdHDJ6OVxrPA91l3sJ9JyvdA5XIRCYoqKzvgV34tz7SnM4cA4GBNJ
         yK1+6pn+Cse1l1R2ZpiT2jQ/u8LNOAje4DdLL/Jq2AWWfPwmG/AZ3iYtfZpo2v+p2VEX
         k9ZqSS6dyxoJCqY2ap0UvFaNwi/UxCIy28mOWx0SsijrIt7UAJfaIX7qqJ7NcJWn6M+3
         rFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xz9KAt7iKkRe860VAsJztzd6HIBSENl4m6ocsDtmCa4=;
        b=kbfwtjOmXtHA6SPwv6HzI45M+z5HuJm2/Aw6o5zfeF/r5yoyPT3ID2Ffrz7Azg+yL3
         jQFmDZ9kpdcH5GcctrfWHQRjohVcCliT5ziKcwhOgzjDU0sOtp4a4vLa251UysD1HHiA
         kHaDq4mRfh2flCWfkLlJoymVCCyt80ru5FK3ij/3YCR6oFy2opzHpZgucnT0D/mgfYgC
         loAKgKQWxSou0TlQJmxYwHcQyoplH3NqM49iaGyo3nJfO+uRIdMXw0FeTgutXVSoATlK
         QS1345eQCJL+/SN/9n18p2MbxHecegmKU4zf124oJnZMiCsBKwhTzj8RXd3RgcqEo9Nu
         gxvQ==
X-Gm-Message-State: AIkVDXIKuodiqxatHJDHyaq+Z8OkijJXn+VLh4h971IM/HOetFmC3XsIpPR7enCBBbnBkJ0Q7lfOsUUrQsYx2g==
X-Received: by 10.25.141.12 with SMTP id p12mr8267974lfd.147.1485821424900;
 Mon, 30 Jan 2017 16:10:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Mon, 30 Jan 2017 16:10:04 -0800 (PST)
In-Reply-To: <20161204144127.28452-1-peterjclaw@gmail.com>
References: <20161204144127.28452-1-peterjclaw@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 30 Jan 2017 16:10:04 -0800
Message-ID: <CA+P7+xqYGigV=8k_vS+4Y5fS2ORHUjYOnNRsAGYb1BwCx13xzg@mail.gmail.com>
Subject: Re: [PATCH] Completion: Add support for --submodule=diff
To:     peterjclaw@gmail.com
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 4, 2016 at 6:41 AM,  <peterjclaw@gmail.com> wrote:
> From: Peter Law <PeterJCLaw@gmail.com>
>
> Teach git-completion.bash about the 'diff' option to 'git diff
> --submodule=', which was added in Git 2.11.
>
> Signed-off-by: Peter Law <PeterJCLaw@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 21016bf8d..ab11e7371 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1206,7 +1206,7 @@ _git_describe ()
>
>  __git_diff_algorithms="myers minimal patience histogram"
>
> -__git_diff_submodule_formats="log short"
> +__git_diff_submodule_formats="diff log short"
>
>  __git_diff_common_options="--stat --numstat --shortstat --summary
>                         --patch-with-stat --name-only --name-status --color
> --
> 2.11.0
>

Yep, this looks good to me.

Thanks,
Jake
