Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2425E203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbcGYWni (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:43:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35181 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbcGYWnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:43:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so18747415wmg.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 15:43:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VcVhrWXLRbta+R8dvOVAKCQXcDAhFPxd/afYkxWPFLU=;
        b=qukb7ay4yLtzmTD2aiT1/Pst17FPR9QBpwYjbaFRc2tEfKEVUjRjI6FUxoZQH9GY5X
         AZmKI/VyYDdmQ/1ug4fwywBibf3uqINaHAWnH+Jmnd0/RogrWBeaYF+twYIeV+yplosE
         I95LXYssU2gJadCaSbH2VVXERojwKjPYTMUYUPLr7+ev5gppMP3gotLDDUBHDZKroHJA
         o89UIWMnbowwbQBxcaqAu7eJOFAKrzSNKASG3ONGE0EB7S0Rc4WRfQZEdgrgkbl4wWi5
         9E9KKibGXNhnlpumd9x0kqgWsu4en0zL3+E5apjStOWHY1VqBv5uMQVC5Kz955kptvrS
         7EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=VcVhrWXLRbta+R8dvOVAKCQXcDAhFPxd/afYkxWPFLU=;
        b=jIHG918jvyfTfIxooaUUv4uqtNWp+gsNGuzwHHEijml/ZPnlufsZEtU02C2yGZ9mKa
         dHG1guIC+xB+JomLXVj1YhnO3Saf0PBwCJA0JKcA9aeSojX7Q0BS0lSC98WKd9JBlE22
         43/m2RI7dDMhXCzQjgIRxSWcZoPY+QQS09XcVllulqDcAe0oJQHOoWNYuGx40KJzCDsw
         V/vlwaEkyqw/FX6PNUIuSqgGWsBJbDLaoIqVWcRzb+UeMdvKm5xCFjCXD4VdelJ7PS0v
         H5GyijVnOIAQoWevbL62ts5HyqHhQfExpNgQmSIVZBgDz61GUGn+FQswk12WcriyTn0f
         FHdA==
X-Gm-Message-State: AEkoouvZruFXbQxUg+I3tQRmJoHxap4dXhbC+dtQCZOMEUVkQrxLcXZUGz2Jnh0CDfFqJg==
X-Received: by 10.195.12.77 with SMTP id eo13mr10376063wjd.142.1469486612061;
        Mon, 25 Jul 2016 15:43:32 -0700 (PDT)
Received: from [192.168.1.26] (afq129.neoplus.adsl.tpnet.pl. [83.25.146.129])
        by smtp.googlemail.com with ESMTPSA id gw4sm17937888wjc.45.2016.07.25.15.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 15:43:31 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] status: update git-status.txt for --porcelain=v2
To:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
 <1469474750-49075-8-git-send-email-jeffhost@microsoft.com>
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	Johannes.Schindelin@gmx.de
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57969607.9080206@gmail.com>
Date:	Tue, 26 Jul 2016 00:43:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1469474750-49075-8-git-send-email-jeffhost@microsoft.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 21:25, Jeff Hostetler pisze:

> +Porcelain Format Version 2
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Version 2 format adds more detailed information about the state of
> +the worktree and the changed items.

I think it should be "and changed items", but I am not a native speaker.

> +If `--branch` is given, a header line showing branch tracking information
> +is printed.  This line begins with "### branch: ".  Fields are separated
> +by a single space.
> +
> +    Field                    Meaning
> +    --------------------------------------------------------
> +    <sha> | (initial)        Current commit
> +    <branch> | (detached)    Current branch
> +    <upstream>               Upstream branch, if set
> +    +<ahead>                 Ahead count, if upstream present
> +    -<behind>                Behind count, if upstream present
> +    --------------------------------------------------------
> +
> +A series of lines are then displayed for the tracked entries.
> +Ordinary changed entries have the following format; the first
> +character is a 'c' to distinguish them from unmerged entries.

It would be nice (though not necessary) to have an example, either
here or at the end.

> +
> +    c <xy> <sub> <mH> <mI> <mW> <hH> <hI> R<nr> <path>[\t<pathSrc>]
> +
> +    Field       Meaning
> +    --------------------------------------------------------
> +    <xy>        A 2 character field containing the staged and
> +                unstaged XY values described in the short format,
> +                with unchanged indicated by a "." rather than
> +                a space.
> +    <sub>       A 4 character field describing the submodule state.
> +                "N..." when the entry is not a submodule.
> +                "S<c><m><u>" when the entry is a submodule.
> +                <c> is "C" if the commit changed; otherwise ".".
> +                <m> is "M" if it has tracked changes; otherwise ".".
> +                <u> is "U" if there are untracked changes; otherwise ".".
> +    <m*>        The 6 character octal file modes for head, index,
> +                and worktree.

I think it might be more readable to be explicit: "for HEAD (<mH>),
index (<mI>), and worktree (<mW>)."

> +    <h*>        The head and index SHA1 values.
> +    R<nr>       The rename percentage score.

I assume this would be C<nr> copy detection heuristics percentage
score in case of copy detection, and B<br> break percentage score
in case of breaking change into addition and deletion of file.
Or am I confused?


> +    <path>      The current pathname. It is C-Quoted if it contains
> +                special control characters.

I assume that "\t" tab character between <path> and <pathSrc> is here
to be able to not C-Quote sane filenames with internal whitespace,
isn't it?

> +    <pathSrc>   The original path. This is only present for staged renames.
> +                It is C-Quoted if necessary.

I assume that "C-Quoted if necessary" is the same as "C-Quoted if
it contains special control characters"; also: '"' quote character,
'\' backlash escape character and "\t" horizontal tab are not control
characters per se., but still need C-Quoting.  The rules are the same
as for the rest of Git, e.g. for `git diff`, isn't it?

> +    --------------------------------------------------------
> +
> +Unmerged entries have the following format; the first character is
> +a "u" to distinguish from ordinary changed entries.
> +
> +    u <xy> <sub> <m1> <m2> <m3> <h1> <h2> <h3> <path>
> +
> +    Field       Meaning
> +    --------------------------------------------------------
> +    <xy>        A 2 character field describing the conflict type
> +                as described in the short format.
> +    <sub>       A 4 character field describing the submodule state
> +                as described above.
> +    <m*>        The 6 character octal file modes for the stage 1,
> +                stage 2, stage 3, and worktree.

Errr... the pattern has only _3_ character octal modes, <m1> <m2> <m3>.
A question: what happens during octopus merge?

> +                For regular entries, these are the head, index, and
> +                worktree modes; the fourth is zero.

This is remnant of the previous version of "v2" format, isn't it?

> +    <h*>        The stage 1, stage 2, and stage 3 SHA1 values.
> +    <path>      The current pathname. It is C-Quoted if necessary.
> +    --------------------------------------------------------
> +
> +A series of lines are then displayed for untracked and ignored entries.
> +
> +    <x> <path>
> +
> +Where <x> is "?" for untracked entries and "!" for ignored entries.

I assume that here also <path> is C-Quoted if necessary.

> +
> +When the `-z` option is given, a NUL (zero) byte follows each pathname;
> +serving as both a separator and line termination. No pathname quoting
> +or backslash escaping is performed. All fields are output in the same
> +order.
> +
>  CONFIGURATION
>  -------------
>  
> 

