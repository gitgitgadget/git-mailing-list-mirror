Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4679D20D09
	for <e@80x24.org>; Sat, 15 Apr 2017 09:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbdDOJhH (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 05:37:07 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34138 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdDOJhG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 05:37:06 -0400
Received: by mail-wr0-f173.google.com with SMTP id z109so60705311wrb.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TB2QsQzij0m1j4bhm6IlWmWjgKZ6MSBcRpffzDMykUc=;
        b=MHTsVIepeO5pjv0ntTcS/S44LjCdv+A195jKKBak3JbX2v1nPZdEoXzLgg6peVMYsD
         T3c5ASvtFqUNsXO8cUyz30agG7eKteC2TtD6Imv9cQVfctlKi0hNg2DRsThrUt2oKauI
         xlOV64kiOl4fPKb5oMEwgStXIz/OiHaf6ZfUi10oITGKCfXLSSlVJlgcPCI2eF2gIsx9
         KgM6ueCU330Ku5bLYQ1RKavKeKSoe0QxonNEDnmySbbVJzxaNHu4P0AU3cHe9YBQxjKw
         UrGfhNq9PR2tfajRgxxqFgaMcGnjrL7ayAR6G1U76oFl86YZFzf60pMdFOrHwu3vNIqs
         DVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TB2QsQzij0m1j4bhm6IlWmWjgKZ6MSBcRpffzDMykUc=;
        b=f6mYUC1C6qL3GH4EEiTLnEfyLr3GNtO2UAKcQ1j9Svn2A6yWC9MCnMel+CyW4WJzSv
         kiQUNIeOZa387HjjzNLZeJEnCk+5PYrfWPKoVtz0+9Olup1q+Bxp8Hwx6ked0CfI1GzF
         Hgy31R3xvvtZSfl6UeaZHRDVsov9kM/UVNZXBPOklMz+ySVN7N59ceqhSRSvbFICwQGr
         yudG+cCmw8oRiwYcMkIYIa8919/DlcyPJcgNFCutdSCX7/lFWCzRfHfmSK9BkPy6d9sV
         pT98dZzSx41EcZIjndMhWKvAn0W4LLro682BGn/0BwjlLuM0RyC1ZVwkUmljp5oRq9nL
         FkPg==
X-Gm-Message-State: AN3rC/7bXRJsXquWaD7YdK05FRnYvc9HJyV/Mj/zs4wNtxpYO4fSxUzN
        EXqKNiwp1tmWqYBDz/zgii7e8jclUg==
X-Received: by 10.223.138.199 with SMTP id z7mr11559184wrz.66.1492249024680;
 Sat, 15 Apr 2017 02:37:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.98.212 with HTTP; Sat, 15 Apr 2017 02:36:44 -0700 (PDT)
In-Reply-To: <xmqqefwum3mh.fsf@gitster.mtv.corp.google.com>
References: <20170414225713.29710-1-giuseppe.bilotta@gmail.com> <xmqqefwum3mh.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Sat, 15 Apr 2017 11:36:44 +0200
Message-ID: <CAOxFTcwDrYvg5Nf1w9SfmM=Nt7XYsJPhKSYkJzMC0123EY94Aw@mail.gmail.com>
Subject: Re: [PATCHv3] rebase: pass --[no-]signoff option to git am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> This makes it easy to sign off a whole patchset before submission.
>>
>> To make things work, we also fix a design issue in git-am that made it
>> ignore the signoff option during rebase (specifically, signoff was
>> handled in parse_mail(), but not in parse_mail_rebasing()).
>
> I doubt that the above implementation detail in the code is "a
> design issue"; it is a logical consequence of a design whose
> "rebase" never passes "--signoff" down to underlying "am", so it is
> understandable that whoever wants to pass "--signoff" thru during
> the rebase needs to update the implementation, but I do not think it
> is fair to call that "an issue".

Good point. It's an issue now that we want to be able to pass signoff,
but when the split was introduced it most definitely wasn't 8-)

>>  Documentation/git-rebase.txt | 5 +++++
>>  builtin/am.c                 | 6 +++---
>>  git-rebase.sh                | 3 ++-
>>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> We need new tests for "git rebase --signoff" that makes sure this
> works as expected and only when it should.

Would the norm in this case be to introduce the test in the same
commit, or in a previous commit (as in: this is the feature we want to
implement, it obviously doesn't work now, but the next commit will fix
that), or in a subsequent one?

>> diff --git a/builtin/am.c b/builtin/am.c
>> index f7a7a971fb..d072027b5a 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -1321,9 +1321,6 @@ static int parse_mail(struct am_state *state, const char *mail)
>>       strbuf_addbuf(&msg, &mi.log_message);
>>       strbuf_stripspace(&msg, 0);
>>
>> -     if (state->signoff)
>> -             am_signoff(&msg);
>> -
>>       assert(!state->author_name);
>>       state->author_name = strbuf_detach(&author_name, NULL);
>>
>> @@ -1848,6 +1845,9 @@ static void am_run(struct am_state *state, int resume)
>>                       if (skip)
>>                               goto next; /* mail should be skipped */
>>
>> +                     if (state->signoff)
>> +                             am_append_signoff(state);
>> +
>>                       write_author_script(state);
>>                       write_commit_msg(state);
>>               }
>
> This removes the last direct caller to am_signoff().  It may be
> worth considering to remove the function and move its body to its
> only internal caller am_append_signoff().

Good point. It becomes a bit bigger change though, so I'll probably
split it off in a separate commit now.


-- 
Giuseppe "Oblomov" Bilotta
