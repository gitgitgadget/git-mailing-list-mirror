Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48D7C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 16:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A26322284
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 16:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgJSQAJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 19 Oct 2020 12:00:09 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:43880 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbgJSQAI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 12:00:08 -0400
Received: by mail-ed1-f44.google.com with SMTP id dn5so10786055edb.10
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 09:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=No5bxocKqQ7TtVmIPK2TBqLtR+IF8LDiklvJ8cj5/fM=;
        b=a1ckl9XqQTh8xgOVMjRCco70ctigwTYx2DDrof6qM7+kFSh1i3cLasVrtm8kylgN6O
         ZuvT5ZcL/+ShYfBQCG04TIXDqnl/+ZPjF1N3GVzb/bE9uv7lbts4oLes+JXF2K3FfnLZ
         XwUZ2SSn40IQOEYsbeYpDWa6lX6yPFRUswHWJxe7c/VhkR/lgCQckAGDXrlcFkdpH99J
         3J0+w0Eyh0yAqshQssgzQ4yayaB3JDS3XcesLs6MyRGYNtk2sJ4uKgvXVuAkwm2vScj3
         I+jMRjMCn2kaC73n6BBBL72twH4VROTR7lEEuZ23YydcxoUQOubfl+rKIDA+mntl5qe8
         LZ+w==
X-Gm-Message-State: AOAM532wMGrNRY9tvHRudJ6Lh3GhzwVCfN9qkqGltghnKXbkBXNSrnGh
        DtUJcYpMs0bcCFwa/zEF6AkBFO5zXEVb2BkBmHP3JbVgRNAGXQ==
X-Google-Smtp-Source: ABdhPJyemzgkP3FFepu9I+vqAsMbOnZ89tGOnQlMUTDnrmV4GtutI/9OyJY+Sdr4/GlOkh5IeAEH+/HRC99Yn448Quw=
X-Received: by 2002:a05:6402:143a:: with SMTP id c26mr524917edx.150.1603123205023;
 Mon, 19 Oct 2020 09:00:05 -0700 (PDT)
MIME-Version: 1.0
From:   Sami Boukortt <sami@boukortt.com>
Date:   Mon, 19 Oct 2020 17:59:54 +0200
Message-ID: <CAAb+AL_xObsexRXL_fZdhj2FNQsOLzEz3_mZqd1Yz7F0=-havA@mail.gmail.com>
Subject: =?UTF-8?Q?French_translation=3A_incorrect_translation_for_error_?=
        =?UTF-8?Q?message_in_=E2=80=9Cgit_push_=3Cremote=3E=E2=80=9D?=
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just noticed a misleading translation. When running `git push foo`,
one can get an error message that looks like this:

> fatal: You are pushing to remote 'foo', which is not the upstream of
> your current branch 'the-branch', without telling me what to push
> to update which remote branch.

In French, that message is:

> fatal: Vous êtes en train de pousser vers la branche distante 'foo', qui n'est
> pas une branche amont de votre branche courante 'the-branch', sans me dire
> quoi pousser pour mettre à jour quelle branche amont.

which incorrectly refers to foo as a remote *branch*, as opposed to
just a remote.

In the error message for `git remote rename a b`, remotes are called «
serveur remote » (« fatal: Pas de serveur remote : 'a' »), so this
could be what to change the message to. « qui n'est pas une branche
amont » would also have to be changed.

Thanks.

Best,
Sami
