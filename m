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
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BC41F454
	for <e@80x24.org>; Mon,  4 Nov 2019 15:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfKDP02 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 10:26:28 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46449 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDP02 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 10:26:28 -0500
Received: by mail-oi1-f172.google.com with SMTP id b19so5154408oib.13
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4vNUvEfncbCNvz+5cGzdVZhpuw8akv2hCc5mIV8Fe0=;
        b=qqJzJkrz1A8885I5L9iWi0jGCSllhUUWGozvNVMelitnMy9Dv9JrJyjCFnIm/6uyVM
         7XHJkdR4wX3HIOlhM0mIkFvZ+fGP4OCjc74h3NQ0WGLAbAXVLl42HEThaP3azMeK6BgP
         aSfsmqPrtgvbjCFEG7WmbXdlSpZO/CH6q7ghVSDl1NOoHHOzrHn4pe6prhL47ERcArJe
         PU8OlngxMdGbg1OppxAIYC+VCbp4xa3tpiOhFL3zBRubWtRRRbbTBVfcpMJpushh66RE
         127bBBa+ozwgnmgXzbNDia0CRE4JTUPIyc64pmMWU6021OjbMgIAPR5PiZZN2FitgnN+
         DZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4vNUvEfncbCNvz+5cGzdVZhpuw8akv2hCc5mIV8Fe0=;
        b=XbzrgfprZNQKedSTn6eqLVAGDTQOpUmjoGU54Ml3ZKfrxgfcDmNr+N1mu6nzkGyhzz
         begHD0tGpnyZNl5CK6xLupxZo83BsQIErjA4r3fY2ck4FtQmzZon8hjJkCSDD67wZ/rg
         SlnaPtctRSxFuHP/2oXW0QFEsuYQrjnncWXKtgitJzLPkEmONvNmU8NcOpAgAyiC4p+h
         AoL9MlkWQqv5mgwoWbDQ5GNDtyObM86URTQw3ISPoqFmRtbCM+PRmp7gsLLBdphRle49
         wGSLsmq9Ki4CWhKK/1TI9iTvIdI7TDbtrlqvaPsUXCTi5alr7EB5QWaihERYuMInQbSo
         7F6g==
X-Gm-Message-State: APjAAAWAWIAzOp9grPUKodk89nm8V6ugrhmD5HsZl8HmK0PstqNGmvKb
        TB4c4Xr6rrYWxVqa+TfrVcvXyHqp51n6JGitsTe6DJ4h
X-Google-Smtp-Source: APXvYqxwFSr1x5+OUbkqGxWdZUMFOBmEhHn4PdcArfbXTdh9bu5/4HDkm/a/F7/64PdOiTlx2ZAvuDnvo/6NgXqTGqc=
X-Received: by 2002:aca:d6c4:: with SMTP id n187mr1644556oig.6.1572881187238;
 Mon, 04 Nov 2019 07:26:27 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.21.1911041316270.23271@fossies.org>
In-Reply-To: <alpine.LSU.2.21.1911041316270.23271@fossies.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Nov 2019 07:26:16 -0800
Message-ID: <CABPp-BFUPhJ1wmJa5htnjXrHkFKLuj2ggAuyPvrM0TP-0TZwuw@mail.gmail.com>
Subject: Re: Some misspelling errors in the git release 2.24.0
To:     Fossies Administrator <Jens.Schleusener@fossies.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 4, 2019 at 7:07 AM Fossies Administrator
<Jens.Schleusener@fossies.org> wrote:
>
> Hi,
>
> although misspelling corrections are not the most exciting issues and the
> spelling errors are rarely true code bugs but mostly contained in the
> comments and documentation parts they correction may still improve the
> overall quality of a software project a little bit.
>
> In this sense I created a code misspelling report for "git" using the
> program "codespell"
>
>   https://fossies.org/linux/misc/git-2.24.0.tar.xz/codespell.html
>
> or version independent
>
>   https://fossies.org/linux/misc/git/codespell.html

Cool, thanks for sending this report along.  The typos within the
Documentation/ subdirectory have mostly been addressed by the
en/doc-typofix branch (in next, not yet merged to master).  There are
also some false positives in this report (e.g. mmaped should not be
changed to mapped, CREAT should not be changed to CREATE, examples in
format-patch showing how to correct spelling errors need to keep their
spelling errors or it won't make sense, and perhaps some others), but
most of them look like actual spelling errors that should be
corrected.  I'll send in a patch, and mark you as the reporter of the
issues.

Elijah
