Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC9D1F51C
	for <e@80x24.org>; Fri, 18 May 2018 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeERWas (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 18:30:48 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33762 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeERWar (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 18:30:47 -0400
Received: by mail-vk0-f67.google.com with SMTP id q189-v6so5756886vkb.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w2bWYYShsxJk96XdgBS4KYlhJC4JsUu9JTT/LXqMX8Y=;
        b=WI4fe6PIDVkRJGxyNxgE9o5SYf+jlhT7rIFkWcW5Nyee5TtST+WWl4Kj+Mt8KOkO7C
         ySg7N+R5SZN6vgLNRLLvRm+4VGaAFaZgODM69hX1H3GKdKZcMANEyv8A8Sj4hK7d0i+x
         qpnJAXJ1dkPNox7wNo+gnOAVndo51XyIMlRzTfish5larN+yfPUtS0kCdcbh0drLBXcj
         5DfjkTjh7rHnkc4GcIgT6i4gS6XzP2z82wImCtkSS0ZsqOtwAtKxHaa2zsfWZJfSLh3v
         ECeKgtP875n4EKdLJKI8C6Bl69hGj9EL1Je3YjRAkdsPjOCdq/jMpE3tVxbh0O6WvWfg
         sMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w2bWYYShsxJk96XdgBS4KYlhJC4JsUu9JTT/LXqMX8Y=;
        b=RlEA+FUhtDvOMKcEb3EDL8d4amOUVuOvMjDmiqjzJAoZXPejMGm25zJl4CCT/5TEFn
         mDQShS6IgfKHO8gX0nkzAj6c5CA/NmF7h04zV3ORfLZEBqUe1pebXyudZblEAIbSEQ3I
         tpMC32OA5f5QSaKzxs3EAUwsadXJOg9YDx4gzzN3qwuZFU7/FHH+ha+oQEB84eky3HMg
         MzWfn/QqGrKh+U+P8nUZoFKPyiaO3GSR8sovmXCTdwiUiL+mILgAUGNymm/crDA5S46J
         zLT0BsHLFG/cFr05lKjkuthv+Vln+HMSx2AG3IIa4o+gZXbKoQZ8jtH/GAWEThIXd/N0
         QAcA==
X-Gm-Message-State: ALKqPwf7hZ0O3XR4yhHGOk3BFXMymXx891owMj8CyAV8MZJ+sZYjlF9t
        e6PVtU7hID4oMzEkXolCqC/rXqjGy9dPvBfp35c=
X-Google-Smtp-Source: AB8JxZoNGV5IBg4c8ygIItLfyKa0BNsHNhZ6vO+j49l/+FCIesTgV1LT/d8ZbWmS4/9wpZuy7nmZdRPha6fKudzr0C0=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr8112711vkf.76.1526682645816;
 Fri, 18 May 2018 15:30:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 18 May 2018 15:30:44 -0700 (PDT)
In-Reply-To: <20180518213333.GB21797@sigill.intra.peff.net>
References: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com>
 <cover.1526677881.git.martin.agren@gmail.com> <f4e7822ebe8fcab8243ae3931084e10f3b199788.1526677881.git.martin.agren@gmail.com>
 <20180518213333.GB21797@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 May 2018 15:30:44 -0700
Message-ID: <CABPp-BFdKFNLHxqt-rbSVPx_cXVG3iyad42qYFbWvP9_2fW2gQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] unpack_trees_options: free messages when done
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 2:33 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 18, 2018 at 11:23:27PM +0200, Martin =C3=85gren wrote:
>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 79fd97074e..60293ff536 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -103,6 +103,8 @@ void setup_unpack_trees_porcelain(struct unpack_tree=
s_options *opts,
>>       const char **msgs =3D opts->msgs;
>>       const char *msg;
>>
>> +     opts->msgs_to_free.strdup_strings =3D 0;
>> +
>> [...]
>> +void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
>> +{
>> +     opts->msgs_to_free.strdup_strings =3D 1;
>> +     string_list_clear(&opts->msgs_to_free, 0);
>
> I like this string_list approach much better, but it's too bad we have
> to go through these contortions with the strdup flag to get the memory
> ownership right.
>
> If we had a string_list_appendf(), then we could just leave that flag
> alone and this:
>
>> @@ -118,8 +120,9 @@ void setup_unpack_trees_porcelain(struct unpack_tree=
s_options *opts,
>>                     ? _("Your local changes to the following files would=
 be overwritten by %s:\n%%s"
>>                         "Please commit your changes or stash them before=
 you %s.")
>>                     : _("Your local changes to the following files would=
 be overwritten by %s:\n%%s");
>> -     msgs[ERROR_WOULD_OVERWRITE] =3D msgs[ERROR_NOT_UPTODATE_FILE] =3D
>> -             xstrfmt(msg, cmd, cmd);
>> +     msg =3D xstrfmt(msg, cmd, cmd);
>> +     msgs[ERROR_WOULD_OVERWRITE] =3D msgs[ERROR_NOT_UPTODATE_FILE] =3D =
msg;
>> +     string_list_append(&opts->msgs_to_free, msg);
>
> would become:
>
>   msgs[ERROR_WOULD_OVERWRITE] =3D msgs[ERROR_NOUPTODATE_FILE] =3D
>         string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
>
> I don't know if that's worth it or not (I suspect that there are other
> places where appendf would be handy, but I didn't poke around).

The strdup_strings=3D1 immediately before calling string_list_clear()
has been used in one other place in merge-recursive.c, and tripped up
the reviewer requiring a big code comment to explain it. (See the very
end of https://public-inbox.org/git/CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQ=
sB6fHXT+9hLQ@mail.gmail.com/
).  So there's already one other place in merge-recursive.c that might
benefit from such a change.


A quick search shows about half a dozen other sites throughout the
code that are doing something similar:

$ git grep -3 strdup_strings | grep -B 1 string_list_clear
bisect.c: refs_for_removal.strdup_strings =3D 1;
bisect.c- string_list_clear(&refs_for_removal, 0);
--
builtin/shortlog.c: onelines->strdup_strings =3D 1;
builtin/shortlog.c- string_list_clear(onelines, 0);
--
builtin/shortlog.c: log->list.strdup_strings =3D 1;
builtin/shortlog.c- string_list_clear(&log->list, 1);
--
mailmap.c: me->namemap.strdup_strings =3D 1;
mailmap.c- string_list_clear_func(&me->namemap, free_mailmap_info);
--
mailmap.c: map->strdup_strings =3D 1;
mailmap.c- string_list_clear_func(map, free_mailmap_entry);
--
merge-recursive.c: entry->possible_new_dirs.strdup_strings =3D 1;
merge-recursive.c- string_list_clear(&entry->possible_new_dirs, 1);
--
revision.c: revs->notes_opt.extra_notes_refs.strdup_strings =3D 1;
revision.c- string_list_clear(&revs->notes_opt.extra_notes_refs, 0);


Maybe someone wants to tackle that as a separate patch series?  (Maybe
we make it a micro-project for future GSoC'ers?)
