Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F231F45F
	for <e@80x24.org>; Sun,  5 May 2019 20:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEEUO5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 16:14:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37114 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEEUO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 16:14:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so4476946wrn.4
        for <git@vger.kernel.org>; Sun, 05 May 2019 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v+Qqj+wv5FTwkqTFf3esSE6q/jToH61N54XKh/qy4+8=;
        b=jls4mvghRK0Q+TuXJ+WvHmYGGdNAlkTPWD2HJvZ00ziyl7siugrNFV2sW4yMzxBKCs
         /xwi6+YOEACQuWK7QoI6RVniWJQRNi4mRuzp30QhS6XYMwqauFL+OY2VUK6iWB/gvzR6
         tm58xqtFx70cMM5tmzPE07llup3BVzsCoxMdy9ZsiFmCoSA1SBHn5Z6NRTCvN5/xeApS
         26SbkyWA1xgdm5j+vQoPmlrN1SjZLbxYqsEfc7VSusUBmhzIN2arf1fCApj8TuUblYX/
         lmeF0YFWqqJKmpNgzYY621Uw702OkotxqbBwnci0tbBeBXB84hR8bN3FCIKTP0oy5Smi
         jQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+Qqj+wv5FTwkqTFf3esSE6q/jToH61N54XKh/qy4+8=;
        b=o7DplnrH+muD0m6KUB4vFZrdU4Mwgz61KOOjmPM3wX6pmsf1QK/WzCnruvACi/rBMZ
         vGQNXrsgiOkVVafGNQWpEOROzcm27uauKM2Aqcp6PHnUwdIqVD0Iq8WYkTExoai4hBN4
         pzgWJy8ziJH8LjssNuJxBBTrkc150Fxw1pA5p0QR38WE9h85Fq+6UraWuf4uerPU0uNJ
         iBgjigdt+oM/xQm37IBh/uTUDKXLTLfOkBngi93kFCm7yC7FbDA+3lyzLDaIWseizmd+
         9Hgq7BKYtbSVLPRVuLpwIOJRBU0+4JbvE6tTSq4C4iRVNsUqNJxIpAZctzoQ5ySO0lK2
         0oSQ==
X-Gm-Message-State: APjAAAVEH7J8r8cRhkeKT3awx5EZao7A1Qss6yGXpJk6nr4Pwf70+XsB
        8EQgKHPlzgRvdpytS17mA98=
X-Google-Smtp-Source: APXvYqzG9BB0nOVE7a62zUm1mi/cTNniYSh1R4laS0mnxuPI0++ehsiDCG0d39y1feN/5pkZdzJbow==
X-Received: by 2002:a5d:4ec9:: with SMTP id s9mr15090499wrv.223.1557087295634;
        Sun, 05 May 2019 13:14:55 -0700 (PDT)
Received: from szeder.dev (x4d0c1fd3.dyn.telefonica.de. [77.12.31.211])
        by smtp.gmail.com with ESMTPSA id z74sm19353257wmc.2.2019.05.05.13.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 13:14:54 -0700 (PDT)
Date:   Sun, 5 May 2019 22:14:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git build on antique PowerMac
Message-ID: <20190505201452.GL14763@szeder.dev>
References: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 05, 2019 at 03:42:45PM -0400, Jeffrey Walton wrote:
> I have a PowerMac I use for testing. It provides several testing
> differentiators, like OS X 10.5, Bash 3.2, GCC 4.0.1, Apple cc-tools
> linker, and big-endian PowerPC. (I think Gentoo provides a Linux image
> for the hardware, but I don't use it).
> 
> The Git libraries and programs build fine out of the box. They also
> seem to work as expected once installed.
> 
> The pain point is the self self tests, which I have never been able to
> build (or execute). I'd like to close this gap.
> 
> make -C templates  SHELL_PATH='/bin/sh' PERL_PATH='/usr/bin/perl'
> : no custom templates yet
> make -C t/ all
> rm -f -r 'test-results'
> readline() on unopened filehandle       test_must_fail
> run_sub_test_lib_test  at check-non-portable-shell.pl line 34.
> Modification of a read-only value attempted at
> check-non-portable-shell.pl line 34.
> make[1]: *** [test-lint-shell-syntax] Error 255

You could try:

  make -C t all TEST_LINT=

That error comes from one of the "lint" targets that are supposed to
catch some common errors that we repeatedly made in our tests.  This
linter is enabled by default, but this command disables it.

Yeah, it's not the proper solution, but I would think that you don't
need them on that antique PowerMac anyway.

