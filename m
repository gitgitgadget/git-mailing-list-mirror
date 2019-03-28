Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B00C20248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfC1QCU (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:02:20 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40909 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1QCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:02:20 -0400
Received: by mail-vs1-f66.google.com with SMTP id f22so8738449vso.7
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfMqqA37r5EKfG/GSuHzGSYod4miHMpvibc9kpHNqkU=;
        b=i22/kj+8z0QjmApabsz2Qo9p/hq3GnbxVb1xd8utfT5xyjHpUqtQUPJ+nZTsj0tVmJ
         ov5kvhTgZefionZFiPenb81qMu+9mMMEKUocVSGIRPa2PvedY2tRptLW/7OZ2zuRb7ND
         HAbaRCfpomE3LDHdBG0ak0lTjfMxfhi2dZQu22gwNUsJbZi0xzCsFLrZk499CoGYb22M
         sijdfX3LxefT1YzpZnQYebzjmZXKVgycmoFvp2sRbyrMijMqFMpEouru645pCXWeLJqc
         VuXEyHRfvF4+8i5y97aiIwRfH/+VmJg1a68J+MtXvnusWIwppq/Kr/qfICYaw0ldmO6I
         wezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfMqqA37r5EKfG/GSuHzGSYod4miHMpvibc9kpHNqkU=;
        b=pxDnFqJTWu68JHOTMBaGiuRJdUZ34oxMJXBd1BMv9xvnYtaG2o8cw11RMEmC97v6G8
         e0U8jD/N9sFr3dn9hhgOWfYBjqLsd9YXxC2o3zQ4ex/atiI8bi5EyNelwBZl3HRLJBB3
         TdUyiaMOwKBvzH+ASa76ztMo28NQj622S38nUn8JiU9N3ww2OPaGR+mr7Xx5vHYWbsfY
         blJcLZTT36d071UOI0P11iNjLK2bWcDDEA2FT2ruzR0J48x+bdul8rCbGoRhKncr7MtM
         ybgHjdnOz5QGA8Z+nlhhHSuBEILT189GBJvdz9iIpDS9MF/hcanLG1bRpCliAGwH+Xuz
         vBbQ==
X-Gm-Message-State: APjAAAUZjuazAD0oMDRy9WZHh6QCwQruAf5coO2Sm2PINT2BnvWx/zuM
        UPdp3Sfe8ssrPLS4D8DoLGjiX0okQfMAaH5SR0pv0n4m
X-Google-Smtp-Source: APXvYqyGmSwiXdiQOHL838FMkD//Dp6MDzGVgAQWnttn49L4m5Tn3mpdMwG/+RlrbXBWwrOjEISoWUpvgyGFt9vdpWM=
X-Received: by 2002:a67:f416:: with SMTP id p22mr27693966vsn.175.1553788939232;
 Thu, 28 Mar 2019 09:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <1A5DE2FC-7D94-4785-A915-EA2A71C6C377@m-mooga.com>
 <CABPp-BE9vNhnN6XdcxnePnXkek0bNogAiA_cKJqZ1-ct=QA2pw@mail.gmail.com> <BF34A383-7714-40CC-B5EF-4FD20E7AC839@m-mooga.com>
In-Reply-To: <BF34A383-7714-40CC-B5EF-4FD20E7AC839@m-mooga.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 28 Mar 2019 09:02:07 -0700
Message-ID: <CABPp-BGiP8BZwWQMbYhVQjqq8jZx+bbUTfgLaC6ZyukpLErZBw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] microporject test_path_is_*
To:     Mooga <contact@m-mooga.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 1:31 PM Mooga <contact@m-mooga.com> wrote:
>
> Hi Eliah,
> thanks for the advice, but still after I read the  SubmittingPatches , and see around the Submitting patches process still confussing for me , there's a better way  for explanation as an example
>
>
> Regards

On this list, please respond to emails interleaved or below the
original email; we discourage top-posting.

What part of the process is confusing?  Without knowing that, we're
likely to just repeat the document as it stands.  Also, have you taken
a look at https://gitgitgadget.github.io/ (which is a new thing
designed to make submitting patches to git.git easier)?

Hope that helps,
Elijah
