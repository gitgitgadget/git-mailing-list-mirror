Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA3A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 21:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfA3VuB (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 16:50:01 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44459 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfA3VuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 16:50:00 -0500
Received: by mail-ed1-f52.google.com with SMTP id y56so889024edd.11
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtl//zAJLlMVTewl+VuuwWX7BKA3hMV9Ebpb6sbZ2M4=;
        b=NjJ8k51rRbwZ8lktFAtzEr9QUZqlB2iu8fO36Dm9M4S3c4lLTkBH37EtBdHxVCW9zJ
         xe+9um9R0eU1fHtq1ZPB3WTPSo7hpEeJDPlKyF4x55LfyDIYkoXsl497DOTJ8XBKyKGm
         hKmK+R35euEsPiPPEIvv+5l96OmCddWNqPMo2JSHsbTqP5yR8OnIueHXaGTfFX4kVh48
         JcCNu8xyNZ024H7jhI1oLJIych7OTicOlzOXwFDi0ie//VA6vrxk57zWDU0d6KFidqZn
         rIkgZ8pVOtfbGqsV077tKfDXOOAItDWSOq/RFwe85R4yoqgZclnGUuG/8QbKVSMP1AHz
         T4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtl//zAJLlMVTewl+VuuwWX7BKA3hMV9Ebpb6sbZ2M4=;
        b=pUIhKBi/iokx1UpPl4LUL+HQgOPzFlzcC5Wc2hMpwNqqKGPGUCbFkXCWvfhfiQxSj2
         P1GS2Evo6194liL4gzVZTKp97rwOT+PuO26lAoQzO7gz3lWKeACyVaTdMqqw16p9uA9P
         vDEFd58KwIzKH4OYpsrNsXiHuwiz4XJlRQBPijtFh0jfbB+GKLaYd48PMiKT46YyBnX1
         PHD9mNXFWSosFNk9Uphhr9z//GZ/1hwCD6NdemMNuyicW0/aGyJYQqsokYpWos80t1vg
         yRH8NFvrzzeDgAB6D/DQKyCjc6+aOyqRc9ZfG8vdExTatdu3GMatRnuciDJYMC2jGokG
         6GFw==
X-Gm-Message-State: AJcUukfshGksXPE6WVeXC3yevmRjoGcdf+dW+PbH3jLwFDvDE9+lgq+C
        KkT2m+IC4WGpMGyWdYpDAiFfL6/SnnEssyT2MRxtyQ==
X-Google-Smtp-Source: ALg8bN55MMEAH+6YqwEY+evXgunI35RfipaLOO7sq2oSEteYqCSBgVewIHhVAOX6XhLCdYgXtu1uFbSsHzdO3CS6ECQ=
X-Received: by 2002:a17:906:5950:: with SMTP id g16mr28440935ejr.168.1548884998829;
 Wed, 30 Jan 2019 13:49:58 -0800 (PST)
MIME-Version: 1.0
References: <1fd0fabb-a9e3-da85-0b00-e00578bd2ccd@narod.ru>
In-Reply-To: <1fd0fabb-a9e3-da85-0b00-e00578bd2ccd@narod.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 30 Jan 2019 13:49:47 -0800
Message-ID: <CA+P7+xqv0bH+TfeN8eG0b1XT7zNdvxJxsdOktywQdpA0DS5EBQ@mail.gmail.com>
Subject: Re: Feature suggestion: Filter branches by user
To:     Victor Porton <porton@narod.ru>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 7:22 AM Victor Porton <porton@narod.ru> wrote:
>
> I want Git to display all branches created by me.
>
> So we need the new feature of Git, to display all branches created by a
> given user ("me" by default).
>
> I think, the similar feature for tags may also be useful.
>

Branches don't contain authorship, as far as I know. Annotated tags
do, but lightweight tags do not.

For annotated tags you should be able to build an alias which lists
all the tag objects and includes the author, i.e.

git for-each-ref --format='%(refname)%09%(tagger)' refs/tags

This will list the refname along with its tagger.

I'm sure patches to add a "--tagger" option to git tag in list mode
would also be welcome.

Thanks,
Jake
