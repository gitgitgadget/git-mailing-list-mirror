Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031A11FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbeARVTG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:19:06 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45984 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeARVTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:19:03 -0500
Received: by mail-wm0-f66.google.com with SMTP id i186so24535107wmi.4
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p4cMhutrUSImDAGCxMU2RtvgjoRyGm2b5HAqLc72igA=;
        b=EJ69OGmAMWyk6Un1XQ7OCjxTydfLdO1FgFSpkeFTj0J0WOZRTIlzjbucUwBU4WmzeN
         NEQ+yWWmNQ7YXaC6/umiU1d4oniypkjsGo3k1xLzMXSK38FtICss8dsb0to59jQ/HeK8
         6V7z43EnNm/vpFVj8iNmSjJYDHJuyrtBc8dMLnYfkQliddLUKvKII0m8dsMY2ewUtdvL
         uENDv/Br/aTvAt4fkmJGF3qUBmir6DdaNJu9chCYl86e9+ENaFrkfkijZ8IQRilMFDOS
         Qnub+4QDtlxKVRxFHoZTqeGFRemjJcgMSp4rW6BIYp1OnjvszVLqMXOY3dwY6YAfQv+1
         u1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p4cMhutrUSImDAGCxMU2RtvgjoRyGm2b5HAqLc72igA=;
        b=W0I13QMfyXjfC41V2/JocYU+q30JE2yYy7SlBQuEN+mTYjKqwb+ddJhSB+JnAx0oUb
         IvWK9Nl0cdUbYfh/9bm/2Gi4VcTUgUUf/a1ZJnFu++GSdojhfTDFY9DqX+H6ySQVTpnO
         X/6wExr2OSbk/izdZB6hwDsU2i19ZpGm39I7BM4qtkLZLif9wICtOX/f3vIVeHooIzP7
         hJRo1QWEsrIqLKEDwgFgiDfa06qTATP5k1/335u+YH5M5uci1trFyzt13rAArWCVgAUv
         giTLEJ1woWvN1qDRD8YyOKliwOSgc+GkkTaw4qH+vX6zwHF6ivaAHeoT8awsN8v2H7RG
         Sy5w==
X-Gm-Message-State: AKwxytd4wjkHEGi5lpWCLPB4agbPAhhFI8A5XvwJaG5R82Px4YHID6QH
        PMABVeLtdoVnefGi2Ffhhdtu6OqKAHG73WUbQiGKPA==
X-Google-Smtp-Source: ACJfBot+oOUb74HlLE+jyM5Vwzczf6nBv27G50SJbQafugPsjv6VX1+ShncFk+WQ/N9vz1BxEZ5xkYJuN5Cie+Lgnr4=
X-Received: by 10.80.204.219 with SMTP id b27mr9450093edj.18.1516310341614;
 Thu, 18 Jan 2018 13:19:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 13:18:41 -0800 (PST)
In-Reply-To: <20180118183618.39853-2-sbeller@google.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-2-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 13:18:41 -0800
Message-ID: <CA+P7+xp3BVSPapd=P1+fPqimQXYhc2z_A_7djwvrv0HE_WB=LA@mail.gmail.com>
Subject: Re: [PATCH 9/8] [DO NOT APPLY, but squash?] git-rebase--interactive:
 clarify arguments
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:36 AM, Stefan Beller <sbeller@google.com> wrote:
> Up to now each command took a commit as its first argument and ignored
> the rest of the line (usually the subject of the commit)
>
> Now that we have commands that take different arguments, clarify each
> command by giving the argument list.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-rebase--interactive.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 23184c77e8..3cd7446d0b 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -155,17 +155,17 @@ reschedule_last_action () {
>  append_todo_help () {
>         gettext "
>  Commands:
> -p, pick = use commit
> -r, reword = use commit, but edit the commit message
> -e, edit = use commit, but stop for amending
> -s, squash = use commit, but meld into previous commit
> -f, fixup = like \"squash\", but discard this commit's log message
> -x, exec = run command (the rest of the line) using shell
> -d, drop = remove commit
> -l, label = label current HEAD with a name
> -t, reset = reset HEAD to a label
> -b, bud = reset HEAD to the revision labeled 'onto'
> -m, merge = create a merge commit using a given commit's message
> +p, pick <commit> = use commit
> +r, reword <commit> = use commit, but edit the commit message
> +e, edit <commit> = use commit, but stop for amending
> +s, squash <commit> = use commit, but meld into previous commit
> +f, fixup <commit> = like \"squash\", but discard this commit's log message
> +x, exec <commit> = run command (the rest of the line) using shell
> +d, drop <commit> = remove commit
> +l, label <label>= label current HEAD with a name
> +t, reset <label> = reset HEAD to a label
> +b, bud = reset HEAD to the revision labeled 'onto', no arguments
> +m, merge [<label-or-commit>]* = create a merge commit using a given commit's message

The merge arguments are complicated, i'm not sure how best to add
clarification here.. I think it might need its own paragraph, since it
takes something like: <commit> <parents to merge>* <possibly message>?

Thanks,
Jake

>
>  These lines can be re-ordered; they are executed from top to bottom.
>  " | git stripspace --comment-lines >>"$todo"
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
