Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85A01F404
	for <e@80x24.org>; Mon, 22 Jan 2018 12:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeAVMx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 07:53:26 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:41060 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeAVMxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 07:53:25 -0500
Received: by mail-ot0-f181.google.com with SMTP id 44so7332167otk.8
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 04:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SjOoB3NZl96I4+f0hw1ZhnRjW6rRU4PsD4AZAxD2wRM=;
        b=MuF7y15998LX+MSPXU23rNzbxoF4HHDLSEz9RYWa1zgljZvcl3ICGjFa9AigY5amHB
         8FAuadT7MdYzkBdo+yTByQ4CWkyh5gLXWifsqouAsMBTUzRV+zip1QmuD7VYS34kHvx+
         rzqv7mJ7zDiqTLxu5L8fCWMKBoBClPxibWyD81I0VX816mRcoIECHvNIIo1UP1EVcHU1
         NSWSw5tCc2iGR2W0KiJVtVR+ZDFyN312DcwB3tywqYqoqZrO0nwN7bmiRmugCVsrqERi
         qLzThi9ZWXa+gdb7KI5+E6jo+xF045SP/nzweJs3tan1V2YXe4Csxe2Ykru3Wl7kF1jp
         EKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SjOoB3NZl96I4+f0hw1ZhnRjW6rRU4PsD4AZAxD2wRM=;
        b=eQptIRTuRllU2G7rQ6gGC+gGh83JfdEAAFhWFMAutb9m1VReUvoBJHCeniPPAfaohJ
         P5P3OA0lLaFU8RPCSLL7QomFBr6oYQT78UWDpfbNWFnYPviTO33PNmYLt763Ngdg5SB4
         L1gSEgplOnkADlFp/fH7JUwUA4+LmOBCXtxus+y5gxhGKxKuSmDyzBX/LNbZkxgFBkIY
         6k74pdAsiszA+pkueij73pViACFM7JKwygHTrgPF3uyEp8eHyaw2gjcW4zxQBmiSck3q
         BEOzUBdv8PltcVWBN5y7/elfAfrACpXNKpQm30zwjl3y84lbKZagbFucXpt7ilMaPbSC
         cMoA==
X-Gm-Message-State: AKwxytcFw9xmV8CN3HSmxCQqVcoCCS97iKjmq4Pk2ZctxbXBuclDJGfA
        ERCVZf30sDVzNryT16TGovevz9V4B3f2luwdiBA=
X-Google-Smtp-Source: AH8x226POtw521KoK9LJ8ayx5vMGuqRHwKPGU4NBkmSNZbomNlhb9ZmM6gekrviGK+s8fLaNa4OSXXZP/RLdJ/8Woq8=
X-Received: by 10.157.64.169 with SMTP id n38mr4223746ote.151.1516625605001;
 Mon, 22 Jan 2018 04:53:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Mon, 22 Jan 2018 04:52:54 -0800 (PST)
In-Reply-To: <CAJfL8+QcfaypDagYDjCw=eFqUhhFZ5qyMgjQcoyshnvnh7aTmQ@mail.gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com> <757646a6b42e8a0ceb50665a1fe6f588227d9873.1516617960.git.patryk.obara@gmail.com>
 <20180122114925.GA5980@ash> <CAJfL8+QcfaypDagYDjCw=eFqUhhFZ5qyMgjQcoyshnvnh7aTmQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Jan 2018 19:52:54 +0700
Message-ID: <CACsJy8BKXxAK176V54855kUVSDZcxwPfkRba0YrMqk0LzGeang@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] sha1_file: convert hash_sha1_file to object_id
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 7:44 PM, Patryk Obara <patryk.obara@gmail.com> wrote:
> On 22 January 2018 at 12:49, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Jan 22, 2018 at 12:04:28PM +0100, Patryk Obara wrote:
>>> @@ -969,7 +969,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
>>>
>>>               /* step 4: substitute */
>>>               strbuf_addstr(buf, "Id: ");
>>> -             strbuf_add(buf, sha1_to_hex(sha1), 40);
>>> +             strbuf_add(buf, sha1_to_hex(oid.hash), GIT_SHA1_HEXSZ);
>>
>> oid_to_hex()?
>
> I didn't do it originally because the size of hash is explicitly
> passed as the third parameter.

Aha! I didn't see that.

> I should probably replace this line with:
>
> strbuf_addstr(buf, oid_to_hex(&oid));
>
> ... since a hex representation is correctly 0-delimited anyway.

Yeah I think that's a good idea. This 40 came from 3fed15f568 (Add
'ident' conversion. - 2007-04-21). Back then memcpy was used and 40
made sense. The conversion to strbuf should have used strbuf_addstr()
as you suggested, unless there's performance concerns, but I don't
think there is any.
-- 
Duy
