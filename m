Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDA320248
	for <e@80x24.org>; Sun, 21 Apr 2019 05:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfDUFDc (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 01:03:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35087 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDUFDc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 01:03:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so7708698ljc.2
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 22:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1R5ql6vQyXcZlHoL/bza9PGQJK5AZOjOSyd5jOlr0vQ=;
        b=TjmwbFnawl4N5K2b6VaVeFraooYIzjO2CQzMQGF+jRMsRNVKBlBCwCIzGMnbuLlhCb
         aJ2tYK+g3NLiaWEYZlZNIzcLt6dYxR9+bOumUJXGUWV2Ct9xzOKkJk5kJ3d2ULhje34l
         O1mGs2qjPSValjPZXT9HmD9682A3+Bfu1qMTaeIlVllKvAVrofwrkfcIVzWUMA4YIiy0
         n24oO+P8PAnp0bZ4aLnKgEJS77UKSmOu1r+0qVGVdqOhYU7ZkVKmiPt32Bmq2wrqbQkf
         C1wT8mkAu/I4327Lp6vdRFItYXTQnUjjQ7MVfs7knF5mErgrGPpFr8GbLH3je39qNUTj
         bv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1R5ql6vQyXcZlHoL/bza9PGQJK5AZOjOSyd5jOlr0vQ=;
        b=cujfd2C9x0CjJnSaI2AtKwgN0br/N6nmea3eybLT02HAzyEcV2lCYKBcNluTR1LeL0
         Bylb3cddJccHI4Tm1+fBkN16k1Te4ZH4U2hF6CanDpLxWsk5jAEhCT82nERHt1bP2zb7
         bfpPEllgdVRtIL99P5LMA7eHPZbvhmCFVeoaQPXhJ9WGhyWS0hkZW7oP78WW8Vl//sU6
         j2fBIwv/QmL7xOIrbqslZV0BHqnBrCgS0g22JfcOcHk88PxTCR9lp3c0VOnlKvbmL2oT
         /nZQ/WHxT2xJpGBN82oXo9iEff/oupTQM6m3uXQBbHmTcJuaBAZXctBbAC5JIIwxCQET
         lnHw==
X-Gm-Message-State: APjAAAXNNvqXjGsPhtuaQpDJnCEtw5CHgS+doVMQCRi5sBcJRcLKrEHC
        5P9UaPYytuNIIu5o9Wv0dZVfTRIQF5zvouyWYJc=
X-Google-Smtp-Source: APXvYqy5m80VnPHYH3lK8GZVWk5clagJIxJsTiWeDclwZ7AVtFLShp9kmRmAQHeG4qSTxMKoqP+sjpKJ65/GWbqwQzM=
X-Received: by 2002:a2e:219:: with SMTP id 25mr6700162ljc.34.1555823009986;
 Sat, 20 Apr 2019 22:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
In-Reply-To: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
From:   Adrian H <adrianh.bsc@gmail.com>
Date:   Sun, 21 Apr 2019 01:03:17 -0400
Message-ID: <CAP_kE8XaFW=G1f_qrS2sEp+ELQ9otk=j0-ZtbF1dATQX8ZjrAA@mail.gmail.com>
Subject: Re: I messed up my own git tree and I don't know how to fix it.
To:     rob@drrob1.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I understand the commands you are using correctly, you are
referencing the remote repo.  You need to reference the local repo.
So try using the following commands:

git checkout -- alecthomas/gometalinter
git checkout -- kisielk/errcheck
git checkout -- rogpeppe/godef

Or if those are the only files that have been modified, then you can
use the following single command:

git reset --hard

and that will reset all files that have not been staged.

HTH


A


On Sat, Apr 20, 2019 at 11:22 PM rob <drrob100@fastmail.com> wrote:
>
> I have my own code at a github repository, using Go.  Part of using Go
> libraries not part of the official Go people is by using a system they
> call go get.  This essentially uses git to, well, go get source code.
> Mine are at github.com and golang.org.  My computer runs LinuxMint 19.1.
>
> I used goland IDE from jetbrains to run go fmt on my entire project.
> Now I am getting this message that I cannot get rid of:
>
> changes not staged for commit:
>
>    modified: github.com/alecthomas/gometalinter (modified content)
>
>    modified: github.com/kisielk/errcheck (modified content)
>
>    modified: github.com/rogpeppe/godef (modified content)
>
>
> I do not want any changes to central repos to be tracked or committed,
> but I cannot undo this.  I tried, for example,
>
> git checkout -- github.com/alecthomas/gometalinter
>
> I don't get an error message but it does not do anything.  The file is
> not changes, and git status show me the same information, ie, these
> files have changes not staged for commit.
>
> I do not know how to restore these files to the state they were in in
> the repo, and to have my own git tree not to flag this as an unstaged
> alteration.  Running rm -rfv on the repos on my computer, then running
> go get to restore them does not change git status. It still sahs changes
> not stated for commit: modified.
>
> This happens for the above 3 tree items.
>
> How do I restore these to the github remote repository condition and not
> have my own git tree mark these as changed?
>
> --rob solomon
>


-- 
========================================
            Adrian Hawryluk
         BSc. Computer Science
----------------------------------------
           Specialising in:
        OOD Methodologies in UML
  OOP Methodologies in C, C++ and more
        RT Embedded Programming
            GUI Development
========================================
