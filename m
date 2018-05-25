Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373071F51C
	for <e@80x24.org>; Fri, 25 May 2018 08:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964791AbeEYIQI (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 04:16:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40137 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935866AbeEYIQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 04:16:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id x2-v6so4846219wmh.5
        for <git@vger.kernel.org>; Fri, 25 May 2018 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/56vA2K6Aut/LqCzhMFqmcPk+Swdjl2GfHnieisc6rE=;
        b=b1b9PKDlWp5jWMNg3n4g1uoKollXCS2Qxl5DGDPZ1yfsidqzUzcxznr01Q8I/8zd1J
         ey/BP2mhcjnCdbeec0+9lN+ssdMq4vU5MPF6tRQyAGmwm193IMrA+9gHf7xlngCAHBQE
         IeCyDUBBtVrVNuih8yGr/m3umHUf5idnNXklh5yeKpCsnhjnG0MogI5UaQGNZA2BeimI
         3Ox+n+6GnNfNIT/kyHaPiw4QuCBjXKRonKpAEQAF9aJXL0wRzXd8lmlFv1yzqV7sPIgZ
         +Q2bua0mAYYbR5BtAP94PQLq+KRWvXU4f7a9VkBslo1SCLCy/FqMVggNNATK7wzWE/jI
         neAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/56vA2K6Aut/LqCzhMFqmcPk+Swdjl2GfHnieisc6rE=;
        b=JUHp5wMqba5AeBCL1CFIgZdBTVBY7PAtvDcMMwismynQBdup345sUrW2MW6Mp2q7Ba
         j0e78PG73nFfyASCA3CIORXvo/0VQnojPmc+1wa2j7x5RCEPxl1QS++S1NAVeDYSu5d7
         1MbTCzuPD+BJfdqQKLRkrCc+bXMMo3NqI/pkLf8aiyZQuFrF4uFjZMzKMnhRg+VtgIXY
         rzcIwHfRF4HZy7NTznj0yZfSmWklAenuav7G2LSABwjImgvQNQLAc8aOEGjC/4vj2Ao6
         /Pv/R9kUzww29dsegnuHfI2IqNiPE8oDy3/Mu/BaOZFUJr/KqT5VAhILTeZpuRrZ/BRt
         Ifkg==
X-Gm-Message-State: ALKqPweIj0VitLkNVNqtbCdnviiHjqEUO9hcocjXHFJxsANoWTVvcrrI
        5LRCc3dcN0eeFzV8LYxfQnA=
X-Google-Smtp-Source: ADUXVKLDPyYCFbVLbFVdrYuMe/IFXnpipxD+5lbEKi4omhSvcAhx8jn3PqHca0mATY6vDNeysk8O8A==
X-Received: by 2002:a1c:eccb:: with SMTP id h72-v6mr863211wmi.157.1527236165758;
        Fri, 25 May 2018 01:16:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g127-v6sm5696562wmf.42.2018.05.25.01.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 01:16:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] Use proper syntax for replaceables in command docs
References: <alpine.LFD.2.21.1805241610030.7254@localhost.localdomain>
Date:   Fri, 25 May 2018 17:16:04 +0900
In-Reply-To: <alpine.LFD.2.21.1805241610030.7254@localhost.localdomain>
        (Robert P. J. Day's message of "Thu, 24 May 2018 16:11:39 -0400
        (EDT)")
Message-ID: <xmqqlgc8noaj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> The standard for command documentation synopses appears to be:
>
>   [...] means optional
>   <...> means replaceable
>   [<...>] means both optional and replaceable
>
> So fix a number of doc pages that use incorrect variations of the
> above.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
> diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
> index 05fd482b7..e44a83133 100644
> --- a/Documentation/git-annotate.txt
> +++ b/Documentation/git-annotate.txt
> @@ -8,7 +8,7 @@ git-annotate - Annotate file lines with commit information
>  SYNOPSIS
>  --------
>  [verse]
> -'git annotate' [options] file [revision]
> +'git annotate' [<options>] <file> [<revision>]
> ...
> -'git check-mailmap' [options] <contact>...
> +'git check-mailmap' [<options>] <contact>...

A pedant in me screams s/<options>/<option>.../ after seeing this
line, but <options> appears _very_ _very_ often and extremely handy,
compared to having to spell "<option>...".  So let's standardise
the way this patch does.

Thanks.
