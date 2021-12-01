Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D6CC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhLAWAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:00:35 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:37613 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhLAWAe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:00:34 -0500
Received: by mail-pj1-f45.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so833232pjb.2
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 13:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OuQPNGus+JTzSVXNJ0f3u+jMl2XqFGR+kf5DNoN4Bc=;
        b=CvVKYQIHuun1dLSTxsfUcXE3rmvZLD7ExNLceRjTmioQZ+KkzdvoaDt33Wf3mRXyao
         UHYpzfMxB4T/H81kHJzcvZL8kQlgEWGOMPp7sVkNYDV2d4xvj9AMtUFKZKcVxbJHGDAw
         8PwSCJTiLrDvMP5W5y2iH2eR3vr04qg7N29k+ABGhSf1F4OdKHkGioliIFlBQAg55a11
         dNVAB71UtDGibsK5VNdx8cCnEWk9G5KseIxaAdM6U4DlSFMG1vZofMbd9zvBWPUX2J7X
         Nq/6aXkRTdxYUWIAbsBaMCpWm3M9qlEmWmflYGRN6cxo3uY2Ws2fZIKALu57pb+t0lMU
         nnNw==
X-Gm-Message-State: AOAM533egZp8EUqY5PMai7uW1Y2viS4QcXb16CslIZTCQcbdHqbztdQ1
        lhGx7AJx3YgCPbJWZlb23fUBBeSytveRc19e2+FArwFino0=
X-Google-Smtp-Source: ABdhPJz3PUq9fwegZdzroTEi1ZQQ17/wTRC6f5sOPLWL4PmzkBbunwg+FgOjYx3bIMKSYFNaHmH7M99bEOQNcpWgNbQ=
X-Received: by 2002:a17:90b:4f44:: with SMTP id pj4mr1138558pjb.150.1638395832592;
 Wed, 01 Dec 2021 13:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20211201053214.2902-1-sunshine@sunshineco.com>
 <20211201083301.ozrhi2brjk4zx5ll@fs> <CAPig+cRFqO5wcZTPrpTuiBP72+6enJs+---mjT2AFAQq5ztt_w@mail.gmail.com>
 <xmqqtufsypmu.fsf@gitster.g>
In-Reply-To: <xmqqtufsypmu.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 16:57:01 -0500
Message-ID: <CAPig+cTAg7CwYZBEMVyub05GrGkHjLSuZ_YJ-PdAQ7M_C3aMqg@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 4:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > However, I can certainly change these to say "Git command" if you
> > think it would make the intent clearer, and can update the final point
> > to say:
> >
> >     Error messages from Git commands should always
> >     be sent to the stderr stream.
>
> In an earlier round, I think there was a version without "should" in
> there, but I am sure we have bugs that do not follow the guideline.
> The proposed phrasing sounds good to me.

Yes, the addition of "should" was intentional, though not for any
concrete reason (it just felt appropriate). I don't feel strongly
either way.
