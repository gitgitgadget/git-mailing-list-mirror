Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D53C33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 20:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0289E2080D
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 20:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="p/lww4cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgALUlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 15:41:14 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:11525 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732914AbgALUlO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 15:41:14 -0500
Date:   Sun, 12 Jan 2020 20:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578861672;
        bh=BlmF8BHytAXtFcvVST9pY8sDkgxHZAmQvoqd0vgxFtk=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=p/lww4cmx/UQfj2c1+/ag9AS40tb5NGykUxl1AB52ifofxUdUU7Nw2ic7xylqYAFB
         1cYTe7ofuF3fFQMtcVNM4jwYzP7cFoEoeWtu1jiuJJJO4sVrOrwIOejDzmFHa7Gk/e
         ZYUQqDLfiziA2g5RL518gbhxh7dJeEZy3wxUYzQM=
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   1234dev <1234dev@protonmail.com>
Reply-To: 1234dev <1234dev@protonmail.com>
Subject: Re: [Feature request] An easier way of rebasing if you just want to "force send" a file back to a previous commit
Message-ID: <XqPlWEhzUXEI3NHYcd-yQnaXz7zMf6ycdm9hOZasaDWbWDBvmD3RCjGulYYsftUu6nbS79rvwZp1n1DNMqWgEW3UYWKo5linu1BsyHKScBw=@protonmail.com>
In-Reply-To: <20200112195646.GQ6570@camp.crustytoothpaste.net>
References: <jvRjyPq1IXAbIqfIOfEu2KxNKCMq9ktnAlVF9jGrccIvlPt22V62Ic8j0dHvLDOS31YrHZ2_t8ldgUTgJQHGdsMiYhnpYJJmOlJQFwiif_8=@protonmail.com>
 <20200112195646.GQ6570@camp.crustytoothpaste.net>
Feedback-ID: jm_lYfXrrNlRjeoYk2ubMr1Ofg3d6jxZVz74GfYfMumLfq3Q9_Z5n8vqkvDBYWSlKkQ9TIGL2Vvi-4DSzBFTyQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Very cool :-)

Thank you so much for making my life easier! Have a good day :-)

Best regards,
Jonathan


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday, January 12, 2020 7:56 PM, brian m. carlson <sandals@crustytoothp=
aste.net> wrote:

> On 2020-01-12 at 19:42:46, 1234dev wrote:
>
> > Hello!
> > I'm pretty new to all of this, but I was wondering. Is there an easier =
way of rebasing if you just want to force send a file back to a previous co=
mmit? Rebasing can get quite tiresome in the long run. It's like 7 steps, a=
nd that's without the merge conflicts someone with my luck is guaranteed to=
 run into.
> > For instance, say I've made changes to a file. Those changes are too ti=
ny and insignificant to make a new commit out of - they actually ought to b=
e part of a commit I made last night.
> > If there just was a way to cheat :) I'm aware it would rewrite my entir=
e history but that's okay, I haven't shared my repo with anybody yet. Maybe=
 something along the lines of "git rebase --off-she-goes <file> <hash>"?
> > As opposed to "git stash && git rebase --interactive '<hash>^' && <chan=
ge pick =3D> edit> && <apply changes manually> && git add <file> && git com=
mit --amend && git rebase --continue && git stash pop && <merge conflict th=
at requires manual intervention> && git rebase --continue && git stash pop =
&& <still a conflict> && rm <file> && git checkout <file> && <repeat the wh=
ole process> && <still a conflict> && <go to IRC and ask for help>
>
> The way I usually handle this is something like the following, although
> I have some helper aliases that wrap this:
>
> git add <file>
> git commit --fixup <hash>
>
> git stash # if necessary
> GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash
>
> That does use the interactive machinery to apply the fixup commit, but
> it also avoids prompting you to edit the interactive TODO list. It
> doesn't avoid the merge conflicts which can occur, but it is (IMO) the
> easiest way to go about it.
>
> If I'd like to edit the message, I use "git commit --squash" to add the
> comments I'd like to add and I'm only prompted to squash together those
> messages.
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------
>
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


