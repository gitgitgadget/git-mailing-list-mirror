Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2651FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbdBPSla (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:41:30 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36182 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbdBPSl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:41:28 -0500
Received: by mail-wr0-f174.google.com with SMTP id 89so13274257wrr.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fhj8KCKMk/7LwGxnVYCcYQqo2rUbZQj6yW7UsRQMjK0=;
        b=pfkOKL5JIhZ/jXCkPrNilw5xKXGLkbAyadsVCQr7suEN1HjM/dOGl43r6BUL/wnsya
         rLKXCETIhfmd2yc3fJqUYs4MD/HOEI8uBcWcuFYuIeBOv4O1z8X6xq4eHGMg45UAPRaa
         U4QF7qyDf6hnqtH2951Q3VcT58TM9mSvWkmihiTZJqa7+0Q8XJLG0ZXV1msCSiYMpqkH
         OOqZLoZ56t1+MFDfSzvZi5MKtJthBRqZqEBXYu1Ei7IuY2/GK8OSt38MUs6mNux9No0r
         Bh7o9g0Y+nYVdkHbLlnKnTkDF1/EsvLgoNl8UlvdKuYOq+nGgJzOsehzRgISb4hx2nCK
         98fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fhj8KCKMk/7LwGxnVYCcYQqo2rUbZQj6yW7UsRQMjK0=;
        b=VP1zQMmB6/pgnwnUKe+HV2f2wh38ZWGt+Mqn3NQRzmrgflw5uxFQ0f5Jvm6YJgr8CH
         qAgRoFIuYJkWZnvzX7k6ZhTeR4LIK6xI2FF6PbrsqCUL+3KUxY/JfWYnGEocUfWtujqR
         AM5G6f1O1wOwnUphJYVYFV3mC74q2KWPkD7AOIqEh63xystLZkx5UaZm4dXHS+jm7Zlc
         gz6gVe3oFeyX9w1396osGCa/1OqpeFu4vbTzIJUPme0PBvJryeHPcoFbEAGH+ZuJLkc6
         JOW0IbF27+qNUGSd7Lm46cAFL2liNF32jqjTq8sArskijJm6wUz8Ix8x2pap+oHUsZLm
         U+Fw==
X-Gm-Message-State: AMke39nS5SLCap6xfuMPgPd7xIdXV3ek9jfURSacIiiPQEkPwIChxR+4n4oEbgM6X5YZWkGA6H9piQWL3TkoUg==
X-Received: by 10.223.165.87 with SMTP id j23mr4091890wrb.79.1487270487075;
 Thu, 16 Feb 2017 10:41:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.138.211 with HTTP; Thu, 16 Feb 2017 10:41:26 -0800 (PST)
In-Reply-To: <20170215215633.deyxp76j7o3ceoq3@sigill.intra.peff.net>
References: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
 <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net> <CAOxYW4xqk4j6Uu86jq2Vi9Bpgihxfr2Tw-DQLc+7YTZiPmDtiA@mail.gmail.com>
 <20170215215633.deyxp76j7o3ceoq3@sigill.intra.peff.net>
From:   Fabrizio Cucci <fabrizio.cucci@gmail.com>
Date:   Thu, 16 Feb 2017 18:41:26 +0000
Message-ID: <CAOxYW4x93cjMJoXYzSXCwqYVEstSLLcxzad_BPdvxfasrkxapw@mail.gmail.com>
Subject: Re: Back quote typo in error messages (?)
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 February 2017 at 21:56, Jeff King <peff@peff.net> wrote:
> Grep for "``" in Git's documentation directory, and you will see many
> examples (asciidoc only accepts the double-quote form, not singles).
>
> You can also try:
>
>   echo "this is \`\`quoted'' text" >foo.txt
>   asciidoc foo.txt
>
> and then open "foo.html" in your browser.

We are probably going a bit OT here :) but AFAIK there is no such
thing as non-symmetric start/end quotes in AsciiDoc.

Even enclosing something in curved quotes is done as follows:

'`single curved quotes`'

"`double curved quotes`"

(http://asciidoctor.org/docs/asciidoc-syntax-quick-reference/)

> I think patches would be welcome, but as Junio said, it probably should
> wait for the next cycle.

It can definitely wait and I would be glad to contribute!
