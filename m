Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47C0200B9
	for <e@80x24.org>; Mon,  7 May 2018 12:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeEGMSE (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 08:18:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34847 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeEGMSD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 08:18:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id o78-v6so15064562wmg.0
        for <git@vger.kernel.org>; Mon, 07 May 2018 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hXexKTEyCyz3/eZDmGaqV28U8qFdV3lFbep6CUg9KTo=;
        b=gX8TUxcxOnzcPB7G5h/xdldNd5gaMu+b4tqqlxWGAaYPgAenqNty5IycpDIkPcdMv1
         jdLAY8qaEPjSmxU/DolepI/Z93WtXknoQPZlbhoouwKEe9znHTmfNX/R3/CKP1j+xlsr
         3pXppM6tnPxNhtUaSZ8CVIylcOk+U5jUmIEbbYHhEebGzkO+EcL0nuxtYKwQrpC4pO9d
         SJXKMmama6YN4KvtM67DIrRhCyI3iJ561CgdEMIA0/911eY3Whhb+oaiRkq2tTeQPJoE
         RQmjBa6Dw93mrplf35DOqhci38Llw5cRqY8FeM1fqB4O3OgCbZgcz96QzkBhQWiYrXot
         aBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hXexKTEyCyz3/eZDmGaqV28U8qFdV3lFbep6CUg9KTo=;
        b=SGa61uxMrjSExVU4G3+6pgZziTxQBNnL4h1WHsiXLMSW5Iqscn/dvLQDvrH9g0drxX
         uxXcNSr4CfkFyKcsaGuoI6D7b842n0GWA/RUEsAtaiW84yR50SpJZiGdQtQDzfOVyM5S
         sdWeU7nY0yG1zPYA9uS5UOlMKnanBQEJ0yIR2NmAhdvOzxuLXqTjtkBScClCpRS5pHH8
         zqRhURjJniTwkaWvL++hachnTI9OHG4UV1ubFYGy/BIVD4hMvPLSW+npXERglyOmVlmv
         bVjSR4roU3vmLKke2FFmQ8q9fzaVpef0NfFzrI1gnF8d33aYvty1a/vsYjSe5JHfIglt
         rZ4w==
X-Gm-Message-State: ALKqPwfFrIBHJM17jR2ZN+n1Jk1KSfsIapF3Zm10wvEpJ9qb5rw2Wqtn
        VjNwLaxpOXo7lKd4oS3M4VI=
X-Google-Smtp-Source: AB8JxZr2T5G9kcfnGm+N3gmgWWOxBP132RIkdJV7/+MCPNRGIePmepj3sulxKq1ioFpoB/Euc1lY8Q==
X-Received: by 2002:a1c:6d97:: with SMTP id b23-v6mr674639wmi.86.1525695481472;
        Mon, 07 May 2018 05:18:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a129-v6sm6311074wme.3.2018.05.07.05.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 05:18:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: main url for linking to git source?
References: <20180507063713.GA28961@sigill.intra.peff.net>
Date:   Mon, 07 May 2018 21:18:00 +0900
In-Reply-To: <20180507063713.GA28961@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 7 May 2018 02:37:14 -0400")
Message-ID: <xmqqsh73pslj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The git-scm.com site currently links to https://github.com/git/git for
> the (non-tarball) source code. Somebody raised the question[1] of
> whether it should point to kernel.org instead. Do people find one
> interface more or less pleasing than the other? Do we want to prefer
> kernel.org as more "official" or less commercial?
>
> I could see arguments both ways, so I thought I'd take a straw poll of
> what people on the list think.
>
> -Peff
>
> [1] https://github.com/git/git-scm.com/pull/1202

I personally do not think 'the' main url for linking to git source
does not exist and depends on what the URL is going to be used for.

In the context of the cited PR#1202, for example, the first hunk is
about a URL that appears in a sentence like this (paraphrased):

    "... If you want to build from the source and fix bugs yourself,
    use this URL to clone and try the next branch; the issue you
    have may have already been solved ...".

The URL is *clearly* about feeding it to "git clone" so prettyness
or familiarlity of the Web UI at that URL does not matter an iota.
Unless one of k.org or github.com has far superiour bandwidth and
latency over the other, I do not think it matters which one is
recommended in the documentation.

But perhaps in another context in the same document (I didn't
closely look at the rest of PR#1202), a URL may be involved in
viewing a patch in Gitweb/cgit interface.  In such a context, Web
UI's familiarity would matter a lot more.
