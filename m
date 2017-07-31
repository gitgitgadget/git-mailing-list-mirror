Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76EA1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdGaUX0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:23:26 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33826 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaUXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:23:25 -0400
Received: by mail-lf0-f48.google.com with SMTP id g25so114619272lfh.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=imzHzdT0FAYZvDnQlex3l3bjdN5QwztK+pZxVQVNgBo=;
        b=udz8uPJtxuerm1H2x/1HHQFTfMX9N8HpNB3ZnCqg9svV29CVdSkyUuq4X9AouZnJqv
         LrldZ+VeN6F1dFMApbgqkMHxnbOo53CS5M6cE2XXg9tmXXSQm3q6SZrmyvmU4HpkMWA1
         1o8hxP8eNtCaXYVp9g69LaVHmtdXnKE0r9SPNmIIYOe95LLnGx62Bnafgrr51d0VEgLD
         zojrYuWZnGwIfQB6HUeT8j6r/5L29krtvnnRCnss1O9BhpZ03Jt98awuY08c3FVnqvf6
         jK8qv4ymZednD38uioIPnvKszqn8P3PSGu5Y5H2hlO7ixU+h0rfKFPH1mXT7/lSby+CN
         V9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=imzHzdT0FAYZvDnQlex3l3bjdN5QwztK+pZxVQVNgBo=;
        b=U3hoii0wwA/1ih8+dlLnjMSOWwYQ7RpJXcxcRZmigdstRK22Qd63pDr0YrgiUVZjZU
         puk4m4roOsWimc4oOxUk+NdNVVhbRFIJ5xEPCwifzg8pf93QCrygVoe646cazWENkraR
         dj82G3ybFZ9v7zNqenpXXwf61WbSaiXyQ31R68JtHEOPjWdD6usbc9+19xQas9ek2R09
         r5O3QtQzyPunUyb2wmfnGrTfpoWLYcuRGJX/zWrplT5MTllkdGWkoHQFkTB/AePEH994
         Wkmp7yVkszBUBH94OKtfSn7mTeLzvXHq2G+7tEuIlCJ8oIqMJMvQsH1v922sq/CfY43B
         h4zw==
X-Gm-Message-State: AIVw110BJp8WovSiC4YGQCxj4GfupjLLLvX9unbw4SjHdPTiQCxQxTQ1
        9jiLOOui6q4ie4rz7u8q3sbnG2L+GQJN
X-Received: by 10.46.69.66 with SMTP id s63mr6737595lja.116.1501532604317;
 Mon, 31 Jul 2017 13:23:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 13:23:23 -0700 (PDT)
In-Reply-To: <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley> <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 13:23:23 -0700
Message-ID: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: fix small issues in SubmittingPatches
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 9:18 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Replace the dashed version of a command with undashed
> version and quote it.

I like it, but similar as below, we'd want to go for
consistency.

>
> Further, remove duplicated space character.

https://en.wikipedia.org/wiki/Sentence_spacing
seems like a globally controversial thing. (I assumed
it was some sort of local dialect before researching
it properly)

I personally do not mind one way or another regarding
(double) spaces after a period, but I would think we'd
strive for consistency throughout the project.

>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Documentation/SubmittingPatches | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 558d465b6..9d0dab08d 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -293,7 +293,7 @@ then you just add a line saying
>
>          Signed-off-by: Random J Developer <random@developer.example.org>
>
> -This line can be automatically added by Git if you run the git-commit
> +This line can be automatically added by Git if you run the 'git commit'
>  command with the -s option.
>
>  Notice that you can place your own Signed-off-by: line when
> @@ -366,7 +366,7 @@ suggests to the contributors:
>       spend their time to improve your patch.  Go back to step (2).
>
>   (4) The list forms consensus that the last round of your patch is
> -     good.  Send it to the maintainer and cc the list.
> +     good. Send it to the maintainer and cc the list.
>
>   (5) A topic branch is created with the patch and is merged to 'next',
>       and cooked further and eventually graduates to 'master'.
> --
> 2.14.0.rc1.434.g6eded367a
>
