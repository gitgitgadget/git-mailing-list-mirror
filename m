Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEB21FF34
	for <e@80x24.org>; Thu, 11 May 2017 10:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbdEKKdl (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 06:33:41 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35757 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755097AbdEKKdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 06:33:40 -0400
Received: by mail-it0-f42.google.com with SMTP id c15so41033259ith.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sD1+2tp+inxVK2GGZ+CBR9WigLBgEodPvZ5a9aVShnM=;
        b=V877UI0H6Zk0j2dsGRLb3SayOo0RXhvksm6f+s8gpwzK0T+BUu/pRIPK1ZGjmo7v5z
         Hk5gSNQPzkCLYzZec2GZlB5kZfJ3VH0DFvSlLgilig2j04gHTU9e5YEU3TTHfQsOJUng
         IvxF0w8HsRfj6TDtRY5X9u5/F7Rp5lHZDkwOh07SueInJevjPJFpJ4IYomjIB62pS+ez
         k1XQEP9c7WU6FeM/Mjtr5rWlOHZCXti+xqIvdYDQVm9o9M79oDJvoP6mICNK4ELGbPzn
         BFtoaQpRsGtFPaNRWjMf9DxZnnz94yIrcEgFoMJwqAbOFgGBl1T4JdaktOCyc9qnjaPO
         YcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sD1+2tp+inxVK2GGZ+CBR9WigLBgEodPvZ5a9aVShnM=;
        b=PNLdYrrh7QBmvm7+Caa+hp1Lv5ODKph+vNRnk54TB/8yXLx0qoazvg3UI+5whayhVI
         ECxsRcVWqxH69aX1+esGEAa0SEcnTfZlxkHBLh1itW9jE+Qi1NuMoKW+qjKk3ntC8syn
         u3cL956TW4Po7Bu0AwzIGEw1XVzw/znLkSNWjW6XyNO9E0z8myaurDAfd6Dpp8CDYWFV
         0VYRJdKDLDhq/dQWCjsUPXIDBJ0HGdMC3AbxwST0Q6XuA2zBy74GrYSFqXvx4NNzPtSS
         +hJ4QXSjyvNkXCbvBAQqvQpdm7DEulzavivxAQ94RUZAvL0i9RT5unXV3rUv5w9x0XqB
         QOkg==
X-Gm-Message-State: AODbwcBp+ueue1gTIGnq9CVDuoq+rNd+2kvZetavpAbCSgeNQblDyd+B
        5OzFf9HKgsRu/4SEu2qAc0l0JDfwDEva
X-Received: by 10.36.138.131 with SMTP id v125mr5607194itd.66.1494498819210;
 Thu, 11 May 2017 03:33:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 03:33:18 -0700 (PDT)
In-Reply-To: <20170511102812.3ed3sqycjmapfj35@tigra>
References: <20170503162931.30721-1-jn.avila@free.fr> <20170503210726.24121-1-jn.avila@free.fr>
 <xmqqa86kccca.fsf@gitster.mtv.corp.google.com> <61C67DC73308BD49B2D4B65072480DBA2BDAB97D@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
 <20170511102812.3ed3sqycjmapfj35@tigra>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 12:33:18 +0200
Message-ID: <CACBZZX7YV2Xx43vn50x1ZO70=et9kNBrCKKoR8xRo1NCQPR2gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply is required
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 12:28 PM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Thu, May 11, 2017 at 10:10:05AM +0000, Kerry, Richard wrote:
>
> [...]
>> > > @@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
>> > >
>> > >     if (unmerged_cache()) {
>> > >             printf_ln(_("You still have unmerged paths in your index.\n"
>> > > -                   "Did you forget to use 'git add'?"));
>> > > +                   "You might want to use 'git add' on them."));
>> >
>> > This case is *not* an "rhetorical question is the most succinct way to convey
>> > the information" situation; I think this rewrite is a definite improvement.
>> > "You might want to 'git add' them" may be more succinct, though.
>>
>> "You might want to use 'git add' on them." It isn't about what you
>> *want* to use, it's what you *need* to use, isn't it?  And I'm not
>> happy about "on them".  I'm not sure quite why, but the phrasing seems
>> odd.  How about "You might need to use 'git add'.", or "You might need
>> to use 'git add' first.", or "'git add' needs to be used to add
>> files." ,  or "'git add' needs to be used before any other git command
>> may be used.".
>
> Why not just
>
>   You should run `git add` on each file with resolved conflicts to mark
>   them as such.
>
> I'm not an English speaker but IMHO this phrasing concentrates on the
> essense of the problem.  It's far from being succint, unfortunately.
>
> I also wonder what to do with "deleted by them" state of certain files
> which are also "unmerged" but `git add`-ing them would be a wrong thing
> to do if we want to accept the upstream's decision to delete the file.
> So maybe something like
>
>   You might run `git rm` on a file to accept "deleted by them" for it.
>
> appended to the original hint would be good.

I think something like this sounds much better. I think being a bit
more verbose is good here, if you know how to solve conflicts you just
go "oops, forgot", but for confused users who don't know how, it's
better to explain things a bit more verbosely.
