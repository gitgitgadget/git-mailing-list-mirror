Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CAE1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 15:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfJKPpE (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 11:45:04 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:37788 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfJKPpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 11:45:03 -0400
Received: by mail-ua1-f53.google.com with SMTP id w7so3182530uag.4
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYClNDhjFaErTpKGID8bs8HkmfQAcxna5BHVtrN3DtE=;
        b=m4meE9kCHI6WJQ17peVp4dw1b7iYl0ijVSzxGwVNThx0u9PI3mRAbphg7bSG7xVqBd
         WK00wC5BdXKprhx7DqrzZ8IATbmpnJo34yndUbN+UVz0ElSMYysslNMa6S1Zkr/9q2aT
         9CV7K6ptGjEIL2EpTbgSCcVeN3um8yOH0W2/hGO6fbYY/MXe8PImW9IumnBtcHAszcam
         2WWSMSCO2DzfsVNTV6AhlaXGh3sLKNyDUnsAa92NkXoythmQFayji8E2ypb+kjnFbgjJ
         nJSQ3SvOleyspsyke7TGz93GJvVb0FBI5mM9dc9jH0wIRgpzpMEq75/w6KiSmOLcyoR5
         QW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYClNDhjFaErTpKGID8bs8HkmfQAcxna5BHVtrN3DtE=;
        b=sDQG6vcV3q05XjmepbukiXhgiAfSAof1sIsvZNLT+aycTbpbO7InnYf83AmaXF2+B4
         I8lYEgZ1UolU9gWCHVYn/wwXEGWnPIDbZWwjm21am29EpH+KfHBEOD6jko4b5NrKlxtO
         W+QfD+hqNXlbh3+PK0yNM+g85HNmBpvQT+7TLI/sCKW34q8DauPThtxXoAOvPpZdkTvw
         5QJNjJoiM3tYNq8mLhFJSjFSQxkqZJ7aY4pSHDVGn3Z4iWYCT9kroq6OM7Sl9zDcJ2vZ
         wdjyEGIbJBDyo69bee0qY9xd3lEc6682PXpJYX7UTM0PIoqHCv2vpVh8y3/chNIJFFWs
         Q38A==
X-Gm-Message-State: APjAAAUtQ6ButLcEg+s0mNQZf93g00bkvGG8HeBy4gol/XWWcdhjz0uT
        Bo6pkjkjOnoWjjUTdwRRyPWybpc/tStsQfcXz7o=
X-Google-Smtp-Source: APXvYqwQ4iUmIDfcZ1Ryr9ARfvX9iaT7vEBGTYKmCacKaXQSywqA775fPL4SzBA79StiURbhf/Yk9/nyELlfuz2nSOw=
X-Received: by 2002:ab0:7107:: with SMTP id x7mr4647107uan.87.1570808702429;
 Fri, 11 Oct 2019 08:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 08:44:50 -0700
Message-ID: <CABPp-BE4f5f3HyZu9wOyq599JN-n0EMF08di+2V51uxDMEwuGQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #03; Fri, 11)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 12:35 AM Junio C Hamano <gitster@pobox.com> wrote:
> [Cooking]

[...]

> * en/fast-imexport-nested-tags (2019-10-04) 8 commits
>   (merged to 'next' on 2019-10-07 at 3e75779e10)
>  + fast-export: handle nested tags
>  + t9350: add tests for tags of things other than a commit
>  + fast-export: allow user to request tags be marked with --mark-tags
>  + fast-export: add support for --import-marks-if-exists
>  + fast-import: add support for new 'alias' command
>  + fast-import: allow tags to be identified by mark labels
>  + fast-import: fix handling of deleted tags
>  + fast-export: fix exporting a tag and nothing else
>
>  Updates to fast-import/export.
>
>  Will merge to 'master'.

Any chance this will merge down before 2.24.0?  I'd really like to see
and use it within filter-repo.
