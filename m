Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1107C33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B45B21744
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 19:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="WXeRqXYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgALTmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 14:42:54 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:18006 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgALTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 14:42:53 -0500
Date:   Sun, 12 Jan 2020 19:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578858170;
        bh=rYGfg5oEnErS6vTZAEfohoRlzl4xNw7NvAtLDuWBCyA=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=WXeRqXYDGdpjmM2yH8+ECsJjhs/LFbR3ziWftJkm1AljuAhW+qDUSe+eFNIEkmbbK
         sxsG6e0Oy43e6fi7a1lt8mfPvYejAKfrMEz0jXNoMBGLnt6XT05UKXiGxW1jfRG9e9
         z+18mqJW4ZNYGA4J2HGrzgHTCnZvRD1guZIjpgu4=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   1234dev <1234dev@protonmail.com>
Reply-To: 1234dev <1234dev@protonmail.com>
Subject: [Feature request] An easier way of rebasing if you just want to "force send" a file back to a previous commit
Message-ID: <jvRjyPq1IXAbIqfIOfEu2KxNKCMq9ktnAlVF9jGrccIvlPt22V62Ic8j0dHvLDOS31YrHZ2_t8ldgUTgJQHGdsMiYhnpYJJmOlJQFwiif_8=@protonmail.com>
Feedback-ID: jm_lYfXrrNlRjeoYk2ubMr1Ofg3d6jxZVz74GfYfMumLfq3Q9_Z5n8vqkvDBYWSlKkQ9TIGL2Vvi-4DSzBFTyQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I'm pretty new to all of this, but I was wondering. Is there an easier way =
of rebasing if you just want to force send a file back to a previous commit=
? Rebasing can get quite tiresome in the long run. It's like 7 steps, and t=
hat's without the merge conflicts someone with my luck is guaranteed to run=
 into.

For instance, say I've made changes to a file. Those changes are too tiny a=
nd insignificant to make a new commit out of - they actually ought to be pa=
rt of a commit I made last night.

If there just was a way to cheat :) I'm aware it would rewrite my entire hi=
story but that's okay, I haven't shared my repo with anybody yet. Maybe som=
ething along the lines of "git rebase --off-she-goes <file> <hash>"?

As opposed to "git stash && git rebase --interactive '<hash>^' && <change p=
ick =3D> edit> && <apply changes manually> && git add <file> && git commit =
--amend && git rebase --continue && git stash pop && <merge conflict that r=
equires manual intervention> && git rebase --continue && git stash pop && <=
still a conflict> && rm <file> && git checkout <file> && <repeat the whole =
process> && <still a conflict> && <go to IRC and ask for help>

Might have gotten the above sequence of commands a bit wrong, I just learne=
d how to rebase a few days ago. But hopefully y'all get my point.

Thanks!


Sent with ProtonMail Secure Email.


