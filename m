Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1289C1F4DD
	for <e@80x24.org>; Tue,  5 Sep 2017 09:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbdIEJDk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 5 Sep 2017 05:03:40 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55329 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751846AbdIEJDj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 Sep 2017 05:03:39 -0400
X-AuditID: 12074414-0d3ff70000006ddf-c3-59ae686a53bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.15.28127.A686EA95; Tue,  5 Sep 2017 05:03:38 -0400 (EDT)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com [209.85.223.181])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8593bUI030581
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 5 Sep 2017 05:03:38 -0400
Received: by mail-io0-f181.google.com with SMTP id z67so12871735iof.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 02:03:37 -0700 (PDT)
X-Gm-Message-State: AHPjjUhgXCXaz6uVwrqVD65PwlLuEBiFNBoKcsQXnN256Ya9NfbNZbTT
        q8glAlHJ0ai3PZFzerI7RmBPyHAaDQ==
X-Google-Smtp-Source: ADKCNb6tu29ZdSt+B4efhf0th/soiKpCfv9xyvRLIWu+kot3A1RI/XZ29JJoaeqcn73pyWVZgz5nXhUA3L74NZGilJI=
X-Received: by 10.107.69.21 with SMTP id s21mr2900081ioa.143.1504602217332;
 Tue, 05 Sep 2017 02:03:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.13.17 with HTTP; Tue, 5 Sep 2017 02:03:36 -0700 (PDT)
In-Reply-To: <20170905084507.wntm3bfzfezgimcz@sigill.intra.peff.net>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
 <20170905084507.wntm3bfzfezgimcz@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Tue, 5 Sep 2017 11:03:36 +0200
X-Gmail-Original-Message-ID: <CAMy9T_F5HWF=hinxdp0C+pgyH_8MnR31p=XK1rjyMiM3UwST_w@mail.gmail.com>
Message-ID: <CAMy9T_F5HWF=hinxdp0C+pgyH_8MnR31p=XK1rjyMiM3UwST_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqJuVsS7SoKVV0aLrSjeTA6PH501y
        AYxRXDYpqTmZZalF+nYJXBnzvxcVdIhWvNo8n7WBcbVAFyMnh4SAicT/y5eYuxi5OIQEdjBJ
        XF67mgXCecIkcajnJlSmn1Gi+9InNoiWfIm5j6dB2UUS75c+g7KLJd59fg1m8woISpyc+YQF
        xBYSkJN4teEGI4TtIdG78CqYzSngItG9rocdYsFdRomuBfuYQRJsAroSi3qamUBsFgEViQfz
        b7BCLEiUmHz0FTvEggCJLyufgC0TFoiSeDNjO1iviICsxPfDG4EWcHAwC2RL7Gk3BwkzC2hK
        tG7/zQ5ha0ssW/iaeQKj6Cwkp85CUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboW
        ermZJXqpKaWbGCHRILKD8chJuUOMAhyMSjy8EaFrI4VYE8uKK3MPMUpyMCmJ8oYmrosU4kvK
        T6nMSCzOiC8qzUktPsQowcGsJMK7KgUox5uSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1OzW1
        ILUIJivDwaEkwauaDtQoWJSanlqRlplTgpBm4uAEGc4DNPxRKsjw4oLE3OLMdIj8KUZjjitX
        1n1h4phyYPsXJiGWvPy8VClx3ndpQKUCIKUZpXlw02AJ7RWjONBzwrxJIEt5gMkQbt4roFVM
        QKuqXq4BWVWSiJCSamDkcdK7oLV059P7ws6zCnk8D576UfcpjvuB3AG1h9XlKxX+aXTs/tR9
        lL2q+GRtd/2ElNOKj551XJrYt0ycdZfe5in++W+nMvAtaCgXknrqGHfTKiDcuML7fOodfcPA
        mmS/VxGb5kfsndpw4sjPr55dnCafzi8sWuMh7tTL/8eXufpSaeb6+VVKLMUZiYZazEXFiQDz
        PsQ8QwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 10:45 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 29, 2017 at 07:18:22PM +0200, Martin Ågren wrote:
>
>> [...]
>> Rearrange the handling of `referent`, so that we don't add it directly
>> to `affected_refnames`. Instead, first just check whether `referent`
>> exists in the string list, and later add `new_update->refname`.
>
> Coincidentally[1] I came across this same leak, and my solution ended up
> slightly different. I'll share it here in case it's of interest.
>
> In your solution we end up searching the string list twice: once to see
> if we have the item, and then again to insert it. Whereas in the
> original we did both with a single search.
>
> But we can observe that either:
>
>   1. The item already existed, in which case our insert was a noop, and
>      we're good.
>
> or
>
>   2. We inserted it, in which case we proceed with creating new_update.
>
>      We can then in O(1) replace the pointer in the string list item
>      with the storage in new_update. We know we're not violating any
>      string_list invariants because the strings contain the same bytes.
>
> I.e.:
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9266f5ab9d..1d16c1b33e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2178,6 +2178,11 @@ static int split_symref_update(struct files_ref_store *refs,
>         update->flags |= REF_LOG_ONLY | REF_NODEREF;
>         update->flags &= ~REF_HAVE_OLD;
>
> +       /*
> +        * Re-point at the storage provided by our ref_update, which we know
> +        * will last as long as the affected_refnames list.
> +        */
> +       item->string = new_update->refname;
>         item->util = new_update;
>
>         return 0;
>
> It feels pretty dirty, though. It would certainly be a bug if we ever
> decided to switch affected_refnames to duplicate its strings.
>
> So given that your solution is only a constant-time factor worse in
> efficiency, we should probably prefer it as the more maintainable
> option.

This is clever, but I don't like that it requires outside code to
change internal `string_list` structures in a way that is not
documented to be OK.

If we cared about getting rid of the extra `O(lg N)` search (and I
agree with you that it doesn't matter in this case), I think the clean
way to do it would be for `string_list` to expose a method like

    struct string_list_item *string_list_insert_at_index(struct
string_list *list, size_t index, const char *string);

and to use it, together with `string_list_find_insert_index()`, to
avoid having to search twice.

Michael
