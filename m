Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF8C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2327C22BEB
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgH0Q0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:26:41 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33673 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgH0Q0k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 12:26:40 -0400
Received: by mail-ej1-f65.google.com with SMTP id a21so8509658ejp.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 09:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z26eglZq3m686eyUhWqzF9GLLcET5R4euZQz4mahDro=;
        b=KpGlVGAima+N/dy0pX3k+nESfTdGstnhsAYs8eWhzpW2pm3CIo1kax95esgtSpuGCo
         0YNZcs53KXzNSzqlNdcwzJva03jlOO33eYrlRWdjuZe6+nmcSVJU2oMW+hFJSB+rjzj9
         SEWei4nDF/D+KY5UawuiDgcR93K+J44NgXNBYL8ppdcxxqPvL2XqCb/UI0rUfGizNKbW
         jYn38ruBq8V5j+G5gmz90+XoE4yIAEmlYBiUTq5YicX0y2eoZBAjSg3fQ1Ggt9Tr7aLt
         bcWpYJ0pqM5cuTGmefdI9F9quk1snpfY1iwVLbCn48Px9yzS0x7ZBqtm85YKJCYSFraP
         g05Q==
X-Gm-Message-State: AOAM531L+kwqBRZIfxqIxZGhnRGlxnfoNkg7xP8HMcHis+1YWrbgQA04
        Jbn9nlKctfyqE1AXcRYVRGeXfOxlRRL+NlS65bWtRf+DRSE=
X-Google-Smtp-Source: ABdhPJzvgUfIUtj0yjwsCh0VAMPhhCCnKE5DkgKFoYinwQHnGd7K5ab7r/Fmybb00UPSx0eaWzqrZL/kJo0l5Lz9Ln0=
X-Received: by 2002:a17:906:4f11:: with SMTP id t17mr19315279eju.371.1598545598691;
 Thu, 27 Aug 2020 09:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161224.824365-1-dev+git@drbeat.li>
In-Reply-To: <20200827161224.824365-1-dev+git@drbeat.li>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 12:26:27 -0400
Message-ID: <CAPig+cRZEgu4GfMGSWQbs4cV9OGT9z7gKh8v8S+_sWmKFJd4Sg@mail.gmail.com>
Subject: Re: [PATCH] gitk: use the 'reference' format for the commit reference
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Paul Mackerras <paulus@samba.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:19 PM Beat Bolli <dev+git@drbeat.li> wrote:
> Since 1f0fc1db85 (pretty: implement 'reference' format, 2019-11-19) in
> the main Git repository, there's an officially blessed format for commit
> references. Update gitk to also use this format.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>

See this thread:
https://lore.kernel.org/git/da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com/T/
