Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944C12018D
	for <e@80x24.org>; Tue,  9 May 2017 20:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdEIUZj (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 16:25:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34779 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEIUZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 16:25:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so3046230wrb.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OHcbqNQxAtW54vbKXD3Z2tNe1PDFxiTNP1x/0omFfSY=;
        b=X/aSnuyxtBPPePdKr+JVCTF5f8NEPg+hHPqIpIFtl+vyF9QJp/d+JpftGi6QLwpv+l
         KDw2L0PWr6ktl18TPhGtdydFl9p8i6Um9pCYjYsILhcJwZk3tlyfusWZha5YKBUVgN8F
         Nd+IIz7h1JIb7W8wyjIHiXHMLu3mjfTwn17+n5aOnwGoK2s6EQM3laTwmHMhcO02a7iB
         I/gbsu8WPwzThDJMBQvgUrFXJ3AKAv2y5eb2NjTZIyfJn5d+53DOTIEowkFjLJpI5gmK
         ePmj/rHl5bYXeUCjhBPCrRyNu4q0zfrFoW9ZfcvcgCbKSZ/1OKuq5tWVXJF+Xp7lZcbF
         imlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHcbqNQxAtW54vbKXD3Z2tNe1PDFxiTNP1x/0omFfSY=;
        b=lhGc5FBFHA3fDliKNAr9+8p2wV0vwxb0sXiEH7YevDGG+tG55KukffRLyhZQxsM6oV
         lGnAnX/wnGaRSKjsa1i+BTGw15q9G2244U0F86N+eNSgC48HXt/YbfOm/VQw4y2KipIv
         aG50jdsMoYl80deMMK3dqEvdoNopV4Ot+KXesmHgdO/MG9ZuIfg2YGLOZuCcG3yRhHDA
         Mcys42igsr3c7KH4oojaUarVJFeZAtI0qq0pDIdJrFz0pmqfDmXTsPWob8dDzbQN2y/S
         9QRteSxmEEqN0gmXYpP9KNtu7kJth60lO7LTamlM03QZAAZRxlmhcMlSC/toCqp2sSqM
         tVhg==
X-Gm-Message-State: AODbwcB8gGBKHBK4WKOkJji0owlKw9kjhNfLWjXg2IYMhwgAi7Y6nHlh
        UttiimUHV8jmraiiqN0=
X-Received: by 10.223.166.48 with SMTP id k45mr1152718wrc.190.1494361536233;
        Tue, 09 May 2017 13:25:36 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.180.192])
        by smtp.gmail.com with ESMTPSA id s29sm867403wrb.21.2017.05.09.13.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 May 2017 13:25:35 -0700 (PDT)
Subject: Re: [noob] is this normal behavior
To:     Harry Putnam <reader@newsguy.com>, git@vger.kernel.org
References: <868tm6w5bz.fsf@local.lan>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <03ef09e8-62a1-b6bb-041a-bad83dc353f4@gmail.com>
Date:   Tue, 9 May 2017 22:25:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <868tm6w5bz.fsf@local.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harry,

Both behaviours you report are normal, specifically:

On 09/05/2017 15:02, Harry Putnam wrote:
> Shouldn't files that changed but are already being tracked just show
> up as modified and not need adding?
> ...
> Since that file is already being tracked; shouldn't `git status' show
> that file as modified but ready to be committed instead of a file that
> is modified but needs to be added before a commit can happen?

No, it shouldn`t - even though the file you`ve modified is already 
being tracked, it doesn`t have to mean you want the modification 
inside your very next commit, and Git doesn`t force that upon you.

That is where index (or "staging area") comes in handy, allowing you 
to `git add` only the changes you actually want to commit now, 
leaving the others for later decision.

You don`t even have to add all the modifications inside the single 
file at once, for example by using `git add --patch`[1] you can 
select just some of the them, fine tuning what gets committed and when.

With some precaution/steps needed not to commit broken project states 
by accident, and some discipline not to overdo it, this allows you to 
fully focus on the actual work you do, making logically unrelated 
changes in place as you see fit, on the go, and only later organizing 
them into logically grouped commits, through diligent use of `git add`.

> Another side of this is that a `git diff FILE' only works before an
> `git add .' operation is done.
> 
> That is, if I run `git diff FILE' AFTER `git add' .. no diff is
> reported, even though it is not committed yet.
> 
> So, for example: if I'm committing and in the vi buffer of the commit
> and want to see a diff of FILE to aid my log notes.
> 
>  git diff FILE will report nothing whatever.
> 
> Is that expected behavior?

Yes, that is as expected - in the form you`ve given, `git diff` shows 
the differences between your working tree and index (staging area), 
so only changes you haven`t added yet. Once you `git add` the changes 
from the working to the index, there are no more differences to show, 
so no diff is produced.

If you want to see the added changes, what will be included in the 
commit if you make it, you can use `git diff --cached`, as per 
git-diff[2] documentation (--staged can also be used instead, being a synonym 
for --cached, but maybe easier to remember, relating it to "staging 
area").

That option shows differences between the staging area (index) and 
the specific commit - with none provided, it implies your currently 
checked-out position (referred to as HEAD), usually being your 
latest/previous commit, which is exactly what you`re interested in.


As a side note, if you think you don`t need it, you can skip staging 
area and commit all the modifications/deletions without a need of 
adding them first by using `git commit --all`, as per git-commit[3] 
documentation.

Just pay attention that untracked files are not affected, you still 
need to add them first to tell Git to start tracking them, including 
them in the next commit, but that seems to align nicely with your 
expectations already.

I personally find the staging area to be one of the greatest Git 
possibilities, but I do understand beginners getting confused by it, 
as admittedly I once was myself.


In the end, you may want to ask questions like this on Git users 
mailing list[4] on Google Groups, being a a nice place for beginners 
to get answers to their concerns.

[1] https://git-scm.com/docs/git-add
[2] https://git-scm.com/docs/git-diff
[3] https://git-scm.com/docs/git-commit
[4] https://groups.google.com/forum/?fromgroups#!forum/git-users

Regards,
Buga
