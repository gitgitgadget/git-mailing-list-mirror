Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF91C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 09:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB0260F92
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 09:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhJKJr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhJKJrz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 05:47:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F64EC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 02:45:55 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s64so37533401yba.11
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEgVuQnXX+YQsFmhpzTGQat7WEfvV+6+lW+2Z7ity1M=;
        b=H76mffrRllOki7JIQA9nkiOj208cLkis4K7k47UO2OaeosLuW/JBZJH12FdxTiCuSS
         1ualz2PV/uv/iCR2UJh8i1wYnBNEZAURic6+WthSAlFHpKrYMl9nUEph6BV1fZ8RhDA8
         ibzYk9amS7iN0wzFmDjifxDcH26WU1ejZTkoWGWLMKgQNlAnOJq6davg14ChQkrf+eyj
         9H0ajdpvkWkhTKkua+Ojo4xSZQZ3p+9xadadYAv7wDj9iObSEOXoyrdbgvFdFriBDZBw
         Ss0pnf43exL0qoehWqzPDkjaY11+b9KQYBngy5o/emvekbLKbNbj3Od0xZKIjTPTcQpZ
         zdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEgVuQnXX+YQsFmhpzTGQat7WEfvV+6+lW+2Z7ity1M=;
        b=Qi/Re2Zg+jYOzaQ+ReMDyRpO5mhCT2OXCmuoTcpKFtOKIVV2zs9ODV6xOXFeaQc/n6
         hRsQIgL3wHs4craHWm1JqerJdaQJZrY1+cLxd/0RgJN6rFfZBB3Wt8V17+Et3q8WuRhB
         Ndq11MUV3w1az/TKC0Z7CIbmoOsn/OxLj+H3U6PM/dynVL5+AW0lr8a+ftj0TiXfDJjb
         yQOFbe95J1gHwEOwhG3WkWfUsaJD22+N6616mRnqcAF+TsoIEzjOKuuL5yZvTQ7r8hT0
         Y2IcGE8vQ827I6jlyyRjFtL+Cx/LNGSK6oy3EajyH+MqrFCLv7hu5ic5SQ9An4zM2aBm
         JpoQ==
X-Gm-Message-State: AOAM532PZct/EWuZ4DGJV/b/oa3M0xPi+SL9FGOx2Zaj8eMB9MkVC53+
        utk5SIPVktxvnGv8yU2FxCBC47RNfJyhNQOZ8TUERTPqw2k=
X-Google-Smtp-Source: ABdhPJwI8Vvef4XYEJEIZFMoO5JcGGaNYrsi91bIuVz1KE76NTSO3O9WDFEWaf11ET0bVeZ5peQ7eH/WLK0jPR4rz1k=
X-Received: by 2002:a25:d94d:: with SMTP id q74mr20430371ybg.196.1633945554856;
 Mon, 11 Oct 2021 02:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
In-Reply-To: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Oct 2021 11:45:43 +0200
Message-ID: <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com>
Subject: Re: I just want the revision
To:     ToddAndMargo <ToddAndMargo@zoho.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Oct 11, 2021 at 4:57 AM ToddAndMargo <ToddAndMargo@zoho.com> wrote:
>
> Hi All,
>
> I am trying to write a script to tell me the latest revision
> showing on
>
> https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/tree/master
>
> which is 'virtio-win: rebase on 0.164", but I can only see this
> from a web browser, as the page is dynamic.
>
> I do have access to the git link on that page:
>
> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
>
> Does git (or some other) have a way of telling me
> JUST the revision without having to download the turkey?

If you just want the commit ID, you can use for example:

$ git ls-remote
https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
refs/heads/master
f6ad44f35f5caeec51b7002169977272d85701a3        refs/heads/master

> If I could get something that contained
>         virtio-win: rebase on 0.164
> I could dig out the revision

You might also want to take a look at the GitLab API docs, for example:

https://docs.gitlab.com/ee/api/commits.html

Best,
Christian.
