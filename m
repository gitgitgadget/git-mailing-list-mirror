Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5734F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162763AbeBNTMK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:12:10 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36070 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162665AbeBNTMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:12:09 -0500
Received: by mail-yw0-f174.google.com with SMTP id t129so15517712ywc.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8ovLYNIvxuziLw5ixVMhpur49hnEJk0X0BcCLjwMJ8w=;
        b=D+pnUQpHtXMnhQ25+ktbi/haOLSWI+NI7KO3ItNjAzVo9boLnaI6UiY30KXvzkQ+NR
         5I+ZZqR7s+Knz4lOULEnmjZKCctt5SOh8yPtn6RaGqQWwKos95jd5uhkUXabNoe3A5U/
         8OgPZhlKEvc9JrWRssO7SlGqK9yed9haVTuJ2mPecxBYaNu0KV4flskbTuAZn68HzMYJ
         YY9eJBWou+fKTt9OQO6OD9sMBTcfCVVJbFaEAY7aUozLfCtziNerLlY9/b6PWjeHuv4g
         s546FbZXZCff5D05AYlxtFQg4KBM52uZ1OrMVqvFzVn8rNfr2wIc/KlMAplJOFGL4sQ/
         BELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ovLYNIvxuziLw5ixVMhpur49hnEJk0X0BcCLjwMJ8w=;
        b=mn/IHityIJewIGhSLB9moSNBh4FtuUpBrZta7bT4nMSIv+LctnrdO5DgMSfzZ7WXVy
         NUsNMSHKz0AnZCVjhEh9YM3X7XdKdUrKGdUE3dB4finRvozkPPIX2suJttCwv4wldfVI
         wnh1C/Az6SoaB0vl2lTlrtR0TldKKIlU7KBtXiurGjeKgsnNCcuWBzI6G1o7JvYXxYd5
         hD8Z6b67IIC6P0qh8y1nGnBCaAq9ISNMbp3Pyp0uSTBa6MyZUqIGHkHFRF25nrbiAI82
         Xdf8i4W2qnZd4TYAxwzaKMHRpmEIAQGnxarjp9VmTQbyRTPNMuJovS7zukK8r+Y3ba30
         /tnQ==
X-Gm-Message-State: APf1xPC0hgIVLwykEACiO8H/uHxXFz3CF5czammrDZOy/gEJ7q9JDk9x
        hAyk6qrSPp2Po+LmSgxupo53UCc6izArdl7rqwqWtA==
X-Google-Smtp-Source: AH8x225yKagcENBSaTVJXF9iFi5B9gkuG/kxzf0p9RecXOtce/bvOQNsn0VJoTYePUlusoIHnsdP06OiaU3AYq/eYlA=
X-Received: by 10.129.86.139 with SMTP id k133mr204049ywb.253.1518635528218;
 Wed, 14 Feb 2018 11:12:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 11:12:07
 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802131927310.17903@localhost.localdomain>
References: <alpine.LFD.2.21.1802131927310.17903@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 11:12:07 -0800
Message-ID: <CAGZ79kZ1yYXToC_WvW8e93zvajkw06e8BT_FcJUXWtFBK3Xe4w@mail.gmail.com>
Subject: Re: should "--recurse-submodule" be "--recurse-submodules"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 4:30 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   also just noticed the following:
>
> Documentation/RelNotes/2.13.0.txt:489: * A few commands that recently learned the "--recurse-submodule"
> Documentation/RelNotes/2.12.0.txt:226: * "git push --dry-run --recurse-submodule=on-demand" wasn't
> Documentation/RelNotes/2.11.1.txt:27: * "git push --dry-run --recurse-submodule=on-demand" wasn't
> t/t5531-deep-submodule-push.sh:366:             git push --recurse-submodule=check origin master
> t/t5572-pull-submodule.sh:45:test_expect_success 'pull --recurse-submodule setup' '
>
>   should some of those be corrected?

I get the same list via
  git grep -- --recurse-submodule |grep -v -- --recurse-submodules
so there is no missing piece left.

As you can see, the first 3 are Documentation, and the other 2 are tests,
the actual code is always --recurse-submodules (with an s!).

Fixing the docs as well as t5572 has the impact of "just fixing typos"
(though that is specifically valuable for command line options where
exact spelling matters)

The fix in 5531 is an actual bugfix in the test suite, which
went unnoticed as the test itself did not fail.

The test did not fail because git autocompleted the command
line option silently. But that is not what we want to test there.

Stefan
