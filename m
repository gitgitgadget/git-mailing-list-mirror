Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70D5202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbdI1RSM (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 13:18:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36782 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbdI1RSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 13:18:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id r74so1565790wme.3
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jQGCtmbgExQQpt03RVlw+tvIdTcJ4ozt50j6PTeFJNc=;
        b=b6DSXvsW0AOUNOMBxH6Vi59JHUeLJ1qd0JHwQUpaA0hOKiUuz08TazIQ1PQtq/2LWf
         hBFlJZ5tMzTVgLhXbVksI8eePZIoZaFFiYexSIUjbAXD/8t7eTnMUbJD1ffCjPvUl+TQ
         LcJuz/3mguP2q4qjOQ75JQ8zOpJf9gPD62q+guQdSvbX/hVvI2CL29DN8CEgqAJNGOSD
         UPq+1kvLqycIi2FvLm4AjViGdPCgnesOdBHVG2HBve4nsfYzckV8SAvtRDHYYEZHW3FO
         PSQKllf82Hdfr5aPOW/s2rrCSmmfezKerMlSrLSUtl2eY3CQ5S2grQVJCtsZroHBBsZy
         1mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jQGCtmbgExQQpt03RVlw+tvIdTcJ4ozt50j6PTeFJNc=;
        b=Jtia44fUmehz3Xc0aGfgqrO/QS5/p+QSmUb7o/19LBVs7UZRjwbFPTokVUw9XE93WB
         usgsxuX21eQlvet3RVImBsB42Yp6GJwwEmgQOLdQVbWe0lkvencvb6IctAplZdWgUs6B
         E65yIN5koMSZdCPM6CexiUw4PANjY4oz+FDeVt/J8Er1wpabD8wHxbnFLcLxc3hQ4pPg
         1FyoqR45o6h9b1SCTmZXF85ti5A/B3cllpKTpTLnc93x0Xi79mZc5QbBB3/GKxjwFN8H
         xcYufTS2yNPo2OT0NiGheGscdiKRKJ3PHsj0unvI7Ue9ccbYc/d6OQIyChN/KM1cPENT
         N0Ew==
X-Gm-Message-State: AHPjjUhPfBRz7aPigJDlmDXYxHMGullECwq1y7D4FvtHKJ+62XohKWLW
        6M79vQnxYOhXUwo48z7QZDJkQw==
X-Google-Smtp-Source: AOwi7QAvKWIhNW1o9NUwl8KrLGV9H2AW6Jw3Xjl/cEyCTjlZfk2tYVjFJvqqAye3oLUiCJAYyV8lOw==
X-Received: by 10.80.200.201 with SMTP id k9mr6620295edh.66.1506619090246;
        Thu, 28 Sep 2017 10:18:10 -0700 (PDT)
Received: from ?IPv6:2001:a61:1015:7101:55e:6494:f4c9:167b? ([2001:a61:1015:7101:55e:6494:f4c9:167b])
        by smtp.googlemail.com with ESMTPSA id m10sm1921827eda.30.2017.09.28.10.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 10:18:09 -0700 (PDT)
Subject: Re: [PATCH] doc: correct command formatting
To:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
References: <20170928140648.GC9439@dinwoodie.org>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <70decbc2-093c-9f9a-3661-ee6500cec641@gmail.com>
Date:   Thu, 28 Sep 2017 19:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170928140648.GC9439@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.09.2017 um 16:06 schrieb Adam Dinwoodie:
> Leaving spaces around the `-delimeters for commands means asciidoc fails
> to parse them as the start of a literal string.  Remove an extraneous
> space that is causing a literal to not be formatted as such.
> 
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 6e3a6767e..98b9b46b9 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -75,7 +75,7 @@ example the following invocations are equivalent:
>  Note that omitting the `=` in `git -c foo.bar ...` is allowed and sets
>  `foo.bar` to the boolean true value (just like `[foo]bar` would in a
>  config file). Including the equals but with an empty value (like `git -c
> -foo.bar= ...`) sets `foo.bar` to the empty string which ` git config
> +foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>  --bool` will convert to `false`.
>  
>  --exec-path[=<path>]::
> 

+1, Thanks for spotting.

I did a quick

	grep -r " ` "

which came up with with another relevant place:

Documentation/git-format-patch.txt:	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.

But here the space IS relevant but asciidoc does not pick up
the formatting. Perhaps that one could read like this:


	`--subject-prefix` option) has `<SPACE>v<n>` appended to it.  E.g.
