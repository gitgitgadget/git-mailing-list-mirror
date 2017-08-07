Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE832047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdHGOeS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:34:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37679 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdHGOeR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:34:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id 83so539240pgb.4
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=ZD15KVy9CyhDQ04b0ZO+dSc8+q1tvgjFYDoiNhi/tAc=;
        b=r09fhVhT84eHB1WwftO8fmenjHb18JbPUDIEe+zJL6n4lXHNLMwS1356WIPUYkQeq4
         icdZ/j4zZng0/2E+9CIfaRx+a/8azki2/LLWh9ygAiWq9W1pSlnsKsobDkl1QAQ9Ynkp
         9b6an0XFxUjHZHfPQlVvn8aaXO9R+Gl+2Wcyb0x6X5qxGIjE/koqZfDx7oL0t5efMApq
         WTdefbUHS+7ZjFz0BW6V7nOeETwU4yfvKj83vrYdbGMC7g9XBivXrvKq75xSsJJw2gB2
         gHLNT/7Rvm3p2bkjj4jhYcxqTK1WoH8/+U7eeyQ9e1RAIb1D/7gjHUT1Qjm7FA+w8nBy
         HkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=ZD15KVy9CyhDQ04b0ZO+dSc8+q1tvgjFYDoiNhi/tAc=;
        b=Nd5tTBL0JSEFwqBXNYqn0rtaTobjFfTMHsW09vFsiLXQDsIAQExAYhSvDqnirVD5dH
         Wh+hc0PM3GDEw8+qm40jzNJoNr/qIFreAbKEkAbmM01+62SJUylFkAqgGf7qioKtMMtO
         8GKCT1ICmdU3eanu268iwNTg4F2WIE+uBB6YfGaCv5lp4dO4WSvR2IoHzpD0an3EAgnx
         dFNJJI9hBk/g4J8EJqVK6UyVghQANv4T+lHwCdcGWhMMYEt9FnBSdoPipH/jkB2m6cP8
         UPdB7zAbOagsX3hpGbMV2EYQM+Q1MZvU9NppvRT70xvB+Xh2HCF4P/1DyW622V2k6W10
         shbA==
X-Gm-Message-State: AHYfb5h1BNxondJkG+3hHcOvZorKtoxQNPfr17JMXM2nSX9GwDmpq48+
        un9Jw3AfsahR0w==
X-Received: by 10.99.4.3 with SMTP id 3mr761703pge.102.1502116456477;
        Mon, 07 Aug 2017 07:34:16 -0700 (PDT)
Received: from unique-pc ([117.249.143.188])
        by smtp.googlemail.com with ESMTPSA id m2sm12986220pgs.72.2017.08.07.07.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Aug 2017 07:34:15 -0700 (PDT)
Message-ID: <1502116490.3172.6.camel@gmail.com>
Subject: Re: [PATCH 2/2] doc: add another way to identify if a patch has
 been merged
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kYArf6R-vx1-Lm4X_ANLMrXc3VNd2aCQMnqq3J6y-s31Q@mail.gmail.com>
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
         <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
         <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
         <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
         <1501677122.1957.8.camel@gmail.com>
         <xmqqini6dkmu.fsf@gitster.mtv.corp.google.com>
         <xmqq60e6djcu.fsf@gitster.mtv.corp.google.com>
         <CAGZ79kYArf6R-vx1-Lm4X_ANLMrXc3VNd2aCQMnqq3J6y-s31Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 07 Aug 2017 20:04:50 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-08-02 at 10:58 -0700, Stefan Beller wrote:
>     That may be either a contributors problem (lacking time or
>     motivation to go through a long document) or a problem with
>     the community.
> 
I'm trying to avoid the former.

> I would not want to explain the same thing over and over again,
> but rather have a technical solution that explains the problem and
> solution once it is detected.
> 
> Coming up with a technical solution for each little quirk
> is not the hard part (e.g. grep for the sign off string, count lines of
> the commit message), but rather to put it in place. (How can I make
> sure that contributors run these small checker scripts?
> Currently I cannot.)
> 
I could see quite some alternatives for this.

1. scripts

    I guess the kernel community use some scripts to check if the patch
    has the required style.[ref 1][ref 2]. I guess we could do something
    similar. Like writing a script that checks the log messages for the
    required format (sign-off, area etc.) and giving users advice about
    how to fix the issue. After a all script test pass we could give
    some advice to the user about how the patch needs to be sent.

    To identify the set of commit messages that need to be checked we
    could make the script accept a single parameter that specifies the
    base of the branch. I'm not sure if this part could be automated.

2. Hooks

    warning: this might be a little over thought.

    1. Code all the checks as 'hooks scripts' that aren't samples.
    Possibly scripts related to 'commit-msg'.

    2. Place them in a 'hooks' directory under a new directory, possibly
    named 'hook-checks'.

    3. Inform the new contributor to re-initialize his git.git with

            $ git init --template=/path/to/git/hook-checks

    4. Rebasing their commits with 'rewording' each

    Of course, this relies on the fact that he wouldn't have enabled
    hooks in their git.git. In which case he would have to merge the
    scripts with his own scripts.

I'm not pretty sure if they're feasible or not.

-- 
Kaartic
