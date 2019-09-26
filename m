Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5ACB1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfIZTNr (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:13:47 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:32967 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZTNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:13:47 -0400
Received: by mail-lj1-f173.google.com with SMTP id a22so79028ljd.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUbadSmwbI0bSeeAbXiBGdldfMFyUVWk/JhSQzSYvvs=;
        b=o6hFg303Sw08cv9724MGYNMpU35F0u4497W3HfLx/QYAxGsKtfBAuTbs65OYgmMRv6
         FLPIi4SV4YQtt0uuc8xyY1MDOkvt9S5hCKCDhjpma2WyXf5ocUqMIbPsioUfbgBpOvNO
         korQGUlZw23Yoglx24IIbEV6kKlQq42DzdqPjAaXrdtmAF0QRU+9YQBpVjTf9YhHce8l
         54LbX/22iZ2uhuwq+9RcvdxXq1YGqkoc8ANqrtoyjW67qcCJ7Nx8PexZzwzKvQBQw2G1
         LC98M01KWexAm89JyeMEMqR9/uUlAQqaPaFDlFJKXBYd9ynt5cF2vlpiqU1bk6ZcunDy
         ToaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUbadSmwbI0bSeeAbXiBGdldfMFyUVWk/JhSQzSYvvs=;
        b=ncOTdVzdKvfvapwu8+7aMxsAhMODR7VpoJ7wt1ZGeuwpT0Rk2ZrXys4j/ocmgqloMN
         veUXhuS+I1Y1nsLf/rsCWc0pkH6p75MAZOI/CYeJ8VI7GDmtSEcyFFPYljflAG2eSag/
         La4RlPSH2Zn7I7M0jsgfdtLYU2LWhDewn7PXmO8YD0GjhmD8GBg0PYWow5PCK1HD5gBV
         prbDdd9M+q/FFLV0P71DqpvVBJ5Jdy/5BdjYLzaKhpxsID7GRdfiVkq4y2rpTRknTBT5
         N5GKBU3jUwj8NWnR9bu1SJEDwJZcQDhPzPn0thQ3ty5k4omroKh6cni0RjRe1E1wu1rJ
         WLAw==
X-Gm-Message-State: APjAAAV/UK45W4Vi27U6w7qTHwEXc7LplsYLfPrUGr7Rg7HBhPfHqxlr
        LLAzeyS9AgT8EZKWqlzCWkPT97w4pUk6swfSn4iN3B2Ws07cbQ==
X-Google-Smtp-Source: APXvYqzGxGXA+57CVJUwzG6EwX31K4TTmYJBnib7OilouGV2uNCTsLAA0DJPINLST5MiHVFR12ocNoHyj4AL+ZZ7l3E=
X-Received: by 2002:a2e:9d50:: with SMTP id y16mr178884ljj.70.1569525225327;
 Thu, 26 Sep 2019 12:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
In-Reply-To: <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 26 Sep 2019 21:13:34 +0200
Message-ID: <CAGr--=+dnNQ-1xOtiQnby6UV8sP9Xapuet3VV7KJxFsZkjXZ+Q@mail.gmail.com>
Subject: Re: git-gui: disable the "loose objects popup" dialog?
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Thu, Sep 26, 2019 at 8:54 PM Johannes Sixt <j6t@kdbg.org> wrote:
> I dislike the popup, too. But I want total control over my repository:
> No automatic compression behind my back, in particular, when that
> expires reflogs, and git-gui does that.

I understand what you mean. In my opinion, An option to make git-gui
"ignore" loose objects (disable the automatic check) does not
challenge total control over the repository.

> What about a configurable limit, but still show the dialog?

Sorry, I don't follow. A limit to what?

I'm struggling to see the reasoning for the loose objects check (and
popup) to happen in git-gui the first place. Why does git-gui take it
upon itself to automatically perform this check? Is loose objects a
"gui" issue?

Birger
