Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB9C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885286109D
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbhJ0RHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:07:50 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44690 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhJ0RHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:07:49 -0400
Received: by mail-ed1-f48.google.com with SMTP id w12so13045863edd.11
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTZQkWUHoCSFdsSJyLbwdE8GlvIHojA8+s83Eysz/uw=;
        b=6KhAnslc3zZIqcNhCbISoBlGZ0HcoarTAZdKoPJCHkdMn1GpNZBSsMvEcuh+Ynfork
         OH7D8RMMN40nnJenH9tLWSRAFi3lIE4puhapV624dZhxNfiPC/9bUzQ14rMd+66zUMu9
         dvOBWUrDcor3P1nPZKiNhxNBcBAmpTXnSxdRcK8+o0EzKZKNC0JaV8a5EVA4rg9CBLqz
         QaoIMXHoqrg9WbCoj9CogdglqVl17zKo4oTuewpvEgTPeavTB85AOA06bIGOy+DJf/+/
         fUkWeuaVE7qeJIZ7uPhD2WLVhjS6I22Ju9W2HCMLxKcK84vhYflFNPi74j4tgUBGBs6d
         kjag==
X-Gm-Message-State: AOAM533A3iV5Xt6IYSVYLSrkn1PdxPhTK3HD8dMwXPfRuSqRQwu8prXK
        F1vsTiCHpUMhNPfUy/mwtJNtXN+cttv7vyPgJKB+z+IAKxc=
X-Google-Smtp-Source: ABdhPJz41zH0t6R9eQMEsAz2BnTiRLa0CxLceCUXNKOmECxiTh5Odb5H3GPbDYD7gQClbNkTOKvqL6Ut7oQgw103vtw=
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr41306861ejc.28.1635354319785;
 Wed, 27 Oct 2021 10:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com> <6c95f11f110be63dafa10dde5067b6e7eeff1a53.1635343531.git.gitgitgadget@gmail.com>
In-Reply-To: <6c95f11f110be63dafa10dde5067b6e7eeff1a53.1635343531.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Oct 2021 13:05:08 -0400
Message-ID: <CAPig+cTmHT9uZ=c4tGK487=K1905cYoFZcPfMRv7awbqoKHBfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: fix places that break compliation in MyFirstObjectWalk
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 10:05 AM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> docs: fix places that break compliation in MyFirstObjectWalk

s/compliation/compilation/

> Two errors in the example code caused compilation failures due to
> a missing semi-colon as well as initialization with an empty struct.
> This commit fixes that to make the MyFirstObjectWalk tutorial easier to
> follow.

s/semi-colon/semicolon/ would also be appropriate for the rest of the
project (but not terribly important in a commit message).

> Signed-off-by: John Cai <johncai86@gmail.com>

The patch itself makes perfect sense. Thanks.
