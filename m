Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5429CC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 07:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F83F20748
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 07:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdoVY+nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgC3Hdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:33:50 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]:45126 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgC3Hdu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 03:33:50 -0400
Received: by mail-qv1-f52.google.com with SMTP id g4so8400808qvo.12
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4GSqmOpPIaDFeNRvshmFBkEQzAELyCS18qsrWcfMmfM=;
        b=tdoVY+nHJa/YxOliO4RoyMeT8bL8Urluh4wHxFAGnolj8aysdqv5W/lY4gJoVs/nz0
         soP5NpnaZhaA5R+7aoWLD6ooNdYURPhf3zUFYCocpZWgkhQ1tYZafvb3Ts0JIYaPWcK3
         k9FixQtnDr6fvNVpIgTX9NcRM5h8UK1sSSvY4HHTePtuujIK1jSFpz3E7oM+fHcucxMC
         YG2RS2zAJey6/WT63ih/8u1V6nNGiJdgDOHXaXOWv8G0Fg5wxupPnbyQ9IxynxS0l4AQ
         Ayg1BCYwswma9ZXybTLl2Envch72401SAdBjSQbH2BioaMmoIec45PTEd/pwPtSM6hz/
         HHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4GSqmOpPIaDFeNRvshmFBkEQzAELyCS18qsrWcfMmfM=;
        b=DlR9k9qSWAij5Sl4gRHQnq5I3tqujFHuWAAj65/hMvQ/q/OYfxRXQcmkAoUcj06c57
         8pVghxDUMNjki3FEWQW5VBfqsBQSpD+beDBJeiGAhAoyLkSuCB8YZHdwp7hvP+ShN6Ss
         /CfmyAmIHmn3OHNll3Y2tHjaDXV3ZJ5rKXgvPLOJbcE7EeLQxXQtrpGcDRcjrTxizrRv
         94a+mun1Tq9HECCkYnxBr8aCpL7MeCNaitkTDIbKh4OgbKj/l1+UU7EEbU4x+4QR6rsd
         GyAqTefhMCup4XoVeLURbMTmD5UfIs1LnWYRR66zJJC2HyZmaS+rq/b0CrCrERnPWzER
         1VuA==
X-Gm-Message-State: ANhLgQ23OuMe0TUVZE4Exf91WQm6D5V0qGRCzr609SyGXtRhATZC4vqc
        NNN7z8KwcwRCMGvUN5kzZcr1AUmJjvh9NrsBdTJn3nJVcrk=
X-Google-Smtp-Source: ADFU+vuZ7HDQckM5I2rMi0leCPHtC2T6wmVYhiixzLAQpGIT7XvtdICE7+ILkgmf6afpsnhfWbFGij6cFR824bQOIDs=
X-Received: by 2002:a05:6214:2c4:: with SMTP id g4mr10669315qvu.65.1585553628933;
 Mon, 30 Mar 2020 00:33:48 -0700 (PDT)
MIME-Version: 1.0
From:   Angel Pan <dinoallosaurus1111@gmail.com>
Date:   Mon, 30 Mar 2020 15:33:38 +0800
Message-ID: <CAFk=nY7efz8ZisEuyAcU09J+ja4qE8LorUUPeupGVEjBBc6HDA@mail.gmail.com>
Subject: [GSoC] Question about microprojects
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone. Sorry I am late for GSoC application... But I am ready
to start contribute to git.
I am a freshman in Computer Science and this is my first time
contributing to git project.  I have already had some experience
working with C, shell and Perl. I found that there are several lines
of code in shell scripts using 'type' instead of "command -V", which
is not currently in POSIX standard but in XSI... See:
https://pubs.opengroup.org/onlinepubs/9699919799/
I thought that it would be better to use POSIX standard although many
common shell including 'type' as its built-in.
I would like to go through all the code and replace type with "command
-V" properly.
Is this worth doing so?
Thanks,
Angel
