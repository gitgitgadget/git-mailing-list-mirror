Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22781F453
	for <e@80x24.org>; Fri,  1 Feb 2019 23:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBAXcW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 18:32:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42581 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 18:32:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so9630590qtq.9
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 15:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvYsGqSQPkqsWQ2Ly43TIgTGxGfd6JqIu2gltJeq8f0=;
        b=b/W5by/0JwxlacSr7J6CL+xVDYHXwz7P6K2W6zvKkgqfTvaOL/Ab4aKPNlPoP7sjcL
         66SHlujdsU976ZTaMaHeHNLDXXm9kePaS8f1s4vjSdmFzzxPtRYyBvpPiKrIVYrCb4sQ
         KP5qrLhB4CMaY+myiDGKBmj6pYwlGGZUHxkOX3I9rkG4QjQ1PApDWeaKR+IEJACh3mC4
         5BimwbBsUQdMyThU/kqkYCeJy4fcLtqwlrN/ULVyHPBe5vwo2ddA8XmXyLwAGligjPbT
         Y5+rHxcv24UCvJZpb6PpqTOshN59QA/kQiDf/LVlUo5u017NJcRgFrDUNBRdBaPwG9lh
         aAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvYsGqSQPkqsWQ2Ly43TIgTGxGfd6JqIu2gltJeq8f0=;
        b=YmObPIJhuqYvKfQ2rPPz3NwF1cE6pF/M6qAl678LUU/ph/jN40OncVfeVZ3BaCnJBk
         tzis2MeveM/MXdEw2mkMfWZl4LXZCXVgBE0l19l2W9Iyfm4xyfwvkQgMXP+hjGpb0/4w
         tGI1tSSO6oEaIHeVrW/IGMWIGpLJvScInSEtAxf87azeGPqPv8s3uiy+Og3x/NvrzcIG
         t18w0gi6OtJ8T7edQqdakcd2gDnPC3Vf6pYorKGpCIkfMpNnGeicBw8vQwEtbdx1e8p1
         cCH7svcNCjoIEYKgEUr1XzZULQll7ehxYjd0278G2ifvT4rfYVyibyYaxW4U8+YF5ESC
         Ke9A==
X-Gm-Message-State: AJcUukcv2AN2J8R6d1htDyxMMdF7MSppuUwNWhGdZ24xoEsovgsXsfk+
        s2faGQzVST808wLlJbMKLhMgSxi864jFKGK+33J3rKxS
X-Google-Smtp-Source: ALg8bN7UxGOHPPHZvMJzaebxUp3+Zf68L8nPNK2N66+gP+xWHSR4hq13n/lzE1ibmmXr0BMbKou3JWuHXEdZ5PnLvpk=
X-Received: by 2002:ac8:41c8:: with SMTP id o8mr41072845qtm.232.1549063940827;
 Fri, 01 Feb 2019 15:32:20 -0800 (PST)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-1-nbelakovski@gmail.com> <xmqqwomjw25s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwomjw25s.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 1 Feb 2019 15:31:52 -0800
Message-ID: <CAC05386CRvmLUbG+O89=i9oXsOSPsoP3VpnrR-w1HJhMa6U7AA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 2:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> As you can see in "git shortlog --no-merges", later two patches
> would look quite out of place by having overlong title and starting
> the description(i.e. after "<area>: ") in a capital letter.

Hadn't looked at it that way. OK, will shorten/uncapitalize.

>
> It is still not clear why we would want 2/3, even though I think 3/3
> is a good idea.
>
It's interesting to me that you like 3/3 but not 2/3 :)

My apologies for restating the commit message, but the point of 2/3 is
to communicate to the user that highlighted/marked branches will
behave differently from unhighlighted/unmarked branches for commands
to check out or delete. I think this is useful since it gives the user
actionable information ahead of time, as opposed to providing that
information upon failure of checkout/delete. It also makes sense since
'git branch' is already highlighting the current branch, i.e. this is
just an extension of that idea.

As we've stated earlier in this thread, 1/3 allows for users to
implement this on their own with a custom git branch format.
Personally I think there's value in making it default, since it's
adding information in a minimally intrusive way. I do believe that
merely adding information isn't a good enough reason to change things,
as information overload is a real thing, but in this case the output
isn't changed for anyone not using a worktree (same goes for 3/3), and
for someone using a worktree this provides useful and actionable
information, IMO.

Does that change your mind at all?
