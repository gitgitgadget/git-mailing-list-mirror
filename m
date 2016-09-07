Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E100A1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757097AbcIGRCG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:02:06 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34865 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754181AbcIGRCG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:02:06 -0400
Received: by mail-wm0-f41.google.com with SMTP id i204so96848811wma.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LotYvcxKbTWx0IFIpovMraQmj5+x9h7bebM2xU07Dz4=;
        b=klzSnfEAHKFeuleMKwV3cRjPho6XiJdK+MMlvmyejve8oFuG/nL3+P2y9pA90x/Ke+
         8C5lY2gtL15OkZC/3x4sBEpN5VnPvuEOJ17ZPgYX/IuSSq4XrXOaiXd6i6lGdwKRuB7i
         sez+tCGz8z0JWLjlYrSYXrzLvrz4w6fJem2OL8gdYF3zjAx655WQk6McQyiYbpRQZjL8
         +4iWKdxd86nHMtMyd0UKxjCWRcwcxsy3i+P0TsdKCHkxm14JM7PfPOSGJhZcLCqs6V9G
         GsgnIhZyAGvd1gQ9jSCwcFYH4NFWX/p8JX2Rd6ScFgjjX12nBpYiprtGTPejOu/M0MFi
         NWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LotYvcxKbTWx0IFIpovMraQmj5+x9h7bebM2xU07Dz4=;
        b=hw6/hMEd0mDlma49CPzOT/2uKCBqx4DBOoabvnPp3D+m5TAUAXDxs1tUzTPv348I0p
         ZZpNnOcSFrhQQfKrm3c5hvVwfps/QeIatowSyoxhV6nrORj1IJhO8q9zfp+2YyUC/Dr9
         JrZLazOFxvRCXcOIpEO030rETO6bvbMWo12AcpOqDM9ypfK9EyrCEyz9uRMhB+ZnGLyJ
         jRD6qCx2KEwDbSSfJafryPcZSonk5RVvuaVsKWHiBA9sc1JW5W7qOpDlUyx1+wj3xZO2
         +P6T/wqMGzy+mMUwHj0nx57AVzjLSy5CYvuobbLPZ5k/W4j+XniZFnVqNOecUx5zxuk0
         P8qQ==
X-Gm-Message-State: AE9vXwP7/18PWTfUKOjwuMaXdYF2DXZagwmFnPjkPheYY4gCFIbYbuUJ7/h3c8wN4yfPxeBQQF+AUe7cRdxWCg==
X-Received: by 10.194.94.34 with SMTP id cz2mr11683407wjb.130.1473267724415;
 Wed, 07 Sep 2016 10:02:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.234.212 with HTTP; Wed, 7 Sep 2016 10:02:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1609071714540.129229@virtualbox>
References: <CAN0XMO+ZOV3M02wJ_=oMPbN4ch-=7gA_pXEegfHApvSNeOu3KA@mail.gmail.com>
 <alpine.DEB.2.20.1609071714540.129229@virtualbox>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Wed, 7 Sep 2016 19:02:03 +0200
Message-ID: <CAN0XMOL7LEcJAHhmSwq8QWH7mD7+jQXRkAdQA+3hZ2JQUJ99Gw@mail.gmail.com>
Subject: Re: Bug? ran into a "fatal" using interactive rebase
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-09-07 17:19 GMT+02:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> So, something like this should help (if you are interested in seeing this
> patch included, please run with it, as I am running short on time):
>
> -- snipsnap --
> diff --git a/wt-status.c b/wt-status.c
> index 6225a2d..8e4d999 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1072,14 +1072,17 @@ static void abbrev_sha1_in_line(struct strbuf *line)
>         strbuf_list_free(split);
>  }
>
> -static void read_rebase_todolist(const char *fname, struct string_list *lines)
> +static void read_rebase_todolist(const char *fname, struct string_list *lines, int gently)
>  {
>         struct strbuf line = STRBUF_INIT;
>         FILE *f = fopen(git_path("%s", fname), "r");
>
> -       if (!f)
> +       if (!f) {
> +               if (gently)
> +                       return;
>                 die_errno("Could not open file %s for reading",
>                           git_path("%s", fname));
> +       }
>         while (!strbuf_getline_lf(&line, f)) {
>                 if (line.len && line.buf[0] == comment_line_char)
>                         continue;
> @@ -1102,8 +1105,8 @@ static void show_rebase_information(struct wt_status *s,
>                 struct string_list have_done = STRING_LIST_INIT_DUP;
>                 struct string_list yet_to_do = STRING_LIST_INIT_DUP;
>
> -               read_rebase_todolist("rebase-merge/done", &have_done);
> -               read_rebase_todolist("rebase-merge/git-rebase-todo",
>                 &yet_to_do);
> +               read_rebase_todolist("rebase-merge/done", &have_done, 1);
> +               read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do, 0);
>
>                 if (have_done.nr == 0)
>                         status_printf_ln(s, color, _("No commands done."));
>
>

That works for me. Thanks.
