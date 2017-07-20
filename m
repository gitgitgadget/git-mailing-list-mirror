Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2D81F600
	for <e@80x24.org>; Thu, 20 Jul 2017 17:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965410AbdGTRWQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 13:22:16 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:38012 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965329AbdGTRWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 13:22:14 -0400
Received: by mail-pg0-f45.google.com with SMTP id s4so17451113pgr.5
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l+Kb6QYXWJxFT+DEB7K+LiFhaMUzRdGL4W3/mlIWOLo=;
        b=bNrh5KemejBEs0wjMPSqP+s1SPy/TxkptSK4aEsxetAlkoQQFRWl92QQvvTM/fwapc
         A5JnT9nvvZkUqiGVCvFZGan4+P3DUGKRA7Swdd9h2n26s8mJGpe/YCUSEV3XQe4fn//E
         xOkOcfXan8gMCRKi/aQFZ9vjPAgVxkoWrCE+U/howFRboT6v2qAVyxkmGWV42OIPPRPw
         8GCxBFWxHZwunVVc7tKAEjITcghnvBpAmGMFY5F+WXQARVPMwoIndRrBgGDFk8BixkJb
         K+Y/tGuD5vtOHhNdg/i6bObbGzz7QGFAjYZSuePDFSVb1JVWF5rWToozJvIHDfyTqEjr
         RmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l+Kb6QYXWJxFT+DEB7K+LiFhaMUzRdGL4W3/mlIWOLo=;
        b=DxPqt0sTsS6uFkxxxWKT+/aA5jrXzyZXZpBfo2W4xIjsR2WCzK5fJo0FxEP/3PsoFj
         BMCb10eMb0RxkjCRvghWmnrPWXylr9lhG9yu3hl+Xjh6OKtm24CRghCIDwzwtwxElb9x
         K7asWD7Jj7MyCCFg06S4ysH7tBdKavTIxtgpSMnQfb+JafEKGWQtTCOqc0nfSAqD04H+
         xXpSw5fhPv9MVFHutIiKDm6vrf3ENu7J5o88+fpSOQw1Q9LO0YewBBirNQWhdfC/Jyun
         AI7M20Xlk8l8OYZ3I6645KKH+GQ1oAP8KXhVUWeIQfGMGwqCz/ILtyivY072TKb9f+uS
         XvLw==
X-Gm-Message-State: AIVw110k/D7VrJWEC+yGj4t3XN9ExO85oPyCFgS/TX2DCtXcwoWf4UkK
        seMkVoa3xGQJRXDb0WTwlj/eeXd+nJOX
X-Received: by 10.84.217.16 with SMTP id o16mr5060773pli.31.1500571334392;
 Thu, 20 Jul 2017 10:22:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 20 Jul 2017 10:22:13 -0700 (PDT)
In-Reply-To: <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
 <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Jul 2017 10:22:13 -0700
Message-ID: <CAGZ79kZ+5G0iOZ5ZpEYpB_Hsc9mftNNWNvixx4k37SzamFvrJw@mail.gmail.com>
Subject: Re: Binary files
To:     Volodymyr Sendetskyi <volodymyrse@devcom.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2017 at 12:41 AM, Volodymyr Sendetskyi
<volodymyrse@devcom.com> wrote:
> It is known, that git handles badly storing binary files in its
> repositories at all.
> This is especially about large files: even without any changes to
> these files, their copies are snapshotted on each commit. So even
> repositories with a small amount of code can grove very fast in size
> if they contain some great binary files. Alongside this, the SVN is
> much better about that, because it make changes to the server version
> of file only if some changes were done.
>
> So the question is: why not implementing some feature, that would
> somehow handle this problem?

There are 'external' solutions such as git LFS and git-annex, mentioned
in replies nearby.

But note there are also efforts to handle large binary files internally
https://public-inbox.org/git/3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com/
https://public-inbox.org/git/20170713173459.3559-1-git@jeffhostetler.com/
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
