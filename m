Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E2E1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 01:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdL1BJg (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 20:09:36 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34475 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdL1BJg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 20:09:36 -0500
Received: by mail-ua0-f178.google.com with SMTP id v22so9518546uaj.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 17:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y7oJLp7iBCAIiZFWWU6ZEMXeNoTf1LvzZX53ivyVOm8=;
        b=dx8ybtX3M7N9ALdaDow9MCFjVUNOo1LJEUdVuGWomdlS0cFBW6udbwuH/45Eh+DlxL
         FBWZQ9peMEkKNmcuaNtqxIYgxsVDtO+NTf1Eg3PT8ri3mgGFYLcfHbrbAFzFsLum/TW3
         mUBW/uBEfUj30hv6FxN0a1AhM0SnvynZ3S1IVZEYI88r9McDKia02nbwmwkfD7dXgMJT
         vFQ/9sfY1l3ZAgiNmKJjWUJ1NFqlriiEXfetYveMh448EmG1XN9TsvmJQhIkxCxpkv9i
         xGpm8X9X4q+d566Zcu7owjcRa12K5S29jj5Uf4IGaQuxmnaw1S3Cr16lWc5ZnYbl/Xvd
         QCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y7oJLp7iBCAIiZFWWU6ZEMXeNoTf1LvzZX53ivyVOm8=;
        b=ERNrKcRCbZ41abWysXQEzII14gQQTzaJ89bGtM7U2KPrnncvNzTEyqVSVbpGoqH0u9
         MGSGe2ebsWskdI46TTFmXZICswCQ2MlM6tHkBe0V68QSPFs/n9o2Z03/3tERna14GqB4
         xnqNCJ8Gf91fJVP00x7F3LxMPj5EIGmbBoxRr84SI6iaWMPkfn4LZpZnroWx+7aQLgbn
         MEDsFvSfK2TkJ9IEIBJ1rMwa7b7hjqxuLPjpnSb/tMdNRRcdMRnaTnSSubXMWsr2Hg6W
         WyDuiK1Su4M9Go1p+DjaYa3YD/ArRei3QwQ6av/76x5kvgjeYOS+jYPh+IQzzZZ9CT77
         Qg6w==
X-Gm-Message-State: AKGB3mLyLimSyaQO+Ds6y6FLIpyUdlgg/9RK8+GsQ1kJm609VxJ/Eb4U
        GpKzRLYAy2RxLM3nULPYNAVbh3OlHKHSQz8Lo3Y=
X-Google-Smtp-Source: ACJfBotQAckBeJCOaya29Tbxru0xCeIM4M0peVbMhygp1OnpwWe+zUM/Unx8dRuUmzqYCgnLSifOXSJuWfTRTap6fIc=
X-Received: by 10.176.65.135 with SMTP id 7mr22171333uap.127.1514423375095;
 Wed, 27 Dec 2017 17:09:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Wed, 27 Dec 2017 17:09:34 -0800 (PST)
In-Reply-To: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
References: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Dec 2017 17:09:34 -0800
Message-ID: <CABPp-BHxcFU+e4OgccWb+LgLbMo5sJsNjYFQb=WnxViTFdOu=g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #05; Wed, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * ew/empty-merge-with-dirty-index (2017-12-22) 1 commit
>  - Merge branch 'ew/empty-merge-with-dirty-index-maint' into ew/empty-merge-with-dirty-index
>  (this branch uses ew/empty-merge-with-dirty-index-maint.)
<snip>
> * ew/empty-merge-with-dirty-index-maint (2017-12-22) 3 commits
>  - merge-recursive: avoid incorporating uncommitted changes in a merge
>  - move index_has_changes() from builtin/am.c to merge.c for reuse
>  - t6044: recursive can silently incorporate dirty changes in a merge
>  (this branch is used by ew/empty-merge-with-dirty-index.)
>
>  "git merge -s recursive" did not correctly abort when the index is
>  dirty, if the merged tree happened to be the same as the current
>  HEAD, which has been fixed.

As promised, I looked through both to check for mis-merges or problems
in applying to maint.  The changes all look good to me.  I was
surprised by the branch name, though.  Was 'ew/' a typo, or does that
part of the branch name mean something other than what I always
assumed?
