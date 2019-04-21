Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0112520248
	for <e@80x24.org>; Sun, 21 Apr 2019 04:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfDUExx (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 00:53:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47029 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUExx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 00:53:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so11750277wrw.13
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dfBRLoDbbH43HX7sJxElzzI9ssQJlvQbvcTtBeIlYaM=;
        b=LcRgdV5+8CLpeC+cQbZJshhp8KlFScc4ihbstalU1ib8sTokOnn7ojZ9WZ06J2G4Wf
         CI2J0VjX8RX5zqMl5Xy1BEHLCC+qSCpi5jlQaLH6NdvYcrZ0VLe7VN0xXmF8gzE0+14q
         v9gzF337cjotF7SUeq6GUWzbtiT9/OnfFDj8/uq0Al7FoRdL7MvwVz/fgmoz7QmNNJqE
         /GUctuoFOknClBjOPSiv3Ho/InJusoDbu0VOKaZyU7uDEP793PDF9lFE6EFsv4Fbs7/X
         Pr0pJ7Ih4YW/KUUz+Fhd6frhvGKB5p0twVI4XG50jqh5vXFDnAikiikYE5koAHw8S++p
         93Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dfBRLoDbbH43HX7sJxElzzI9ssQJlvQbvcTtBeIlYaM=;
        b=e3IcWoE1zGO62dzSgsQz+eSYKUgYIKqawoNdE00rG/DMypEGdRmrygRdTyyyZjpfNU
         eWFau+GbQjzmzW7PFvrHe166BiRWOkBU353gLrLkki8L6mZRrSUcv6EJoTY7T27xyjtU
         kqoM/QAzR3l68Vq0UgVPxxQFfxv+5CSFygPhrs0iVnrcpMD/YWQ12Z3QyG067UtBPDLb
         GnKjAO95gTgaf57K2Mtz14vu83T+AtI0FdyBlFCLtMpv5ftdCt/UgXAir9nlI6IyDrFf
         t3R9nkQ2OeNpxF6NeZrdvW1e1TP0j+Q/CB0j6uGjvvuGXfjP4ozK383VN9Rw9fQXhLSa
         y7zg==
X-Gm-Message-State: APjAAAWiuds6fzhnQ5nIm944X0bbFJq50ugD13DJv64dkZGY2icWdMGU
        0XnZ1XcNau0YFvJjNFi9wmM=
X-Google-Smtp-Source: APXvYqw9xbI2EUU1gmar/pyjbwNXFzhe4o6xWqxDlPv1cQ6finB9k7bMw6Iwhx3Vwh4Dv4S4Qf67xA==
X-Received: by 2002:adf:f102:: with SMTP id r2mr8298660wro.136.1555822430962;
        Sat, 20 Apr 2019 21:53:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x18sm8164415wmi.6.2019.04.20.21.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 21:53:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] reset.txt: update the title line to cover all use cases
References: <20190419093011.5753-1-pclouds@gmail.com>
Date:   Sun, 21 Apr 2019 13:53:49 +0900
In-Reply-To: <20190419093011.5753-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Fri, 19 Apr 2019 16:30:11 +0700")
Message-ID: <xmqqpnpgc61u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> git-reset could be used in three different ways:
>
> - move HEAD to somewhere, optionally (not) update worktree/index
> - "move" HEAD to HEAD, mainly to update worktree/index
> - just update the index from some tree-ish
>
> The second case is frankly a (neat) corner case of the first one. But it
> makes it impossible for me to summarize git-reset in one line. Without
> it at least I could write "reset HEAD or the index".
>
> And even "reset all the things" is not correct because reseting worktree
> selectively is the job of git-checkout, not git-reset. Sigh.

I am not so sure if the current one is too bad.  The primary action
of the command is to reset the current HEAD to point at a specified
commit, and everything else it does is to make things consistent (in
other words, in line with having the HEAD at the given commit) with
respect to different requirements.  The "soft" reset wants to keep
the index and the working tree intact, the "merge" reset wants to
undo what a mergy operation would have done to the index and the
working tree if it started from a clean state, etc.  And "reset the
HEAD" is quite approiprate for a single line summary of what the
command does.  It perfectly is fine as long as the differences
brought in by having various "modes" are sufficiently described, I
would think.

> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 26e746c53f..e12d8edee6 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -3,7 +3,7 @@ git-reset(1)
>  
>  NAME
>  ----
> -git-reset - Reset current HEAD to the specified state
> +git-reset - Reset "something"
>  
>  SYNOPSIS
>  --------
