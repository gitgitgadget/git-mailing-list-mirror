Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0823C20248
	for <e@80x24.org>; Thu,  7 Mar 2019 06:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfCGG5B (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 01:57:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40646 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGG5B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 01:57:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id y6so911045wrn.7
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 22:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VIqDcyQdLe8I9RXi8VdNNB/iDcB0u0nBidc7SoPnOkU=;
        b=Cp7wdHBd3FvL+UF0UShEA7ExBJipsK+yh1ycXJytM/zv8EctkjfdYjsMjql8kMrMDe
         UEo9uTb72JzwtgujjXb8xPz7CWOvoF956SYnpIjpOinvr22Q9A74smQvoSxSKKmnE4lM
         RmuWo8OVyfp4bYOeQpSbTyliw3F94//gfjygyfokUE4dAQq99hQH2cRdL92yxgfmTuTM
         P4GtsPwVLi3vnXVJhf2/eeT+Kp0lHkPEa7GJ8fRc8HCCSOnl3JvMwWWBleemrpAlqQK8
         qO6lSh9FSYT8tJamTvBNCL9fB+DpiAQXCn/GaKQaDNuJCuYYVBaAADnQ1qtRYmOaeGd5
         G4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VIqDcyQdLe8I9RXi8VdNNB/iDcB0u0nBidc7SoPnOkU=;
        b=YO8jhVPNFVQm+WFDbgOyGRA6Oq6Ud4RSwehfVPHPaVzPFI7nPYP2DvL/OZ1ddGtPEF
         hYdMb8gZfhnTsy1dVKoBC9wR3nPgCNotZO4RrD7sSVwl/mkMLAMjV1mpu10qFh5H5UCW
         a0YSuve2ILVwWrzQHnjNuNjcTAgFwc6aqKZBy8Y1jL385MDWgPmIy2bLNyo0rbN8iOJl
         VAIuYk4usRQd7Jzr0CA3VlKAf/61E2s4UDaBemlefTk7l4SHko4kYqew5pZXKVXiHkGj
         d+iCA3/ykrdYYYUDTf1lZ2lLMrfFc0RQJiUuan322uuWYsfJHAnmzxTuVut6JLrx2LKa
         THWw==
X-Gm-Message-State: APjAAAUds0lfZBtUNxn8jpaOn/vADNZUuxCRt345EIYnk3ZH9oQlPS78
        +i5H0Fd0jx+PSbpRPGVgwHg=
X-Google-Smtp-Source: APXvYqwKeTwmDlEN08+k+eWK6Sfj26AjOFnAVLcvz9BEQXpBRghxjtHm1Ca8vbKkOX3Za8fgZZaAAQ==
X-Received: by 2002:a05:6000:10c9:: with SMTP id b9mr5453077wrx.281.1551941819205;
        Wed, 06 Mar 2019 22:56:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1sm5127496wrq.96.2019.03.06.22.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 22:56:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/1] git-clean.txt: clarify ignore pattern files
References: <cover.1551868745.git.liu.denton@gmail.com>
        <cover.1551938421.git.liu.denton@gmail.com>
        <2eda83517ebad39e14dca9d86b9dc2e0d32e37ef.1551938421.git.liu.denton@gmail.com>
Date:   Thu, 07 Mar 2019 15:56:57 +0900
In-Reply-To: <2eda83517ebad39e14dca9d86b9dc2e0d32e37ef.1551938421.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 6 Mar 2019 22:05:01 -0800")
Message-ID: <xmqqlg1rmati.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>  -e <pattern>::
>  --exclude=<pattern>::
> -	In addition to those found in .gitignore (per directory) and
> -	$GIT_DIR/info/exclude, also consider these patterns to be in the
> -	set of the ignore rules in effect.
> +	Use the exclude pattern in addition to those found in
> +	`.gitignore` and similar files (see linkgit:gitignore[5]).
>  
>  -x::
> -	Don't use the standard ignore rules read from .gitignore (per
> -	directory) and $GIT_DIR/info/exclude, but do still use the ignore
> +	Don't use the standard ignore rules read from `.gitignore` and
> +	similar files (see linkgit:gitignore[5]), but do still use the ignore
>  	rules given with `-e` options.  This allows removing all untracked
>  	files, including build products.  This can be used (possibly in
>  	conjunction with 'git reset') to create a pristine

I do agree with the direction to abandon the attempt to be
exhaustive, which has failed us and will fail.  I am not sure if
".gitignore and similar files" is a good phrasing, though.

    Don't use the standard ignored rules (see linkgit:gitignore[5]),
    but use the ignore rules given with `-e` options from the
    command line.

perhaps?  I dunno.

A related tangent.

"git add --help" also has this bit.

    CONFIGURATION
    -------------

    The optional configuration variable `core.excludesFile` indicates a path to a
    file containing patterns of file names to exclude from git-add, similar to
    $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
    those in info/exclude.  See linkgit:gitignore[5].

I do not think the omission of per-directory .gitignore from this
description is because the description predates the feature (which
is the reason why "git clean" doc does not mention, by the way), but
this probably needs a simliar treatment.

Or perhaps this configuration section should just be removed (or
moved to gitignore(5)), as it is not specific to "git add".
