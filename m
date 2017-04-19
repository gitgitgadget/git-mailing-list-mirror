Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCE11FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 16:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938432AbdDSQsl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 12:48:41 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:33697 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938426AbdDSQsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 12:48:39 -0400
Received: by mail-yb0-f172.google.com with SMTP id 81so8461030ybp.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2rsWX9FBORHVyPhpxmir08sIPbnYkhi5eXUHpiK4GvU=;
        b=j5Qk0BIA0OlkMRAYQo7z98dmy5b3KlCqRvPvQzsKChFe6Qf+lAG7U6ALMlS2XgMwf4
         fDb4jQksxrwcECtZskvaDS3qAvbRjY8Y9VGeqVqzP5O8/moRg8nVgk6mup11MCGn2xwV
         qsmawsvavUs8qkTwyrcLMwjBIHG2vV9jCcW+/GtZH86mLM7gsHiLv2MBN3Wqwob2XpvU
         SSh1qBWv5a4lRnMos71Jtr9uPgSKAOuOyJbG0WDWluv2gJbHN3GgqevJU2cYxeHz4FF4
         OvSgU+wfla4jGmyu7qd19rfq5fFfJr6NteWcv/BMEewxd64FwM0byfkzOJxIN2vjuiMf
         6dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2rsWX9FBORHVyPhpxmir08sIPbnYkhi5eXUHpiK4GvU=;
        b=QHjf8iR7gp4TjbygigK17ToxeI9XN0Ed3AxYN0OHGNi9NxxjBsYJo/cUao6kAvsAh2
         aFCzt5i4Lj7r6qEcoMR4ijGCUsDDq3ysBKJ/F88fXhj63TR/Vc6XEIapr3cw6elrsVjt
         v5Si9vrD3wGgZK+5OlkIaTKhzd9lf49bubcalMgF3TJhYk13MBxHU/W2N/stUuTQLO2I
         ZOEFm6LS03V6zPRj8TFRy0FIIW1QQ90kOFo4STPbtyNjKfmUTfsOGrp+S/xTe3uYs83Y
         79SP8rVOkmsEHLqSW/gV232eHFQyEaMCZuLk9M3llOwQXDUkguBXUtUfCQioIGW3QmBS
         1mlg==
X-Gm-Message-State: AN3rC/6JhAm+mwvXpSKcov63I4o9Dv3A3aQxVa9m9WVXRiszjle4416I
        MPQnjcfDtgrOLU4Bq0mJiWSzeVpdJuVW
X-Received: by 10.99.44.140 with SMTP id s134mr3887065pgs.178.1492620513092;
 Wed, 19 Apr 2017 09:48:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 19 Apr 2017 09:48:32 -0700 (PDT)
In-Reply-To: <0102015b853681c6-2fb6f9ce-28dc-4ca8-82de-d5fbff10d3af-000000@eu-west-1.amazonses.com>
References: <0102015b853681c6-2fb6f9ce-28dc-4ca8-82de-d5fbff10d3af-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Apr 2017 09:48:32 -0700
Message-ID: <CAGZ79kZxH+5bpFpiXqac=gKEjg+3rsyzH4G5z=KL0mSorcmj8g@mail.gmail.com>
Subject: Re: [PATCH] gitmodules: clarify what history depth a shallow clone has
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 12:56 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

Thanks,
Stefan

> ---
>  Documentation/gitmodules.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index 8f7c50f..6f39f24 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -84,8 +84,8 @@ submodule.<name>.ignore::
>
>  submodule.<name>.shallow::
>         When set to true, a clone of this submodule will be performed as a
> -       shallow clone unless the user explicitly asks for a non-shallow
> -       clone.
> +       shallow clone (with a history depth of 1) unless the user explicitly
> +       asks for a non-shallow clone.
>
>
>  EXAMPLES
>
> --
> https://github.com/git/git/pull/347
