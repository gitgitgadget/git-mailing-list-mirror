Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033461F576
	for <e@80x24.org>; Sat,  3 Feb 2018 09:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBCJCQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 04:02:16 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:34418 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeBCJCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 04:02:14 -0500
Received: by mail-it0-f44.google.com with SMTP id j21-v6so3327146ita.1
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p0Emy01O9WqMDMojmFtTRowcqo9PJ22y85yT8dJBklo=;
        b=OOUQ6zhrIKTZN9Ny2bWZswComaxuJsKnlLHDX7NHFpwYrXmIMgHf3jnd8pTyy+HWj1
         7kl9iAXQ0WNK82sn5kV5rLclCq/O6aZB5IXEjkxF+Go5ADPvYlGF5HIZ2HogU7iQZE94
         ucoKel25pvt3fHXqQX7DM+CMXvubswBAiEk5VD6rzD1GEJ5eiaM+k5vyG1lL3XJ98MkB
         BLexXRNBc7vtQygoq1L6NiW8ddI50WAf1TkAuKQRgcG9Z0Y3jEITU2THW+V8b6bPFmkz
         GZf33cucBHBQ8BBYCAoKXYPmiejk9NsmzKrm0ciLGPiI+L7WRuwJTx8Ox56zxV3lQ+wa
         Uc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p0Emy01O9WqMDMojmFtTRowcqo9PJ22y85yT8dJBklo=;
        b=DOx7O3J6w8jkDtPTAtHDOg23f7mw7hGQ8m+kNHpOtD6JksZ8B87awHjMZNRMWHIIIr
         j4/OpMgwp18KelxZGKkyLulpZmWogNX4L6naDUOYUxYIxRk3xnNdGjkTeYaKZyy8zAmx
         cUByk+m7xjaohqP8IA1yDpNeC9QgbyL6OTtBLwLAxHhkk6PluPpf8Pz11u6Q7xuUQ4QG
         uuk/s44Be7SHSyqxZLnPEJFxyRcpYezzvM3p6mVa/wkpTMEM4s7qIsPixAjd0AJWou0W
         863IPPfi/9DDPrUdZz5CUjILpES8zl1CkPy8RK5Zm4S1d3lsef/kFqT/5Mmcyx8OcfB2
         gA3w==
X-Gm-Message-State: AKwxytd4q79vgoYsVUfvHQuri3wtuiwmOwCv/nhxnLhiCPcecm+POOCI
        ut+/Uiaoy1N1izwP9Npf3mKe6lNDLkJZ5WzULEk=
X-Google-Smtp-Source: AH8x227N7u4zG1pkT7ExmLAYtQ39snkNj5kzvG5AqVPTHfRv+QfxiV1w1W6ip/bHk5G4pTydfAYOhhJ2fazov7rODj8=
X-Received: by 10.36.192.10 with SMTP id u10mr49117789itf.73.1517648533270;
 Sat, 03 Feb 2018 01:02:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.11 with HTTP; Sat, 3 Feb 2018 01:01:52 -0800 (PST)
In-Reply-To: <CAANr7CBNhkYJ=u8Bq-NG3KkSYY8yczJCt_25KcZU4VMFsS399A@mail.gmail.com>
References: <CAANr7CBNhkYJ=u8Bq-NG3KkSYY8yczJCt_25KcZU4VMFsS399A@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 3 Feb 2018 10:01:52 +0100
Message-ID: <CACBZZX4qH-w3YevoaW8RXAoFrjpfGerLWpBhetrO2tV-FGr3cQ@mail.gmail.com>
Subject: Re: error: unable to create file: Illegal byte sequence
To:     Brian Buchalter <bal711@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 3, 2018 at 4:17 AM, Brian Buchalter <bal711@gmail.com> wrote:
> I am attempting to repair a git repo which has an illegal byte
> sequence but am not sure how to proceed. Steps to reproduce: `git
> clone https://github.com/christopherpow/nes-test-roms.git` results in:
>
> ```
> Cloning into 'nes-test-roms'...
> remote: Counting objects: 1049, done.
> remote: Total 1049 (delta 0), reused 0 (delta 0), pack-reused 1049
> Receiving objects: 100% (1049/1049), 5.23 MiB | 8.97 MiB/s, done.
> Resolving deltas: 100% (406/406), done.
> error: unable to create file other/Duelito - L=EF=BF=BDeme.txt: Illegal b=
yte sequence
> fatal: unable to checkout working tree
> warning: Clone succeeded, but checkout failed.
> You can inspect what was checked out with 'git status'
> and retry the checkout with 'git checkout -f HEAD'
> ```

You can clone my fork of this which fixes the issue:
https://github.com/avar/nes-test-roms

As for fixing this yourself, if your FS can't represent files in the
repo the easiest thing is to clone it on a VM with an OS that can
(e.g. Linux), or alternatively (and harder for non-experts) is to
clone it with --bare and manually create a fixed tree with the various
plumbing commands mentioned in "man git".
