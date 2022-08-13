Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EAAC00140
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 03:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiHMDQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 23:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHMDQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 23:16:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A10186C3
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 20:16:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so3353868edb.9
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 20:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=XeGnfRu6VA0Vtb3Uha0DNnOyaFsP8pQquz3WQ2moiLM=;
        b=Xdpl+0W5E06XeEH6vBfB82RU0Xa/iCwLUL7G9d0jgnfgo0tEumU+VXrY+nVqyaJZ9x
         Cgv8b0XylJwEiLeDUMLIg9XOk/jHirShAM3+RBfTAGtgVnizaAK0Ujdn9lY1HSL69w15
         fuijiKuvjKqo6juLQw02smtkilZKPYmPzjQIijaQHRyIfCPWhOHcRlADAHp71hUsVl4i
         AK2G98rAsgmzpniV/BOzxTVM15I4DDJ2dMwE4QBPBvZ2hgn64J1s9OAcU1hHR7CmguU/
         YSPvHpp3KK0bQncJa8cK+XpuxP02efhqBH3T3vZyxE5RmICDYZTNwyDmmPccTiq6ViX0
         zWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=XeGnfRu6VA0Vtb3Uha0DNnOyaFsP8pQquz3WQ2moiLM=;
        b=DpKYv+66arZmOpTiK16JqW4xEWna7FLCMTcM/AdNfBT5Kl8H1m1DrzZQQErB5SJML/
         awIc/7v7nXwtEy8XkKiTj+FEUFyD/WbiVGkiE4DmNwI3GdTSjvQ1tjLeF8i76v4/CXyf
         7Q1fBunKwU7koMcGG6h7bb6byB71hb4IBztjfx6g0ib7wrqznL98WrXXfpJsZ+9gVUAW
         kKOBCSr1chHF+OqpgS3W2zLy5otT2ZEnlqm+0ViXW6xnB+0ztXBN6FKRHdn9w/EmIGIC
         2jmyijtzrKb6K+AkTkySSjRuLVXOW67gT4V3yQrG6hmVdM2dkybnM2LngINvCavKiSY4
         DoWQ==
X-Gm-Message-State: ACgBeo3UF+wqE6qOYroyk85oApWjvFwYMJOMlACIiUEiznLUfYPCZOg3
        0fEPK8JWiTnzx+EvQb8KszA+2BPoLsUgBMWfnXjw/CyqlxM=
X-Google-Smtp-Source: AA6agR6DVYcRmB83C8vSWjnZsffGFbYj2Y4i5M4hBhuaKHaSP9u3Iq7NK8eA45xZaPfPtkcLS0O4KuxoqEBWxwyrets=
X-Received: by 2002:a05:6402:4301:b0:43e:4d31:6ec0 with SMTP id
 m1-20020a056402430100b0043e4d316ec0mr6038194edc.69.1660360562713; Fri, 12 Aug
 2022 20:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <6896FBE4-9160-4969-8969-D92F9FE19F14@gmx.com>
In-Reply-To: <6896FBE4-9160-4969-8969-D92F9FE19F14@gmx.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 12 Aug 2022 22:15:52 -0500
Message-ID: <CAMP44s2A7nJDVRPbixPPPtTedg_Q53CEdw+sBpGZwOfQG4EZSg@mail.gmail.com>
Subject: Re: "master" term - no one cares
To:     Ryan <rmrmail@gmx.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2022 at 10:10 PM Ryan <rmrmail@gmx.com> wrote:
>
> I installed the windows version of git today and was annoyed with the =E2=
=80=9Cwoke=E2=80=9D message stating that the =E2=80=9Cmaster=E2=80=9D branc=
h term will be changed to a different name to be more =E2=80=9Cinclusive".
>
> Don=E2=80=99t waste your time, just get rid of this annoying woke questio=
n in your installer.  Very annoying!!  No one thinks git has anything to do=
 with slavery.  On the plus side, git is great, I just started learning it.=
  Thanks!

This is not a Git issue, this is a Git for Windows[1] issue: they are
the ones exposing that message to their users at installation time.

You can raise the issue in their issue tracker [2], but I wouldn't
hold my breath.

[1] https://gitforwindows.org/
[2] https://github.com/git-for-windows/git/issues

--=20
Felipe Contreras
