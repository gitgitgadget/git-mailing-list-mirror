Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6084820281
	for <e@80x24.org>; Tue, 19 Sep 2017 02:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdISCeP (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 22:34:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38581 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdISCeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 22:34:14 -0400
Received: by mail-pg0-f65.google.com with SMTP id m30so1240414pgn.5
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/Fh6AxRnIk0MKDl2jpeXg5Ltib7J2zfJeeEnlru5ooE=;
        b=FAaXiV+BKNIEb95N+hD9qemumN1AD6BQPSFhi3EwIEIlIKKNDx9GSFhIcDL3uKsUrD
         rxELR1BEp4fG3mNqvMLCcnykJOeA9t00NNSc0VoPL/L47UfciA1equoK56ESJWaW8Hp2
         jiZSo+alyDXxtRK55q/BVtWv8Cxtyxhvs3FrKO3UY3lTZXwebN3wB+2+es8YKDQ8huV+
         Qo9tl9wzMJJO6dfgDAJgfm680G+GLeiB+bEuEBtRX0oNqJEkhiQ1sMnkQfFAzSW4omEn
         xq9IbKDlW/8U8eY8Ec8JoJU7ynfPcpZOuoRmMa3sZ2DZ/LvUDWXPSjX8z+QLpQ7zWo03
         8j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/Fh6AxRnIk0MKDl2jpeXg5Ltib7J2zfJeeEnlru5ooE=;
        b=nTY9XngiVX/H8y6TLi48rg3aSoWSf5RBHwoBRIQwGX/Jv15g+EgRs5Pfuku4LiKY2q
         GHBfCNsRYOWOiRuA2qoZNBptER9J2J6KwlOGrwigPs2xdhjOEeBlnSDGdQWsU9c9/2BJ
         lt0ZDZeH8PmU4ReDBIL3muiwQLwd3ZLaNA9PygC8tiUioR4FrWx8ZU4PSXWbYlHX25Ok
         VXlIwHrctz+ZYr1vz6nAtEvX2L+dIrs2edTWlYwa0kndlH5kx57CQC2hoRZ4MmUDtseC
         lhkEFcam+dAJcK2KgOhnKr5YuyFOH1x1EFN5klaFZBxbWHlXWFx0a4tdH9mN5KOcmQpY
         43oA==
X-Gm-Message-State: AHPjjUh99IAj1iIK1F1agWuTLFgHJNdpgZQK3XhRzsdeanx/R+rQ9J/i
        2pYJstzgAWLG9w==
X-Google-Smtp-Source: AOwi7QAdqtdqRbudek7DGwX4hTyNBTX6xQ3qvzU1LkVBpAcu4EaS6P6B6u7GqbN406rYuMgoGXzw5A==
X-Received: by 10.84.216.69 with SMTP id f5mr596155plj.118.1505788453817;
        Mon, 18 Sep 2017 19:34:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id z69sm848578pfl.86.2017.09.18.19.34.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 19:34:12 -0700 (PDT)
Date:   Mon, 18 Sep 2017 19:33:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: rev-parse: add --is-shallow-repository
Message-ID: <20170919023349.GA175206@aiede.mtv.corp.google.com>
References: <20170918170429.8328-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170918170429.8328-1-oystwa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Øystein Walle wrote:

> Running `git fetch --unshallow` on a repo that is not in fact shallow
> produces a fatal error message.

Hm, can you say more about the context?  From a certain point of view,
it might make sense for that command to succeed instead: if the repo
is already unshallow, then why should't "fetch --unshallow" complain
instead of declaring victory?

>                                 Add a helper to rev-parse that scripters
> can use to determine whether a repo is shallow or not.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
>  Documentation/git-rev-parse.txt |  3 +++
>  builtin/rev-parse.c             |  5 +++++
>  t/t1500-rev-parse.sh            | 15 +++++++++++++++
>  3 files changed, 23 insertions(+)

Regardless, this new rev-parse --is-shallow helper looks like a good
feature.

[...]
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -868,6 +868,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  						: "false");
>  				continue;
>  			}
> +			if (!strcmp(arg, "--is-shallow-repository")) {
> +				printf("%s\n", is_repository_shallow() ? "true"
> +						: "false");
> +				continue;
> +			}

The implementation is straightforward and correct.

[...]
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh

Thanks for writing tests. \o/

> @@ -116,6 +116,21 @@ test_expect_success 'git-path inside sub-dir' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git-path shallow repository' '

What does git-path mean here?  I wonder if it's a copy/paste error.
Did you mean something like

 test_expect_success 'rev-parse --is-shallow-repository in shallow repo' '

?

> +	test_commit test_commit &&
> +	echo true >expect &&
> +	git clone --depth 1 --no-local . shallow &&
> +	test_when_finished "rm -rf shallow" &&
> +	git -C shallow rev-parse --is-shallow-repository >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git-path notshallow repository' '

Likewise: should this be

 test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '

?

> +	echo false >expect &&
> +	git rev-parse --is-shallow-repository >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'showing the superproject correctly' '

With the two tweaks mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
