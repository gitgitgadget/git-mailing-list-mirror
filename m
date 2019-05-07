Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9575A1F45F
	for <e@80x24.org>; Tue,  7 May 2019 14:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEGOlO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:41:14 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33217 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfEGOlO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:41:14 -0400
Received: by mail-lf1-f54.google.com with SMTP id x132so1126258lfd.0
        for <git@vger.kernel.org>; Tue, 07 May 2019 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=aydSB0c3NahvTus3q4cQ8v8htiB0/2NDF8vsGlq5Ors=;
        b=lSwwlW55GFhLLnJzKVLnqNBpgp/TrOh+LgiPJhR7NRWrtfLHsfvW+A/8PbTOkCisEd
         Nt5aZuYp599BqCakDnelkll8opRaEuae3vkGg2Cm/kX2LPs2YSjeEveqpkQPIewgvQ1P
         qoZmSZ60KnPGrCcj/XX7P39euAKu/5bgkCyc4IAj1JhhjbJ4cxMCA8kEgJCdvoq2N0hc
         C6Po6FDsCxs4b+Khd5fjpSkF5wrThYJUGasAAJz0ByGvbCGow8N4eU1VVsEzO7odq3c4
         P8NlsHfOMRHRy+G7jtLQLEtvMMPGhrsseyOEmx0/lCwyNQU4Icrvj7dh5MEUJhPPx5hb
         gLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=aydSB0c3NahvTus3q4cQ8v8htiB0/2NDF8vsGlq5Ors=;
        b=GzhRv3leGftQCZV3JkS2IGdixiFlbFzzaGE5/11tiLvwvxbhNWYrK85HHYle+BtVvQ
         NXtgOI/a3PckvFVFOhoZCIcoZehdD3WbhIRMiXqVcfiWNzBoNXag4nQBKIW7FiX0H5hU
         lWqwRL/0NCHcwf9Di+kNX4t6YMAuFEiEOrpoXHEkOuo6hns5ZBTpS8803WgxQpkmSy6u
         +OP/hoRyM2Wx95xpWqlIoYP9G0q1Cq6dtilaoM+6SPCGBk0Gobjok2ZxOUwcHfSfgmYI
         /md8e4rKIC9nCxDejcAXP3yGyCfpxWdz9C+N7kNEnnMOMzu/lvc1YDExuilNLPiJieyk
         jIxg==
X-Gm-Message-State: APjAAAVg4ZsDxCt7CSUE/l+vQlzPvIxumWdlUXIThRCrJM72K30pMvBO
        2ThrvuoSMBAw1DbKsQ1gMA29WYL3bFAVlTK/1O14r5mT
X-Google-Smtp-Source: APXvYqxUtLIWB5h/20ECREXnKUtkSCV+imyOf+NlkaE0ayYwantKzpeUrNnvv7Y1mhE1wyTR2tQIFJcB5o9DbA0aasM=
X-Received: by 2002:a19:6a06:: with SMTP id u6mr966109lfu.26.1557240072115;
 Tue, 07 May 2019 07:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm> <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
 <874l67i1ie.fsf@evledraar.gmail.com> <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
In-Reply-To: <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 7 May 2019 09:41:00 -0500
X-Google-Sender-Auth: eppS9ORsTK9u-klVwEGuNllB9BY
Message-ID: <CAHd499DvwcHGkSF6DjivvceUaMRO994Q8e1JrjNqjzpQkhDMFg@mail.gmail.com>
Subject: Re: Merge commit diff results are confusing and inconsistent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 7, 2019 at 9:10 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Your example is very helpful. I understand what you're saying for
> conflicted lines. But the "whatever the default merge resolution would
> have been" doesn't exist, because there's no reality where line 1 in
> color.txt can be something "automatic" (i.e. deduced by git). The only
> reality for the merge commit is some hand-edited replacement to line
> 1. So there is no "diff what I see with some alternate reality".
>
> The majority use case I'm interested in is seeing net-positive changes
> that happen in merge commits. Normally I take for granted that merge
> commits have nothing meaningful in them (meaningful here defined as
> something unexpected for a merge commit). But what if someone makes a
> poor decision and does some crazy refactoring in 1 file and amends it
> into a merge commit? Let's also say that these changes are done to a
> file that wasn't modified in any parent (say a unrelated.txt next to
> your color.txt). Since neither parent cares about that file for the
> purposes of the merge, I am trying to make sense of a revision
> specification that can be used to see what they did to that file.
>
> Even ignoring that issue, the more concerning observation of mine is
> that `diff @^!` produces any output at all. If you exclude both
> parents, why do I see a diff for parent 2 (I see the complete diff of
> the branch that was merged in)?
>
> Again, thank you for your example, you definitely made things very
> clear for me. I see where the confusion is. And I think --cc is a good
> way to get more context. At this point I'm just concerned about the
> @^! behavior with merge commits & diff.

Also I'm really confused how you got diff-tree to work. If I pick any
arbitrary SHA1 of a merge commit in my existing repo's history,
diff-tree produces only a SHA1 as the result:

$ git diff-tree --cc bdd47a73d
bdd47a73d18948aa46a8a7aa964543f0d989ffd4

I tried with just `-c` as well; same result.
