Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF46C1F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 10:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdH1KJN (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 06:09:13 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36640 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdH1KJL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 06:09:11 -0400
Received: by mail-pf0-f182.google.com with SMTP id z87so132729pfi.3
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WKRxkda+2MbmGjKh5cKjm5mk1qkTU/FvjX1SpVHU2wE=;
        b=M8sWAtxxt16mkmet67vBkihOsSNy+L6rupdg073FbDpJvs+a5Fu+sG2CqKjQppcUHa
         p50LzEuS+SzdzswljXRbzQ7rwcakjkH2znVY3CirIx9uf6Yhde/6e7K+NENPGhQibruQ
         3SRnLeOZwWYobfLLGHMigPcasceIHrN6sbk6gho/qhlzabVx6IHZ7GmsJUiId+O2AMB+
         htda8q+Typtf5mn3u2FrKXJMKFr/+gx1xn8zKB65PxPAc8jIdDT9DXpdXsIgVHaBksWU
         M886fXTL+4e1LtVgDFIfRZ9ociP8zNUpbMgpmnzJMh+J4G6i1vlicZOgD9uaxPDiSgZV
         o8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WKRxkda+2MbmGjKh5cKjm5mk1qkTU/FvjX1SpVHU2wE=;
        b=ssrDkOIVb7JMR6VXqrkyDvEC49OWTStTbfVmMGSNT3TB/OxDFqP6LXy1/guDDFjzwI
         MIYwE4PtwcMCXHcZtfDzwaoauAFshElYpx9BOs5OJkKOt9feg6aYihkpCP+AkaFfeHsx
         NGtuG8MzCne9ruY7Wdgr7j25Szd4nhrgd1C6Zbrpm7FkFLiTYdjWT1JfFa9bvIZBPHO7
         GtaJjExk4vrXyiCaYHU20IKDP+B586HMYfGo/n0ItHz+DbrJM9NTOdFLjdqAMw6xJsc5
         VfRQ4ULImqXL3Z4l5v2RPSKo5oSnlqCwRRK7dHb8Vb4JP6f7eEfvXM8RAFGl1B/sre3P
         1jsA==
X-Gm-Message-State: AHYfb5jhTo7Nhi+cwGGbmJxN0ExBLGUySjl6jC2Kx83uou3xWoO3hW0a
        DHjRS3rGCRRDzKdu4vwcAUs5ewudnA==
X-Received: by 10.99.112.20 with SMTP id l20mr34973pgc.362.1503914950291; Mon,
 28 Aug 2017 03:09:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Mon, 28 Aug 2017 03:09:09 -0700 (PDT)
In-Reply-To: <CAMy9T_FUGehTbfVfVfi877Gi3DOR5Z45A-H-v92s7g=m7RVnSw@mail.gmail.com>
References: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
 <xmqq8ti7s6ph.fsf@gitster.mtv.corp.google.com> <CAN0heSq8RdH5vWFgq1UvJOfWerMJSZwhV4FMCjvA=XUqu2OQQQ@mail.gmail.com>
 <CAMy9T_FUGehTbfVfVfi877Gi3DOR5Z45A-H-v92s7g=m7RVnSw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 28 Aug 2017 12:09:09 +0200
Message-ID: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs/files-backend: duplicate strings added to affected_refnames
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 August 2017 at 10:06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Sat, Aug 26, 2017 at 12:16 PM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>> On 25 August 2017 at 23:00, Junio C Hamano <gitster@pobox.com> wrote:
>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>
>>>> files_transaction_prepare() and the functions it calls add strings to =
a
>>>> string list without duplicating them, i.e., we keep the original raw
>>>> pointers we were given. That is "ok", since we keep them only for a
>>>> short-enough time, but we end up leaking some of them.
>>>
>>> [...]
>
> Good find, Martin.
>
> First of all, you are right that we don't want any memory leaks here.
> Nobody promises that the program will end soon if a reference update
> fails. (In fact, there are invocations of `git` that trigger multiple
> reference updates.) This is a small leak, but we should fix it.
>
> The problem (if I may take a stab at explaining it in my own words) is
> that `files_transaction_prepare()` uses a `string_list` called
> `affected_refnames` to ensure that the same reference name is not
> modified more than once in a single reference transaction. Currently,
> `affected_refnames` is configured *not* to duplicate the refnames that
> are fed to it, which also means that it doesn't free the refnames when
> it is cleared.
>
> This is correct for most refnames, which are owned by entries in the
> `ref_transaction`, and therefore have a longer lifetime than
> `affected_refnames`.
>
> But there is one code path that can add a refname to
> `affected_refnames` without making a provision for the refname ever to
> be freed:
>
> * files_transaction_prepare()
>   * lock_ref_for_update()
>     * split_symref_update()
>       * item =3D string_list_insert(affected_refnames, referent)
>
> The `referent` in the last statement comes from a `strbuf` that is
> created in `lock_ref_for_update()` then passed to `lock_raw_ref()`,
> which fills it.
>
> It would be a serious bug if `lock_ref_for_update()` would dispose of
> `referent`, because the pointer in `affected_refnames` would point at
> freed memory. But in fact we have the opposite problem;
> `lock_ref_for_update()` never frees the memory (it doesn't even
> `strbuf_detach()` it). So that memory is leaked.

Thanks for this very well-written description. It matches my
understanding completely, which is comforting.

> Your proposed solution is to change `affected_refnames` to duplicate
> the strings that are stored in it, in which case
> `lock_ref_for_update()` can properly dispose of `referent`, fixing the
> leak. This works, but at the price of having to allocate memory for
> *all* references in the update, even though most of them are already
> fine.

Agreed.

> But note that `split_symref_update()` *also* passes a copy of
> `referent` to `ref_transaction_add_update()`, which *already* makes a
> copy of the reference name and adds an entry containing the name to
> the `ref_transaction`. If we would store *that* copy to
> `affected_refnames`, then it would get freed when the
> `ref_transaction` is cleaned up, and we could fix the memory leak
> without allocating any new memory. This requires a little reorg of
> `split_symref_update()` but it's not too bad:
>
> * Do the initial check using `string_list_has_string()` rather than
> calling `string_list_insert()` already.
> * After `new_update` has been created, call `string_list_insert()`,
> passing it `new_update->refname` as the string.

I haven't looked at the code yet, but from what I remember, this would
a) work and b) be a straightforward rearrangement as you say. I'll give
this approach a try (unless you want to, of course; just holler).

> If this is done in place of your first commit, then your second commit
> could be left unchanged.

Thanks a lot for your comments. I appreciate it.

Martin
