Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3031F576
	for <e@80x24.org>; Fri, 26 Jan 2018 11:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeAZLhU (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 06:37:20 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43924 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeAZLhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 06:37:18 -0500
Received: by mail-ua0-f193.google.com with SMTP id i5so100143uai.10
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 03:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t44Jk0hShVqSheYmI+h7OL4b7ocqodVamGTLd+DPf+o=;
        b=EpHGWVM5dvJDZeVlTEpnwjMj2H1U+hJIHLWkZyGw4dwHzsM+qZAUBhJO693PS7Or6O
         2CuiCGx+3o4XgoYUKTorA4z4zCa/CHv3v7E632XlzJjDSi5No3FnTKXvOpfUl6Q2vpnE
         QkNc7SkeLGvdyehXubC0y8j4o3qhpsDxiHOkEH5hlEf5xlvlfY7P4OnuysCTlTmt8ISf
         iqERajGxHHQSc98T61L0WaX7u4FKto+vKUaqxvbyPzWkiUA+WBe3zHnPxRDyO94KHqIr
         d34Z2CgcYoshU6gTyIJMeCLPVitu0qz4Z8ro5Sbac/uqLRVcJ8oQPiiOdZPM7otF7PjJ
         +QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t44Jk0hShVqSheYmI+h7OL4b7ocqodVamGTLd+DPf+o=;
        b=Cq2XHnlI490tkLiJ5l6Ugd7ws694wmPQtAC55BXzSPfN1imB0yO0qMy3nrYfTTpo8N
         oRsGO6lzoP6tyYayX3o9T8/EBp2DmUxCIi7KIxP4HBh+50GoSmtBpYdiGQbqCJvBW7HI
         FdSsxHmgRq4aXQE/w4mLhf4jEPXufNsGdtoMXLIEWGYiow7QxhGUUS/LC44cqDIS3Eg0
         w7j8Hu9wfBgwUCfc4/OH20cVS4gy/taXB0mbPdn+QsN8hNiub67X+TLlZ3z+QMp0cv8Q
         4CNIEFfAFNM/dQVyKqQMomjML1hfstMSW8WKl1yUpd4RgzLM9OpCfdVzBUMBilxtgHuO
         E8BQ==
X-Gm-Message-State: AKwxytcLxR2yPne0j73ozEOEk6clFyeXpdyuJb9fL9SPZRyaoMfIlCEM
        JjNxzyDaYxFwzvhnFw3UkMX/hinOYFk9ECnw7Ak=
X-Google-Smtp-Source: AH8x224DIi4KCd1UcI7M04PWqV9RLHQwVMHHuuc0TU3DCeGqHlJgowMMR5h/sCvc+BncEBFgPe3t07I/75xAhjSfwdU=
X-Received: by 10.159.57.111 with SMTP id i47mr10135652uag.79.1516966638234;
 Fri, 26 Jan 2018 03:37:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 26 Jan 2018 03:37:17 -0800 (PST)
In-Reply-To: <20180105202711.24311-4-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com> <20180105202711.24311-4-newren@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 12:37:17 +0100
Message-ID: <CAM0VKj=qhJQJ7uJWbBouSTYD0frA1zp1gwXzMVXuTiF+C6GH+g@mail.gmail.com>
Subject: Re: [PATCHv6 03/31] directory rename detection: testcases to avoid
 taking detection too far
To:     Elijah Newren <newren@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, git@matthieu-moy.fr
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 9:26 PM, Elijah Newren <newren@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6043-merge-rename-directories.sh | 153 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index f36493289..239819f2d 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh

> +test_expect_success '3b-check: Avoid implicit rename if involved as source on current side' '
> +       (
> +               cd 3b &&
> +
> +               git checkout A^0 &&
> +
> +               test_must_fail git merge -s recursive B^0 >out &&
> +               test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
> +               test_i18ngrep ! CONFLICT.*rename/rename.*y/d &&

The filename argument is missing in the above line.

Why does the test still succeed, then?  Because 'test_i18ngrep' is
expected not to find the given pattern, and of course it won't find the
pattern if its input is empty as it comes from /dev/null instead of the
appropriate file.


> +
> +               git ls-files -s >out &&
> +               test_line_count = 5 out &&
> +               git ls-files -u >out &&
> +               test_line_count = 3 out &&
> +               git ls-files -o >out &&
> +               test_line_count = 1 out &&
> +
> +               git rev-parse >actual \
> +                       :0:y/b :0:y/c :1:z/d :2:x/d :3:w/d &&
> +               git rev-parse >expect \
> +                       O:z/b O:z/c O:z/d O:z/d O:z/d &&
> +               test_cmp expect actual &&
> +
> +               test_path_is_missing z/d &&
> +               git hash-object >actual \
> +                       x/d w/d &&
> +               git rev-parse >expect \
> +                       O:z/d O:z/d &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +###########################################################################
> +# Rules suggested by section 3:
> +#
> +#   Avoid directory-rename-detection for a path, if that path is the source
> +#   of a rename on either side of a merge.
> +###########################################################################
> +
>  test_done
> --
> 2.14.2
>
