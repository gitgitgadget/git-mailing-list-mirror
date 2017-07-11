Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF092035A
	for <e@80x24.org>; Tue, 11 Jul 2017 20:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbdGKUUl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 16:20:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35804 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932351AbdGKUUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 16:20:40 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so796719wrb.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gRJHOLwcyKIeobN9gqvHVE3m4YtDiXzA/6QzBrGyYQM=;
        b=kDXQgdEuOX0PBzYNrQdtvdo5/y5oSF2fBKndD/AIVerR1i+LeHU+5iqvpXAkMw6z/f
         xlVrFXNcHIxvy89ylOV0sTtBSZ156Qj5UjcGC4hw2D1xh51JawyBbt7P3zYkaGC0mLPA
         QSwY82Hq6oTHvQERaoCfCq0phPvplQo30HPVWfjuJOFi9XsmhWDuLhDx0G+vaGoFGseO
         SR1DOLxRt+2MAXksQSO+gP2ddbVMCra7d4si7B80fWiypuf63a6q1lkmGl1/UAhcSiEs
         sIweaXYDt//mOSL4Cdibyn8DyiDOn/aH9phfmVQL61Q98X3KhF5HAtzVoekYWwrCI7J9
         8jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gRJHOLwcyKIeobN9gqvHVE3m4YtDiXzA/6QzBrGyYQM=;
        b=m4euicI46TmAp5HEIuakiKD1U+E3kF9H9Y8tBrGJkvmXPsFD2zJSATo4d7GXP2CsCB
         D/EQ3PAjnGosSih93HfRi/HtoyLqDPCP0LE/e1eIjDjbUkLvTKSQZnhafQ2ML+CVbVYS
         Ef5grO6QzX21dJcIdAVe63iV0FdRHLHpQz18/H911YETCHlB3FDzc2aVNyS759KoVJQ1
         z4EZwnr7qBGBc8wAp9jUL/OCyTadZrtYw7Q61MKEZzeg3zGaBA+8sRS3+YyzyMNPI/Yl
         OyVTRdpsfZW0GafArPgDkUxf8I56jwIm1xWIzVesAHuWkLAJnTpHFZ2x73OMGw1LFXYw
         4tMQ==
X-Gm-Message-State: AIVw112JrTSYOHvX6Dx5RbJTMoyFvNDE54LZH5E7EbK8dgr56Yy05EJk
        RsnW5xuZD5ting==
X-Received: by 10.28.105.28 with SMTP id e28mr69775wmc.42.1499804438857;
        Tue, 11 Jul 2017 13:20:38 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4E2D.dip0.t-ipconnect.de. [93.219.78.45])
        by smtp.gmail.com with ESMTPSA id v102sm299722wrc.53.2017.07.11.13.20.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 13:20:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "groups of files" in Git?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAEcERAxR_G-tVKsUZ7G97E5B8zCzBoqGqAK2U0fz-p5FvRwfUg@mail.gmail.com>
Date:   Tue, 11 Jul 2017 22:20:37 +0200
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FDE1F7C-9C01-4C50-996C-920F6E0E2DCB@gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com> <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com> <CAEcERAxR_G-tVKsUZ7G97E5B8zCzBoqGqAK2U0fz-p5FvRwfUg@mail.gmail.com>
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jul 11, 2017 at 1:39 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 11 Jul 2017, at 17:45, Nikolay Shustov =
<nikolay.shustov@gmail.com> wrote:
>>>=20
>>> Hi,
>>> I have been recently struggling with migrating my development =
workflow
>>> from Perforce to Git, all because of the following thing:
>>>=20
>>> I have to work on several features in the same code tree parallel, =
in
>>> the same Perforce workspace. The major reason why I cannot work on =
one
>>> feature then on another is just because I have to make sure that the
>>> changes in the related areas of the product play together well.
>>>=20
>>> With Perforce, I can have multiple changelists opened, that group =
the
>>> changed files as needed.
>>>=20
>>> With Git I cannot seem to finding the possibility to figure out how =
to
>>> achieve the same result. And the problem is that putting change sets
>>> on different Git branches (or workdirs, or whatever Git offers that
>>> makes the changes to be NOT in the same source tree) is not a viable
>>> option from me as I would have to re-build code as I re-integrate =
the
>>> changes between the branches (or whatever changes separation Git
>>> feature is used).
>>> Build takes time and resources and considering that I have to do it =
on
>>> multiple platforms (I do cross-platform development) it really
>>> denominates the option of not having multiple changes in the same =
code
>>> tree.
>>>=20
>>> Am I ignorant about some Git feature/way of using Git that would =
help?
>>> Is it worth considering adding to Git a feature like "group of =
files"
>>> that would offer some virtutal grouping of the locally changed files
>>> in the checked-out branch?
>>=20
>> Interesting question that came up at my workplace, too.
>>=20
>> Here is what I suggested:
>> 1. Keep working on a single branch and make commits for all features
>> 2. If you make a commit, prefix the commit message with the feature =
name
>> 3. After you are done with a feature create a new feature branch =
based on
>>   your combined feature branch. Use `git rebase -i` [1] to remove all
>>   commits that are not relevant for the feature. Alternatively you =
could
>>   cherry pick the relevant commits [2] if this is faster.
>>=20
>> I wonder what others think about this solution. Maybe there is a =
better
>> solution that I overlooked?
>>=20
>> - Lars
>>=20
>> [1] =
https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewritin=
g-history
>> [2] =
http://think-like-a-git.net/sections/rebase-from-the-ground-up/cherry-pick=
ing-explained.html
>>=20

> On 11 Jul 2017, at 19:54, Nikolay Shustov <nikolay.shustov@gmail.com> =
wrote:
>=20
> Thank you for the idea, however I am having troubles with basically
> maintaining the uncommitted groups of files: I would prefer the clear
> distinction that "those files belong to feature A" and "these files
> belong to feature B", before I commit anything. Committing separately
> every change for feature A and for feature B would probably a good
> option unless I have many changes and then cherry-picking the proper
> commits to create a single changeset for the integration would become
> a nightmare.

I see. Why so complicated with gitattributes then?

How about this:
Let's say you start working on featureX that affects file1 and file2
and featureY that affects file8 and file9

1. Create aliases to add the files:
   $ git config --local alias.featx 'add file1 file2'
   $ git config --local alias.featy 'add file8 file9'

2. Work on the features. Whenever you have something ready for featureX
   run this:
   $ git featx
   $ git commit

   Whenever you have something ready for featureY run this:
   $ git featy
   $ git commit

Wouldn't that work?

- Lars


