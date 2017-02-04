Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA921F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 14:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbdBDOBr (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 09:01:47 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32956 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdBDOBq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 09:01:46 -0500
Received: by mail-oi0-f46.google.com with SMTP id w204so26246282oiw.0
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 06:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a2C6fx6m25EXi/G7aCJDQrIcMKOh3x3RhInJMB+tNN0=;
        b=t+1rS2R1RW445riqLVwfBsyo7yNEDbPnH6WJmHpf45NToM4cczpzVMfJSyw5a8Tebg
         lWlCTAfrWtb9ANRh/dxXmvEHYhu6sxdWsKfcTAvJW6uNKUIoOmBu86n0EPCtW4w0ckJi
         yGB3JcErs+p8bZh2sIdxJFOW9ZwB9iBl9Takin/njZbJQ4eXL+0KAS3q47dN2nSJ3E9p
         aL+2iVODCVz8qA4me/xGcjN8XNs+DL78jV4JC2Q8dRbk+EdsUGzZArNcmLoXXgq02jfb
         aqATUK6hS4V8v7uG5aq6dN2jsisA9N5pOH6yM7a44hbn8r/uT3WC9RNA01OCd7Jj8nBc
         L/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a2C6fx6m25EXi/G7aCJDQrIcMKOh3x3RhInJMB+tNN0=;
        b=rEtFsyhXx6HTkx8DFEuJ/UYLidCI9aWYA+JrTq4QvJcS+VMuDBYsVWI4MpH5rMv6w5
         1ls8YlTr+KQ4aLXpyX01YvP83//TKtOJ2QTho70rlp9Uqk3ge+qmdw1OerZ07hqevtY5
         C48jdH+3hE7yNkv36vHm2TDloS07aTtuGEylSItBNXg4dbN8rTZB5OTFBQ2MFy9Ft9+n
         /vQXP2i/ZjfXVGWCrR6OeLhfRAK9CncSJyM7ePcQg0gaK5EWD4l5f9Xu6OWCpGuJ+Pk8
         R2nlQ9PDMLjDpOL+dyVcgb3AX7VosEURCxednJfbrHWupzlSAJsiSMeMrWC9vlPglbf5
         gzHQ==
X-Gm-Message-State: AMke39kFGoGEWOaE0hr/aZhLqT0D0QO9QmG6C8Z5/AbdJ96uwkSgOuZUZ0mC2XBtd1aPQjqPieU/PbfPdBpnSA==
X-Received: by 10.202.173.18 with SMTP id w18mr1123795oie.146.1486216905394;
 Sat, 04 Feb 2017 06:01:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 4 Feb 2017 06:01:14 -0800 (PST)
In-Reply-To: <70ccb8fc-30f2-5b23-a832-9e470787a945@intel.com>
References: <70ccb8fc-30f2-5b23-a832-9e470787a945@intel.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Feb 2017 21:01:14 +0700
Message-ID: <CACsJy8A5AXs5jQUQAdb=tuBzWYKNbu5DPnQ88DXott8ht61egA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Feature_request=3A_flagging_=E2=80=9Cvolatile=E2=80=9D_branche?=
        =?UTF-8?Q?s_for_integration=2Fdevelopment?=
To:     "Herbert, Marc" <marc.herbert@intel.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2017 at 12:12 AM, Herbert, Marc <marc.herbert@intel.com> wro=
te:
> (Thanks to Josh Triplett[*] for contributing to this message)
>
> Hi,
>
> We often work with development/integration branches that regularly
> rebase, in addition to stable branches that do not. Git is used to share
> two different types of branches:
>   1. Pull requests and merged code with final SHA1s
>   2. Work in progress with volatile SHA1s.
>
> We=E2=80=99d like to have a consistent way to distinguish these two types=
 by
> advertising a branch as =E2=80=9Cvolatile=E2=80=9D.

I don't think we have branch metadata (besides reflog). The closet one
is probably config variable branch.<name>.description, which can be
picked up by format-patch to create cover letters. We could do
something similar, e.g. new config branch.<name>.volatile. The
commands can learn about it and apply special treatments if wanted.

But that would be local information only. We don't have ways to
transfer branch metadata (and we definitely don't want to just share
.git/config file with everybody). I suppose extending git protocol for
this is not hard (e.g. appending metadata in the "have" lines). The
hard part may be policy (e.g. what if the user does not want a branch
to be treated volatile by various commands even if it receives such
flag from a git server).
--=20
Duy
