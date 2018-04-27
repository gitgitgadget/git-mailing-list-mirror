Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4981F424
	for <e@80x24.org>; Fri, 27 Apr 2018 00:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757217AbeD0ATY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 20:19:24 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:40660 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757164AbeD0ATW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 20:19:22 -0400
Received: by mail-vk0-f46.google.com with SMTP id x204-v6so86646vkd.7
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+4MogIDhJ88l+WA/vw/mzurTThOqscStr3tJPMCGT7I=;
        b=dM5ElisTljnsZ1uT6f4qasvhh1aQScYHpzB62/6Ex96fNOmellXEIpubfCUhpWIUVu
         27c/tRgNE2DZavZPI/XdadN4dzlWZGgXKFv91AlPcJQGauds+RVKpp+8DPIRWoDbd4q9
         n4dkF33pDXVanKZPSqgb0WzTNpsQYZkNaGQ8YJmbl3u3UN8I1Cf4NYkhXnfkeBmI3wno
         thm7vvgiFw5xO/pkCkUpTU+clIsA2txrK82V5j328R0LVIeiFQB2/qF7w0fMWv5lrnbe
         R1k5Ltq0ZQn9yOqqGljkhDY3lrncGVBhZ+YSmuT57941+r0dxRbMOXdz7krZ1qrH9T6V
         Ed/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+4MogIDhJ88l+WA/vw/mzurTThOqscStr3tJPMCGT7I=;
        b=ntdT2oCwwjM/HShpaNHIa1rKCBVnrCsRi8P8b1nPrk/QvGaj0FHTZ+cyGvR+1daXed
         RJNHTI1Vnj2+BrafqJcDPxdj2+EnJL4JIXQruB9NVzFx5Ax0gKaUHNztgbz47FTxEPSB
         FYULX0NkNsbHPeJpq1Zai/utHIk/7STqBmaqfQtiY/KPov/gf8/odhvDv8xb/+9wMGFS
         Dvu5CKuCF03+K/PMJWRUghzzKRCyKmLaV54LmlQoSNVW+re3E5C5nc+6j/fTZ1DBsm3i
         6Fcd0/Z8wWPy2uBUZ4uB8ifyvcL0EopPuerB7rMnBDY1uiEJahLlM5glxmLMfVZpPoOj
         1O1g==
X-Gm-Message-State: ALQs6tCnVB3rk5mF8oJrc9ierY5bR20I+aRemmyj2RkWyOgbZXWLYiHu
        6X+emVxBYqJhy6FRKgZlp9ACf4eWGvsq/O9PFIg=
X-Google-Smtp-Source: AB8JxZq3bhRnxaf2PSSbS1VUasOBsiMzW4tKXo2kkCDjEZ/T8nXFFCUbmJULgQ/nsU4OKRkkEdRAz6fgDEQJxUnj7sw=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr118853vkf.76.1524788361302;
 Thu, 26 Apr 2018 17:19:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 17:19:20 -0700 (PDT)
In-Reply-To: <1524739599.20251.17.camel@klsmartin.com>
References: <1524739599.20251.17.camel@klsmartin.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 17:19:20 -0700
Message-ID: <CABPp-BE5jRG8JdDfH1XG-Btz9jJxfwf_oyNni8Ci1j+J3icbVQ@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 3:49 AM, Middelschulte, Leif
<Leif.Middelschulte@klsmartin.com> wrote:
> Hi,
>
> we're using git-flow as a basic development workflow. However, doing so revealed unexpected merge-behavior by git.
>
> Assume the following setup:
>
> - Repository `S` is sourced by repository `p` as submodule `s`
> - Repository `p` has two branches: `feature_x` and `develop`
> - The revisions sourced via the submodule have a linear history
>
>
> * 1c1d38f (feature_x) update submodule revision to b17e9d9
> | * 3290e69 (HEAD -> develop) update submodule revision to 0598394
> |/
> * cd5e1a5 initial submodule revision
>
>
> Problem case: Merge either branch into the other
>
> Expected behavior: Merge conflict.
>
> Actual behavior: Auto merge without conflicts.
>
> Note 1: A merge conflict does occur, if the sourced revisions do *not* have a linear history
>
> Did I get something wrong about how git resolves merges? Shouldn't git be like: "hey, you're trying to merge two different contents for the same line" (the submodule's revision)

Hard to say without saying what commit was referenced for the
submodule in the merge-bases for the two repositories you have.  In
the basic case..

If branch A and branch B have different commits checked out in the
submodule, say:
   A: deadbeef
   B: ba5eba11

then it's not clear whether there's a conflict or not.  The merge-base
(the common point of history) matters.  So, for example if the
original version (which I'll refer to as 'O") had:
  O: deadbeef

then you would say, "Oh, branch A made no change to this submodule but
B did.  So let's go with what B has."  Conversely, of O had ba5eba11,
then you'd go the other way.

But, there is some further smarts in that if either A or B point at
commits that contain the other in their history and both contain the
commit that O points at, then you can just do a fast-forward update to
the newest.


You didn't tell us how the merge-base (cd5e1a5 from the diagram you
gave) differed in your example here between the two repositories.  In
fact, the non-linear case could have several merge-bases, in which
case they all become potentially relevant (as does their merge-bases
since at that point you'll trigger the recursive portion of
merge-recursive).  Giving us that info might help us point out what
happened, though if either the fast-forward logic comes into play or
the recursive logic gets in the mix, then we may need you to provide a
testcase (or access to the repo in question) in order to explain it
and/or determine if you've found a bug.

Does that help?

Elijah
