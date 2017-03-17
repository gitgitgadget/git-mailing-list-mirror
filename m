Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDDF20951
	for <e@80x24.org>; Fri, 17 Mar 2017 12:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdCQMjj (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 08:39:39 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:33257 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdCQMjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 08:39:37 -0400
Received: by mail-it0-f42.google.com with SMTP id w124so11867900itb.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kq60LdE4xT2t8EXtYsWaz81bZ+9MeD9RvMwMcT/Z5H8=;
        b=XNi5yPs34L3IxCNnV6hec10QKW2AtrtO0o17vJ6AW3IOlZHKcDie//gN0YeRbjs+fk
         z7F78EaXKdUqHg0VkqdSJqVBjp90s9QUDz6T9GiAY2OQHpVECdXy9EBNzgV0K+AvbOY4
         gf7+iGpTNY4ed/a/4OrLn2mzx/m+mHZ5qMcAJ3KT8b8nW/TsiHzgRJPdqzd14I6lQR6N
         DZjy+5UUhrIEDg+1qtruCkj5aqgNpOJArKjzMDC8/FaXanqvoyYS0+tZ7UoOvvegAK0G
         usM4064D3IWHx6zMvJoFLVnBe+l3pxP2jsFP6dZLOgz9iAESLYr6dY7SQEDD6mAZ360/
         q2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kq60LdE4xT2t8EXtYsWaz81bZ+9MeD9RvMwMcT/Z5H8=;
        b=nDX3IV1ts+Uc7mWHt3QuPEUHW+cfiswp5gM9qQDtMNFgCfZia6oxNd0JYHUk+bFgj/
         xKEDtZG/J/sj9KlLs0Gd79SA5ExM+4DTxGFYi0mJUreZkhJgfNbN0ltogDFQQgXA0II9
         zzDamCFt6x/n6ILp5+W1alXNQih1i1toTls2LSZ+ESm7Z23mcgKG+qiaZGA5apRf1nDJ
         I0t6CfLAUg2GlS2ijS0aEmTLQLYyhuHSJlszPDfRyjSamZ51WJPs+njqEiHAgSVtYMH2
         QB4EoBMqI9QqsQOgjNUEkhoq7J1yn283bN80TzjT7ETFcZE4BY74vYl9a/i67AsOYvmj
         f9MA==
X-Gm-Message-State: AFeK/H0Bh/gtgaMLDT2X6Tw52eMzkuytIWvpQ/zHKNTQBNog6zBkSWCwaa0SIPfvz+YeW000sRUjxZcsx7L5hw==
X-Received: by 10.107.149.7 with SMTP id x7mr14073162iod.167.1489752496673;
 Fri, 17 Mar 2017 05:08:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.144.198 with HTTP; Fri, 17 Mar 2017 05:08:16 -0700 (PDT)
In-Reply-To: <CAOtcWM1jExsj_L4HRm194F57bt9LPuf8fFSpyuGWiPG7U_4v8A@mail.gmail.com>
References: <CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com>
 <295db01e-6252-6acc-88d8-d2f366397ea0@atlas-elektronik.com> <CAOtcWM1jExsj_L4HRm194F57bt9LPuf8fFSpyuGWiPG7U_4v8A@mail.gmail.com>
From:   Okash Khawaja <okash.khawaja@gmail.com>
Date:   Fri, 17 Mar 2017 12:08:16 +0000
Message-ID: <CAOtcWM2wg3_uV=THi_PUSVcD8rXMwbd-ZDcTxC=YXvgpP1g_vw@mail.gmail.com>
Subject: Re: Viewing untracked+stashed files in git stash show
To:     stefan.naewe@atlas-elektronik.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 17, 2017 at 9:50 AM, Okash Khawaja <okash.khawaja@gmail.com> wrote:
> Hi,
>
> On Fri, Mar 17, 2017 at 8:20 AM,  <stefan.naewe@atlas-elektronik.com> wrote:
>> Am 16.03.2017 um 17:34 schrieb Okash Khawaja:
>>> Hi,
>>>
>>> If you have some untracked files and your run `git stash -u`. Then
>>> `git stash show` doesn't show the untracked files. Is there a flag
>>> that can be passed to git stash show to report untracked files?
>>
>> Not for 'git stash' but you can use 'git show stash@{0}^3
>
> Okay that's fine as long as you know. But the first thing that comes
> to your mind is that you've lost those untracked files. Is there a
> reason why git stash show doesn't show those files?

Here's some more interesting behaviour when stashing untracked files.

Add new files (untracked) + modify some tracked files -> `git stash
-u` -> modify the stashed files in a way that `git stash pop` will
fail -> `git stash pop` -> it fails so now you would expect none of
the stashed files restored but instead the untracked stashed files
reappear.

This combined with the fact that `git stash show` doesn't show
untracked files suggest that untracked files go into an undefined (or
at least undocumented) state when it comes to git stash. Is that
something that needs to be looked at?
