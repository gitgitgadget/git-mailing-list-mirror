Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50461C4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF2B61078
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDSMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:12:07 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35599 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFDSMG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 14:12:06 -0400
Received: by mail-ed1-f43.google.com with SMTP id ba2so10434863edb.2
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 11:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZZO+P90GiA2TeK4Z1c7yoNCq/PexPzZreKnNzoLufA=;
        b=UDWjDhNFxKS9803XfIdSB3vrqnPrTZ4P4y/2E2hDQkr2jnsz0ksWIAVxN4P0tuqqEv
         +vzuyQksd80IZ99Kl1p9NdMHKYCMc+lEMC7654hRzzydWWnhW8hsrj5Xc1o6ltRzsnL3
         HV8WYF5pfqjZ0xKT5z06OftyalBvaYbc5njejQzkpTz07FwRUtYw1Y+e/V0RU0YOPH9k
         ONrJki0rmWgIm4iSWLn894NBQ3SIiT+lyT95ElWng/izR2I0IMmrjWtXi8VmPFZ7FVVz
         wCJQ1Po9btRIshCfjEd5h+/5hRO4zT94+fh4L7YpC2RXNrE6rq6l4B/pK41jVqvuqJIx
         wggg==
X-Gm-Message-State: AOAM531q43fneZu6Uuhjrhlht3z+/Fg0QzUlV38YOOhBMI8g3X7PdKIh
        kxMA/3QOkZ/DwMtnsA9i3l8iU90bk/kwsjXqgKDE7BDWP+SgLw==
X-Google-Smtp-Source: ABdhPJxUT3NjQHlU5fyrvWOQ5N6vEXOiBKvAdt8JbRyG2P36WcfYUu18iZh2IGZIcQ4DSUyeLerEG4ZccVqidVa7Uns=
X-Received: by 2002:a05:6402:311c:: with SMTP id dc28mr6080944edb.291.1622830219181;
 Fri, 04 Jun 2021 11:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <07763a9de723af8674b707ba762845fd414bd0a6.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <07763a9de723af8674b707ba762845fd414bd0a6.1622828605.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Jun 2021 14:10:08 -0400
Message-ID: <CAPig+cQkR2LRmgHDz13-Cc0ohihJgsRAjGMnMagSbKh5QHLL5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] cmake: add warning for ignored MSGFMT_EXE
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 1:44 PM Matthew Rogers via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> It does not make sense to attempt to set MSGFMT_EXE when NO_GETTEXT is
> configured, as such add a check for NO_GETTEXT before attempting to set
> it.

This would be easier to digest if "as such" is the start of a new
sentence: "As such...". Or "Therefore, add a check...".

> suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>

s/suggested-by/Suggested-by:/

Tiny little nits, both. Don't know if it's worth a re-roll, but if you
happen to re-roll for some other reason, perhaps these could be
tweaked.
