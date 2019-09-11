Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5F11F463
	for <e@80x24.org>; Wed, 11 Sep 2019 01:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfIKBDz (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 21:03:55 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:36262 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfIKBDy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 21:03:54 -0400
Received: by mail-io1-f49.google.com with SMTP id b136so42032689iof.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 18:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tV0uJoJl3Rt1zfzDHv+QQWUgVJXY6le3Q8EqhdFWJv8=;
        b=U75jpPDRBigS8QOZoFqBRYd9h+tRueCJvA/cnBJLIRHsPLnW2RFWCmcrDHPDXg90jK
         z7b06N2HX1HPv9DXNd1DI2ZRodvfYNzCaU6P8nHx8toHZMQ5RukHaFYF4KDXgArnqjpy
         l+ESyLqEBFQgXJPcf9BCRYWOQTH8CP4cMqkfMzDUTNEWuRmB27Kbz97BXTqQJkq5tWY4
         4H5A9YfxX+YO+WS4QemoYQoiVWkDKoBo6lpE04a8VlbLi7OmFL+EtBcJf3vr01BdwcM6
         /yuKUIRI7pBFbQInWZd5ZAy+uBghgRd6TSI51DjpweQHDeSWNignd/QgrEUdGgMUQ+QP
         f/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tV0uJoJl3Rt1zfzDHv+QQWUgVJXY6le3Q8EqhdFWJv8=;
        b=ZHh88HDxqg1vF63Bl/j7ZyF+WIk1gBYQoFgrJEX38IiVMc5ANKkLy3Aq8Mr26KE6yK
         hKINS3oWBUfIAFv4poKfoz6c+PYhuPSDKHEmkh2MAgCdkLNfx/5QP4L2nyEzbkiw3A1n
         cnXTsOGsZPMiGOVT+q8g6hjDgHCcLdVH71AU2ra9L28RIamFViXtxG6e5ODRUMJ2cIfj
         X8YHYEa6GMdHir+DO7uh0rfi+NAKJ26FimvSZCskrd6n7bRsYSx4tTwUHpSzO5Dcb8c6
         xo4qSrhJFhcqoJQfWX2KNNVbdSrcrnoQeJ6nkRTw3yOwF6dOlQxg7btqb4bGH4xIj1xR
         kypQ==
X-Gm-Message-State: APjAAAWqwF3ffMxt1PePT2LWK/2fy5pAa00XNzT0V6dd6bJzCFFXKtfJ
        WeoMSbhqNgl7pPApcOqahbyNlgFnIS4mX2EtXFiBxQ==
X-Google-Smtp-Source: APXvYqwNrEVnPri80rspRY00v42nMBHkv8GNr44kcTcDeBTAfIDI9Mm/WQd+OjEMiStkHyBPYt6RbyzDNwiiWuum6hs=
X-Received: by 2002:a02:1109:: with SMTP id 9mr36093467jaf.90.1568163833623;
 Tue, 10 Sep 2019 18:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 10 Sep 2019 22:03:42 -0300
Message-ID: <CAHd-oW4LZTFcoPvqd+FU03+64y7MzesMurCT7tUFQrF_z9ocnQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Sat, Sep 7, 2019 at 2:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * mt/threaded-grep-in-object-store (2019-08-13) 4 commits
>  - grep: re-enable threads in some non-worktree cases
>  - grep: disable grep_read_mutex when possible
>  - grep: allow locks to be enabled individually
>  - object-store: add lock to read_object_file_extended()
>
>  Traditionally, we avoided threaded grep while searching in objects
>  (as opposed to files in the working tree) as accesses to the object
>  layer is not thread-safe.  This limitation is getting lifted.
>
>  Comments?
>  cf. <cover.1565468806.git.matheus.bernardino@usp.br>

Just as an update on this, I'm still working on v2 which should also
handle `git-grep --recurse-submodules` in parallel (for the
non-worktree case). So if possible, hold off on this topic a little
longer, please.

Thanks,
Matheus
