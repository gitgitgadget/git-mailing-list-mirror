Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384111F404
	for <e@80x24.org>; Wed, 18 Apr 2018 03:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeDRDG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 23:06:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43575 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbeDRDGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 23:06:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id u4-v6so582674wrg.10
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 20:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jpKmkWt27WJKjp5aWhjMLdTyAVPdieOnLsProApJgzU=;
        b=lSwAFjJo0zL1od81api0pj80dsJ25FwzfViRVNWkqiPN7ZS8bp13Ls+J6YTBp427/f
         J0B/6SYnwUKobO7ZaUPh/EH5bgeGqWZX7+GgwFgYy1Xe2wQGjk2Uho4suPT8sMMh6WQV
         fft3grAN1e4w/iRDqcIPK2FxIM2YePaHCIy6E0lssmbtk2aCW8iCLf5NrjcfjAVuJDsr
         B5rt8Qlt1jH/js9kEdA5pwCTCq/QH/CgtTbYMgtu5PpaOqeYwvizd+fplinnsorM1U2k
         +/MNLzofkaG6TJ/+VleExFp93zAzuCvvDHZ0JZcgHawQAqMJOBswFKDI8DJHHhKh1n3x
         GVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jpKmkWt27WJKjp5aWhjMLdTyAVPdieOnLsProApJgzU=;
        b=AqCc6kNFCaX7eSy7WILHmneG1DezcNqYjOFWOlmSXtLzp+tEPg2Nt1P71q7pL/RTiF
         vEd7IbHICpYmKyWKH9Jmv3+mqEYanbcgIB1vJIK8VNLX+ZcBepaYGFIJgY9GAfScXpLh
         NeP2YseqC233BlBs/eZw1xUlCAZTnGYhS9BO+0sxJCEGeYbSxnEcec54/Xiym/yh+WBZ
         WUvIPbCmQSRXYkdFwM8OQi6tn9+lZ29VuOVxuloloCvPfVj7x+oP+060IERxF+THqvfU
         jAsgUhlou2uYcjQMk4HrWI9EQLPQ5qCjEex2lH4oIArfalwlvUddLiMMYwLZgtLyQnik
         WRUQ==
X-Gm-Message-State: ALQs6tBmP3WMYnH8TuXkDaIocRU3PXG4VlNLLy8/AOflNOvA346vU4AC
        zcODxMvpobh4FHnQnbcJQew=
X-Google-Smtp-Source: AIpwx4+QY2N59GoywmDF4pprlhplXrGq4m12Lxc3/Li5q919+Cx0/4QC75MkfutKabdh1ViKGXnnWQ==
X-Received: by 10.28.134.203 with SMTP id i194mr413637wmd.114.1524020813431;
        Tue, 17 Apr 2018 20:06:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s15-v6sm98353wrg.28.2018.04.17.20.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 20:06:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs/git-gc: fix minor rendering issue
References: <20180417213628.29265-1-szeder.dev@gmail.com>
Date:   Wed, 18 Apr 2018 12:06:51 +0900
In-Reply-To: <20180417213628.29265-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 17 Apr 2018 23:36:28 +0200")
Message-ID: <xmqqbmehjjqs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> An unwanted single quote character in the paragraph documenting the
> 'gc.aggressiveWindow' config variable prevented the name of that
> config variable from being rendered correctly, ever since that piece
> of docs was added in 0d7566a5ba (Add --aggressive option to 'git gc',
> 2007-05-09).
>
> Remove that single quote.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  Documentation/git-gc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 3126e0dd00..7c8a2edd48 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -129,7 +129,7 @@ The optional configuration variable `gc.aggressiveWindow` controls how
>  much time is spent optimizing the delta compression of the objects in
>  the repository when the --aggressive option is specified.  The larger
>  the value, the more time is spent optimizing the delta compression.  See
> -the documentation for the --window' option in linkgit:git-repack[1] for
> +the documentation for the --window option in linkgit:git-repack[1] for
>  more details.  This defaults to 250.
>  
>  Similarly, the optional configuration variable `gc.aggressiveDepth`

Thanks, will queue.  We might want to `monospace` quote these
options that are to be literally typed by the users, but that is
better left to another patch.

