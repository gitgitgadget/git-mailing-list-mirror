Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DBD21F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 14:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395082AbfJYOsE (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 10:48:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38447 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394082AbfJYOsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 10:48:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id y8so2044109edu.5
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gM58WLd6ZV8shHQnC+f8dK5vA2CGhyTdVeF5HBtif0s=;
        b=rZLCDxRrf9QKmUUZkKvh3sUFDc2gJ2s6V1jhYe+mk9sRtJB3hqNbw3abGTye/0DeIr
         ZH6Z9gQz/cESPJ8W0Uh2AasGDnuVBpKz14qJ35ReTwbQtJ/B3+JlucbWPhxsBq+vDYS7
         U224IyXH0LF5RJIBiIrKCgEHsaY39XlyE1MjHYKJUAoN+C6he/rEpXkF5ptegHug8W0q
         emms5UtUtPoSyIN9E7SM9ux/wSJWnYBy9/rRauOKWJGQu6zWVqcscL9YRypujbC4E+dw
         10+ws0pjO/vlMmzYYs+f4VQGqtb1pE/qzBcLisqzLhlb2MR/m6RXGuCt59Z5pWPm9vey
         xe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gM58WLd6ZV8shHQnC+f8dK5vA2CGhyTdVeF5HBtif0s=;
        b=qr8pbrKGcZGRlLmMkBT8hcT+c31mbJihOs2naw+azwA9WUZ7l/mgY8qLSui0CrOKhs
         n/kjxe1iB+rQg3dysI2w8o1QcXUofW/u8sN9mCHs8+hCCTMZNhTmOq0spjrbXwsUDbfq
         eexL5IHvQeNHPgVp5rfIpffsirt/8ynjbrwCK19Vc1IvPUDZAfmPPXcgmuqKBVAzvu1V
         N0W7u9WscdqQPiEUf3Hvja+lbaTRZDWUjMNxjrGglss8A8OCQchDpmBptUhRzfa/Lj0H
         zINk73lNpACGyRqWfd+RuTBjcbdjRTwhefmlC5KiraibvulIa69Yv666BDSOy9/OhAan
         AhHA==
X-Gm-Message-State: APjAAAU/fRWJ+Qt9R4cVd7wt3tTJGONxqL+xBftnvkWyIDcygIVqbzz6
        Skh/16cQJBEkmdGso2MFZL45JxLb6tXsRi90abRl3n8MOwk=
X-Google-Smtp-Source: APXvYqzyS1K90Spu0OD3zf8CDn8dFwVm1swm6POac4RVEgiEpORPR53s0d5fwx3E18nWWwtb/DfBuqnv/4ieFLjYwz0=
X-Received: by 2002:a17:906:c801:: with SMTP id cx1mr3982979ejb.266.1572014882099;
 Fri, 25 Oct 2019 07:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092745.97035-1-mirucam@gmail.com> <20191024114148.GK4348@szeder.dev>
 <xmqqmudpee57.fsf@gitster-ct.c.googlers.com> <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
 <xmqqzhhpb1nx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhhpb1nx.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 Oct 2019 16:47:50 +0200
Message-ID: <CAP8UFD1_vnjApobt+aN3M12g8mLqOZJGyvr4oqqTax5=cmLhsg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 25, 2019 at 11:43 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Miriam R." <mirucam@gmail.com> writes:
>
> > Ok, then after discussion, finally the issue tasks would be:
> >
> > - Add path_exists() that will work same as file_exists(), keeping for
> > now the latter.
> > - Use path_exists() instead of dir_exists() in builtin/clone.c.
>
> Sounds about right.
>
> > And also:
> > - Rename is_directory() to dir_exists(), as it is the equivalent to
> > path_exists()/file_exists(), isn't it?
>
> I wouldn't go there in the same series, if I were doing it.  I'd
> expect that such a patch would be more noisy than it is worth if
> done in a single step.  In order to avoid becoming a hindrance to
> other topics in flight, an ideal series to do so would support the
> same functionality with both old and new names, convert code that
> use the old name to use the new name, possibly in multiple patches
> to avoid unnecessary textual conflicts (i.e. some of these patches
> made to areas that are seeing active development will be discarded
> and need to be retried later when the area is more quiet) and then
> finally the function wither the old name gets removed.
>
> You would not want to mix the first two bullet points that are
> relatively isolated with such a long transition.

Yeah, and for a micro-project it is more than enough if you only work
on the first two bullet points.
