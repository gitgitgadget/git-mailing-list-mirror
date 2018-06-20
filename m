Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07301F403
	for <e@80x24.org>; Wed, 20 Jun 2018 17:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFTRJJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 13:09:09 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41163 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTRJI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 13:09:08 -0400
Received: by mail-vk0-f67.google.com with SMTP id 128-v6so170467vkf.8
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oY7gWGYXQV1MwfaFI4HG4l3OjJJJwRicgLqTWZimNsE=;
        b=HnwnQviTNb6zwmm4nbWOImVgYkqVawPHkhLKN8bRoIfCcBWLQW55ypu4BP9dPswdDB
         UCs49g0Gg0VC9u8NrDgjf3yp02YfFs5GqSrtvMGU7hxm5fyDMrPRE2Ra7+ll5T/VuqYP
         oe/YJNjlsib5h4wNiuI59BiIg2qvdeokrKRCQHIyvJxSLsdGEmpyC/3kNSkvZ1hgMFYn
         GVd0xXcPtlysc0P4gB5XBp2UAp0QtE52ZMXBtWkSISB8GcfgtYeExHMLCEc1BW872X9I
         JRzQimzNQbsQnI+cwwnFkprP5FCdcIUY9zcSzC2SPKHL7MyhB8WJ6SxGH8Ca/5kFbYYU
         bZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oY7gWGYXQV1MwfaFI4HG4l3OjJJJwRicgLqTWZimNsE=;
        b=h7ZvckYoIePLBoFjuruDBZvuPH/uKuNiL3z0psTJVx2DlxnLiw6ZdhwhzdsjmtU3fj
         ZMHvNmpDOptPI/rQ889Vx098fBZA0uM1spWXUf8/kkYYPCnM/CsWDhVy+J60XyudwhME
         WgDl7RYjU8XsNJU2LAltM7AMHtn+y5FdNCapHSuhztT0W5x9sQc95FVUEq8McS7nkqqW
         96DVDiO24AeyPSPiQqls9FabiY9ce2QHvGjkdbSR5KCAl1gtJYKH4OFzylWCIFM17R0t
         nMlQIJGRdh5BSVUr4CpeJCCOciqfYPiDTFzsTvm87rJTVKDJ0UkvQ97EQwcOEcDj2C0f
         JMKg==
X-Gm-Message-State: APt69E1CVteaZOR/wDo14jLtq7PmzMygSBD48QVUKy4qVRkTcU46gv2O
        nEZw6WAvgXYX+IYJBhN/kEVlFbbbG8VvbKrrdeM=
X-Google-Smtp-Source: ADUXVKIp0cCzfpeivjX71/SxpBiTPSlckPnnpCm+JtZO/ZaejkHVvK5O4tXRu0vwJPeQHnQPNMT2KDFsY9rmqYu+OjI=
X-Received: by 2002:a1f:4e81:: with SMTP id c123-v6mr11877405vkb.184.1529514547684;
 Wed, 20 Jun 2018 10:09:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 10:09:07
 -0700 (PDT)
In-Reply-To: <13ccb4d9-582b-d26b-f595-59cb0b7037ab@talktalk.net>
References: <20180607050654.19663-1-newren@gmail.com> <20180617055856.22838-1-newren@gmail.com>
 <20180617055856.22838-2-newren@gmail.com> <13ccb4d9-582b-d26b-f595-59cb0b7037ab@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jun 2018 10:09:07 -0700
Message-ID: <CABPp-BFSgFyRrsVc+-gO04KvZGe+6siPJ0LwEtC7ZKQ-q5Gusg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] git-rebase.txt: document incompatible options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 17, 2018 at 8:38 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> +Other incompatible flag pairs:
>> +
>> + * --preserve-merges && --interactive
>> + * --preserve-merges && --signoff
>> + * --preserve-merges && --rebase-merges
>> + * --rebase-merges && --strategy
>
> Does --rebase-merges support --strategy-options?

Good catch.  I hadn't yet tested --rebase-merges or --preserve-merges
myself, so I was just going off notes in the documentation or code for
those ones.  I created a simple case needing -Xignore-space-change to
merge cleanly, and found that any --strategy-option argument will be
silently ignored by --rebase-merges currently.  So, we should also
document and warn the user that those options are currently
incompatible.

>> +
>>   include::merge-strategies.txt[]
>>     NOTES
>>
> This is a great step forward. In the long run it would be nice not to have
> to mention the backends. Once git-rebase--merge.sh is gone, the situation is
> simpler and it would be nice to reword this to say something like
>   The --committer-date-is-author-date, --ignore-date, --whitespace,
>   --ignore-whitespace and -C options are incompatible with the following
>   --exec ... Also note that --rebase-merges is incompatible with
>   --strategy; and --preserve-merges is incompatible with --interactive,
>   --signoff, --rebase-merges.
> rather than talking about am options etc.

That sounds like it would be simpler for the incompatible options, but
what about discussing inconsistent behavior between different backends
(empty commit handling, empty commit message handling, and directory
rename detection)?  Do we first need to remove all those
inconsistencies before rewording the documentation here, or is there a
clever way to discuss those?
