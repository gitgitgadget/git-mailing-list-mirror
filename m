Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5865920437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932374AbdJaR4Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:56:25 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:51633 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbdJaR4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:56:24 -0400
Received: by mail-qt0-f177.google.com with SMTP id h4so21815922qtk.8
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ufyGWGt9SjkcSlqhMuck5zRqVvUa2cC2VzIZzkL2k8=;
        b=CWZjTcY5vKDsHr8ZUvWl34y1oJz2i3yWcAIQnD4juJv45S5M76fSCAiLuKA6Nb9DyO
         qfXBfWkCZbcmH88ucnC1YT0AJ7WcQaTzRK3hLTdI2z2J+64HwhUxEMFjXXN/X3M5ch2K
         ImbPUc17goPY4n8PgWfcuZvpH5DS2AT7d+l4kjP0fJAcmUBbIGM961C9Tv0yPbGMkSkd
         WnnmgPVL5MpW6QgduVLinfPFnSiRam/etgpG8iqAGSCu14IFv/Zn+EdpokBngTQFf+Q6
         9IiieGSuJXwd1FyeLAo1BGT9I6McX/SJF3LkWBaiaqfwyMUEvqbESnXJ26QarIBtORoi
         dQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ufyGWGt9SjkcSlqhMuck5zRqVvUa2cC2VzIZzkL2k8=;
        b=Wbd8YncNvoYtD+mO6/gPxAoRzu3cZVy/8zZ14jfxDiZOuvcRueo+VTxfx+QVq1fyVI
         +rXxslVy3slRiFDX3IP8Zcd0zmcUTbho40HquNlsvyOrSvvNt3t13BGo6+3oa5cGlb5S
         K3qfWKHSFaCA4TAzkZit3FiVDPMA9xlDACdmUxV8xK0VUpZeEOoEgK8+M7Q9OHtsE5e7
         4i9NneNpCpBOtSMOzdLi3vncfswGgo3E/cc2WlLlZBSbTsv/87AWkUf2Ml5XW6RCOA2w
         2mJMJkl/AsALCNDc0GcRfOZpNLGtxlQhsqginiwmzG5H2l1q+B3AeHmMUKRXDltwWlO3
         ezoQ==
X-Gm-Message-State: AMCzsaWj+cWFZFGCtKWVqsjNsIb8aIc/gBLNK63krerjGJjwZucmR+71
        oNciz2Idit2FkFkwI6N3Tozd2S7NvNTuiXAYIjZwElaHuIM=
X-Google-Smtp-Source: ABhQp+RkQw27qZfAW4vDrpiTOaXoZmVoLH5LRnzecWRWu+EXrctw6qNM+ZmsjTE04cZDIHuE/zCLndzLc3+xo57CbJY=
X-Received: by 10.200.8.53 with SMTP id u50mr4377184qth.260.1509472583428;
 Tue, 31 Oct 2017 10:56:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 10:56:22 -0700 (PDT)
In-Reply-To: <5829116.cWPNik6EL4@yoga>
References: <5829116.cWPNik6EL4@yoga>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 10:56:22 -0700
Message-ID: <CAGZ79kacD1Gw0tyPWv+1_PtFW-wM8SAjFTg_i2bk7ogPBvYn7Q@mail.gmail.com>
Subject: Re: Bug/Wish: bash completion for git pull --rebase doesn't include --autostash
To:     Albert Astals Cid <albert.astals.cid@kdab.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 8:21 AM, Albert Astals Cid
<albert.astals.cid@kdab.com> wrote:
> git pull --rebase --autostash
>
> is a valid command but the --autostash autocompletion is not suggested af=
ter
> typing
>
> git pul<TAB> --reb<TAB --au<TAB
>
> Would be great if that could be added.
>
> Thanks :)
>
> Albert
>
> P.S: I'm not subscribed CC me if need me to test something

Maybe you can propose a patch for this?

Rough steps to success:

  git clone git://git.kernel.org/pub/scm/git/git.git/
  cd git
  $EDIT contrib/completion/git-completion.bash
   (look for _git_pull)
  git commit -m "my first commit to git"
  (This is paraphrased, see Documentation/SubmittingPatches
   for a better idea how to craft commit messages)
  git format-patch HEAD^
  git send-email 0001-xxx.patch



>
> --
> Albert Astals Cid | albert.astals.cid@kdab.com | Software Engineer
> Klar=C3=A4lvdalens Datakonsult AB, a KDAB Group company
> Tel: Sweden (HQ) +46-563-540090, USA +1-866-777-KDAB(5322)
> KDAB - The Qt, C++ and OpenGL Experts
