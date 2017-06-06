Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CE220D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 01:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdFFB1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:27:09 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33721 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdFFB1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 21:27:08 -0400
Received: by mail-pg0-f50.google.com with SMTP id f185so27788573pgc.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 18:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kzr5VTfD05bAhHQXLQwZhgBm6+S7x2Uylj8SPGW0c/0=;
        b=S4QCpV7mr8oSC5aq+uYbj7px4kZxj9eXG30VT73/Zgq4IGmbJuljwBS6qFADCCK1jR
         W1XDx5wSoLS5v9Jaev6Lm07sN1fxGh7Tx0ispo8Vs5CYmoWDijRbEmJriUu+gtJ2Ip5c
         PgyLrdPJoYKaIFvn7LdCHu0oe8iM3X4bZ60LpQt5dfeybY7/DEh3vM1/fW6aBkjj2iZx
         uZXzGBJqK1rTki9LAqQVIR2e5IYgRmH1JMQ3XHXOsE/GEg4zel5SGusNI3bFpXcN4OcK
         Q9amnRjAUTm4/GIGXmQcD9HW5dUAxKr0aTk/gNIvIJ5AdSmXFEvPh/6F0sTbYeXc3YYK
         cesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kzr5VTfD05bAhHQXLQwZhgBm6+S7x2Uylj8SPGW0c/0=;
        b=l8iAS/JkyxeqbJ54g4F4G3iAWyhVhRkf66ZgSlRn7DoaH+dB25AIJTAHrq7c5SwtQE
         UFKB7KU2Q4oPhvHdo7aeSxQ0JgjKwi4p3GX3Nro28rjeX0vD7pu0sPvhVSjf+etPJIF4
         RQDyjpRJB/NYy1vePXeT5h91D/uzpr/GxalbmicCeTSdmNzoKEEwlbLu7qleN6e8CSXg
         /XyqjCcCAZvnUrYA6K+938D9QHR0fZ408VyW/Jc6Kpfsiopbzxxyegt6nccLFZn42V1I
         j28uY/KW3YViIgDM79EX7SSRkyFz8UL2NG1PZzIc3S9Oi5j+uBgS6zaQeQiUZCicSBNk
         4aHQ==
X-Gm-Message-State: AODbwcBba+nxPvYvFW0u4Ndywgkc4Ql24ISkfegfNBWrVgU46mNe2X5s
        uW3qEbDFsl1g+w==
X-Received: by 10.98.13.138 with SMTP id 10mr2148762pfn.218.1496712427537;
        Mon, 05 Jun 2017 18:27:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:5d03:f5d1:882a:10e])
        by smtp.gmail.com with ESMTPSA id q135sm74557533pgq.41.2017.06.05.18.27.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 18:27:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t3200: add test for single parameter passed to -m option
References: <0102015c7a68c647-372a5a13-5412-4838-921d-66980bac4099-000000@eu-west-1.amazonses.com>
Date:   Tue, 06 Jun 2017 10:27:06 +0900
In-Reply-To: <0102015c7a68c647-372a5a13-5412-4838-921d-66980bac4099-000000@eu-west-1.amazonses.com>
        (Sahil Dua's message of "Mon, 5 Jun 2017 22:38:25 +0000")
Message-ID: <xmqqzidl9a8l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> Adds a test for the case when only one parameter is passed to '-m'
> (move/rename) option.
>
> For example - if 'git branch -m bbb' is run, it should rename the
> currently checked out branch to bbb. There was no test for this
> particular case with only one parameter for -m option. However,
> there's one similar test case for -M option.
>
> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> ---
>  t/t3200-branch.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index fe62e7c775da6..7504f14bc52f8 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -100,6 +100,14 @@ test_expect_success 'git branch -m n/n n should work' '
>  	git reflog exists refs/heads/n
>  '
>  
> +test_expect_success 'git branch -m bbb should rename checked out branch' '
> +	test_when_finished git branch -d bbb &&
> +	test_when_finished git checkout master &&
> +	git checkout -b aaa &&
> +	git branch -m bbb &&
> +	git reflog exists refs/heads/bbb
> +'

Looks almost good.  Don't we want to also make sure that HEAD points
at bbb branch, e.g.

	git symbolic-ref HEAD >actual &&
	echo refs/heads/bbb >expect &&
	test_cmp expect actual &&

after the "do we have reflog for the bbb branch?" test?

Also, I suspect that we care about the reflog that is moved to 'bbb'
retains entries created for 'aaa'.  So perhaps "reflog exists" needs
to be replaced by something like

	git checkout -b aaa &&
	git commit --allow-empty -m "a new commit" &&
	git rev-parse aaa@{1} >expect &&
	git branch -m bbb &&
	# the topmost entry is about branch creation
	git rev-parse bbb@{2} >actual

no?

>  test_expect_success 'git branch -m o/o o should fail when o/p exists' '
>  	git branch o/o &&
>  	git branch o/p &&
>
> --
> https://github.com/git/git/pull/371
