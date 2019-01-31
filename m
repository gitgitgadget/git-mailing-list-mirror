Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0851F453
	for <e@80x24.org>; Thu, 31 Jan 2019 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfAaUsM (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:48:12 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:39403 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfAaUsM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:48:12 -0500
Received: by mail-vs1-f45.google.com with SMTP id h78so2827881vsi.6
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/yLq1kpAz249cSqKipUHoliIzcckgT2XiYBsr9ftVX4=;
        b=Tk+Abqr+g2/p2PyoP+xbXooVEvlAuFZtsShcZfHlPU4zSGDTz4l/DZbso2DM6O9/1V
         1zIu6ivJjBJASv5/GOO1E13DzSDIBHA9Fppdsgoy1sGD5MSxGgWNltKDuibS2G5icPpD
         2+Hz509MnEqybBRkH6/yXaFI40XC23T8yCy+sDH2Af/trW4dRwJ5oLnAJ7sTxAPwZwGU
         7dyjoU0E35hQGiKIRE/rtXBhv/gkCBOtDOFYYvJ6WBUERk8oxEO4JKV+rYe9kkULzHMx
         ielD2fVRAJQu8fOpnIS9TlKtL6KOCNupSE/15jlB+uo3jOOhCawYsl6n3WXjyPH4vD1j
         1oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/yLq1kpAz249cSqKipUHoliIzcckgT2XiYBsr9ftVX4=;
        b=r9reY0HQQM6eOOH7s21k9d3jViSzOVoK38gWIHgEtujnJVAU5PNn9B9BDF5k3K7d98
         CPBEz5IpgviJiFk1sCAOKM9kJx+VWN3yCvjpWiTil+6qTYp+JwDTjGK13k4Mlz9jMAQb
         QWJpSbehmL/klh5G7gLQKL386iF8o14tvCnUOPseOfXpRmw5eBenTL1unXor6NuTwV55
         xClbsbk/3yVL0CnvqE0gaECYmTIjbDsiPy7gQROF6j9K6TCEbrRy8KhV7fSNOgZCk3oA
         Mpgh/O2jcls637Jm+/8py8Lu+LFEerkrXpKHlyGxFYi1VdcW1XqpeXCLVDj2FxZJx06f
         Ma3g==
X-Gm-Message-State: AJcUukeuUZy9rLy9LvXnOIWyqz3BZguL/k5JE39rsYrJnQipYqA7ALmr
        cAfFHgQJoP9W5EeU5t+7WCVqFyG1YyjcaTjZYT+2S+QhzpA=
X-Google-Smtp-Source: ALg8bN5EzJyDf688VBV9oSBzHyWzWs1blyHqc2dOzQ6G+RysToWnyGEGLhKpmhGOA1gmFRmaqmpMxXyc1P2mrJAZ2Kk=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr15756119vsm.116.1548967690759;
 Thu, 31 Jan 2019 12:48:10 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
In-Reply-To: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 31 Jan 2019 21:47:59 +0100
Message-ID: <CABPp-BHOwfnpd=thMrGNQN0t+btN=jZhWHuhJ59HZ2oH5qDrBA@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 9:57 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi everyone,
>
> git-filter-repo[1], a filter-branch-like tool for rewriting repository
> history, is ready for more widespread testing and feedback.
...
> What's the future?  (Core command of git.git?  place it in contrib?  keep it
> in a separate repo?)  I'm hoping to discuss that at the contributor summit
> today, but feedback on the list is also welcome.

Turns out we didn't have enough time and didn't discuss it at the
contributor summit.  So, I'm even more interested in feedback from the
mailing list.

Thanks,
Elijah
