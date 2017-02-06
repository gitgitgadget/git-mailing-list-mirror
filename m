Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B6C1FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 05:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdBFFz1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 00:55:27 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33486 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdBFFz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 00:55:26 -0500
Received: by mail-lf0-f67.google.com with SMTP id x1so2984090lff.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 21:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XzOhI/dNLBi8geboYCHEK1us9dOcxl9lmRUyfkDg/ds=;
        b=PPtoSadyIPv8nbS7Up05FtJfsC0VPgyywerYyslvp4H6YMg7EpGQ+d4IBgHtG4GJZf
         izHdOZ0q5p5+8JMtnXPF1/Cg6zvkZ5GPe8XpUN4ogjC+m5xqBqy2J2kV95bXGwSTO+MT
         na7SMSZ1yNz7EhCSFNQROHWuuYJb84Z4uQjxOAr5u9U9N3JwVOnKSPzAMN0dHb5uE/Ia
         6buMi1IEf2a+jy+HIRn0/bDMfN3VFThTjiq5a1jYWjxNjQFwE9sivJnMrMx7dA3vOqdy
         q43FL4c05UKXOpLFzS5fkoEZbWtAGr0UmfhtER2cGWr0Sviqy5C8GvalqJ69P8vwinJ3
         Hw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XzOhI/dNLBi8geboYCHEK1us9dOcxl9lmRUyfkDg/ds=;
        b=HAepfecc48DZc45Xy3J8fDLlrV4XSwWqpF9bYFiTDSu4dqPzpF0+idp7y0p3uCftaN
         d34RZsmS+LWrS5/5AkgEfUneXkqa7UHRD5fYTlPoRavlqPsnO176Ndad6wGxFEAFBxek
         ql+eW7/0tQxqLd/e3/Aotea96G5l+rLZo6TM6NlN6uNIoteeZr/QMEg89pmXpDcE4YbV
         KtRuzM5nDlTeiz1df4pAcRSC6Jc70BeOvQou7JSti4pHp/eMaE24QDJqwj/qZZEWk53C
         AnyEr5eM5teoDOS6zG07xNd2Cn1r8XD9XgZyQXzsnJMTOAKDTkiJfyY8U/Fnkj1wGf8h
         FA9g==
X-Gm-Message-State: AMke39kEtEGmHORP7np0dozxLL+04rSLn0MdA2R0u+jt1u+0X2K3hi/G5n1aY+jzudQUiTYTql6iyD9IixZ8wg==
X-Received: by 10.25.10.6 with SMTP id 6mr3025419lfk.88.1486360524639; Sun, 05
 Feb 2017 21:55:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 5 Feb 2017 21:55:04 -0800 (PST)
In-Reply-To: <CAGZ79kY_1ELUZ2wZwNbQ+HrDnRBM3ngt9HKHKPmvaJEcoAFTtg@mail.gmail.com>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
 <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
 <xmqqr33krtww.fsf@gitster.mtv.corp.google.com> <c872072a-4754-051d-81e7-1e2166560733@benjaminfuchs.de>
 <xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_1ELUZ2wZwNbQ+HrDnRBM3ngt9HKHKPmvaJEcoAFTtg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 5 Feb 2017 21:55:04 -0800
Message-ID: <CA+P7+xp0QJZkiYzgBhPvYPsG7iqRDhRQUjcdgf_GHU-93bSO-g@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-prompt.sh: add submodule indicator
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Benjamin Fuchs <email@benjaminfuchs.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 5, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote:
>
> (unrelated side note:)
> At GitMerge facebook presented their improvements on mercurial
> and one of the things was "hg absorb". It would take the dirty hunks/lines
> of the working tree and amend them into the "stack of commits", i.e. into
> your local unpublished history. So instead of making fixup commits
> and doing the whole interactive rebase thing, it would do it automatically
> for you. I think that is a neat time saver.
>
> Thanks,
> Stefan

How exactly was it different from doing "git  commit --fixup xyz" and
"git rebase -i --autosquash"? Like, what was the advantage to the user
facing workflow? Just curious to see if we could learn something from
it.

Regards,
Jake
