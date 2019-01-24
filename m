Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D721F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfAXSPZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:15:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50710 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXSPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 13:15:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so4216713wmd.0
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 10:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cLPTfQrDUmGHn7yhQnQH3OVKXv3InSWZyDPR4sK68Yc=;
        b=FNFHDG1UjtTql7U+rsWDU+/MTiIARndN7s5IVhMBwakkwXZAtB2DfKGniAhMnB2Chs
         duAz08xxYTANnwoSZsD2JmCTUw3ze415rquFyDmhNDZMmBjK761SLabE0rE5Ya9yG0mb
         8Lm5ExEW7VADW5DguICeCN3FYTA3oyNYqhfqs4CB4T9oAVSIuibrPCeeDeqqhamhgdhm
         xLMMwStYTvKFpT5jg/TzpMo4F/8kjsMsyGcFMaTRe8/xdYQrS4bgiDCgJ6zGaFcZMWd6
         f4qAtR67lSVIMbDVVscYB35YmTLg/tGoYPBVVIp2Lgm7ldc95JUlBJNnT4EsBCkxQ2u4
         6T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cLPTfQrDUmGHn7yhQnQH3OVKXv3InSWZyDPR4sK68Yc=;
        b=f36+mlGfzIiy6dRc0nq4t6mliW07Qd89jrVqEMjmQQ9Z9vgAt7cJZ+lACP7PUiW5X2
         23tsGJOaC8XBJfjTveNudK94aG6UQYo7j9bi2tkrBRh3kAPwwSMmh3XUGWtZmKfbuoUa
         BCFdEHnyo65xUlnmf5MBNlpTx4vrrsr/JUlRjAaxuJHBtU/4hxI0WeoQ0P8eqbSoW4Gg
         P5Ol11612oLtfQGlmaxxbUoL6q3dPrZEYa/SxnmoAkaenQj1rEWDIWycYqvu1SlWtuPR
         D+uxX5qkjS04PzypFlixoMGlVR9JYpiIghyPfDqJUhSDKfqrYREOZoRYp3I33+96kJv5
         3/6Q==
X-Gm-Message-State: AJcUukeCOSM80YZgcahdtVUZ6BfoisDtzbP/0zk7oPO86mXJ33qomRaS
        34tE2j5I3A6xWqhgOziccbDTccqR
X-Google-Smtp-Source: ALg8bN6q8dPO13YL01fLVyF/KwNc+zpIfmLlSZZV8cJypvLPAsrUhUQjNS5p7+wZp3gnfyAmNoGwaQ==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr3653578wmg.78.1548353723097;
        Thu, 24 Jan 2019 10:15:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l14sm203378857wrp.55.2019.01.24.10.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:15:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Sat Jan 19)
References: <6addc879-a792-202f-2aeb-7097ea344894@gmail.com>
Date:   Thu, 24 Jan 2019 10:15:21 -0800
In-Reply-To: <6addc879-a792-202f-2aeb-7097ea344894@gmail.com> (Derrick
        Stolee's message of "Sat, 19 Jan 2019 20:07:07 -0500")
Message-ID: <xmqqa7jp53d2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Here is today's test coverage report.
>
> Also, there has been some feedback that it can be hard to manually
> match up uncovered lines with names at the bottom of the summary. The
> suggestion was to auto-generate an HTML report that could be posted to
> a public page and referenced in this mail for those who prefer
> that.

I wanted to "grep" for lines attributed to certain commits that
appear in the list, by filtering lines that begin with enough number
of hexdigits, except for those object names, but the attempt failed
miserably because of the line wrapping (which probably comes from
the assumption that it is OK because the "text/plain; format=flowed"
would not care).  If you can keep the long lines (due to the object
names and line numbers prefixed to each line) unsplit, it would be
more useful to locate and isolate lines.




