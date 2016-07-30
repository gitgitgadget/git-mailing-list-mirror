Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204041F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcG3RXR (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:23:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35595 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcG3RXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:23:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so20033886wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:23:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nQVYBkxukmKcsQDO7qdW84Pf4CwuyYsIgt+0URYYpgM=;
        b=jrJUcI98Wtf43ypg33Gq7wxqSPl1LgVqYOVhrRdHhJO8cHKFUzJANils08TwftTCN4
         ZKOsYFsQCCEIAtSno8w4/Wt3hIkOqKdseAFxTLDxZmTlAGXdjfqTrh1FNJkHGwtHM8wY
         wquRRSkCzyoII8loLeOF6ahXeoQv93FRdtzqm9YyhJr8gT/c+ZLRfA35d8LiKzUZbaxg
         M1tTNeUDTFDa2gu5B0LAo69gIl11hr3KH0R4nqFdWx0fd7K0UWlyf+yOd63HcZisNe1O
         9D/DbltQ9LGvnwm71c7oCRBAYPiXboLN0QGfrTXZCwu9RWX1yNIe455INE+M3zsODJVH
         qA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=nQVYBkxukmKcsQDO7qdW84Pf4CwuyYsIgt+0URYYpgM=;
        b=Fpt9D2R9vbBpKnHARzjOUB8S9czN7EcV066pFKu+ej3aUz0lqxzIRW25jhaVXEgkVY
         YXO2Mih7tczL7TP6n/AbudF5f8bmEmiyEn61gyYTgi3oHZKXbinY/UXtImzsf9X+2dzr
         nZvDH+4NunfmBdR3HbdtDgpu3dTw1wfzITIMLNPEtyQJLJ32qHJ1uUF9we7uenHCvXor
         RnwHp18IBGdTVd6QsOCR5lXId4kTKnG1PSuQ1H6fR8tvzw171pMSAU5UsuPQhQENv+iB
         94Vwf1Xw/z19OgS7RdPN6DhHkaOT3fGJ5zLlSGNUVT5teXqYrcx1T20tcpTB0Q69Z+Pk
         8kQg==
X-Gm-Message-State: AEkoouvneOcKKa6zN/zZPrHB+dfK9dyBstaqoiNagd1cFs5aoa4psEvWwZZjCGJxf+aHZg==
X-Received: by 10.28.25.135 with SMTP id 129mr6080782wmz.59.1469899394375;
        Sat, 30 Jul 2016 10:23:14 -0700 (PDT)
Received: from [192.168.1.26] (dax57.neoplus.adsl.tpnet.pl. [83.23.23.57])
        by smtp.googlemail.com with ESMTPSA id za2sm22069594wjb.34.2016.07.30.10.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 10:23:13 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] status: update git-status.txt for --porcelain=v2
To:	Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
 <1469567483-58794-8-git-send-email-git@jeffhostetler.com>
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <fe5d1dd7-11da-e09b-5880-cf103e34fb9a@gmail.com>
Date:	Sat, 30 Jul 2016 19:22:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1469567483-58794-8-git-send-email-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 26.07.2016 o 23:11, Jeff Hostetler pisze:

> +Porcelain Format Version 2
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Version 2 format adds more detailed information about the state of
> +the worktree and changed items.
> +
> +If `--branch` is given, a series of header lines are printed with
> +information about the current branch.
> +
> +    Line                                 Notes
> +    --------------------------------------------------------
> +    # branch.oid <commit> | (initial)    Current commit
> +    # branch.head <branch> | (detached)  Current branch
> +    # branch.upstream <upstream_branch>  If set
> +    # branch.ab +<ahead> -<behind>       If set and present

"If set and present" means "If upstream set and present", isn't it?
Well, it is a shortcut, and I think easy to understand.

> +    --------------------------------------------------------

This is a nice change, available because of lack of backward
compatibility with v1.  The porcelain v2 format branch-related
information could be enhanced without risk of breaking parsers,
or having new information put at the end even if it does not fit
there (like in previous iteration).

One thing that can serve as goal for the series is using the
question: would it make __git_ps1() from git-prompt.sh be able
to render fully decorated prompt with all bells and whistles,
and with all combinations of options.  Thus beside upstream
in the future we might want SVN upstream, and/or pushed-to
remote branch (and remote push upstream repository), etc.

But that's for the future (and it is possible for the future)...

> +
> +A series of lines are then displayed for the tracked entries.
> +Ordinary changed entries have the following format:
> +
> +    1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
> +
> +Renamed or copied entries have the following format:
> +
> +    2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><nr> <path>\t<pathSrc>

Nice solution to avoid those all zeros / null-SHA1s

> +
> +    Field       Meaning
> +    --------------------------------------------------------
> +    <XY>        A 2 character field containing the staged and
> +                unstaged XY values described in the short format,
> +                with unchanged indicated by a "." rather than
> +                a space.
> +    <sub>       A 4 character field describing the submodule state.
> +                "N..." when the entry is not a submodule.
> +                "S<c><m><u>" when the entry is a submodule.
> +                <c> is "C" if the commit changed; otherwise ".".
> +                <m> is "M" if it has tracked changes; otherwise ".".
> +                <u> is "U" if there are untracked changes; otherwise ".".
> +    <mH>        The 6 character octal file mode in the HEAD.
> +    <mI>        The octal file mode in the index.
> +    <mW>        The octal file mode in the worktree.
> +    <hH>        The SHA1 value in the HEAD.
> +    <hI>        The SHA1 value in the index.
> +    <X><nr>     The rename or copied percentage score. For example "R100"
> +                or "C75".
> +    <path>      The current pathname.
> +    <pathSrc>   The original path. This is only present when the entry
> +                has been renamed or copied.
> +    --------------------------------------------------------
> +
> +Unmerged entries have the following format; the first character is
> +a "u" to distinguish from ordinary changed entries.
> +
> +    u <xy> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
> +
> +    Field       Meaning
> +    --------------------------------------------------------
> +    <XY>        A 2 character field describing the conflict type
> +                as described in the short format.
> +    <sub>       A 4 character field describing the submodule state
> +                as described above.
> +    <m1>        The octal file mode for stage 1.
> +    <m2>        The octal file mode for stage 2.
> +    <m3>        The octal file mode for stage 3.
> +    <mW>        The octal file mode in the worktree.
> +    <h1>        The SHA1 value for stage 1.
> +    <h2>        The SHA1 value for stage 2.
> +    <h3>        The SHA1 value for stage 3.
> +    <path>      The current pathname.
> +    --------------------------------------------------------

A question: do unmerged entries always have only one single filename?
Or unmerged entries are always only about CONFLICT(contents), and no
other?

Would a note (or a link to other documentation) about octopus merges
be out of place here?

> +
> +A series of lines are then displayed for untracked and ignored entries.
> +
> +    <x> <path>
> +
> +Where <x> is "?" for untracked entries and "!" for ignored entries.

A question: are they displayed in that order, i.e. first all untracked,
then all ignored, or it is something one cannot rely about?

> +
> +In all 3 line formats, pathnames will be "C Quoted" if they contain

"C Quoted" or "C-Quoted"?  How it is described in other places of
the Git documentation?

> +any of the following characters: TAB, LF, double quotes, or backslashes.
> +These characters will be replaced with \t, \n, \", and \\, respectively,
> +and the pathname will be enclosed in double quotes.
> +
> +When the `-z` option is given, a NUL (zero) byte follows each pathname;
> +serving as both a separator and line termination. No pathname quoting
> +or backslash escaping is performed. All fields are output in the same
> +order.

Does it mean that

    2 [...] <cq-path>\t<cq-pathSrc>\n

line (including line terminator) is replaced with

    2 [...] <path>\0<pathSrc>\0

that is, it replaces a separator (TAB, "\t") and line termination (LF, "\n");
here spelled in full?

BTW. do we have name for "C-Quoted" paths?

> +
>  CONFIGURATION
>  -------------
 

