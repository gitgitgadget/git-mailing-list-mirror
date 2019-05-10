Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B980F1F488
	for <e@80x24.org>; Fri, 10 May 2019 09:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEJJmz (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 05:42:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44071 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfEJJmz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 05:42:55 -0400
Received: by mail-io1-f65.google.com with SMTP id f22so3799251iol.11
        for <git@vger.kernel.org>; Fri, 10 May 2019 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cioYm2BMDEeAKXGXcYkmjWL0aT6NpSrqCEPzDbQEntQ=;
        b=f3drcdvY0Xa0Gn8J4T8WwlCuGTDWOO+XrgZ1u7itX+gz+jlD+SpJAXcxu6Yk7KzMw3
         Da5PTs7xn5StraLRBqJOgBjmKp4lc6m2MsdgDjkJ+7oNJzr8eUni2IxprP+IK8GCQ5G9
         ByVGYm2wDQFdKn666nmoGN5Pd+7aw9k1/aOlO61Hqua/Tf/LmMWx1Yh/fGZKrBUK2rHp
         k1aDSGQaGVTGJP4vICamBTAnkhTTU3tinJ+rg4L5r61DAkOM6HsXLPxglu4pqx4GYfME
         PGM8v4+lf2gniBUi/RltKkUggytuu8bBVwc0zUz+rnUg123d+gqtT81ys2bX5U+i0JQ5
         bHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cioYm2BMDEeAKXGXcYkmjWL0aT6NpSrqCEPzDbQEntQ=;
        b=HIEszhKJidtJlk9CI2VdFPUP7VmVqsK990Eo0j4hFZ0AiC8OcrYMpg//6f5KdhQVQ3
         AHDPytM8vU2xkCjZCEtNWdy1LOX73AnDa+npS17PrJZsD8I6cWVp5UGMl5zh/IdZj0MQ
         kbMrkJrWUzjYBftN0AgPB5S2DJ6JnuXBDcEpl23Gwz+dV+MJjdRi+SZIYwtoIqgaq9sD
         O9Y65iJzBQ1zj1yHyCdc2E3TGJopSbp2ohglGIutg4E4KSHpzBFRUpIckNs0Fvi1CiZ/
         Y7h25ouVA775b/y1BDrEJCERgL6ujnOcZODKGxavaC2i3Udk23auw3MkywAjzf9z1a3M
         lEwQ==
X-Gm-Message-State: APjAAAX/hcwAJ5b8ctjwdnntSyOee5npA8S5HAUUucca7hhzJ208PtUx
        kZuB1yLeA3Df6u7jOV2iYFda0Vasu/jthYmm444=
X-Google-Smtp-Source: APXvYqykx8/G+TI/8TCkDmGQL5Z5+Zz8bLj2a/Wr6witHlvN7piczQF7q4BiCd2n6XZmB+hOJkxG6Dh+gavvjIe78cQ=
X-Received: by 2002:a5e:d60f:: with SMTP id w15mr5311072iom.282.1557481374243;
 Fri, 10 May 2019 02:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905092251200.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905092251200.44@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 May 2019 16:42:28 +0700
Message-ID: <CACsJy8DTErpeoNHUkCieDafnjc3iwg6QKAp2VP-8tUNYh33tJA@mail.gmail.com>
Subject: Re: nd/merge-quit, was Re: What's cooking in git.git (May 2019, #01;
 Thu, 9)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 3:54 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio & Duy,
>
> On Thu, 9 May 2019, Junio C Hamano wrote:
>
> > * nd/merge-quit (2019-05-07) 2 commits
> >  - merge: add --quit
> >  - merge: remove drop_save() in favor of remove_merge_branch_state()
> >
> >  "git merge" learned "--quit" option that cleans up the in-progress
> >  merge while leaving the working tree and the index still in a mess.
> >
> >  Hmph, why is this a good idea?
>
> It also seems to work *only* on Linux. At least the tests break on macOS
> and on Windows:
>
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=8313&view=ms.vss-test-web.build-test-results-tab

Sorry I have no idea what the problem is. That's basically the same as
the 'merge detects mod-256 conflicts (recursive)' test earlier but
with rerere enabled. It does not even look like some leftover rerere
records accidentally fix the conflict.

I tried with a case-insensitive filesytem (on linux) and with
--valgrind, no problem found. Travis on pu seemed ok with t7600 on
mac.

One difference I notice is the the failed test looks like it found the
wrong merge base

found 1 common ancestor:
c4c4222 commit 1

while my tests have "commit 0" as the base. "git log --graph
--oneline" indicates "commit 1" is the wrong base.

Something is wrong with the merge code (this has not even reached the
new --quit code). I could change the setup steps to be more stable,
using a simpler commit history, but this looks like something we
should find and fix.

> Sadly, I ran out of time do look into this (I am pretty busy preparing Git
> for Windows for v2.22.0-rc0).
>
> Ciao,
> Dscho



--
Duy
