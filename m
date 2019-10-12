Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3061F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 10:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfJLKrD (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 06:47:03 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41300 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJLKpC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 06:45:02 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so7854130vsr.8
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me1tYhkBP+/GboDXYy0PclWAF27EYbA35iKQi0+BoXI=;
        b=GwbsDMRo2sSm0gMRaZmwSqBOPH60F4QU22Bq+yzoZWcK/6R2/yzXkAnqDpXZSvaZtm
         ZPlVxRVsF6RWq5tXiyO9Vt4L/SRvRIiEiEPVK4LX6tAydMytQirB10nzVP07s5uAeHDs
         GPsOKY6mGSFokqfE+NkQwsltOfX/OBuniz0wqeWI/WOiERZhTE9/cwsJdqUsXFV/pyCI
         o0LFw8WEZpouSkBYtpmarXgWY5w+8j3b7vAtfg918TY+d6aAKrPMA7/zztlmPn8RVubn
         b3P0rvtgjrOJuPtMhB5JHtryNmlu1oIwmYCAafVEFDmcs/J1ce62wBkiETTl9yh+kLG4
         iNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me1tYhkBP+/GboDXYy0PclWAF27EYbA35iKQi0+BoXI=;
        b=ap/T09LWVmdsgcJeY0HAi7ratTz94w12G9yIuGRwkFezgaI9tYcGCtu3l1Lq3rEAOh
         e/8ODlK/7zsIlvy96DprflQ8DYJy3GZgfmOKmHvJ6xI+ZZvt/wXnMTB2zAtvU5cfJ5YI
         s2Pynrp7uMFSXhr+fQCGZhfmclVPAoXLXJSD1plgTqF4Y1u+/xHvzPiZFR+/q1gjpLYc
         uZLsik73HM6mhbIWIt/l7BD11gWKMZkTa6i9kJFn53/KkLa3BS4uW+uBmADJhEm4JN3T
         FCxIhAof9A7es7QVgHBhx6CPVR1vLqtPbJvAyLFYBc7QqWr005Yz8evB/Nz1vTzaXJts
         zmlg==
X-Gm-Message-State: APjAAAVnpOuesf8sw4sTrF4RKnwmm5pBUYhZEa2sIpOgworW2g9IqXQp
        4KlSMkD6WPuzXw0EzXgcjuOr/jC1FIv/2JuwrJo=
X-Google-Smtp-Source: APXvYqxISHY9bFTCHUKpRcnru5SBB7jfmpchvDru+3HyP+NUXCOhzi+UQmE5cnVEOiXDgLEUtjd0awEqiOmUzYyE+Nk=
X-Received: by 2002:a05:6102:232e:: with SMTP id b14mr11271823vsa.75.1570877101673;
 Sat, 12 Oct 2019 03:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191004221052.23313-1-me@yadavpratyush.com> <20191008121735.29531-1-me@yadavpratyush.com>
 <20191011213524.i2zo4oxkpui3tzth@yadavpratyush.com>
In-Reply-To: <20191011213524.i2zo4oxkpui3tzth@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sat, 12 Oct 2019 12:44:50 +0200
Message-ID: <CAKPyHN3tvho9Hs4Tt7pZiT46X+AoRajPdUS3RgcpNbJPPmkJdg@mail.gmail.com>
Subject: Re: [PATCH v3] git-gui: add a readme
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 11:35 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> I'll take the silence to mean there are no further objections, and will
> merge this version in to 'master'.

correct. FWIW

Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>

>
> On 08/10/19 05:47PM, Pratyush Yadav wrote:
> > It is a good idea to have a readme so people finding the project can
> > know more about it, and know how they can get involved.
> >
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> > ---
> > Changes in v3:
> > - Reword the first paragraph to avoid some repetition. Suggested by
> >   Junio.
> > - Do not mention "written in Tcl" in the intro. Suggested by Junio.
> > - Add a list of dependencies.
>
> --
> Regards,
> Pratyush Yadav
