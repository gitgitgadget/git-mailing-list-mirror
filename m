Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468601FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 21:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbdDCV6O (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 17:58:14 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35712 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdDCV6N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 17:58:13 -0400
Received: by mail-it0-f44.google.com with SMTP id y18so54967934itc.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3STx0cbbUxTsP9ZwGhh9H1CRhH62cY3cfRWJ+z5agz0=;
        b=Z4ZbzCZipC2qLP8EwrjNsCJIMxVe0PrfhWljH0qY/GePXChENR0KAMGW7I1RMyJz9H
         lcPeTWcNAcLY4+I/66Leoomj2t/fv66c8+ZL76T0EeDA1wvOWZjyE9bgYHr7oOXxtxzf
         3AIV1XhFMzVMossU0xcvmpxRZO9Wbxzt7Ar2hZf2MxSX8g6UUCxO7Vc23QCnJogyvke8
         UuIusYsbv9uAbbwbgONUUn7F8x1pc/BuGmcEe0HHW6GGaYvEWGa5lqZIilaDzvrGRSFW
         Ap4zC2SVwfUOe+95IRlkDSap0o0gQq7yNVuCf1Ig7DrYkRlY0iK9a3vppq2ep7utlPBY
         KgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3STx0cbbUxTsP9ZwGhh9H1CRhH62cY3cfRWJ+z5agz0=;
        b=sSorcRgFlnh0Phks7VZ5Fn+SYgIMv74c2xpS2u/BsyItugqrzd+EKMl7kYr6NdapSn
         53aHY72Wb/+rwL1mvWHoBfh6Uaa291kZbUFbsl4aG++Cn+8a51u0PUbsx+CsudxQIBrp
         /HK5WZM26VJVa9PhSm8EjfhuiWd8CsL9Q/yySeoydsapnKK2Ex1lu26BJy4jdQkAdce5
         a/fIjBdber8kqYk9+ld1lRaYZteQQoKD4B3KSXqZISUA+rq02pPjf03+1BvlnqyeWOj7
         vys7XK8mw+u6JsjlPOLdfehg+tZWDFAkIly1ENDwESbf/MgK3AgHE71A4ced4jAMuoAv
         6FRQ==
X-Gm-Message-State: AFeK/H3dKLECviqi/zBqkTJNXR0ZpEMv5PEA/MYonj9XL/1ocU/aYgKC
        pDQ1i1yl/UXqXqE6lqHDUgAmSkuGG9b6ehI=
X-Received: by 10.36.173.91 with SMTP id a27mr10596427itj.60.1491256692356;
 Mon, 03 Apr 2017 14:58:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 3 Apr 2017 14:57:51 -0700 (PDT)
In-Reply-To: <20170403213440.GA1409@whir>
References: <20170403211644.26814-1-avarab@gmail.com> <20170403213440.GA1409@whir>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 3 Apr 2017 23:57:51 +0200
Message-ID: <CACBZZX7R5svNJ+Ak3LFh8+kY48i6V7Yo6JDS+PSDJCkZ5vHb6w@mail.gmail.com>
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
To:     Eric Wong <e@80x24.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2017 at 11:34 PM, Eric Wong <e@80x24.org> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>> Add a new manpage that gives an overview of how to tweak git's
>> performance.
>>
>> There's currently no good single resource for things a git site
>> administrator might want to look into to improve performance for his
>> site & his users. This unfinished documentation aims to be the first
>> thing someone might want to look at when investigating ways to improve
>> git performance.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> I've been wanting to get something like this started for a while. It's
>> obviously woefully incomplete. Pointers about what to include would be
>> great & whether including something like this makes sense.
>
> Thanks for doing this.  I hope something like this can give
> server operators more confidence to host their own git servers.
>
>> Things I have on my TODO list:
>
> <snip>
>
>>  - Should we be covering good practices for your repo going forward to
>>    maintain good performance? E.g. don't have some huge tree all in
>>    one directory (use subdirs), don't add binary (rather
>>    un-delta-able) content if you can help it etc.
>
> Yes, I think so.

I'll try to write something up.

> I think avoiding ever growing ChangeLog-type files should also
> be added to things to avoid.

How were those bad specifically? They should delta quite well, it's
expensive to commit large files but no more because they're
ever-growing.

One issue with e.g. storing logs (I keep my IRC logs in git) is that
if you're constantly committing large (text) files without repack your
.git grows by a *lot* in a very short amount of time until a very
expensive repack, so now I split my IRC logs by month.

But I'm probably forgetting some obvious case where the ChangeLog
use-case is bad.

>> --- /dev/null
>> +++ b/Documentation/gitperformance.txt
>> @@ -0,0 +1,107 @@
>> +giteveryday(7)
>
> gitperformance(7)

Oops, thanks.

>> +Server options to help clients
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +These features can be enabled on git servers, they won't help the
>> +performance of the servers themselves,
>
> Is that true for bitmaps?  I thought they reduced CPU usage on
> the server side...

I'm not sure, JK? From my reading of the repack.writeBitmaps docs it
seems to only help clone/fetch for the client, but maybe they do more
than that.

I also see we should mention pack.writeBitmapHashCache, which
according to my reading of v2.0.0-rc0~13^2~8 only helps clone/fetch.

> A sidenote: I wonder if bitmaps should be the default for bare
> repos, since bare repos are likely used on servers.
>
>> but will help clients that need
>> +to talk to those servers.
>> +
>> +- config: "repack.writeBitmaps=3Dtrue" (see
>> +  linkgit:git-config[1]). Spend more time during repack to produce
>> +  bitmap index, helps clients with "fetch" & "clone" performance.
