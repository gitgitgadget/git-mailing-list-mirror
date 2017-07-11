Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605102035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbdGKWqJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:46:09 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34501 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754887AbdGKWqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:46:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id k67so1578261wrc.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4gPXPN+8aFj1ZdFiCfHq3HdBbHiW1p5yX3r1S18sJ+s=;
        b=ROYzAp6TiACS8tMX/ZC1Rdp3S5d9euV5FN05QaxkSBy66g9QzLyW71jZYJQLWE/S6h
         pvwWZXgyenabRrzn0b0QK66H498R2dX1UJh+Wx2RfEq8PmvFTWs/7V3l3xS9eZeR9Brn
         9n/QygUfM1SB+D6qh4J0vLsqtzs9kmpFu6Eo8E23MqzLGEYs8w2nhw122qZ/fus0LzzO
         yZfnoR0VNAxVpLoYRBKkxlmRbs+r/7+U0qwR6pwnj4OmB/LCh6zaMDjxKQJOlD7BOrzV
         3OMBFIy+XoRxxK6mkSMy1Fcfto3Ook3yJS3BOqNN4ubDQzIlgBY3ixvEE4zLgcG5P0On
         x4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gPXPN+8aFj1ZdFiCfHq3HdBbHiW1p5yX3r1S18sJ+s=;
        b=s6HbPU0Fqejr9vXyMEauimUi32Gwt1qZdg7D2l7Ydh3o16EF1O9Ts8cEtFL0KhVLcX
         vOLMyoaFyDBX84c6ZZO9ZgCuIlIj3qLfo0F3UlNvWSuNNIAxJ3IVMJpd66QY2fIGKSvd
         XOmOcnWpL+fQQ+d+wDNDDub/GaeQrMMzp7GSEU4Fv12R2Tzq+DF5GHp9MFH/55r9+Htt
         ZQhf+XNLqkQfece+hx3IhFKGod51fNmKKSXTXZ2HSVvnzmzEhde/MVHrOqUjTkZ/uU7w
         e6vgQvljaKc4ih/pNGXKwfXkSHvsnvBwvsRuI9jjE1m6+llp1WXjJqmuztR4sbzSJmwm
         JBCg==
X-Gm-Message-State: AIVw112+Q5vsXF7/VWMHc95R+43MOIPDM+ZN+YPSl3tLtQ0XDahzeiAx
        E5EOt3ibFM7tv91u+CDHNA==
X-Received: by 10.223.153.165 with SMTP id y34mr1178068wrb.41.1499813165851;
        Tue, 11 Jul 2017 15:46:05 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id 142sm538781wmi.1.2017.07.11.15.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 15:46:04 -0700 (PDT)
Subject: Re: "groups of files" in Git?
To:     Lars Schneider <larsxschneider@gmail.com>,
        Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     git@vger.kernel.org
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <6e4096fd-cbab-68f0-7a23-654382cb810e@gmail.com>
Date:   Wed, 12 Jul 2017 00:46:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For starters, let me say that I consider myself a mere advanced 
beginner Git user, and I haven`t used Perforce ever before (did some 
reading now), but still, for what it`s worth, here are my thoughts, 
please bare with me :)

Do feel free to correct me if I miss something.

On 11/07/2017 19:39, Lars Schneider wrote:
> 
>> On 11 Jul 2017, at 17:45, Nikolay Shustov <nikolay.shustov@gmail.com> wrote:
>>
>> Hi,
>> I have been recently struggling with migrating my development workflow
>> from Perforce to Git, all because of the following thing:
>>
>> I have to work on several features in the same code tree parallel, in
>> the same Perforce workspace. The major reason why I cannot work on one
>> feature then on another is just because I have to make sure that the
>> changes in the related areas of the product play together well.
>>
>> With Perforce, I can have multiple changelists opened, that group the
>> changed files as needed.
>>
>> With Git I cannot seem to finding the possibility to figure out how to
>> achieve the same result. And the problem is that putting change sets
>> on different Git branches (or workdirs, or whatever Git offers that
>> makes the changes to be NOT in the same source tree) is not a viable
>> option from me as I would have to re-build code as I re-integrate the
>> changes between the branches (or whatever changes separation Git
>> feature is used).
>> Build takes time and resources and considering that I have to do it on
>> multiple platforms (I do cross-platform development) it really
>> denominates the option of not having multiple changes in the same code
>> tree.
>>
>> Am I ignorant about some Git feature/way of using Git that would help?
>> Is it worth considering adding to Git a feature like "group of files"
>> that would offer some virtutal grouping of the locally changed files
>> in the checked-out branch?
> 
> Interesting question that came up at my workplace, too.
> 
> Here is what I suggested:
> 1. Keep working on a single branch and make commits for all features
> 2. If you make a commit, prefix the commit message with the feature name
> 3. After you are done with a feature create a new feature branch based on
>    your combined feature branch. Use `git rebase -i` [1] to remove all
>    commits that are not relevant for the feature. Alternatively you could
>    cherry pick the relevant commits [2] if this is faster.
> 
> I wonder what others think about this solution. Maybe there is a better
> solution that I overlooked?
> 
> - Lars
> 
> [1] https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history
> [2] http://think-like-a-git.net/sections/rebase-from-the-ground-up/cherry-picking-explained.html

This "single branch, related commits" approach is exactly what came 
to my mind as well.

But, isn`t Perforce "changelist" an "atomic" group of changes - like 
"commit" in Git, "changeset" in Team Foundation Version Control, 
etc...?

If so, it would mean that this "multiple pending changelists" flow 
would/should be translated to "multiple pending commits" in Git, 
where in the end _a single_ Perforce "changelist" is _a single_ Git 
"commit".

Might be this is where the confusion is coming from, trying to fit 
natural Git "multiple commits per feature" (but "single feature per 
branch") concept into a "single changelist per feature" Perforce 
concept, described/required here?

I don`t think there is a firm concept of such "multiple pending 
commits" in Git, but the point is the author is having multiple 
changelists/commits, and it actively updates them (the _same ones_), 
until they`re ready to be merged (submitted, in Perforce)... which 
you can do in Git, and might be quite easily :)

So... In Git, you can create a separate commit for each changelist 
you have in Perforce (all these commits being on the same branch, as 
desired). Then, when you would have wanted to "update" the pending 
Perforce changelist (not sure what the corresponding command is in 
Perforce), you would just `git commit` your current state with 
additional "--squash" or "--fixup" parameters (depending on if you 
would like to add more description to existing/original commit 
message, or not), and the original commit SHA1.

In the end, when everything is tested together and you would like to 
commit features separately (like submitting changelists in Perforce), 
you would just need to `git rebase -i --autosquash` your branch, 
where Git would squash all your "update" commits (fixup/squash ones, 
that is) to the original/initial ones you made as per your 
changelists/features. No need for manual rearranging, cherry-picking, 
or whatever.

An example flow, with two "changelists" for two features (I`ll be 
using capital letters A, B, C... instead of commit SHA1, for 
simplicity):

	... do some "Feature 1" work...
	$ git commit -m "Feature 1"
	... do some "Feature 2" work...
	$ git commit -m "Feature 2"
	... do some "Feature 1" work...
	$ git commit --fixup A
	... do some "Feature 1" work...
	$ git commit --fixup A
	... do some "Feature 2" work...
	$ git commit --squash B
	... do some "Feature 1" work...
	$ git commit --fixup A
	... do some "Feature 1" work...
	$ git commit --squash A
	... do some "Feature 2" work...
	$ git commit --fixup B


Branch history would look something like this (H is latest commit):

	H fixup! Feature 2
	G squash! Feature 1
	F fixup! Feature 1
	E squash! Feature 2
	D fixup! Feature 1
	C fixup! Feature 1
	B Feature 2
	A Feature 1


When you finally do `git rebase -i --autosquash A^`, you should get a 
list like this[1]:

	pick A Feature 1
	fixup C fixup! Feature 1
	fixup D fixup! Feature 1
	fixup F fixup! Feature 1
	squash G squash! Feature 1
	pick B Feature 2
	squash E squash! Feature 2
	fixup H fixup! Feature 2


Once rebase is finished, you`ll end up with branch history looking 
like this:

	B' Feature 2
	A' Feature 1

... where commits A, C, D, F and G have been squashed into a single 
commit A', and commits B, E and H have been squashed into a single 
commit B'. These two single commits should correspond to your two 
Perforce changelists.

Now you can merge your commits separately, as desired ("submit" the 
"changelists").

You can even first rearrange/split/squash them further, or make 
separate branches out of them, whatever you find appropriate - you 
can do whatever you like to them while they`re your local commits 
("pending changelists"), before making them live/visible for other 
users as well (merge them to a public branch, "submit changelist").

p.s. Doesn`t the flow required here look similar to Mercurial patch
"queues" approach (again, resembling "quilt" functionality)? If so, 
"Guilt"[2] may be an option here as well... if the described flow 
can`t be altered a bit to align better with Git itself, might be 
profiting on the side of overall workflow simplicity ;)

[1] Having commits automatically grouped/ordered, you can even 
    replace some "fixup" and "squash" with "reword", for example, so 
    those commits are kept as separate ones, providing you a chance 
    to edit their messages.
[2] http://repo.or.cz/w/guilt.git

Regards,
Buga
