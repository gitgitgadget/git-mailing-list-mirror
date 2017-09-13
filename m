Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA4B20286
	for <e@80x24.org>; Wed, 13 Sep 2017 23:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbdIMXAm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 19:00:42 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:43456 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdIMXAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 19:00:41 -0400
Received: by mail-wm0-f51.google.com with SMTP id a137so1460751wma.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q/hDZshn/0F0b3gF8fZ1ujFdONPz+ogtTtMceQdfpm8=;
        b=tmV5VcWbHlhRRZY0yGGUkit2yR6liHdLw+v5vY6Bsf+d4g4RN1z1LOYQS66Zenxk3F
         kUGPi0fWsC5iqAu+Gm/uxRb35zFthZptEd404f0UZVHY9ckWbOr59KUzM4LrbSbEBVLa
         4gG2HbGZFrZZYaL43WzEH+LeY2ociSgUuDEgFYSr5dbNqwFADYASiu92trvdpueOfH26
         ZQIrsf3AaUrmoWsWyxu1xWhVUSK6iCz6izpF16KRS5c/h/6eugTpBrEBIYOhXS2MEeeg
         8dWqM4RYhokcIHFsdL7W8XeMjqawWHqqbrZgrNE0MpeK2yUtYm2f32bCN1iOeoguBqT0
         iXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q/hDZshn/0F0b3gF8fZ1ujFdONPz+ogtTtMceQdfpm8=;
        b=NV7Xv5fGK8Q/LtzQshlqpMk/Fb6ueJky9FszszNypBkE0727Rbb6eVNQtIXkyWF5EC
         UDLmHnpgYvrM7T81/3CzqEdttmk0e5qoCvcx2d5P71DRAbBxsfNKqRsH10oCZSKt/oWA
         BzHUngkHIN1nns4un/MEtsa8PFzMkGVdY+FLgGx0EvOJTiwKUhZENhUSkB6Wl2sroroa
         lSLLhC41UnFXKmN69i+oEP5dRd2670aueYQUW30YrLvWIHtiOwpI4pkspfkNBQ3rctCd
         2Cx4RxPZNZVdm9Jrcf4Ki8ob/S8dLWv59GJ2KCZ/KrfDecooPhQML4w2BnL9JMaBxk1/
         ddyg==
X-Gm-Message-State: AHPjjUgurDlxEXVoCW6F8uWQF0VOqzaVuzRXgr3+4zEopdJUQNq95s7k
        bqYYF3vBwfLUlMuRtRcZ1va2Bz1LsB2a6b9vv1FCLA==
X-Google-Smtp-Source: AOwi7QD44PkK9ScCg/uI9IvQtEESI3Yr284RHam+z302qjPEjlXEFxkr8H71+3KAZ5+F4ymlSVrAXpnvUkdtlf3a8LA=
X-Received: by 10.28.57.215 with SMTP id g206mr198724wma.117.1505343640099;
 Wed, 13 Sep 2017 16:00:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Wed, 13 Sep 2017 16:00:39 -0700 (PDT)
In-Reply-To: <8844c66d7b245dda7a2fa2794cb4051b5b2b35e2.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu> <8844c66d7b245dda7a2fa2794cb4051b5b2b35e2.1505319366.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 13 Sep 2017 16:00:39 -0700
Message-ID: <CAGZ79kYHzWaPXGE29RUe1J+T_=AHKADhv2TjkMSUu5NM80zX1w@mail.gmail.com>
Subject: Re: [PATCH 20/20] packed-backend.c: rename a bunch of things and
 update comments
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 10:16 AM, Michael Haggerty <mhagger@alum.mit.edu> w=
rote:
> We've made huge changes to this file, and some of the old names and
> comments are no longer very fitting. So rename a bunch of things:
>
> * `struct packed_ref_cache` =E2=86=92 `struct snapshot`
> * `acquire_packed_ref_cache()` =E2=86=92 `acquire_snapshot()`
> * `release_packed_ref_buffer()` =E2=86=92 `clear_snapshot_buffer()`
> * `release_packed_ref_cache()` =E2=86=92 `release_snapshot()`
> * `clear_packed_ref_cache()` =E2=86=92 `clear_snapshot()`
> * `struct packed_ref_entry` =E2=86=92 `struct snapshot_record`
> * `cmp_packed_ref_entries()` =E2=86=92 `cmp_packed_ref_records()`
> * `cmp_entry_to_refname()` =E2=86=92 `cmp_record_to_refname()`
> * `sort_packed_refs()` =E2=86=92 `sort_snapshot()`
> * `read_packed_refs()` =E2=86=92 `create_snapshot()`
> * `validate_packed_ref_cache()` =E2=86=92 `validate_snapshot()`
> * `get_packed_ref_cache()` =E2=86=92 `get_snapshot()`
> * Renamed local variables and struct members accordingly.
>
> Also update a bunch of comments to reflect the renaming and the
> accumulated changes that the code has undergone.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

I have skimmed this series and it looks good.
Thanks,
Stefan
