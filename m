Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5FD1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeBISUb (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:20:31 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38702 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBISUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:20:30 -0500
Received: by mail-wr0-f196.google.com with SMTP id t94so9142292wrc.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FEisuEGWQChPpWBajsv7s0NDT2IlT9ksyeJsTBDQCvg=;
        b=rclVx+JeYUKzRGvkDdl9WuEZNWBE80r5HXHyp2m1eD2G1hJ6oGIUwqHKrgBxj31Yt6
         Wqd7vRuh4/tXv35WZg9ybz83nh2moW+6H6OUzinKYqufzU775kNVuIV9ZBWmdBF03wpO
         uxwQ4iDk143mc2nxoUcke3yBQmWi2ZSEcW1nmx5sgmwJTy60/ybf3DH8Q+6XxhhU6Skn
         cTb7tedOiDAPVFL1hCLdeQYSBMOdQGrIAREVxy4q2uuddtcjez0Hs7r/LmbWpufI5nco
         xArkNV7N7QH6HpzDseF5U0wfow8jFPYnpciZZxm8IzkF1AaL44J4FjTDCTcoQqGsGkG6
         n3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FEisuEGWQChPpWBajsv7s0NDT2IlT9ksyeJsTBDQCvg=;
        b=ZIEEt6iYfNa6HpG12iaScI3haG/zJqS2d+pt5ni2MASW99DgQOeiiCeyTJ83XQLXQW
         r1dJI9Kc3JAVeXXGXItQn0l4uHZpkLxrx4og+qpbbTp74wJX8q8EYFkDe+UPyOnhdJc1
         0EGGFQCHOe0xmAysJywK1e335gtxLCWUJndVna0xIPEvdPE+OVPqbR6W6i8r/igIEDrW
         cNx9RPYYg7o1dmk65MiSNEEjxfRLamYyqJe89BCDiR/TC+sFTb3kktkIs78rNMilRD6i
         kvC9FZr6sCSPTYAY8C8OrfpUG1hL6Ts0TCF7HuTZ8TqcbBkpNAFUma6+olSOrNR6Crcd
         YxrQ==
X-Gm-Message-State: APf1xPDWJFILZtkO3goMY3/k5cV4fXzHKOanw8rR20WpqLeGZGwZOaWs
        n9ISiRZyL1l9Upv6bcWiogU=
X-Google-Smtp-Source: AH8x224dmy/eAeG6S1Gd5CH7EtDWD+aSJXpiw8iSS5CIFIxDSGihGV71t4Ls1t46d7IjhIlnWOzPNw==
X-Received: by 10.223.185.34 with SMTP id k31mr2958640wrf.245.1518200428964;
        Fri, 09 Feb 2018 10:20:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x91sm4846603wrb.77.2018.02.09.10.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 10:20:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, bmwill@google.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        worldhello.net@gmail.com, j6t@kdbg.org, sunshine@sunshineco.com,
        pclouds@gmail.com
Subject: Re: [PATCH 1/1] Mark messages for translations
References: <20180209074404.2902-1-ash@kambanaria.org>
        <20180206073812.GA14133@sigill.intra.peff.net>
        <20180209074404.2902-2-ash@kambanaria.org>
Date:   Fri, 09 Feb 2018 10:20:27 -0800
In-Reply-To: <20180209074404.2902-2-ash@kambanaria.org> (Alexander Shopov's
        message of "Fri, 9 Feb 2018 08:44:04 +0100")
Message-ID: <xmqqlgg2xbx0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Shopov <ash@kambanaria.org> writes:

> Small changes in messages to fit the style and typography of rest
> Reuse already translated messages if possible
> Do not translate messages aimed at developers of git
> Fix unit tests depending on the original string
> Use `test_i18ngrep` for tests with translatable strings
> Change and verifyrest of tests via `make GETTEXT_POISON=1 test`

Perhaps end each sentence with a full-stop?

> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 9670e8cbe..797dcf95b 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -31,7 +31,7 @@ test_expect_success 'bad setup: invalid .git file format' '
>  		echo "git rev-parse accepted an invalid .git file"
>  		false
>  	fi &&
> -	if ! grep "Invalid gitfile format" .err
> +	if ! test_i18ngrep "invalid gitfile format" .err

Shouldn't this rather be like so instead?

	if test_i18ngrep ! "invalid gitfile format" .err

Ditto for the other negated use of test_i18ngrep we see in the same
file in this patch.
