Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84DF01F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeKCC0s (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:26:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37512 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCC0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:26:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id 131so4226195qkd.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVyUn69KJmn9H7bgUWy9nggA5/rbEFTAgstBOsmFpOc=;
        b=OpqMZWYYXw+fEzrUARe0cqmVreMYQyh0omypNE7t0AhiDSUHC/xi7/VcT5KNg9a5hj
         JGRl3MdC3OO/ZiAfQ8NoEKsFudRSmtUXsCP1LzaejRIOMymSKvcKvjwMelHD59h+Z4gY
         StnwgaPNaA0QVw5p86UAsaxbg7KlIbgBbSUvoeQ8XE0I/1Q8yUY07ydH71sJg+DjTsbM
         5auyCmlLUuFJQEmwfvhnwuMPLebbWhkNanlROJaL48tkRFZnwsdaUJE9+qZh8EpUK5Ve
         2kzFp6LYnOq2azqKwBoiO/J86n2u2wEQKDdplGoXkjKy/QGGWpxCDUpYlupKK+SkEtzR
         iivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVyUn69KJmn9H7bgUWy9nggA5/rbEFTAgstBOsmFpOc=;
        b=VSAVVUVD7xZaIfRmLEVh+MqmZX6W6/L7blcoMHYdKFKWRfBVOSxLCEml17qxLnBg77
         vRu8LEDPbm6rzzeRpPFZ/MaXZ9FTk7VQbrXPQ65JxVOrjRquyBHer16uVxaNN9ZVM30r
         0cuNTMQkD9z6Vi1zuccUMPMScPK32IVFyxLwTmPo6uWDZinFRrLB4pmkrHmBP2qVdI12
         EhhnjDnDVQkkP2KQZuDN+SauZ1rja7tryXsVCQbsWU3zH6t8RBkkbKLILfD2rqFcL5nd
         jts9Pa0DN28DxnP1Apxagq+GQITKnkkQ0kCGnrd5nd1SwInAkwW3rw28fCENqjnSYuzh
         veCA==
X-Gm-Message-State: AGRZ1gImkb+LdyOqvlHzqZWBeFJsWLxgbicMUOfl1HjiqHYuBMTlwmON
        EdnzNdfsRQhEYNElGO0Ho0D/dgIr+N1yw93RVuc=
X-Google-Smtp-Source: AJdET5fd38DZiMUStNMzkBNfmfXbt+rLJQzpU1hA2Qoyb8RKSJTZzf0oweXHs4j2fkGiZHHtrYnifw5BAjX5M4+yevs=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr11498157qvg.6.1541179135580;
 Fri, 02 Nov 2018 10:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.64.git.gitgitgadget@gmail.com> <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
 <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org> <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
 <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
In-Reply-To: <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
From:   Steve Hoelzer <shoelzer@gmail.com>
Date:   Fri, 2 Nov 2018 12:18:23 -0500
Message-ID: <CACbrTHcvOQvHbSVbXhen6txksLxMqc4vub6qXVASsjzBt8BhUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
To:     j6t@kdbg.org
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 11:43 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 02.11.18 um 15:47 schrieb Steve Hoelzer:
> > On Thu, Nov 1, 2018 at 5:22 AM Johannes Sixt <j6t@kdbg.org> wrote:
> >>
> >> Am 31.10.18 um 22:11 schrieb Steve Hoelzer via GitGitGadget:
> >>> @@ -614,7 +618,7 @@ restart:
> >>>
> >>>      if (!rc && orig_timeout && timeout != INFTIM)
> >>>        {
> >>> -      elapsed = GetTickCount() - start;
> >>> +      elapsed = (DWORD)(GetTickCount64() - start);
> >>
> >> AFAICS, this subtraction in the old code is the correct way to take
> >> account of wrap-arounds in the tick count. The new code truncates the 64
> >> bit difference to 32 bits; the result is exactly identical to a
> >> difference computed from truncated 32 bit values, which is what we had
> >> in the old code.
> >>
> >> IOW, there is no change in behavior. The statement "avoid wrap-around
> >> issues" in the subject line is not correct. The patch's only effect is
> >> that it removes Warning C28159.
> >>
> >> What is really needed is that all quantities in the calculations are
> >> promoted to ULONGLONG. Unless, of course, we agree that a timeout of
> >> more than 49 days cannot happen ;)
> >
> > Yep, correct on all counts. I'm in favor of changing the commit message to
> > only say that this patch removes Warning C28159.
>
> How about this fixup instead?
>
> ---- 8< ----
> squash! poll: use GetTickCount64() to avoid wrap-around issues
>
> The value of timeout starts as an int value, and for this reason it
> cannot overflow unsigned long long aka ULONGLONG. The unsigned version
> of this initial value is available in orig_timeout. The difference
> (orig_timeout - elapsed) cannot wrap around because it is protected by
> a conditional (as can be seen in the patch text). Hence, the ULONGLONG
> difference can only have values that are smaller than the initial
> timeout value and truncation to int cannot overflow.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  compat/poll/poll.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index 4abbfcb6a4..4459408c7d 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -452,7 +452,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
>    static HANDLE hEvent;
>    WSANETWORKEVENTS ev;
>    HANDLE h, handle_array[FD_SETSIZE + 2];
> -  DWORD ret, wait_timeout, nhandles, elapsed, orig_timeout = 0;
> +  DWORD ret, wait_timeout, nhandles, orig_timeout = 0;
>    ULONGLONG start = 0;
>    fd_set rfds, wfds, xfds;
>    BOOL poll_again;
> @@ -618,8 +618,8 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
>
>    if (!rc && orig_timeout && timeout != INFTIM)
>      {
> -      elapsed = (DWORD)(GetTickCount64() - start);
> -      timeout = elapsed >= orig_timeout ? 0 : orig_timeout - elapsed;
> +      ULONGLONG elapsed = GetTickCount64() - start;
> +      timeout = elapsed >= orig_timeout ? 0 : (int)(orig_timeout - elapsed);
>      }
>
>    if (!rc && timeout)
> --
> 2.19.1.406.g1aa3f475f3

I like it. This still removes the warning and avoids overflow issues.

Steve
