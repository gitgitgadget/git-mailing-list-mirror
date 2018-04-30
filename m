Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654F9215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754616AbeD3PeH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:34:07 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:41391 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeD3PeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:34:07 -0400
Received: by mail-vk0-f43.google.com with SMTP id 131-v6so5320658vkf.8
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYYBy4UMJ66j1rKIgMfKCmYOj+OpW2vwcdq3zjUwlr0=;
        b=WKgK5V4uPckAXKrIhy+ZMEc14v+cl6f7VDiW2JU0Vpo2h6eGZejEq63Q/a6SvFMCVj
         hPgRov15HTlvJtrkYOGWSFtXql8y6y0PPzOLo13N9KLgBfWOntk9sY1dAiCObOEf+z6Q
         EVYT8UwUuozKaZbcuO9Xh1i3fRyH/kA256j+2pzSt3QiLuGu1COacaH9GRbXjLxXQTrH
         L1WYCZ/OWoO4+PLihzXsRmlvgjO3+yynEp2AgcCO5hOAd3+lFQjGC3AA8kcbzOYEaoZs
         a31T2pQXM5XjhqxEhRW+KCVzMPzt9xtkMv7pghB2+ft2uyb5Ha0+uPi1J5gBdHD4CPaj
         f4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYYBy4UMJ66j1rKIgMfKCmYOj+OpW2vwcdq3zjUwlr0=;
        b=LL94JpYVezhn32A8q+RRN3I+1jPluoIERbTUiWfhzFmXc0Wc76exmfRYkxC8SHaczq
         31uhRV0NsemNqpYBPGPzYO0T+Dzz+9lx23e14irIrN3B5cP6mDrO4z+TPLXGj6u6HQ7I
         EW/xHNOFvV30amuu179veisZkqXum+ub7MMBNORG163KJ8nyJFuahCaXxa0pvyRA5Lfn
         SoHgfJrSA/avhUhR/kB6IXT4L3PkUSi0xTjZohfMsmXIcX0joh28twQhgffnpMGc3dx9
         CzP+HRx/12w0npGi0vHp3aZgWgczwyZhG1pCgHMFv5DAtKrYCH85q0easUpnyxLO/Qv8
         va6Q==
X-Gm-Message-State: ALQs6tAxySSPcnLH3nC1EHd2iz37kDP9qPwqXkPSKnFpclVyFeDLQy/Y
        SZsPrnJ7gWbHeLndL8HNfgBGjTeuUEAcAtFrWTk=
X-Google-Smtp-Source: AB8JxZqjAVybPa+GSLVt8lHJPuFP0uCy4mRxW2NgLzh4xliLTCSxBRDk0oQi//7FBP1ApGXPX3ZIeYUChQsTuefOI5M=
X-Received: by 2002:a1f:304:: with SMTP id 4-v6mr9740792vkd.120.1525102446172;
 Mon, 30 Apr 2018 08:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 30 Apr 2018 15:33:55 +0000
Message-ID: <CAM0VKjmkn7eyooKheOEQnS=6HMZSTbhejoxQdKB7W+n=7D5KuQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 5:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * js/rebase-i-clean-msg-after-fixup-continue (2018-04-30) 4 commits
>   - rebase --skip: clean up commit message after a failed fixup/squash
>   - sequencer: always commit without editing when asked for
>   - rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
>   - rebase -i: demonstrate bugs with fixup!/squash! commit messages

>   "git rebase -i" sometimes left intermediate "# This is a
>   combination of N commits" message meant for the human consumption
>   inside an editor in the final result in certain corner cases, which
>   has been fixed.

>   Will merge to 'next'.

This topic branches off from v2.16.3.  However, its last patch uses
the sequencer's parse_head() function, which was only added in
v2.17.0-rc0~110^2~6 (sequencer: try to commit without forking 'git
commit', 2017-11-24), in topic 'pw/sequencer-in-process-commit',
leading to compilation errors.
