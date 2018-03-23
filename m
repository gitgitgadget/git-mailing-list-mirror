Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472FE1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeCWWzF (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:55:05 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33768 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCWWzE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:55:04 -0400
Received: by mail-lf0-f68.google.com with SMTP id x205-v6so20498222lfa.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dtJ4zim0pwcU6VhyJZ3l3/j50NdRDpKKo20iJrM5QiQ=;
        b=dPrjKF3+5VjA4KnQrk/BL7Vco5Ho7A8llSuGwtQbqlUVJO4X6wW23X7NBPYaReFHYr
         HUcUURfysOoSbha2zntfx1MDFnosvIhpvzWB9nzct1TFk3U6NJywYWIcfYWQCy6mACEx
         kgOYhaKPzGErgRpsGkLq5Gw+jEeReAFFjM4/EMRmuvGuzOTzyxIOpC1xDneS8RCdl9zz
         1b6ZJFuiUW2GzgjmbPfTnBbadsEQXjsFwYv8rVd3fhYSQQ0MCbHkMY9yc8kIurSOk/pP
         IK74nj85nPRF8ee7JmUR/HGOhsQy+eHqnEwjDb5f83U3E0ornfVHrr4vTnF6Cx3SV8Dw
         jghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dtJ4zim0pwcU6VhyJZ3l3/j50NdRDpKKo20iJrM5QiQ=;
        b=i9E9wVOlGuNkZ/n/5zJcTqUMiCczocMlDopOABsIodZrk+lBmMUsVFZWdj62PiNFrn
         OcOVJqas3Pab7d02oLhqRUKe35JXJRzCLLS1e0LFccWUnWdvxTxt9rRzAs7ki+xndVSa
         O57OXCbKKs1F1n2fNoubAl0WXs3zCzECcRkii6dOax/9nSBV1KyS7uSW/BE7B8nCZQEm
         eI4WMnvgxSi4w/cSUSXl2ia4Qen8KkUqn/ZPbxn9WJcl24ebzLaKAkxzujBiXv778KAY
         2n4jiWjK4GtU961pZFq3koaMsXbcRDcr4Faw5v8X9xZD0lZ1yBiVqV25H+Cyl6WclLc3
         igag==
X-Gm-Message-State: AElRT7HguLvFmzUZFgrKp5Fp734WCLNyb/13cee5znriZhyps2JEez07
        pwQC6Cwkoc6Xn2c9i7qi3llX4j7AnhC9OEM5BnpQIA==
X-Google-Smtp-Source: AG47ELuRKtJboKUkk2S7rO+ARPgYTwwgGiG8oY+hCqPjcXd9YtL0I+CBPVdZBvQ6eu1NEi/JwhLMK1YclnZgB1O1QNY=
X-Received: by 10.46.18.70 with SMTP id t67mr19853463lje.137.1521845702692;
 Fri, 23 Mar 2018 15:55:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 15:54:41
 -0700 (PDT)
In-Reply-To: <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
 <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com> <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 15:54:41 -0700
Message-ID: <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> On Fri, Mar 23, 2018 at 2:25 PM, Wink Saville <wink@saville.com> wrote:
>>> Reworked patch 1 so that all of the backend scriptlets
>>> used by git-rebase use a normal function style invocation.
>>>
>>> Merged the previous patch 2 and 3 have been squashed which
>>> provides reviewers a little easier time to detect any changes
>>> during extraction of the functions.
>>>
>>> Wink Saville (8):
>>>   rebase-interactive: simplify pick_on_preserving_merges
>>>   rebase: update invocation of rebase dot-sourced scripts
>>>   Indent function git_rebase__interactive
>>>   Extract functions out of git_rebase__interactive
>>>   Add and use git_rebase__interactive__preserve_merges
>>>   Remove unused code paths from git_rebase__interactive
>>>   Remove unused code paths from git_rebase__interactive__preserve_merges
>>>   Remove merges_option and a blank line
>>>
>>>  git-rebase--am.sh          |  11 --
>>>  git-rebase--interactive.sh | 407 ++++++++++++++++++++++++---------------------
>>>  git-rebase--merge.sh       |  11 --
>>>  git-rebase.sh              |   1 +
>>>  4 files changed, 216 insertions(+), 214 deletions(-)
>>>
>>> --
>>> 2.16.2
>>>
>>
>> Argh, I misspelled Junio's email address, so when you reply-all try
>> to remember to remove "gister@pobox.com" from the cc: list.
>
> Heh, too late ;-)
>
> I queued everything (with all patch 3-8/8 retitled to share a
> common prefix, so that "git shortlog" output would stay sane)
> and I think I resolved the conflicts with Dscho's recreate-merges
> topic correctly.  Please double check what will appear on 'pu' later
> today.
>
> Thanks.
>

OK, thank you!
