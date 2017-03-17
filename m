Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74A32095B
	for <e@80x24.org>; Fri, 17 Mar 2017 09:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdCQJub (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 05:50:31 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38680 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdCQJub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 05:50:31 -0400
Received: by mail-it0-f53.google.com with SMTP id m27so19040016iti.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CzvmTnyqKTtAHhz3gFgCzJLc3PVP+gGD6mmEYIiMu/w=;
        b=Glku7yAL00UBq/POD/wLz02jK0qnQFip+5vnWKYI9yU7ITmhGNeX60aLqx8o1zwkee
         /O4fMMgPfvQnqC7gxh0QM13z/hZnjDcDe47dWAUmulNLINl9rmARzqMRICjm/C+LIMlL
         gwq3uo68BqBIjnWZ3x47b6lv+BzOdvHFn/nZcpbKIaO15ZY3N8jS7/pHpC1nD+ZEeNT5
         ktjQOZbvtld3RkM0jcTgCE+HTDM1eTN8ES660IX0Dakxz0yeOMpsboQMJnq1SKv/Wzxo
         KmljoLQLlppfCGRSv4lLbsuBWfp9yvXNtN7zM4XBHUI67G/Zz5yxevmnlH0qypH+T8Of
         CHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CzvmTnyqKTtAHhz3gFgCzJLc3PVP+gGD6mmEYIiMu/w=;
        b=A6SnbUzQ5+f/oPSv2JaQJ5DR836i96Cu8YBeYw+mrFt+SyWxHHQjMz3V7o/qhLlMR3
         w/ToyQlgfBnxgMA2Kks5xk6Q+qvG7X723vvQeVJ1Iuf5XEr+F+caC+kjYs4zn6e8JRbm
         aui314Pdql5A7MSqhlUiy0cC6FcjiL/KYM3z44eGZKawQeuUgXJQW//4YoF9a27DfILR
         1/o+qRQtOSxlnEMXafnc02UoYOfPmwoFIiKbifUpKLVmQg3Deibt28J9bkZED541sRe3
         BVZPe2zO5Y0ToWIoDKOfIIbV1hQ+WQO4XAhYEEYrOXfsOByv+ZKOdS/nuHNL2vm6lV+Q
         R9uQ==
X-Gm-Message-State: AFeK/H3dL1hrsXbPP7foa2bUrz3YnZgRYHkBIDESA4YFjr+Bkk4MZPL4tuB0A2nYN0yyPsL3oz2/DbkgTdzxLw==
X-Received: by 10.107.149.7 with SMTP id x7mr13561175iod.167.1489744229743;
 Fri, 17 Mar 2017 02:50:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.144.198 with HTTP; Fri, 17 Mar 2017 02:50:29 -0700 (PDT)
In-Reply-To: <295db01e-6252-6acc-88d8-d2f366397ea0@atlas-elektronik.com>
References: <CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com>
 <295db01e-6252-6acc-88d8-d2f366397ea0@atlas-elektronik.com>
From:   Okash Khawaja <okash.khawaja@gmail.com>
Date:   Fri, 17 Mar 2017 09:50:29 +0000
Message-ID: <CAOtcWM1jExsj_L4HRm194F57bt9LPuf8fFSpyuGWiPG7U_4v8A@mail.gmail.com>
Subject: Re: Viewing untracked+stashed files in git stash show
To:     stefan.naewe@atlas-elektronik.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 17, 2017 at 8:20 AM,  <stefan.naewe@atlas-elektronik.com> wrote:
> Am 16.03.2017 um 17:34 schrieb Okash Khawaja:
>> Hi,
>>
>> If you have some untracked files and your run `git stash -u`. Then
>> `git stash show` doesn't show the untracked files. Is there a flag
>> that can be passed to git stash show to report untracked files?
>
> Not for 'git stash' but you can use 'git show stash@{0}^3

Okay that's fine as long as you know. But the first thing that comes
to your mind is that you've lost those untracked files. Is there a
reason why git stash show doesn't show those files?
