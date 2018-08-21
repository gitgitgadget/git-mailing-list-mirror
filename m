Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3871F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeHUXAI (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:00:08 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39934 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeHUXAI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:00:08 -0400
Received: by mail-qk0-f193.google.com with SMTP id b19-v6so5266178qkc.6
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=e9gHx03dCimSpDZPQaLFnJ5R3u1GZJgjvLzhoD/4T48=;
        b=MxBfRBW/+pW7adndMzfXH/KUf+kcCjxHgRiUNXW5znlWmGsCLjmh138bc8ERr2FXl9
         fcumSr6O5tMOdqo17CfZcIMZa0Aq/uEmj8O7y5Jiz+PT+mNSMX7xgBK3GLSDZYS3aycK
         DaKfLeREXQdZwFH10DQ6INb8XEzh22CNfGomS4BufpxfKELwzyeOrI6tqbb3MaaYIPDT
         RTldRqojquAMqCltr71SwgG+BJ6ZDloMFY+1kVjtnlDEQrZDXBxG3NfJVmLosIAhsGKd
         /VCRDbNZ7y2S25v+I832mPWIJrXsWnIL0w8uGTpkJerolLglKEuJ3AjME6n9lamXnxFl
         35AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=e9gHx03dCimSpDZPQaLFnJ5R3u1GZJgjvLzhoD/4T48=;
        b=juCNtEFMB05fJj8QKYYjW/62lPsBtNWsrLNGdUno62KrAIes3N0hSj+HqR5/jHuzhB
         Y36Mo8J9IEeqZY9Q1befad5+7Wk7pRi+WUECux1zF4bFNh6FHxTvoOiLWkpmsLRnrFB0
         kExtCbHO8+QFKGsU1f9W3TjmxsZVOoOQeF3AqHLjIEwmTN11wBIwEn8A3BoZDdTjEBlH
         1jtkVawSu+z0vklQ/OKhFl34jdg5RKHmbQQKwq1JEIIQZPqGZE9uaTZiZkj3iPk4aGPo
         dDYb81DChBhbecXy92qNOnnZ6Qs4tRAc0LdJ7arP3ep/1w4aF2Etl0F++W/oaioDT7iv
         k+uQ==
X-Gm-Message-State: APzg51DbHu26ixcTPF3Uf+v/8sCE3/D2s9n1IJJIWJHQaNuFei81/eQL
        Fwb9AjF7P6vzWI5LzDC1zfViJ92f
X-Google-Smtp-Source: ANB0VdZbTHtzKxbqY/z06gIKCBl9pAYPJkDzQPgdwNk/XsgeAXngg19uIHBaEgsFDzJEu5+ae5dbgA==
X-Received: by 2002:ae9:ef13:: with SMTP id d19-v6mr10795088qkg.152.1534880319114;
        Tue, 21 Aug 2018 12:38:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id v7-v6sm9392068qkg.90.2018.08.21.12.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:38:38 -0700 (PDT)
Subject: Re: [PATCH] SubmittingPatches: mention doc-diff
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20180821192321.GA720@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2d03be9e-fa89-f740-0c50-3c2d93a29b09@gmail.com>
Date:   Tue, 21 Aug 2018 15:38:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180821192321.GA720@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 3:23 PM, Jeff King wrote:
> We already advise people to make sure their documentation
> formats correctly. Let's point them at the doc-diff script,
> which can help with that.
>
> Let's also put a brief note in the script about its purpose,
> since that otherwise can only be found in the original
> commit message. Along with the existing -h/usage text,
> that's hopefully enough for developers to make use of it.

This is helpful, thanks!

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just a finishing touch on the jk/diff-rendered-docs topic.
>
>   Documentation/SubmittingPatches | 4 +++-
>   Documentation/doc-diff          | 8 ++++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index b44fd51f27..ec8b205145 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -80,7 +80,9 @@ GitHub-Travis CI hints section for details.
>   
>   Do not forget to update the documentation to describe the updated
>   behavior and make sure that the resulting documentation set formats
> -well. It is currently a liberal mixture of US and UK English norms for
> +well (try the Documentation/doc-diff script).
> +
> +We currently have a liberal mixture of US and UK English norms for
>   spelling and grammar, which is somewhat unfortunate.  A huge patch that
>   touches the files all over the place only to correct the inconsistency
>   is not welcome, though.  Potential clashes with other changes that can
> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> index f483fe427c..6e285e648c 100755
> --- a/Documentation/doc-diff
> +++ b/Documentation/doc-diff
> @@ -1,4 +1,12 @@
>   #!/bin/sh
> +#
> +# Build two documentation trees and diff the resulting formatted output.
> +# Compared to a source diff, this can reveal mistakes in the formatting.
> +# For example:
> +#
> +#   ./doc-diff origin/master HEAD
> +#
> +# would show the differences introduced by a branch based on master.
>   
>   OPTIONS_SPEC="\
>   doc-diff [options] <from> <to> [-- <diff-options>]
