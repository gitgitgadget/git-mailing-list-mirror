Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5642C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 17:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJMRER (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJMREP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 13:04:15 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006CCF53E2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:04:14 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id a67so3467806edf.12
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYw11Gr1U6MEyOpHfAomo7FBfOMBTVwOW1jlcBUzym4=;
        b=Bv3d78twnHVW3GV2BeDsMPVg2zf78HGkleFtwKvHD69gqjaj17t9CP+oVBLJSILXhd
         uEiuLdtzyL9+PLq7fZSEREPjITUxMoIyo2sGlF5L3DGu4OgZrEfpCh9/4kF8ApsyHh3U
         ss+Rh7fJrxpcixi9e9gS1m3KzjbP5CCN/BzJFpUvF1tTqUWc+m6Lqy5nFLyoRotsNRB9
         yk3x6MdT+xTD60GLX2NyF0tT9GGCu8liGnnTLjcrGrHTEGVWGq3zsvuAE3RUfzPKHXS2
         YRnfCQ5FsXg8XzMZQ0XBwN0tIRYjIpTxmNZodNqIbCx5kFXA7+E6bHq3j7nDqURj1WIb
         y/Jw==
X-Gm-Message-State: ACrzQf0ZO4xat/75AHtOKqljbEXX16XbwYiY+QjSD8dYRYJyuTQ/NItA
        Y4cDZgr964yQXn6qcE7GqQgL69XKGOgrjHdTIzzZTjpHMj0=
X-Google-Smtp-Source: AMsMyM7Y7lOedvymtSdY+r2bHcrizZUZBeZ6CQd2tNTDypcn/hmDkEUBFKUc4umAblI7JVKKKl7AVgbblWRWr9vO5JU=
X-Received: by 2002:a05:6402:510c:b0:45d:50f:f65 with SMTP id
 m12-20020a056402510c00b0045d050f0f65mr600724edd.313.1665680653418; Thu, 13
 Oct 2022 10:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <AS4P195MB1527E825B28B3C17F39D0AB7E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <AS4P195MB1527C07F4E985018B6BD12C3E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <AS4P195MB1527C07F4E985018B6BD12C3E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 13 Oct 2022 19:03:37 +0200
Message-ID: <CA+JQ7M8Bcr9czyBNg-+sFpqGSy=3QJfps8vGPa=82QGAvqpUSw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Cannot_rebase_=E2=80=93_possible_Git_for_Windows_bug=3F?=
To:     Hans Meiser <brille1@hotmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 1:43 PM Hans Meiser <brille1@hotmail.com> wrote:
>
> Perhaps this is a bug in git version 2.38.0.windows.1?

I've rebased a lot in this version with no issue. I'd say it's highly unlikely.

Without more information it's hard to advise on what went wrong.
