Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66D520379
	for <e@80x24.org>; Mon, 22 Apr 2019 06:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDVGcY (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 02:32:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52409 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGcY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 02:32:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so13294850wma.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aj4kchaJyT22r7AH6E3d7VHkaharNL6q7mCpRwKw2Xs=;
        b=UwMi5jViKA/VQyvitdh/kM8jPDixJ/0NNYXI2TkM6ya1EHHlTTSUQ8+unS8zuMFmQF
         hJt2WjSovNtbwP/utW4x4NZJO+wDXGjc0bb619M1Lue7vPO1BC1cKWgqZ6BmOFHAIDBw
         1jCH/6qUGjuBE+vnXxxHINZ8S/e/OxwloSKUYqo7vz64JhLf/OcahyeTtLciQplvves8
         1MjwJLzEmaS58HwNAfHqzcd0VMD++nHJxZDBaOeYkLf5TGikTfWPnrsFgU5V57iAZXZ6
         FU3wZHZuH1SfzvUJBy/7NqvPV6XA5I5CoVj1Q2KCpUi8H0yu8KaY3/OE773wvm0ALAXq
         FMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aj4kchaJyT22r7AH6E3d7VHkaharNL6q7mCpRwKw2Xs=;
        b=ehPA3o+0gRTEtNBxc5U+pa1dWjMR0TOfN/O6pK95ojoRVNjT3OGQO25vBgnUPDWT0V
         7NsZ+22mkylI4LfL3LR6u3fL5KIy2hnkNXCtFa8vLToDGQ+lPuWacTY9j9ZYyr4Bd4ii
         ZotwmJ6pjVFuVAGtqaojNwaJcZ7vAOfqf1EGsslm6zx73MFSD/NKevkMZk2qXoADnkEK
         75+pHBs9U7d79V6US7ne4HAwSKjgHHWom2g42Zc0A+ApVhuB5JYy5U8YxYQ53xvr78X0
         x5TKAoN7bpOhvMTwPocd/a+ihoLgvIX5rGLtffUtSepaiofklq79Huj+gzEFmyEqBPEF
         7wmQ==
X-Gm-Message-State: APjAAAUymeKyYPgwiunql8AKitGRnJhz0Hd55FDwJDmIFI78lJO/gM2r
        BbAedbVpRGhPbYsjAxWlfCA=
X-Google-Smtp-Source: APXvYqxbFWvgI7TtH60rQJEt9OMzKr4/0bPnIhJ4gRp12b0BYaP5+ktZ8j4xgHy9bolPyuZr9JkA9Q==
X-Received: by 2002:a1c:c504:: with SMTP id v4mr11508049wmf.45.1555914742580;
        Sun, 21 Apr 2019 23:32:22 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t15sm12386971wmt.2.2019.04.21.23.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 23:32:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revisions.txt: mention <rev>~ form
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
Date:   Mon, 22 Apr 2019 15:32:21 +0900
In-Reply-To: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 21 Apr 2019 23:12:29 -0700")
Message-ID: <xmqqv9z67doq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> @@ -139,7 +139,9 @@ thing no matter the case.
>    '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
>    object name of a tag object that refers to a commit object.
>  
> -'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
> +'<rev>{tilde}[<n>]', e.g. 'HEAD~, master{tilde}3'::

Why doesn't this example say "HEAD{tilde}, master{tilde}3" instead,
I wonder?

> +  A suffix '{tilde}' to a revision parameter means the first parent of
> +  that commit object.
>    A suffix '{tilde}<n>' to a revision parameter means the commit
>    object that is the <n>th generation ancestor of the named
>    commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
