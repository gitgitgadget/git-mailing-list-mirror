Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2012A1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfKFEqG (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:46:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37675 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbfKFEqF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:46:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id d5so7696098otp.4
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 20:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSUIKczLf66hShTiPVUKxEArKRsewS5zGVKv8eqXZA0=;
        b=U6UGo05DH87VGEPftyk1q+9l4JB4cWoktnKX3WP1oKQHvHjealD786jZe7ZQLO1efM
         XlErFca5hq/qZBxqCuXnNClMLjNmcBtfM7Vb7hA4pv1WamusFgQ8K2cush7LNvsKWQND
         FuS4LIVY+wNdoLodlavjw2XC+8LU5f5yDBB2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSUIKczLf66hShTiPVUKxEArKRsewS5zGVKv8eqXZA0=;
        b=SsWxvEp6z4Xe4+7kkcMAgUARE/FZNJDMzDj77EAWdfPT+Rwklb8V2qkfvUkfkx8s7E
         nDZvOg3aH9TG9IaSECkMskxCiLiUMQYAzCI3uboL084xv7xnsUfIv+DtmUOWHWaWgkj2
         5e8eYLgtaCQO4+rR9xH8EoIl4c7Hq1Zd9ZfFYMtBjbPd11X7QkORXtbYHmYVQzyAiKNE
         gFlnYgnHyjzqfbUvRsn24L6hLtmZQ4U9Z0y0zZGSuIkebWF8OH9pegtZVdCvgUlk5Owr
         TG6TDcpLDaB75TRfFRoxAYK5udsepGeO9+tQTkg7Z1UyUU1bohSUBdiWnNovpBheFI/O
         mqag==
X-Gm-Message-State: APjAAAWEushEHlQW7ONLgjRxSFaaR5OVjiZ2MzR8NkYSZjaOSSDXG+Rr
        spD5b2sHQlYuduCxcqtFosuS5/qBU397ddSa2EY+sA==
X-Google-Smtp-Source: APXvYqzEeqrTKYakBhJ1GBhl6EQfYUJpziGz2sON/qujXMSzNL0Z5m2tpG7ei4iamjlHAmLvGWeB578NCAwZ85LqnEk=
X-Received: by 2002:a9d:7b50:: with SMTP id f16mr345299oto.264.1573015564927;
 Tue, 05 Nov 2019 20:46:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.448.git.1573013889.gitgitgadget@gmail.com>
 <5729dd380708da7b40805f75c5d475ff4c0b28c5.1573013889.git.gitgitgadget@gmail.com>
 <20191106042806.GF4307@sigill.intra.peff.net>
In-Reply-To: <20191106042806.GF4307@sigill.intra.peff.net>
From:   Nathan Stocks <cleancut@github.com>
Date:   Tue, 5 Nov 2019 21:45:49 -0700
Message-ID: <CAFo48e625pWZRyXuqFezMXXCHgFg7R2073CMCLQstVRtuX343A@mail.gmail.com>
Subject: Re: [PATCH 1/1] t: fix typo in test descriptions
To:     Jeff King <peff@peff.net>
Cc:     Nathan Stocks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That would make sense. It would be easy to add a space and forget to
remove the hyphen.

~ Nathan

On Tue, Nov 5, 2019 at 9:28 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 06, 2019 at 04:18:09AM +0000, Nathan Stocks via GitGitGadget wrote:
>
> > From: Nathan Stocks <cleancut@github.com>
> >
> > Fix two test descriptions which stated "git -ls-files" when the actual
> > command being tested was "git ls-files".
>
> Thanks, this is obviously an improvement.
>
> I was curious if there was any backstory here. They came from 54e1abce90
> (Add test case for ls-files --with-tree, 2007-10-03). That was around
> the time of transitioning from "git-ls-files" to "git ls-files", so
> maybe that caused the confusion. :)
>
> -Peff
