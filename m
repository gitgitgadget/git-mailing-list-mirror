Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E53D1F406
	for <e@80x24.org>; Sat, 12 May 2018 14:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbeELOOb (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 10:14:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33034 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeELOOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 10:14:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id k5-v6so7129901oiw.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PgefIvtfdwGD8QyqyGwVqYJAMhEy3px/fEbYiIdgTh4=;
        b=bQVfqi7DnM2jJ1xrA3TMrHk0nZCG2+la1N9zjO+MXcAshAWftc61cU9YQCsgHzcCzW
         8hLpg6veUmynQCs21QfOL6NHozLUuQFJDSxzze7cKQ8Tnp+Z//o+ck+A9f8Uv/B0DgPp
         whU0jzahnhZWLUsVh9nDB9xB2bsTdjSmqo9O1u90yXBHbTe83YvQJrZYuwyXd5P2x+tZ
         ainkRbKUouKIGOW6ffyWtBL4ftIWPtmMP0g3TwzUfuNxanaLTmnDopOnIEYWmXT9MJxv
         eHqzkcYOmVHlU5pa/Ww+ahWXc88Y+Xa/DqdOvO9kW+9fZrtPPMqZV9c4jGELC6asGKf8
         FxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PgefIvtfdwGD8QyqyGwVqYJAMhEy3px/fEbYiIdgTh4=;
        b=BVU2ZHM1eyTHCAWlb782Wy2Ed9Xu6HOgoBzA4puqD7QlWPMa1Y6FZfWr2K/gy2EPtF
         0x783FjRg9Dqfy++N+kfbKZd0W5G14sPueSqJm9h3zHTXVTRYQPBUHUL6sXfvoHplezj
         QsnVxSWqAKo4+bJNRdoxo/rVW2E9UTzxaRiRuDNv7X7S1miSE1yQZ47f1wpWFLuFXoMQ
         Fto47nE1cEWa72iWN9nFmVjlAxIex1efWtHY+U5sz+lfFrp+sRb7TOmLL334zK/N+7N9
         k7Gy/Pg2VsmL5qy7qC9deRY36yRmOoWpXN8squ+CNWuR9NBlAuRrf5od3MobpjGzB+ox
         0Wig==
X-Gm-Message-State: ALKqPwcy9rYMAkcrXOVKgpRdEKX5TU1dCdw6SOjwPjCRMkmdzcnzb4zw
        d8WNI8qvlb0JBg3WAz3qPIuQYI159D0Lkj4SR5k=
X-Google-Smtp-Source: AB8JxZpXdOHx8/UqaMbu6ijbbNVqwU1DR6GrOmCLI+2/Pnc5vRXg4hep5aB5NB/VDmJBaZO6JW1Fn6SEZyt4nxry64A=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr2109186oie.30.1526134469736;
 Sat, 12 May 2018 07:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 07:13:59 -0700 (PDT)
In-Reply-To: <xmqqy3gpdlgy.fsf@gitster-ct.c.googlers.com>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180512080028.29611-7-pclouds@gmail.com>
 <20180512093344.GG28279@sigill.intra.peff.net> <xmqqy3gpdlgy.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 12 May 2018 16:13:59 +0200
Message-ID: <CACsJy8CJ1_iKx_fvfoFKp8_x5ZO8Nvhqd_JoGTYYrjePoC0ZKA@mail.gmail.com>
Subject: Re: [PATCH 06/12] revision.c: use commit-slab for show_source
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sat, May 12, 2018 at 10:00:22AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>>
>>> diff --git a/revision.h b/revision.h
>>> index b8c47b98e2..72404e2599 100644
>>> --- a/revision.h
>>> +++ b/revision.h
>>> @@ -6,6 +6,7 @@
>>>  #include "notes.h"
>>>  #include "pretty.h"
>>>  #include "diff.h"
>>> +#include "commit-slab.h"
>>>
>>>  /* Remember to update object flag allocation in object.h */
>>>  #define SEEN                (1u<<0)
>>> @@ -29,6 +30,7 @@ struct rev_info;
>>>  struct log_info;
>>>  struct string_list;
>>>  struct saved_parents;
>>> +define_commit_slab(source_slab, char *);
>>
>> Since this one is a global, can we give it a name that ties it to the
>> revision machinery? Like "revision_source_slab" or something?
>
> Should this one be global in the first place?  Can we tie it to say
> "struct rev_info" or something?  I'd somehow anticipate a far future
> where object flag bits used for traversal book-keeping would be moved
> out of the objects themselves and multiple simultanous traversal
> becomes reality.

Yeah I thought about those 27 bits but discarded it because it was not
that much. But now that you brought up the maintainability aspect of
it, it might make sense to move those bits out (if we manage to make
commit-slab (or a specialized version of it) manage bitmaps instead of
primitive types, which is not impossible).

I don't understand the tying to struct rev_info though. This is a
struct definition and cannot really be tied to another struct. The
pointer to struct source_slab _is_ tied to struct rev_info.

> Not limited to this particular one, but we'd need to think how the
> commit_slab mechanism should interact with the_repository idea
> Stefan has been having fun with.  If the object pool is maintained
> per in-core repository object, presumably we'd have more than one
> in-core instances of the same commit object if we have more than one
> repository objects, and decorating one with a slab data may not want
> to decorate the other one at the same time.

It should be ok. The slab is indexed by the "commit index" which is
already per parsed_object_pool. Commit-slab user has to be careful to
use the right slab with the right repo and free it at the right time,
but that I think is outside with struct repository.
--=20
Duy
