Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206B11F453
	for <e@80x24.org>; Mon,  4 Feb 2019 17:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfBDR7t (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 12:59:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53796 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDR7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 12:59:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so847426wmb.3
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hm8swRS4C6DsDRBKZSOZ1holVrf43DXccYVZPyU+SbI=;
        b=l7wiJwNrutghyxBYAsPCGJ8e6pLNvsq330bPNWfqHDHIreBaTC6tdPNrzvw8jA8/Ok
         hA/QANj5s2/3c8PxYawJs+I6aMHO33XWL+kTEZz/nqKqbv4Mnr5UZ1qSc9nQTHowNqN7
         fFUX3mHPVm/dpparopo3eHdUmZsYTZACP7kSs28LZKmuiWiI/XZujOW5VnVeP2gGpUP8
         mJm9xyZXqcQsPVUvtLBGHNw+WVFbVnyiZjr10gUSFdd1R4oQUj7Xq3GOjLu+scVuu1Mw
         R8dQUQSRsb/Tk++pv6vUV1LMS76mMzH4glN5bl++M+oA5nGtBzQn7tm7bYzKFhQSfqJE
         qo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Hm8swRS4C6DsDRBKZSOZ1holVrf43DXccYVZPyU+SbI=;
        b=SQhIwAOOd1ieVq08hi1QmwAUPIGBkvqbLKLI8fdHR1JC//qljZeu+Hy63VozGXTq5n
         YgDLf87FMPS3xuLEmriKR3xPER/58z61h63963pN1PMMTsFwnIg73GIeiY20F6mZWz39
         oYVeVTGlY6lE+oVObez3VoZQ4AAx6KBYIPWmtP7TURE6kOoSfDQHy8Ah6NnMdc3O5CHu
         D9vGbhlJZmFlck6jRJ7T1kdZO7OvCaYiBNVeeCywbUdpIwoqIZ2B/D6FrixhAxZ0JGY3
         5nj5gHfGba4pF/SvZAeAJ36dN1iBeW5Y92ES8DtDFomZpGK0ThYqKJrLJC91iwqN8m1w
         Kfbw==
X-Gm-Message-State: AHQUAubalu/rvWjzxcj4Mu5gy/crWv82lknhtUHQngJ363rp4RZbLUYI
        vaig9hEsmLJoTbrToTbkefg=
X-Google-Smtp-Source: AHgI3IYSIuIdn3g8RQvaUZILgDV+qr9blAHNuF1JyDKda4v31XXAA3XU6GTTRb/pAKJ8gHkpFyTtqg==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr392466wmc.133.1549303186947;
        Mon, 04 Feb 2019 09:59:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s5sm8845677wmh.37.2019.02.04.09.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:59:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-commit.txt: better description what it does
References: <20190131092112.6197-1-pclouds@gmail.com>
        <20190201100910.30432-1-pclouds@gmail.com>
Date:   Mon, 04 Feb 2019 09:59:45 -0800
In-Reply-To: <20190201100910.30432-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 1 Feb 2019 17:09:10 +0700")
Message-ID: <xmqq7eefwi26.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The description of git-commit jumps right into the commit content, which
> is important, but it fails to mention how the commit is "added" to the
> repository. Update the first paragraph saying a bit more about branch
> update to fill this gap.
>
> While at there, add a couple linkgit references when the command is
> first mentioned.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  NOTES section is gone. First paragraph updated.

I haven't been following the discussion in the previous round, but
this looks like a sensible change.  Thanks, both.


>
>  Documentation/git-commit.txt | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index f970a43422..a85c2c2a4c 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -17,16 +17,20 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Stores the current contents of the index in a new commit along
> -with a log message from the user describing the changes.
> +Create a new commit containing the current contents of the index and
> +the given log message describing the changes. The new commit is a
> +direct child of HEAD, usually the tip of the current branch, and the
> +branch is updated to point to it (unless no branch is associated with
> +the working tree, in which case HEAD is "detached" as described in
> +linkgit:git-checkout[1]).
>  
> -The content to be added can be specified in several ways:
> +The content to be committed can be specified in several ways:
>  
> -1. by using 'git add' to incrementally "add" changes to the
> -   index before using the 'commit' command (Note: even modified
> -   files must be "added");
> +1. by using linkgit:git-add[1] to incrementally "add" changes to the
> +   index before using the 'commit' command (Note: even modified files
> +   must be "added");
>  
> -2. by using 'git rm' to remove files from the working tree
> +2. by using linkgit:git-rm[1] to remove files from the working tree
>     and the index, again before using the 'commit' command;
>  
>  3. by listing files as arguments to the 'commit' command
