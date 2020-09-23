Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F3C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 14:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B2D214D8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cQimQXX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWOZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 10:25:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:57505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIWOZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600871116;
        bh=3/MsfZhcI/lfXPh0j1jysqxTNDtH0e1g2faq2vLoJMM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cQimQXX0/MMmqbyR2eNht5Vlngn/triemLlgHYGo2j47LVjv5enoqChVLuAwnhzvb
         M+/xqIqRAr6VgSInLSoBbfNWdeuwdDn3jV/51tpR/+hUggZ6fl6Bc+Asuor4rVXnFd
         KwFRW757vLBgayqBuu7RlV86+rffWgFn2NW8t1VI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1juw7X0IPH-00SSLU; Wed, 23
 Sep 2020 16:25:16 +0200
Date:   Wed, 23 Sep 2020 12:22:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
In-Reply-To: <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009231206290.5061@tvgsbejvaqbjf.bet>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com> <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yQx++7PERs+mSyafd9UY7yg/4370o4c2WwwZZ5YhU9dbfeAIGf/
 zvXkYMCvEU5DnRkmBFOpcR68lHasPaW8dS5nwQBvGCcTgXUntmYlTiB/y+yK+Yvp+dw8OCt
 XL4jvwpysJ3xIXOqXpxymA4FI636JVvyI1BQZSsAkuyWXh7Oh/xGev+JoinV6SUpPffAep7
 jPbjxIbS4/s+5c1HKntlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yk8wVDkqjAw=:2UJmwOEC1JM5gAuMXjoHgE
 lU2kRi5Swae+31cRy7Ggnjj6770Hv2l3Y84XINqzNTHqenSaDDf07M1uy1Ffw/T3ixoPDqXza
 G3vMrJll+wXJaKGaKvv1hGIvoIGmMCk+45ZMF5PAjIHjByBhvrF/UkWiMcFt+OqX1YtVPAIb5
 0nV6vY6N1wKlmsqyiuGzlkXenXtESeOJPxOLaN78Tckr3NBkc1iiuauqmyYQ3nk4rmFK5+gNx
 lmyA92spz2wBRhVS7DpPI9OPqM9n/0sur4px7wZH8cveXpsFgcUOS6BoSaoZcWiyk75AswOst
 LrZiGIPqKrJ/uHV/AMVEnz6PL1gm8N4bg9Zo/eh+vaB7OrPhNHe7N1k+a0EFKfii9K5KQLjS0
 EksgRm3pBSuuICsLc3fw5oETK+t5qvHP23z+ZtT4B4Wyz3/eLq0LEefSDRE1KLoTmVTwZXrFC
 HyfAd5UZbOy3/KNTHGcagto5QzwLT6ExN+1i6QHWDswQYUk0ZiHSfv11pmiDxtp+t54byx2Zx
 nk2KRZCvam7B/BSqe0NIoMbwB/+ysJ1TG0nCg9ZJbvGiv0xe5f7v2KLFIbGVjTfs/A6S7i9Iz
 aX7n6nlLEAXXqqErH3rKlhhuGXon39ltALbRu5G7ukBN7aA6U8U+cZ493Gf9itskVVekB+B7B
 PS0F6uKZhjgLvZsZM6+7BNPrvlX9JVAxIy9XTdoDIzalZ6TBv0aJ1Wmyz5di0v1OQuYJ92GmT
 u7nks8Ei2ORgkQvPqgu4eCZdMOuH8rVN1RyypSCYA7ZHxepje1bAZkMQ3a1tUIWa6P+35Cz/v
 Bh7B+y15rn770iN0icsDK7jk5Prb7RePPlAsbjl19XLCd2FkVToT0KubtMXijmDIkaPJFIaYQ
 /a4F6odnRfLKYArMqAXzOTNc85YbkcjJlpl9dRiyjCe4zKn7vvxuRmtOJOI64OHxF0CKpqUKe
 CoXUJb1F7zlwJU1Wli/7kYoS9WY7C+A9Hm8S462v4eTJ+iVDhxfnwcaIpBXeeCNgDm+n/VPvC
 BBprUxw9XdZC9ec+TlyCE4jMcjB0orO4kHqJEiqZim2AXXRmJxRi9cvkLDaU3XG7oQHPuxdEv
 Ak9qky4vanaraHUcoWTGCq/TkL8vByfqw6LmSIzr5Vv7vMuvi6n3YeJdQOmXYGIP96hJMYZYs
 CqEJuLHhDzHIFIxEE10hQem1RfnhhD5z0G5e99987WqB5h+BXes1ieG4sCoSK15yIbNSb0/LN
 cnII/Kyr5VsJTaamNv9yffFfJKfJaL/+6Smu0Ew==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 21 Sep 2020, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If one notices a typo in the last commit after starting to stage
> changes for the next commit it is useful to be able to reword the last
> commit without changing its contents. Currently the way to do that is
> by specifying --amend --only with no pathspec which is not that
> obvious to new users (so much so that before beb635ca9c ("commit:
> remove 'Clever' message for --only --amend", 2016-12-09) commit
> printed a message to congratulate the user on figuring out how to do
> it). If the last commit is empty one has to pass --allow-empty as well
> even though the contents are not being changed. This commits adds a
> --reword option for commit that rewords the last commit without
> changing its contents.

I would like to explain the idea I tried to get across when I proposed to
implement support for `reword!` (and `--reword`) because I feel that it
will change the design of this patch in a rather big way.

First of all, let me explain the scenario in which I long for the
`--reword` option: I maintain several patch thickets, the most obvious one
being Git for Windows' patch thicket that is merge-rebased [*1*] onto
every new Git version.

At times, I need to adjust a commit message in that patch thicket. It
would be quite wasteful to perform a full merge-rebase, therefore I
typically call `git commit --squash <commit> -c <commit>`, copy the
oneline, paste it after the `squash!` line (surrounded by empty lines), an=
d
then reword the commit message. When the next Git version comes out, I do
a merging-rebase, and when the editor pops up because of that `squash!`
oneline, I remove the now-obsolete version(s) of the commit message.

Obviously, I have to be careful to either also pass `--only` (which I
somehow managed to learn about only today) or I have to make sure that I
have no staged changes. In practice, I actually specify a bogus path,
which has the same effect as `--only`.

What I would actually rather have is the `--reword` option: `git commit
=2D-reword <commit>`. In my mind, this would _add_ a new, "empty" commit,
letting me edit the commit message of the specified commit, and using that
as commit message, prefixed with the line `reword! <oneline>`.

This, in turn, would need to be accompanied by support in the interactive
rebase, to perform the desired reword (which is admittedly quite a bit
different from what the way the todo command `reword` works).

With that in mind, I would like to caution against the design of your
current patch, because it would slam the door shut on the way I would like
`--reword` to work.

Ciao,
Dscho

Footnote *1*: In Git for Windows, I want to not only rebase the patches
(so that they are as ready to be submitted to the Git mailing list as they
can be) but I also want the commit history to fast-forward. The strategy I
settled on is the "merging rebase": it is a rebase that starts with a fake
merge of the previous commit history, i.e. merging it in using `-s ours`
so that only the commit history comes in, but not the changes. This allows
contributors to pull without problems, but also provides the benefits of
having a rebased version of the patches. The price is a rather big commit
history on top of Git's main branch, as Git for Windows' main branch
contains not only the newest iteration of its patches, but _all_
iterations (at least since the first merging-rebase).
