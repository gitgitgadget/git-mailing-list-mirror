Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF21BC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5BB64E23
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBOUDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 15:03:55 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:35092 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOUDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 15:03:53 -0500
Date:   Mon, 15 Feb 2021 20:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613419349;
        bh=G6uO24XR6sZQWF9MME5LygLFzRVet45OPCeRTQdtvU4=;
        h=Date:To:From:Reply-To:Subject:From;
        b=pJaoxxKchWmgKe5SEC0gRGHuK249oXIJU2qFcIRvVLMYCTwWAAgJWB8e7UA9rfdEO
         yS87lrUE0oqA93VclZbn1/kqNrBTcN+jJiBz3JBamQE7uPuL35lTCz/pjRAv2TXPUb
         YxniKDygOBBp/FHbgGlVKJs7DoHfkf/HFh4QVLOo=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   janek <27jf@protonmail.com>
Reply-To: janek <27jf@protonmail.com>
Subject: Short status ignores --show-stash option
Message-ID: <5ofQpdi3EmG_V-LqPrL6ZttzenOKG9xQ9MCdQ1OK7b_NcFZX0hqqmwr8mr2KByFwRa8ljzX4vj-_34Q6aPcXdZ8_qDahZfFSyJKj5cfyAjc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
git status --short --show-stash --branch

What did you expect to happen? (Expected behavior)
The status shows info about the stash, e.g. next to the branch infos

What happened instead? (Actual behavior)
--show-stash is ignored when using short format

[System Info]
git version:
git version 2.30.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.15-arch1-1 #1 SMP PREEMPT Wed, 10 Feb 2021 18:32:40 +0000=
 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh

[Enabled Hooks]
post-commit
post-checkout
post-merge
pre-push

Regards,
Janek
