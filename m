Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A0EC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A483264EDE
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhBBFmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:42:13 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:43962 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhBBFmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 00:42:12 -0500
Received: by mail-ej1-f46.google.com with SMTP id y9so6433694ejp.10
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 21:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omEbzCMGpJxKkPRwR7L9XEXjfGOAueEfIwwCXCNUkvc=;
        b=P8TlQGqR2v752b0FjUF1OnW0Oy0PrzlXekCPxceRRvsnl37JQEYAe5d/8KX7ncjmAA
         Amd7R+NX2sXIP/9Y0TQHjT050kzd7rSG51cDITW0/hW5cvCNf5l1Xbeg/zQLJ/L19vCc
         8pdOwQfMWfHQ9zKgishV4W7uG93tIIvBbMR7X1FTH9q8H2fICpfZYGlmVSCRtH1c0Fh7
         h7KQ+sn13y0WOJLIAJYMpkz4YAQ9ZGEdMwSi17FYScY3v4l36LLlFuUDKHlAiRGb3WcL
         07Zbd+HfkfJL/8TgcL3RCB1N0KuogNcDjfFSRsoew6MtiN8uObgyYu9H19maWLC3Sdgj
         Wo/A==
X-Gm-Message-State: AOAM531qbotgh3+oqYKIZ+rqU7JPJBJ2TYWnnwQyB3grdw3iT69fJj96
        WpcSMGZmKjEiYJE5sraLSCPgA05yUWs46ITQGnQ=
X-Google-Smtp-Source: ABdhPJzHdOL5E+OejeQB9BSYXO+nIBfxoTDFOBfzK/ha2KnZ1E437RZnVHM1bxXVtCUo3kzWnK7WD7L+T6HjL1+ceFE=
X-Received: by 2002:a17:906:c410:: with SMTP id u16mr20348323ejz.159.1612244490573;
 Mon, 01 Feb 2021 21:41:30 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
In-Reply-To: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 1 Feb 2021 21:41:18 -0800
Message-ID: <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can,  on _your_ end, filter incoming messages that are sent via
vger.kernel.org and do not have your address on To or Cc.
