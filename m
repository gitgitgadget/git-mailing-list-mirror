Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66E6202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbdGMPVM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:21:12 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36400 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdGMPVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:21:11 -0400
Received: by mail-it0-f50.google.com with SMTP id m68so42337657ith.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LpLxlFnqcj0k2PGGUpADcKTgAfbHQf6F30ZWKiAf3CA=;
        b=tcSQPbIJT1GjszRBds4/53r1bP//OFpzEkCwglfzU2wti809Z8YpaWGj4fOxYg6mXw
         4NhnmxurfcNASfaypvecwUEi4Ussrz4d5Oe+oGIyRCtYLjNDOfug1zSqUED00BsQsQAP
         cqd0x6gdED2G4YCmBB9H0xlsxo38AikWeC1EEcsTGcbfTaTsZK2u6pZhcRRL0AHvZ4B0
         souGNMGTENnAnwGX/c2sg9Lj57TYZ0iDU0cGjNF4+iHudEc55+cTrgMbjzzcbkkY3XWD
         isCCU+wAYc+ibK+iOIqqcmHS5exvqJByIcUO9PzXtX+rCN+RhipSw1cDwrZQ0wZOTk/j
         c2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LpLxlFnqcj0k2PGGUpADcKTgAfbHQf6F30ZWKiAf3CA=;
        b=eqQoG19KtUBdV92Y7dYnpeeEbYwwAGVAtW4IrFyYxfrKdFe9vXblUU8NBM3djAhyug
         GUIscx5Echc8aYhHpT7rQVh0GrNtgPma0idJIfTjW5EbncWI2K9hlNOrKCeSN3kySvjc
         Yi/8UAMC36Xw/GNUyi66Lp54xIxdeyjBcNmdr0y8TLKSJj//di3aE2Q6fLmIGvpVrWk7
         nO+wvckCA+ypnobF9uRXoFqj1Gw9eCf54lvs0I4VXQnzbHOcFFfhwbPE8CWqKrJCZ2EP
         UZqE0UkcuuvzPcWqxgyhw10BirQ9VEgLcD11eqtlozIojLRM1iIQzH+s5mQFXZFB9bVd
         eB7Q==
X-Gm-Message-State: AIVw112nSre6TBxJ377OfbI2sMgQ6f1X04gcizxzSXhVOZQHZYUHmxqc
        YHEA2FDuUWyGNwJTArxP1vbFJxSZgw==
X-Received: by 10.36.68.193 with SMTP id o184mr13812826ita.59.1499959270657;
 Thu, 13 Jul 2017 08:21:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Thu, 13 Jul 2017 08:21:09 -0700 (PDT)
In-Reply-To: <5FDE1F7C-9C01-4C50-996C-920F6E0E2DCB@gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com> <CAEcERAxR_G-tVKsUZ7G97E5B8zCzBoqGqAK2U0fz-p5FvRwfUg@mail.gmail.com>
 <5FDE1F7C-9C01-4C50-996C-920F6E0E2DCB@gmail.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Thu, 13 Jul 2017 11:21:09 -0400
Message-ID: <CAEcERAyhyiQXyiJ_DdL_UaFMgYnQnxBqP_oFqAcjA6xHDOCZhw@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, this could work, but if I am adding new file to the
feature/removing the existing file from the feature, aliases usage for
"add" doesn't help much.
I would really need to have the lists of files... and attributes look
more promising.

On Tue, Jul 11, 2017 at 4:20 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On Tue, Jul 11, 2017 at 1:39 PM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>
>>>> On 11 Jul 2017, at 17:45, Nikolay Shustov <nikolay.shustov@gmail.com> wrote:
>>>>
>>>> Hi,
>>>> I have been recently struggling with migrating my development workflow
>>>> from Perforce to Git, all because of the following thing:
>>>>
>>>> I have to work on several features in the same code tree parallel, in
>>>> the same Perforce workspace. The major reason why I cannot work on one
>>>> feature then on another is just because I have to make sure that the
>>>> changes in the related areas of the product play together well.
>>>>
>>>> With Perforce, I can have multiple changelists opened, that group the
>>>> changed files as needed.
>>>>
>>>> With Git I cannot seem to finding the possibility to figure out how to
>>>> achieve the same result. And the problem is that putting change sets
>>>> on different Git branches (or workdirs, or whatever Git offers that
>>>> makes the changes to be NOT in the same source tree) is not a viable
>>>> option from me as I would have to re-build code as I re-integrate the
>>>> changes between the branches (or whatever changes separation Git
>>>> feature is used).
>>>> Build takes time and resources and considering that I have to do it on
>>>> multiple platforms (I do cross-platform development) it really
>>>> denominates the option of not having multiple changes in the same code
>>>> tree.
>>>>
>>>> Am I ignorant about some Git feature/way of using Git that would help?
>>>> Is it worth considering adding to Git a feature like "group of files"
>>>> that would offer some virtutal grouping of the locally changed files
>>>> in the checked-out branch?
>>>
>>> Interesting question that came up at my workplace, too.
>>>
>>> Here is what I suggested:
>>> 1. Keep working on a single branch and make commits for all features
>>> 2. If you make a commit, prefix the commit message with the feature name
>>> 3. After you are done with a feature create a new feature branch based on
>>>   your combined feature branch. Use `git rebase -i` [1] to remove all
>>>   commits that are not relevant for the feature. Alternatively you could
>>>   cherry pick the relevant commits [2] if this is faster.
>>>
>>> I wonder what others think about this solution. Maybe there is a better
>>> solution that I overlooked?
>>>
>>> - Lars
>>>
>>> [1] https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history
>>> [2] http://think-like-a-git.net/sections/rebase-from-the-ground-up/cherry-picking-explained.html
>>>
>
>> On 11 Jul 2017, at 19:54, Nikolay Shustov <nikolay.shustov@gmail.com> wrote:
>>
>> Thank you for the idea, however I am having troubles with basically
>> maintaining the uncommitted groups of files: I would prefer the clear
>> distinction that "those files belong to feature A" and "these files
>> belong to feature B", before I commit anything. Committing separately
>> every change for feature A and for feature B would probably a good
>> option unless I have many changes and then cherry-picking the proper
>> commits to create a single changeset for the integration would become
>> a nightmare.
>
> I see. Why so complicated with gitattributes then?
>
> How about this:
> Let's say you start working on featureX that affects file1 and file2
> and featureY that affects file8 and file9
>
> 1. Create aliases to add the files:
>    $ git config --local alias.featx 'add file1 file2'
>    $ git config --local alias.featy 'add file8 file9'
>
> 2. Work on the features. Whenever you have something ready for featureX
>    run this:
>    $ git featx
>    $ git commit
>
>    Whenever you have something ready for featureY run this:
>    $ git featy
>    $ git commit
>
> Wouldn't that work?
>
> - Lars
>
>
