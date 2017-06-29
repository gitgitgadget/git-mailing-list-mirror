Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F100F202B3
	for <e@80x24.org>; Thu, 29 Jun 2017 18:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbdF2SRs (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:17:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36113 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdF2SRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:17:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so12786820pgn.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Hy2JJgVH2QLmBtn/PKNlvqaJGbJGvF8l/Qmp18aFuDg=;
        b=lJKI2hjMJFlikhd0ny7mk9pPykFlzV9wBWCwvNxQU6JOEtNkDMKnFy+gNBg83T73ss
         M27DsusX9pK2h+ITgJgmr15LP6lmLNXmYDWOZBb8XGcWNyNDMvN+H91VyzNeN1OX7Moq
         wBmUgc6LzOLvABvxeBGfmQrDingNnvxSxhYIHR5iNHd5TVnvuS6JF1Fkmxl4MYOOgX2n
         s5sGLHy/qEDHbR7ITpQF76js0HIPgMkQaj03UMlu/4hK/NLofnIlRpNtxphwfXce9UxW
         tGiC7KGo8pl2kKazCeBQuTWaNNR4XygDFPhZQ70HTNLYeJj6OhFmd30SQsiB9Ef/UeGr
         MsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Hy2JJgVH2QLmBtn/PKNlvqaJGbJGvF8l/Qmp18aFuDg=;
        b=Hi3HiYA0hJY7d131RynfXEtaR1/c9tUOJDvpqIbULIVrocENOMhG+CkJMNukAR3vh0
         uGGYLqDasTsjRrGhshf9pNgXuqjdMqUTkZfbM3l9tYkSfm5WZzhLXf1ytsaXpEKBYXK/
         HOPONaNRAxfMShW9eoQE2KGhNv4mMLvSMlJj6asi+hboOPQ21XPr15XFeZ6ZpjshlKZO
         6oXWuZwCFpv8qznuSPdRSFm6zD1W37+IYa8+kaljkgVfevyTV6HRa4DxeCAqH0iKlRnx
         U6X0/aId8///TVXGfm9K+1TZH60YABvY1dXPWtej2M67dTuCjjbqtLTDJIE9rqww37PR
         MCqg==
X-Gm-Message-State: AKS2vOyOxSGAjM+IzOe53z4Ruv9jW6fPstH2zOTDPn1+3+evqu8ICddm
        EFIQyyIka9B9Gg==
X-Received: by 10.98.59.152 with SMTP id w24mr17858444pfj.107.1498760266340;
        Thu, 29 Jun 2017 11:17:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9846:b2e3:b31e:8976])
        by smtp.gmail.com with ESMTPSA id a84sm13078977pfe.19.2017.06.29.11.17.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:17:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-template: add new line before status information
References: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
        <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
        <20170629170120.11479-2-kaarticsivaraam91196@gmail.com>
Date:   Thu, 29 Jun 2017 11:17:44 -0700
In-Reply-To: <20170629170120.11479-2-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 29 Jun 2017 22:31:20 +0530")
Message-ID: <xmqqmv8qu08n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The commit template adds the optional parts without
> a new line to distinguish them. This results in
> difficulty in interpreting it's content, specifically
> for inexperienced users.
>
> Add new lines to separate the distinct parts of the
> template.

The rationale of this has changed in this final version, hasn't it,
especially with the removal of the "include/only warning" bit?

We used to add a blank line to separate the "we are committing for
somebody else", which is an optional part, from the status output,
only when we have the optional part.  Now with your change, we
unconditionally have a blank before the part that would have been
shown by "git status" to separate the two parts out.



> ---
>  I tried writing tests to ensure that the new line is added
>  but as it seems to require checking multi-line, special 
>  options of grep were required to check. I tried the following,
>
>    test_expect_success 'new line found before status message' '
>     ! (GIT_EDITOR="cat >editor-input" git commit) &&
>     grep -Pz "#\n# On branch" editor-input
>    '
>
>  It worked well locally but seems to make the build with 
>  GETTEXT_POISON=YesPlease to fail. So, I removed it.
>  Not sure how to write a good test for this change, sorry :(
>
>  builtin/commit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 64701c8f4..22d17e6f2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -873,8 +873,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				(int)(ci.name_end - ci.name_begin), ci.name_begin,
>  				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
>  
> -		if (ident_shown)
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
>  
>  		saved_color_setting = s->use_color;
>  		s->use_color = 0;
