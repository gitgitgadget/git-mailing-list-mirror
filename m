Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6DF1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 15:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404865AbfAPPc7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 10:32:59 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38101 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732887AbfAPPc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 10:32:59 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so4147943vsa.5
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIHJAPA3ktCSOVyyUelOOvUKk/7J3/6K0NLbABuctF4=;
        b=ORWZk0Rh8Zg4Zwhe1DItUa17x3xKJLAtKVr7wRWRv9WJm5YW39gjNDL8GyH1d2brb+
         oq0LZ45LH1aAaPdmM8ZBClesZeaUwDQLsOsg2PaGt0gOJY3zqJMMDrgXxlHrKVyt9igO
         Nc+1n4rjz2gwdAcLSshdP/jXDY38+iTq/s/SBe/U3r0mDzxnjjT4kw6SP87t+MqARc/G
         vhzZhSzKPNwXBgGkn4sOpIzvi9lJkgutX6IGaG7n66nbz1K7mRY0nMObNT0S5Vzc7SFH
         Ec/VJOjfOb7Q33qd06xBv/5U6SkgbovXg6yu9zgAAUsuhtZlWBxwZmL4kIQG7Vbu66Rq
         KwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIHJAPA3ktCSOVyyUelOOvUKk/7J3/6K0NLbABuctF4=;
        b=sXnsljSmHYX9/IAP1vcEqXQp1mADeI2OO2IN06uj9UjwWefqkAnrcwSTLPUsygR51v
         vAaagAFjmOTQHKIwHeYlKCEy1zY4UK3CyVfA9i1K2A5ak7fspIjCV8xPhPUIA48+vSnr
         yfCS5GWHyaE+Bve8RFUHuh5D3ODJh+IRwc+jVMVYdwh8dnr2ZRh+lIBH1BcIgx1VkFBr
         Vkj7o2hWkJlRSNtCk0uK9sPiRk0l4X2kZaygSA4cYB4tcs3pTPnS+UDq3yIV7W/Lwb38
         RRLy5BWZ0n2ByV6808DBbqKkeiSLdVvTbCydaV7562g2lQlXKnLejwuZr43al2DiJsI5
         HCUQ==
X-Gm-Message-State: AJcUuke/6j4gX1F1+6nJUTZ/IqdHf+NRcQRguLESqvPlTBYFMVbl/251
        rBU+siLXWGse7F7zBzQbBNtEfig/rpUIAiopeXmboQ==
X-Google-Smtp-Source: ALg8bN51/z5A9vynSTEg//MWDjzHUBUfU1AUTLmdWtY1/e+6Y9eNKndjr+X5Yw4+t0kgV29lMfZimxzycR+RndrjfII=
X-Received: by 2002:a67:3e12:: with SMTP id l18mr4080236vsa.53.1547652777662;
 Wed, 16 Jan 2019 07:32:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.109.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Jan 2019 07:32:45 -0800
Message-ID: <CABPp-BEXU7zbOgMK-JQJrNyyaek593okbWM10G1YCx0Gy0o=JA@mail.gmail.com>
Subject: Re: [PATCH 0/1] t6042: fix breakage on Windows
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Jan 16, 2019 at 5:37 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Unfortunately, Travis decided to change some things under the hood that
> affect the Windows build. As a consequence, master has not been tested in
> quite a while, even if the test runs pretended that it had been tested :-(
>
> So imagine my surprise when master simply would refuse to pass the test
> suite cleanly outside Travis, always failing at t6042, despite the fact that
> Travis passed.
>
> It turns out that two files are written too quickly in succession, running
> into the issue where Git for Windows chooses not to populate the inode and
> device numbers in the stat data (this is a noticeable performance
> optimization). As a consequence, Git thinks the file is unchanged, and fails
> to pick up a modification. And no, we cannot simply undo the performance
> optimization, it would make things prohibitively slow in particular in large
> worktrees, and it is not like the bug is likely to be hit in reality: for
> Git to be fooled into thinking that a file is unchanged, it has to be
> written with the same file size, and within a 100ns time bucket (it is
> pretty improbable that there is any real-world scenario that would run into
> that, except of course our regression test suite).
>
> This patch works around this issue by forcing Git to recognize the new file
> versions as new files (which they really are: the patch simply replaces
>
> git mv <old> <new> && mv <file> <new> && git add <new>`
>
> by
>
> git rm <old> && mv <file> <new> && git add <new>`
>
> which is not shorter, but even a performance improvement (an unnoticeable
> one, of course).

Everything sounds good up to this final sentence.  I'm wondering if
I'm misunderstanding or if there were some simple editing errors; in
particular, I'm not sure what "even" means here (should it be left
out?), and it seems like you meant "noticeable" rather than
"unnoticeable" -- is that correct?
