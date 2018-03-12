Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2851F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCLXzS (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:55:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46077 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeCLXzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:55:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id h2so10322362wre.12
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/5wjteVGsujQPGy+tJZnGwDbENOM8/PWmbFxxG5ZFlE=;
        b=sDaZd3PFzqMJ3AU3dyPEzaF1jxd7F0miVb4QPPTyTNHSXU6GcX5nw4UcMuSnDxOI6D
         dkeE47ihm5o43A6Mhs50J+0y9MlyGkUQsWwkZ1hB7aWSS7X4FyppJK8Oyx9JEfHxHbJs
         AkDUQkXWEu5R20Z7qN37ocL35nLAvB9HR0i2CYtCHNZXesFxm3tGFt7TAPlk7aJUDHCZ
         4KflpEr1Zaw/nygSFH8gtkNMkFWlisLkoCqFKbbwZQZWqQtxFwgtO/zhSsISrel2nn/Z
         7xVHmoKTWTiFPX7JMWgU8A14Pv0sV12ZNx5z9vVnkekp7f7wkIJ/MCy/3NT82OyoBii6
         /vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/5wjteVGsujQPGy+tJZnGwDbENOM8/PWmbFxxG5ZFlE=;
        b=CJXgyZLyy2g9MHCuD085vsBZ7dOnTZYuiXklp6yaXAo9KSJcdlTbKC2xxhv4/qMNeT
         NlnmMv7dMVemnUTx8PI1zEA7l2Ar6TfArtVfJ+OacGxxAxr6dSZ7R1T8S1ck25ApNOiA
         0EO8MGyJFW6x+runw0vWAGL3T31oe57LTTJCjmcN/UWjyG8jhdPRJPr1/U3AkeZLEK95
         Uih7sNTDUQ42y9Lo1Ji5sJ5ct2MdCvuWzSeJwLj0jkoEUeYdPHPcH7yBUtUv2JoTYr3u
         EH05dMxpFOuILsI7/P6xKjqNs9YhoLLAS6U57qeRkZ41+zZDW3OBcxtWo8HHdisaR+If
         D0rw==
X-Gm-Message-State: AElRT7Hh30CL3h0wWSnM/UkZYYxsp3XH9Rh12mAzFIc6+XVjOATltG3c
        yquWQyBPr4TUidJJBRnhKyE=
X-Google-Smtp-Source: AG47ELtaHMOQBUCjUNKUgkJ91GLmh48I9L4t7mozu0zJ8P19NBYuNJ5HCV4RgtgueEkqzBxdW0P5AA==
X-Received: by 10.223.172.37 with SMTP id v34mr4597924wrc.236.1520898916311;
        Mon, 12 Mar 2018 16:55:16 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id l22sm7673631wmi.39.2018.03.12.16.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 16:55:15 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
 <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
 <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
 <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <77b695d0-7564-80d7-d9e6-70a531e66eda@gmail.com>
Date:   Tue, 13 Mar 2018 00:54:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 12/03/2018 11:37, Johannes Schindelin wrote:
> 
> > If we are to extract further mentioned explicit old:new merge 
> > parameter mapping to a separate discussion point, what we`re 
> > eventually left with is just replacing this:
> >
> > 	merge -R -C <original--merge-commit> <merge-head>
> >
> > ... with this:
> >
> > 	pick <original--merge-commit> <merge-head>
> 
> I see where you are coming from.
> 
> I also see where users will be coming from. Reading a todo list in the
> editor is as much documentation as it is a "program to execute". And I am
> afraid that reading a command without even mentioning the term "merge"
> once is pretty misleading in this setting.
> 
> And even from the theoretical point of view: cherry-picking non-merge
> commits is *so much different* from "rebasing merge commits" as discussed
> here, so much so that using the same command would be even more
> misleading.

I would disagree here, as it seems you`re going too much into 
implementation and theory here, where it shouldn`t really matter from 
the user`s point of view - the point is to rebase a commit, `pick` it 
from one place and plant it elsewhere.

Yes, some commits might have a bit different semantics then others 
(merge vs non-merge), but it should just be an implementation detail, 
in my opinion, no need to leak it in user`s face (more than necessary).

I feel that "merge" is a command that works really well in the 
mindset of (re)creating merges. But if we are "only" rebasing an 
existing merge, `pick` seems much more appropriate (to me, at least), 
and it aligns with what I`m already expecting `pick` to be doing.

Down below, if we are (re)creating the merge, or doing magic to 
somehow just port it over, should be irrelevant. So "rebase" equals 
"pick and plant" (port), not "merge".

> > That is what I had in mind, seeming possibly more straightforward and 
> > beautifully aligned with previously existing (and well known) 
> > `rebase` terminology.
> >
> > Not to say this would make it possible to use other `rebase -i` todo 
> > list commands, too, like if you want to amend/edit merge commit after 
> > it was rebased, you would write:
> >
> > 	edit <original--merge-commit> <merge-head>
> >
> > ..., where in case you would simply like to reword its commit 
> > message, it would be just:
> >
> > 	reword <original--merge-commit> <merge-head>
> >
> >
> > Even `squash` and `fixup` could have their place in combination with 
> > a (to be rebased) merge commit, albeit in a pretty exotic rebases, 
> > thus these could probably be just disallowed - for the time being, at 
> > least.
> 
> Sure, for someone who read the manual, that would be easy to use. Of
> course, that's the minority.

I`m not following you here - the point is these are already existing 
commands, which would still fit in just nicely, so nothing new to 
learn nor read.

Now, if we are to discuss use cases where people don`t even know what 
they`re doing, I would think that misses the point. Besides, it`s 
always easier to make more mistakes when you introduce yet more 
commands/semantics to think about/learn, and I think it can be avoided 
here, for the better.

> Also: the `edit` command is poorly named to begin with. A much cleaner
> design would be to introduce the `break` command as suggested by Stephan.

This is orthogonal to what we`re discussing. Existing commands might 
not be perfect, but that`s what we have now, so let`s be consistent, 
not putting additional burden on the user there, at least.

But for the record - I tend to agree, I often find myself wondering 
if `edit`-ed commit means `rebase` stops after applying the changes 
and _before_ making the commit itself (so we just edit and 
--continue), or _after_ it (so we edit, `commit --amend` and 
--continue).

> > The real power would be buried in implementation, learning to rebase 
> > merge commits, so user is left with a very familiar interface, slightly 
> > adapted do accommodate a bit different nature of merge commit in 
> > comparison to an ordinary one, also to allow a bit more of interactive 
> > rebase functionality, but it would pretty much stay the same, without 
> > even a need to learn about new `merge`, `-R`, `-C`, and so on.
> >
> > Yes, those would have its purpose, but for real merging then 
> > (creating new merges, or recreating old ones), not necessarily for 
> > merge rebasing.
> >
> > With state of `merge -R -C ...` (that `-R` being the culprit), it 
> > kind of feels like we`re now trying to bolt "rebase merges" 
> > functionality onto a totally different one (recreate merges, serving 
> > a different purpose), making them both needlessly dependent on each 
> > other, further complicating user interface, making it more confusing 
> > and less tunable as per each separate functionality needs (rebase vs. 
> > recreate).
> >
> > I guess I`m the one to pretty much blame here, too, as I really 
> > wanted `--recreate-merges` to handle "rebase merges" better, only to 
> > later realize it might not be the best tool for the job, and that a 
> > more separate approach would be better (at least not through the same 
> > `merge` todo list command)...
> >
> > [1] https://public-inbox.org/git/f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com/
> 
> Well, the `-R` option is no worse than `git merge`'s `-s <strategy>`
> option (which *also* changes the strategies rather drastically).

What I wrote above, -R seems unfitting for `merge`, as we are not 
really merging, but rebasing (conceptually, not implementation wise).

And it makes even less sense in the light of that previous comment 
where "rebasing a merge" shouldn`t even allow selecting a specific 
strategy, as that would imply (re)creating the merge instead.

So using `merge` for rebasing existing (merge) commit seems as rather 
misusing the concept of `merging`.

I don`t know, I`m thinking if we are looking at todo list from 
different perspectives - to you, it seems to be a sequence of 
commands to create something new (yes, from something that already 
exists, but that`s implementation detail). In that context, using 
`merge` might have sense (even if still being a very special merge).

But to me, as we already have `pick` and not `commit` to rebase 
commits, it means we are not creating but rather reusing what we have 
(being an important concept to reason about), thus `pick` would still 
fit in for picking a merge commit just nicely, and more naturally, too.

*Maybe if* `-R` would be turned into a full fledged "rebase" (or 
"rebasing") merge strategy, written as:

	merge -s rebase -C <original--merge-commit> <merge-head>

..., might be it would make more sense to me (aligned with what 
`merge` is expected to do). But even then, I might prefer having 
`pick` as a syntactic sugar over `merge -s rebase`, at least.

In the light of this, I _could_ even see `-R` as short for `-s 
rebase`, but it still seems a bit awkward and forced.

Regards, Buga
