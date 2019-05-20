Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51F81F462
	for <e@80x24.org>; Mon, 20 May 2019 19:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfETTGT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 15:06:19 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:40931 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfETTGT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 15:06:19 -0400
Received: by mail-io1-f48.google.com with SMTP id s20so11915414ioj.7
        for <git@vger.kernel.org>; Mon, 20 May 2019 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzZE9jFbHqOGJKb7odntY6nSTCezqxIRWPNodlHk2xo=;
        b=CBIza3B1gqmWZ19UAfEjcgM1l7DpiemU8uY4yUS22ENov5JFyxsZ3CBksQYSdxP3fY
         4MFg3eevc5IWAbIwbrAOTsswjBFfaH+0BBTcnQ4ayVDU2zVvSEi13iL0Kq0aduCc2Yfx
         8yaK18JSItLIa8GLI1v1J02rpFGUD0P+y6PhlUWVLWCXiWnDA75F28HRHyXjh+Ie+c9g
         y5E6zVLvOHr6qieIMlH4FERkw3WmsRIfzaMZYZIMv5mPCzNGPFzy5hkzMSmS/e6bYCxX
         o4GrOZxuj85UcljKrEOIzz1c1mcYUR6cFb7e9syLlshs4GYo5nJclkGkWQZAsWh7LnUY
         o7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzZE9jFbHqOGJKb7odntY6nSTCezqxIRWPNodlHk2xo=;
        b=K44lKHDY8h77BR1qJFO/gdWxXYuubPzFTRGrfWEjWB6f+fG4XviUG3yPRN9eRgEbdP
         Wv58p528v1cn24fNQwl7vamC9ubnwETKGui99tZ3wHK77Ts7nMtOp2YldgxhdTmIo5mZ
         O+P1lmMQMkqoGSiujuVY0oxrwD2nDh1Q4ZFfUWoPZohn0itEBH9VeG8s8ijT1Oe6kuKC
         Nr8mhYElQcuM+9I0/jplQRuQ+y+A2mEt+6otVmmBQvol4+6539skpqVKgo4YLPLhzXGd
         OGLLQvnugBO3Vohd8M24B3PqHT92NEhVBgt1EyxWbenX9dqwxOk7XLBe7vGN+zJ4o3Kv
         YMwg==
X-Gm-Message-State: APjAAAWteu2NA4MO+EVnUH2Z59+G7jQrUDWkXO9/rtbQz3S8oWeP45H0
        7ADvlCo7rJo3xixxhvccrhi40EAOqWL93LoIcROIoPk/hrU=
X-Google-Smtp-Source: APXvYqyloS6ZKCQ4Ac7ONK15oKaup7o7Pm35bkJPFMluGEfbd0oRHuQupykbysUKED2G5Ua3l/KlU8Pq4nc9KSYrIY4=
X-Received: by 2002:a05:6602:95:: with SMTP id h21mr20536731iob.109.1558379178175;
 Mon, 20 May 2019 12:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 20 May 2019 12:06:07 -0700
Message-ID: <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 19, 2019 at 10:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>  * The diff machinery, one of the oldest parts of the system, which
>    long predates the parse-options API, uses fairly long and complex
>    handcrafted option parser.  This is being rewritten to use the
>    parse-options API.

It looks like with these changes it's no longer possible to use "-U"
(or, I'd assume, "--unified") without adding an explicit number for
context lines.

Was it not intended that a user could pass "-U" to explicitly say "I
want a unified diff with the default number of context lines"? Because
it's always worked that way, as far as I can tell (certainly since
early 1.7.x releases). Is it possible, with the new parse-options
code, to restore that behavior? Removing that is likely to be a pretty
big disruption for Bitbucket Server, which has always explicitly
passed "-U" to "git diff". If the community wants to move forward with
the change, I understand. I'm not trying to roadblock it; I'm just
listing an explicit example of something that will be significantly
affected by the change. Perhaps Git 2.22 could emit a warning about
the change in behavior and then a subsequent version could turn it
into an error, to give us (and anyone else relying on this behavior)
more time to make adjustments?

I'm aware a unified diff is the default output, but many commands have
flags that essentially tell Git to do what it would do by default.
That can help counter changes in the default, as well as safeguarding
against new config options that allow specifying a different default
(as it were). For example, "git diff" has "--no-color", which could
override configuration and essentially applied the default
behavior--until the default configuration was changed in 1.8.4 from
"never" to "auto". By using "--no-color", even though we didn't "need"
to, we were protected against that change in the default.

Best regards,
Bryan Turner
