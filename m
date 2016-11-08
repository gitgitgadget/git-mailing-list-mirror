Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF132035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbcKHXcC (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:32:02 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35462 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbcKHXcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:32:02 -0500
Received: by mail-yw0-f196.google.com with SMTP id b66so4680226ywh.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zzP7+IcVaba0IP+YeEz5DwGgOmfOUQ+Ya85WV/FUp1o=;
        b=0i3wzsr8ehV7Gao9iZVI3PJyO++WaWbk4dzIrHVdQoiRVBU/NKTgxNkrlA9haOH9Rd
         HPlne1J16m8NFH0uGLSBt0bHqocbQSvcMnWggymeHNy40EopWVqLIXJaMLz4BBIYTek4
         TEEwJcZvC+Q/vlz1gQvxNpr0ICbeyHU/dFmo4kZota6wZiom1nakDwaGY7gdS9ZgJYEU
         KA0TQGOTj0hkClOiH+/0rx29LokTRsE+TcUg9ZTiFPRLB0reubFJTJ/NfY3Lz9WSbtI7
         K7Vn+yBT3v65vaDpFGPxisy7lS+hSxaescfnPVEZOmHyIzmW59iIRvMpz6smudDTZyH3
         duLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zzP7+IcVaba0IP+YeEz5DwGgOmfOUQ+Ya85WV/FUp1o=;
        b=A8L3mTzJyVEqOgVilnutk/PmQS05xU5r65Wye7/39KOpPqixapBBDgWXaqKMdyUMUZ
         tpSS9bFlZwClpDsGkCKPRiK4/uKh6Q45Lsx5S+OS29MMFpH4RqjhEmRNTsNDHI1xV//5
         054GRwNt7JXYbJwwBikffhK30mXs1GsWL0hxIdh0MkggZbnGeYr3VJjj3tbKHCRbPEIi
         xmwctM2SwoTtyWCmppzSchc+IpTBYFD/RcAwWzOYXfUTB+mfxb86c9k4niOknMPwj8vv
         IL+hotGpVwEXPFjPkh9/aIjkmQSij7+VWoNG/8BLdpSi7I17HTP6X6YSvdbZjsnSX6R9
         qljg==
X-Gm-Message-State: ABUngvd0meBEpbe7rHGhBtvRU4SnXTNKnpF1SZ1AJr7P1GPtIbAXqDfZtZx1I11bm7ViwQUNZEUostk89UteXg==
X-Received: by 10.129.130.193 with SMTP id s184mr13893058ywf.276.1478647921366;
 Tue, 08 Nov 2016 15:32:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:31:41 -0800 (PST)
In-Reply-To: <20161108201211.25213-6-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-6-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:31:41 -0800
Message-ID: <CA+P7+xo4M5g15B7zKzC-zJvd6O0Wfpks142-+C8tAqTfyEJ+nA@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] ref-filter: move get_head_description() from branch.c
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Move the implementation of get_head_description() from branch.c to
> ref-filter.  This gives a description of the HEAD ref if called. This
> is used as the refname for the HEAD ref whenever the
> FILTER_REFS_DETACHED_HEAD option is used. Make it public because we
> need it to calculate the length of the HEAD refs description in
> branch.c:calc_maxwidth() when we port branch.c to use ref-filter
> APIs.
>

Makes sense.

>
> -               if (starts_with(name, "refname"))
> +               if (starts_with(name, "refname")) {
>                         refname = ref->refname;
> -               else if (starts_with(name, "symref"))
> +                       if (ref->kind & FILTER_REFS_DETACHED_HEAD)
> +                               refname = get_head_description();

Since this (I think?) changes behavior of refname would it make sense
to add a test for this?

Thanks,
Jake

> +               } else if (starts_with(name, "symref"))
>                         refname = ref->symref ? ref->symref : "";
>                 else if (starts_with(name, "upstream")) {
>                         const char *branch_name;
> diff --git a/ref-filter.h b/ref-filter.h
> index 14d435e..4aea594 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -106,5 +106,7 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
>  struct ref_sorting *ref_default_sorting(void);
>  /*  Function to parse --merged and --no-merged options */
>  int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
> +/*  Get the current HEAD's description */
> +char *get_head_description(void);
>
>  #endif /*  REF_FILTER_H  */
> --
> 2.10.2
>
