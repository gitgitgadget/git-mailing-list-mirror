Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215A31F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeKCRZl (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:25:41 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:33636 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeKCRZl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:25:41 -0400
Received: by mail-io1-f46.google.com with SMTP id f12-v6so3050441iog.0
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+1/QvqvQfF7jfTKmU0XsfndAQEMgkjRq/+zzE+C7sQ=;
        b=el6WGWGIU882RsJug6/TTvCc2RkNeUm6i0Hso8Lv7kvuUEsMopafiRQi8BAoiK+VU6
         kHPSSu67WlykoXe0qFeruV0Yla7r8AtYLGDp19HrEw/uYre+3zPQjkU01F8tln8NGFQE
         GXWnfQVhfEnK1NweFdjWktJBlr6lo6cxj265vWOlzKORoP1nxjm28mp1ot0oUG/Voh2L
         LjFjNmMAFLHYO9dHYpt+cX8iFgd6Sd3KriDjv90HRtNH0t0LYxyj8V+cB/53YkV8OiPW
         eeFvlssHSk4yNOO4nIAhpcgBqbtoqfgWQK5wejdeedc9YrHfY+/1fi6HJLqQkTN4q7j3
         FIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+1/QvqvQfF7jfTKmU0XsfndAQEMgkjRq/+zzE+C7sQ=;
        b=sZcQ1bzDj/7vi19p9gL/g17sS68ElXvdLVjcw4pcdZsqiAAPRL8amAkJtC5GNtAySH
         Pz6saSFqXYorUQOX6yjkvRQJ8VyUQ2BmgQw2Eihfoj7NFznXaz5mn1QgFQm836xl4PHb
         Z184OVOGHG4wveK0iGT7kjaa3ueI9DM9xDvYTPfNPg4Hhl9N6mKzJ2TnwJ1c0TX4kJZQ
         rJq9UaPcsDWqFaChxVI4IXdVT9AIs+lfh2wum0jYZs+FICTLShMxbXQaWJIoHfZHON4Z
         DtoZ6tOZQY+7sVUe+Dc8SaqwSY263O5GVM4tzQsXqTjzwxyX7S/fpj87t+DSlodT6utG
         tdhQ==
X-Gm-Message-State: AGRZ1gLKjr/Uis+JrQfmA1TZVpOFGc5B1X6fZIj/fmfWuqzNPhLwoll0
        OiL6U8mq7YL4Wxb03DnHIZRUV3vh3GrlBuRre1I=
X-Google-Smtp-Source: AJdET5fkttH3jYtiYylMvsegGS5q0ZfCBlO8BfMw2wFPUZzbuKqRcPTwUM4T3OCiZmxEf2qlDSQsKDacnu2q3bT9JBw=
X-Received: by 2002:a6b:8fca:: with SMTP id r193-v6mr12108995iod.266.1541232910144;
 Sat, 03 Nov 2018 01:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.64.git.gitgitgadget@gmail.com> <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
 <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org> <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
 <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
In-Reply-To: <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 3 Nov 2018 01:14:56 -0700
Message-ID: <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
To:     j6t@kdbg.org
Cc:     shoelzer@gmail.com, gitgitgadget@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 9:44 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> +      timeout = elapsed >= orig_timeout ? 0 : (int)(orig_timeout - elapsed);

nitpick: cast to DWORD instead of int

Carlo
