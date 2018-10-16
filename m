Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628AF1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 05:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJPNOu (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 09:14:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36303 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJPNOu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 09:14:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so21711616wmf.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 22:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ZtSpx4y4Bq8OFJyJJqySCnLEKL+I0GaPsf2zySW2DsE=;
        b=LEoHhODGnHnymu31ItU/Bzk0ynDLzFzoEnvFHn04xsXuLTQaTo5soaZQwQPNSRqUzE
         VcGgnOj5S225A+slwzkmHYN/C3BgKPZY5Ew3dMAu2ShF+Ztvw2fN7sVZoqE+2bvpJPYP
         HbgvevRX9daMvi4OX9csSAjnn0NAOlU2hgl8NoXaHHl1YGzCUvHICq0ngRxw0+15Ou6q
         VtZS+HZAnnILuhxguflVz0z54jYbSj0QL+97nxvRrO2nXBTIeiQa+xU/rPgtR7fjXPt3
         5QSaNyfiKAeTR+GpItamGqCSOzpE8V2bkYF6+H8rNnP/hzV7jh984AIOQQRrc961Dkhx
         k6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=ZtSpx4y4Bq8OFJyJJqySCnLEKL+I0GaPsf2zySW2DsE=;
        b=ZdD6jXAmm5IRZpDHCX2/izuVGW4ZfVgwbkRzxx3fiTWgqKEURPydPdRwE39O9cFDb3
         xeKC2mJNTGZYr4Pi1qQZrQTJ4IDBGFEeZEbbVMW41cPQDgD+52llkgnfV5oxcIjFd3zK
         iuUujIL3tm4HooRvDpsH4oAVrLGWc5kYKzMLOqYO/eKPD6ft6NfBFkXf/PpzKr54kuRX
         5GoNa3IVDKUTXsJ0YEuQeHfxYLlh20ux3Ov5+Ar+DXHB+Ph4RsIifyAb5D3+G/BG7V9J
         vdrNTFWPRlN8UxKeBPeoNDdbSYdFdluiuQbo2lvc/vjRZ1r2f7H07u5oSA6mykHK9iMW
         f3jg==
X-Gm-Message-State: ABuFfoho+tJm2JdCKZAVC+/v9XmNMyvLSKBMn7PAzBMLE9pe48yi0dCc
        HxyqX8ggKB52OLMJXkBC0DTCp2ee9rQ=
X-Google-Smtp-Source: ACcGV60wVhyRHycQS3o5IgvXtVSP0DCu5nSMsG1LytGYwSXnCxhtGTH/tVNHb2z6xIqZAyour1GMaQ==
X-Received: by 2002:a1c:2081:: with SMTP id g123-v6mr15262385wmg.144.1539667569296;
        Mon, 15 Oct 2018 22:26:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j46-v6sm17477553wre.91.2018.10.15.22.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 22:26:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/13] ci: rename the library of common functions
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
        <c9631845104dd66e1be6df9f15eec2481089c85f.1539598316.git.gitgitgadget@gmail.com>
Importance: high
Date:   Tue, 16 Oct 2018 14:26:06 +0900
In-Reply-To: <c9631845104dd66e1be6df9f15eec2481089c85f.1539598316.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 15 Oct 2018
        03:11:59 -0700 (PDT)")
Message-ID: <xmqqwoqizclt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The name is hard-coded to reflect that we use Travis CI for continuous
> testing.
>
> In the next commits, we will extend this to be able use Azure DevOps,
> too.
>
> So let's adjust the name to make it more generic.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

With many pieces still shared across these two CI systems, this
looks like an excellent move.

I was wondering if the other extreme of moving ci/* to ci/travis/*,
introducing ci/azure/* and sharing nothing was needed, but being
able to share meaning amount of set-up sounds quite good.
