Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E881F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJLGgM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:36:12 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37866 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeJLGgM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:36:12 -0400
Received: by mail-ed1-f54.google.com with SMTP id c22-v6so9801384edc.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evJg097vEiio+eQi5j51lwBrsfCl0ew3eSBNrNkC9Ug=;
        b=nxzZQcAx52IvyP1xmR/WSpQGIcThjb+hOaCMsAwYaCJIxePHDizxSMZYPfVVPnADqE
         S5YQcxLRe+m+wFeEO3ctPuinVvE4deE1ipLnOVeEwM2ZT2uo//P8ZW46Q8rbNywPhTuI
         Oabrqqsmjze42lmoRobY6knG1JkMBV++ecaU2SO7UuLCdsoLf6QC22TUMnFcUVjc5M5X
         vQq7zE1yeh8Bke/au4XWdBuiYzyiI1yOTH9ERURvzzPAGvshSaTSsNolwZ02ZSiw8vQ8
         NmjfJVNND/Llf6uMnRpwShAP61oD0K3vye2ZxE5/Y9WHWPgIPNHLYA8wnB4Uhd+PIZ95
         LQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evJg097vEiio+eQi5j51lwBrsfCl0ew3eSBNrNkC9Ug=;
        b=K1UR3tPBpvkYQLi9r85iBIjt5zJIMz4F6dtDpWMfPemYDOLQSUxebfTeywFKunBHnN
         JmE/Q5ileZp3sdwxbDdr0SA2eEHifTNDuHwafNek7E2Gd2NTb2AkLLOcyjYbVacHunQ1
         eTI3JMLAO5RTpuNhOH/VemBGEJyKgak1FHVaW8+XReZrxKoSv/+hNzvO9jtJs1o1RfqM
         cFAD4aAUPEmMSBQ1tEN4QfxkQ4IYp9HxVqx0gi1us2wLG0iKBwgktGoNO+F8r/8Xh+5a
         XND/ZM3VNLCcaZpvn2cfkeIh8Ve6Cylr40RJHAKV+NlwIInqPJykuS9tyFhWmM5G8NqI
         /x9Q==
X-Gm-Message-State: ABuFfoj0lc4HFOctnUqWM98rtz9ljkWyTSdnySbkk8JLVlKDfntUugYR
        hYDUbhgHfdJxlgY9Z7BV9LJOjoOOZCQgskdAuEWemQ==
X-Google-Smtp-Source: ACcGV63cTdFankHYdiM6CcxniYJS/5PiO23v37OiZnVkGBXU5Eq9KLHt4Cj0LKbflaKDGoQUr+JxRjAHDKgztjA8eMs=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr4514508eji.67.1539299203043;
 Thu, 11 Oct 2018 16:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com> <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
 <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 Oct 2018 16:06:32 -0700
Message-ID: <CAGZ79ka1pxPt+xT3vBa5xARG5P+Hd19sjOLO_y_zofVStsDWNQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@talktalk.net, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 3:41 PM Junio C Hamano <gitster@pobox.com> wrote:

>  * After fixing ignore-any to one of the supported option
>    (e.g. "ignore-all-spaces"), the color-moved feature still did not
>    trigger.  I think the presence of --color-moved-ws by itself is a
>    hint that the user wants --color-moved to be used.  If it turns
>    out that there are some valid use cases where --color-moved-ws
>    may have to be set but the color-moved feature should not be
>    enabled, then
>
>         diff --color-moved-ws=ignore-all-space --no-color-moved
>
>    can be used to countermand this, of course.

I had the same idea for --color-moved to imply --color, but there
we had some issues with configured settings, as we do not want
diff.colorMoved to imply colored patches, but only when given on
the command line.

I think we should add these tweaks, such that
color-moved-ws implies color-moved (both config and CLI options)
and --color-moved implies --color (command line only)
