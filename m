Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8A31F404
	for <e@80x24.org>; Thu,  8 Mar 2018 15:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755259AbeCHPQr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 10:16:47 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54820 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754957AbeCHPQq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 10:16:46 -0500
Received: by mail-wm0-f45.google.com with SMTP id z81so3934wmb.4
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 07:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvLRJoQhva6Lux8MJIyoTmfLM4JqXTobdACK9cxffKY=;
        b=SVHCTCAVAhnrJoV4ZgQsezSwe5jF0n+0bWTYEcpmTivLrf51bAtUO9fgUj4AU2sgHm
         e6p1ssnqb2rZi9goAZrYxXeqAj26nyQICAKp7rzoZEx9HInp3SHmX1HakOdwIL8rtNtT
         4LmoKAtgBa8hHx1jIvrcCt23KTIT0XT0QAAyz2H1FlyyNDvQTRosLBIHMsN3G1lMNSRx
         wktseZrW4RlModOF7kgJcMo9xs2NvzhZb9OQ7w6dsN8XMVlZYjeLoAHg/PAz4HN0Zo3e
         cTAiQfusMYGSL7+tYUEMGm1Eyl91CSOCpjXHD5C7GsjD+X9nGVmCJ+ifkTQX52uSRIzJ
         yQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvLRJoQhva6Lux8MJIyoTmfLM4JqXTobdACK9cxffKY=;
        b=nr2caT4SAbC+TT5g1thnDpm4OMEU3/1kM2X1mkHazwlxF0ifQcR3r3E8eNt7T2mNxj
         eWE0x8sCX6vgH8Eun5IL9n/1UUrSkZNOYEul/2Tc1rIM0wyawGfCo0lzHGtT6Ms1DxiY
         0dYMoI/Rbksnq7C2qSkZhBYc10lzZ0xMjwJdOksMAYfj5oY4enYtF7vHr/xozY/wtzZj
         U/JorcV3DNKK94SrTX+LknDtwB8JFd2jLsLHYQC16GzZx9D0WrgKpI8MnE9/8/2IOMc6
         3SbhQ/iLQVFfReOszafdNI75Qjdguln4g/BeMiZN7npMsh/IqSUDjkpl61y6IN9bOtFX
         jxXA==
X-Gm-Message-State: AElRT7GpuJOmnxaP96KY+fqYHl8HQl3LQMwE8l//dNLoSvv0x+sRMz4Z
        pqXDiaWE9PNnoY3t6M+iuKw=
X-Google-Smtp-Source: AG47ELudfwEvZDaXRx3ckVtF2dsuC/AG+oJ02c46v1svODbakFwkEDSMxu2Xudfw2eE9hLdNKZM2jQ==
X-Received: by 10.28.223.212 with SMTP id w203mr18941250wmg.96.1520522204886;
        Thu, 08 Mar 2018 07:16:44 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id w29sm19647248wra.84.2018.03.08.07.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 07:16:43 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com>
Date:   Thu, 8 Mar 2018 16:16:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 07/03/2018 08:26, Johannes Schindelin wrote:
> 
> > So, it could be something like:
> >
> > 	merge -C deadbee 123abc:cafecafe 234bcd:bedbedbed
> 
> I like where this is heading, too, but I do not think that we can do this
> on a per-MERGE_HEAD basis. The vast majority of merge commits, in
> practice, have two parents. So the `merge` command would actually only
> have one revision to merge (because HEAD is the implicit first parent). So
> that is easy.
> 
> But as soon as you go octopus, you can either perform an octopus merge, or
> rebase the original merge commit. You cannot really mix and match here.
> 
> Unless we reimplement the octopus merge (which works quite a bit
> differently from the "rebase merge commit" strategy, even if it is
> incremental, too), which has its own challenges: if there are merge
> conflicts before merging the last MERGE_HEAD, the octopus merge will exit
> with status 2, telling you "Should not be doing an octopus.". While we
> will want to keep merge conflict markers and continue with the "rebase the
> original merge commit" strategy.
> 
> And it would slam the door shut for adding support for *other* merge
> strategies to perform a more-than-two-parents merge.

The thing is, in my opinion, as long as we are _rebasing_, you can`t 
pick any merge strategy, as it doesn`t really make much sense. If you 
do want a specific strategy, than that`s _recreating_ a merge, and it 
goes fine with what you already have for `--recreate-merges`.

On merge rebasing, the underline strategy we decide to use is just an 
implementation detail, picking the one that works best (or the only 
one that works, even), user should have nothing to do with it.

> Also, I do not think that it makes a whole lot of sense in practice to let
> users edit what will be used for "original parent". If the user wants to
> do complicated stuff, they can already do that, via `exec`. The `merge`
> command really should be about facilitating common workflows, guiding the
> user to what is sane.

I thought of a situation like this:

(1) ---o---o---o---M--- (master)
        \         /
         X1--X2--X3 (topic)


Merge M was done with `-s ours`, obsoleting "topic" branch. But, I 
later realized that I actually do want that X2 commit in master.

Now, I guess the most obvious approach is just cherry-picking it, but 
what if I would like to do something like this instead, with an 
interactive rebase (and rebasing the merge, not recreating it):

(2) ---o---o---o---M'--- (master)
       |\         /|
       | X1'-X3'-/ | (topic)
       |           |
       \--X2'------/ (new)


This way, and having "topic" inherit original merge behavior due to 
merge rebasing, X1' and X3' would still be missing from M' as they 
did originally from M, but X2' would now be included, as it`s coming 
from a new branch, forged during interactive rebase.

(note - implementation wise, this still wouldn`t be an octopus merge ;)

> The vast majority of merge commits, in practice, have two parents. So
> the `merge` command would actually only have one revision to merge
> (because HEAD is the implicit first parent).

Now, this is something I actually overlooked :( 

I guess order of parent commits could then be used to map to old 
commit parents, being a limitation in comparison to direct 
old-parent:new-parent mapping, but might be a more straightforward 
user experience...

Though in case of octopus merge, where one would like to drop a 
branch from the middle, being merged with `-s ours`, that would be 
impossible, as then the next branch would be taking over dropped 
branch merge parent, yielding an incorrect result.

So in this case:

(3) ---o---o---o---M--- (master)
       |\         /|
       | X1--X3--/ | (topic)
       |           |
       \--X2-------/ (new)

... where "topic" was merged using `-s ours`, we wouldn`t be able to 
just remove whole "topic" branch from the rebased merge without 
influencing it incorrectly.

With (any kind of) explicit old-parent:new-parent mapping, this is 
possible (and shouldn`t be any harder, implementation wise).

Now, it`s a different story if we`re interested in such exotic 
scenarios in the first place, but if possible, I would be all for 
it... :)

> Currently my favorite idea is to introduce a new flag: -R (for "rebase the
> original merge commit"). It would look like this:
> 
> 	merge -R -C <original-merge> <merge-head> # <oneline>
> 
> This flag would of course trigger the consistency check (does the number
> of parents of the original merge commit agree with the parameter list? Was
> an original merge commit specified to begin with?), and it would not fall
> back to the recursive merge, but error out if that check failed.
> 
> Side note: I wonder whether we really need to perform the additional check
> that ensures that the <merge-head> refers to the rewritten version of the
> original merge commit's parent.

No, and even worse - I think we must not do that, as that merge 
parent might be moved elsewhere, which should be allowed.

When I say "merge parent", I really mean "merge parent _branch_" (or 
so to say, merge parent context), I was deliberately avoiding term 
"merge parent commit" as it`s more than that.

> Second side note: if we can fast-forward, currently we prefer that, and I
> think we should keep that behavior with -R, too.

I agree.

> If the user wants to force a new merge, they simply remove that -R flag.
> 
> What do you think?

Having more replies in the thread, I`ll comment the format there, 
might be more appropriate, as discussion already evolved since the 
last time I`ve checked, and I might have a new idea... ;) :P

Regards, Buga
