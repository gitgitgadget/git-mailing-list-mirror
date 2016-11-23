Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A0F20259
	for <e@80x24.org>; Wed, 23 Nov 2016 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934106AbcKWJq4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 04:46:56 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36391 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756100AbcKWJq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 04:46:27 -0500
Received: by mail-yw0-f177.google.com with SMTP id a10so6558484ywa.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2016 01:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e9F1a0NPR7pwUZzOjIuR33T0sfbTWvetJUp69Ihe540=;
        b=CJv87ookt+SqFl0UrsWAB0xGOJsp2eyEHXy2s8apTprHkB7AL/1nDv91P7aap0YOGb
         VIT539pkkQFjlApU/hpoxXg5V9mok5SolzJH5KtdLGelqXPzzuL1VTzWFGbabSWX4BLL
         dzgTd3mXwYDMja+qvBDzzZPFn81sYGHiKb5xmtDX5SKZo/imtrHQN7lLKh2q6molxWWU
         fiWVR96inc4DktoJulEVAy334mAUuylCcQu24BJmVQjwZXcTUDdWQ0zuO7VKzEDKwRBz
         5tmMxWPmvDzm40SybT+IJW9v1KJ3/iIN3fOSslzTbELIIp8qdmdbB/5H/ySm7Dw6XbS/
         YIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e9F1a0NPR7pwUZzOjIuR33T0sfbTWvetJUp69Ihe540=;
        b=kco5+oidP0vmtKAT02MzRP8U0YG8w17whlWKVmgmfv7JHFPB9hQ13BW3QJWfv0UDWV
         oO19UiTDCS8jOPxQVIHvfH6JpMHhB+XlEq/ag6e5jYK/Ryj9pwwClAFYULGx5jdHriR7
         7exhIBWBE4MM+xido6u/wDAi8RF9YX39krwvvKNV/N0kEHkvW8+LpHEX2WYmnkSHdXkv
         gPWHnsUtX3Q7zfuZsMZBRNEpD87JjQF2aJcgkTswsybtfX29h7BCqnNV44NKHH6Zbtoj
         yj6OT1PhyHjnVWEnnlQK5yy6AQUQmg29wZ+uagKsBdAUPRxf0GlZDcvIJB7HC03pKDDH
         KRdA==
X-Gm-Message-State: AKaTC01NZ4WMNke4d2gi6juL5hK0Re5jN+me4C7B3n+l5tRuXOCKps8m70OSiadFINtlUnIBW/BuwHisuZKhwQ==
X-Received: by 10.129.153.14 with SMTP id q14mr2081896ywg.191.1479894386474;
 Wed, 23 Nov 2016 01:46:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Wed, 23 Nov 2016 01:45:56 -0800 (PST)
In-Reply-To: <CAExDi1SYOuq7GJC69+5yDmzaw--vKMmmqv0Jsm80hU1L5phDUg@mail.gmail.com>
References: <CAExDi1SYOuq7GJC69+5yDmzaw--vKMmmqv0Jsm80hU1L5phDUg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 23 Nov 2016 16:45:56 +0700
Message-ID: <CACsJy8CPX3PDfhcaftDHy_U37rEACr7Q1gj_un4ALen45J9GZQ@mail.gmail.com>
Subject: Re: dangling commits in worktree
To:     Van Oostenryck Luc <luc.vanoostenryck@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2016 at 7:52 AM, Van Oostenryck Luc
<luc.vanoostenryck@gmail.com> wrote:
> Hi,
>
> More or less by error I used the fsck command in a worktree and I had
> the surprised to see that it reported a lot of dangling commits while it was
> not supposed to have one.
> I quickly realized that it was the case only in the worktree, in the main dir
> things were OK. While experimenting a bit I also saw that git gc had not the
> same effect in a worktree than in the main tree (the pack was smaller, more
> files were left in objects/xx/ dirs), which is even more odd and a bit
> scary when thinking to the pruning.
>
> This seems like a bug to me and googling about it didn't returned anything.

It's a known issue that gc (and maybe some others that do rev-list
--all, like fsck) "forgets" about some worktree's refs and you will
see what you see. Work on it was postponed because the "refs"
subsystem was being refactored. I think I'm resuming it soon.
-- 
Duy
