Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F3320248
	for <e@80x24.org>; Wed, 13 Mar 2019 01:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCMBmu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:42:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCMBmu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:42:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so166029wre.10
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vpSq0bmS5ntblE3IZYX8pmAC4biWdgqG9fljhURPnHg=;
        b=GoM1nTgXD8W8zp7H9hZf8BiEQIYQFcG60xyXnlUS3abtW4GpE0DS5oojtFMqGx1FVm
         mbKzaAF4WU5s5QqTqOOZK3xkUo2bBoW/CzV7MZafjmEtPP1OlFd04nvlA0ht3bavFRml
         +lTM8Rv0qb2/ATmFuJln55sj/hsh+SzDPksD1aEH2VI7AM7Rwe0IBTf4zdS5svuZoK5x
         sAUTy1ysaNTQn5zhV/YHwjLysWyTv+Zi5J50MFUzzSOLct8Irc0z2XchffsY7TCIl1sh
         rjGXRwAmWFmbhNAZseFLCWO4EiAP/IOMqWQQo7pbRuzUKTIzfAefiGob9FISW4WNkBpM
         evvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vpSq0bmS5ntblE3IZYX8pmAC4biWdgqG9fljhURPnHg=;
        b=IZ5D5v/rEWTRVS0INeHPMOSHNyWErI3qM/uKCKFqM9jzyrinB6tsn8l2YcAKLZgLCq
         QcugRuIgOU+QuEh77724zqebh64ulvQwkuGJT7LpDAOyxy5+T0qjRmuoxiXn3Kak5Ifs
         AE2CKDSoZrbw84Iz2kBAF4g3ST0P80uIbM6Kv59sPLH2FVFhdqRsHn8LmKL8fPR3ISNQ
         k2USbI8XSaE2GyEZ5RggSvlDkyhAUBMqL78gp+IJh0ZBMQNp3v5stYcK65BBxPwDzAfi
         MQzTmVGorv1HdJY53x/il7M8juhciXOp78r2LgvINRhQN5moLRh1QbpZbSblvHE2Rbpj
         hhbQ==
X-Gm-Message-State: APjAAAVW2W6NviiFHvH7vGY3VuLX2HM4wRmyTa7W4YEMAL9trfYBPCkw
        /CDtNIHRZLFFaUilmYKmUno=
X-Google-Smtp-Source: APXvYqzMgy6i+w/uiElQ6rPiwnfp+CeNDc66jHd1rbvToqAxgfDI5nZTjeCC11xrEG9MRIR0hzJnuw==
X-Received: by 2002:adf:e64c:: with SMTP id b12mr17580155wrn.112.1552441368703;
        Tue, 12 Mar 2019 18:42:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o12sm32143795wre.0.2019.03.12.18.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 18:42:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] glossary: add definition for overlay
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
        <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
        <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
        <20190309172733.GC31533@hank.intra.tgummerer.com>
        <20190312233040.GE16414@hank.intra.tgummerer.com>
Date:   Wed, 13 Mar 2019 10:42:45 +0900
In-Reply-To: <20190312233040.GE16414@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 12 Mar 2019 23:30:40 +0000")
Message-ID: <xmqq5zsnh7my.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 023ca95e7c..53df6ecb0a 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -287,6 +287,13 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	origin/name-of-upstream-branch, which you can see using
>  	`git branch -r`.
>  
> +[[def_overlay]]overlay::
> +	Only update and add files to the working directory, but don't
> +	delete them, similar to how 'cp -R' would work.  This is the
> +	default mode in a <<def_checkout,checkout>>.  In contrast,
> +	no-overlay mode will also delete tracked files not present in
> +	the source, similar to 'rsync --delete'.
> +

At least the mention of "checkout" needs to be a lot tightened to
clarify that it is talking about "checkout <pathspec>", aka
"checking out files out of the index or a tree-ish", as opposed to
"checking out a branch to work on it", as checking out a branch will
not work in the overlay fashion.  What's not in the newly checked
out branch will disappear from the working tree.

If readers happen to be not paying close attention to the fact that
the difference between overlay and non-overlay is about the
destination, "similar to how 'cp -R' would work" may not click to
their minds.  "similar to how 'cp -R' updates the contents in the
destination directory" may avoid such a risk, albeit it might be a
bit too verbose.  I dunno.

Thanks.
