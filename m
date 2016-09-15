Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5224A2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbcIOVMf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:12:35 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35280 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbcIOVMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:12:34 -0400
Received: by mail-it0-f54.google.com with SMTP id r192so2790586ita.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h9vxI4tzvEHx2vWriisdd1SyqxXr3RtHCJRujbUm3ZQ=;
        b=dDpQALvZIQT7EOymMEkhVtguGrHLoIVV+n9PnStrQhw5TFjmMazAFHmwzRp47d+weM
         FN5QHYfB9t9FR/BrjRhdulpT+tm68G8u6qeF08HNDPq2AKyJo29MoC4wrPXl3cU0wKAN
         o5XG5n9Et6oKzlCWRgbUdmY9uAsn/Ff24lYX8She6tNSC8uK3wJiT/E0iRwVcTA215g3
         DALiudue1De5PqNi++eHauzVYN9bHbDD8SwrESnMR6UxjPrYKdt59WRJ2wZ3IX20UZu2
         YTbElkszkFA+8zSi9G9E+U9WDFxDcwlDSkW4TFii/VQmaTxiGseDDkeJ2gt5+OyW7Vux
         X7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h9vxI4tzvEHx2vWriisdd1SyqxXr3RtHCJRujbUm3ZQ=;
        b=K2wyn6xmH9AyziG5rIWDAwEBCHuGf3b6rbVPc2ApmdCQ5WtfYabw4guzo1ex8faWuG
         qLBcvannGeymQrCCJwKAFNvNAorbPGRX7IOKGXL2xGyr58kHvtPt/LEe/4FojeAtp9W2
         ojqiL3lKWcj4osqnMKal4NRCc1KqpoiRCNjtOw28Y6FN+ZVYWlBoy1t4/mR9xPLdT2Mm
         0vj86iq36U8yK3FrMv4LkX5iM7wL4QMJZWqgfqNKi5RAQXroPWX0106yW0PaD/1gJ+Xh
         EHuiyScJSTBxJxDGvEVhZN1cVeH7sWoDO9rWx3zPYXEDq5cVXjG/L52gYo4SzET4Sqqc
         rymA==
X-Gm-Message-State: AE9vXwMati+dLvvJpQfWkVx8295UkCiZd5VAT+q5xfiVy7yPDRziufZgKrvJAU8OzOxcK/QCHul8F+7TbgFwj7jm
X-Received: by 10.36.120.76 with SMTP id p73mr1976644itc.23.1473973953139;
 Thu, 15 Sep 2016 14:12:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 15 Sep 2016 14:12:32 -0700 (PDT)
In-Reply-To: <20160915205109.12240-3-gitster@pobox.com>
References: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com> <20160915205109.12240-1-gitster@pobox.com>
 <20160915205109.12240-3-gitster@pobox.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Sep 2016 14:12:32 -0700
Message-ID: <CAGZ79kaCVZ-Z+XSYWK6YtkT8L=pDrDQE-pAyseHNf5w2NO5XMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] SQUASH??? Undecided
To:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ cc Brandon

On Thu, Sep 15, 2016 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If we were to follow the convention to leave an optional string
> variable to NULL, we'd need to do this on top.  I am not sure if it
> is a good change, though.

I think it is a good change.

Thanks,
Stefan

> ---
>  builtin/ls-files.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 6e78c71..687e475 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -29,7 +29,7 @@ static int show_valid_bit;
>  static int line_terminator = '\n';
>  static int debug_mode;
>  static int show_eol;
> -static const char *output_path_prefix = "";
> +static const char *output_path_prefix;
>  static int recurse_submodules;
>
>  static const char *prefix;
> @@ -78,7 +78,7 @@ static void write_name(const char *name)
>          * churn.
>          */
>         static struct strbuf full_name = STRBUF_INIT;
> -       if (*output_path_prefix) {
> +       if (output_path_prefix && *output_path_prefix) {
>                 strbuf_reset(&full_name);
>                 strbuf_addstr(&full_name, output_path_prefix);
>                 strbuf_addstr(&full_name, name);
> @@ -181,7 +181,8 @@ static void show_gitlink(const struct cache_entry *ce)
>         argv_array_push(&cp.args, "ls-files");
>         argv_array_push(&cp.args, "--recurse-submodules");
>         argv_array_pushf(&cp.args, "--output-path-prefix=%s%s/",
> -                        output_path_prefix, ce->name);
> +                        output_path_prefix ? output_path_prefix : "",
> +                        ce->name);
>         cp.git_cmd = 1;
>         cp.dir = ce->name;
>         status = run_command(&cp);
> --
> 2.10.0-458-g97b4043
>
