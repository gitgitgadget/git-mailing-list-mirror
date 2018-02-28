Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE701F404
	for <e@80x24.org>; Wed, 28 Feb 2018 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeB1Phz (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 10:37:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52562 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeB1Phx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 10:37:53 -0500
Received: by mail-wm0-f65.google.com with SMTP id t3so5810347wmc.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nCaBjhCvVdN0liZD4Cp/3dM92xwpJ8JIIlSLfqNWHk4=;
        b=Kk3dfg8x6bjHd1xnM9f+ovoK2OTmI/+uPho/1/4Ce28eM+GPhwov/pgs5ZSMbktKUx
         sBtKMy68+18YRvQJ5RaQMWywbJuw2XbTuwsxZb2RrlpyGyMWiktfg4kbdXTIy7YVSdzY
         EtvOdvtv9xZzllVxIKp/zaUw5VvBcgSNrVKF2gPBf+XIDKXlshVaGHsMCFEXL/+lr7rW
         gOowGjJItKEqu1ijDefdeDIU4qaZyhIUgBP81HNEAyTy/uHBf8hTgGW8BMHTtX3CEmZh
         ETl0Njbn6uGvgfYB4R4GgosKAZD3g5movAjokrJFkgCypB8xauiUdt5gq1GdPZVGohd0
         AkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nCaBjhCvVdN0liZD4Cp/3dM92xwpJ8JIIlSLfqNWHk4=;
        b=Eb5JOL27dnmdBRcbuaSo7EZl2QlfnOro/jVboaluFJoSB9poBAHqd7JeqRQ7er0xef
         8OcM2R/u3tYiswdTv7fHFb1qWTD4RuTRkOxvzttb48959qWwwnH9fYYqT4r5KwyZRETY
         PryBd3TRU5I4Ovr80FKzLm4yYGrszDizTZoxL7SEpgh8rNmvBbVOsM+FuU240BVbM9Xc
         JwApnVkVnIr+XzGt+LOEeig33XlnwEOwOx4iR6oQtzpuPDinwjioXo5JolIqESqFYkpV
         YoAQtaDkfSo9hIaV9Bk9MW5v2DeX4Iv5joiA1fpXz7NGHiwnyl+bx1EtoTvKD9BSVjjX
         CH+A==
X-Gm-Message-State: APf1xPD9HEOnqnn8OgLWQwOBJczLMpIjxe3nSltBI1pK1u2lhC0MwXd8
        LGl9kM64WMHlopwd2a28npq+z8C0
X-Google-Smtp-Source: AG47ELvOQ0d7HcJq0I/29PpcZhs2zUotHRV4BHs1bjyflrprtut1W4pH+j1UKgjrP8sP623fNdCfIg==
X-Received: by 10.28.231.6 with SMTP id e6mr15693464wmh.51.1519832271258;
        Wed, 28 Feb 2018 07:37:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w134sm2054274wmd.45.2018.02.28.07.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 07:37:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/9] t3701: indent here documents
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180227110404.16816-1-phillip.wood@talktalk.net>
        <20180227110404.16816-3-phillip.wood@talktalk.net>
        <xmqqo9kanjrk.fsf@gitster-ct.c.googlers.com>
        <12a03e03-640e-90c8-0ac8-14807a1834c9@talktalk.net>
Date:   Wed, 28 Feb 2018 07:37:50 -0800
In-Reply-To: <12a03e03-640e-90c8-0ac8-14807a1834c9@talktalk.net> (Phillip
        Wood's message of "Wed, 28 Feb 2018 11:00:21 +0000")
Message-ID: <xmqqsh9lm8fl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Is there an easy way for contributors to compare the branch they post to
> what ends up it pu?

Distributed work is pretty much symmetric, so it can be done the
same way as one would review a rerolled series by another co-worker.

 $ git log --oneline --first-parent origin/master..origin/pu

would show merges of topic branches, so you can find the tip of the
topic of your earlier submission (it would be one $commit^2; call
that $topic).  origin/master..$topic would be the one branch
(i.e. what is in 'pu') to be compared.

The other branch to be compared is what you sent the previous one
out of, or the new version of the patches.

To compare two branches, git://github.com/trast/tbdiff is one of the
easier way.  

Before I learned about the tool, I used to "format-patch --stdout"
on both branches, and ran "diff -u" between them, as a crude measure;
it was more useful for spotting typofixes in the log messages than
code changes, before I got good at reading diff of diffs ;-).

Also, tentatively rebasing the two branches on a common base, and
then doing "git diff $oldtopic~$N $newtopic~$N" or something like
that for varying value of $N (and N==0 is a good way for final
sanity checks).



