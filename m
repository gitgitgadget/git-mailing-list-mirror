Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493C81F453
	for <e@80x24.org>; Mon,  4 Feb 2019 12:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfBDMyw (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 07:54:52 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41956 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfBDMyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 07:54:52 -0500
Received: by mail-ed1-f47.google.com with SMTP id a20so11129714edc.8
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b+NHo97GWSZsxKJNh0eSNEdq15dSfUmC1uUJltEf4wg=;
        b=KwteRL0FKJ0sYCCTtZCT9/izIRrgQEBOCbKlbJ0PUbDAdRyoqRh0G3sD5xjeZabBUW
         U3paT3cFA9wVTCLAz0JZO+VV+Ho4PQJQkD50z1QxA2/mG0KzH/PV3HUb0O/rEwtQPDY6
         VwjTwnbeQqufDFRYYRzSpOki8x9yPW4ntzr26JbKfnXJ3TYWxq/vkbShXZJ21meMV81W
         3IuuNvVTgMp+nTX/NWLOjDjovZLHYBsUMkJdWJ247N7swyqlXTzoEx9hUtoFi9nx23mz
         b5AhsZrxJ7V7RUWKXZ+4RopY/bih2Z0w3aXaSqH1MWRkFIZleRafnNFnT8ypMs3IwHhx
         fEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b+NHo97GWSZsxKJNh0eSNEdq15dSfUmC1uUJltEf4wg=;
        b=OSvhmjo4IDlQ9b6tUVCAuQrzMbBE7AluASolRhMjmIZucuu8RdhcJ8MS4LlrDnPAbF
         7IcVR8gDDpCMI9kUhFRzG6946tTRcTmxI6AS2GP6/vtXcBaSU0NISYgIvG183xKsX69R
         q3BSMFvYVW5iY42vWOq/Hc3MCuckRAm1K6C3BWNhhkBJ2WJQJTZH+OL/knY9iR3Z5+8m
         7WsgKosTYJN/YGGddKG5otBzJvs7Z/0cm97ucA7qxDdHAmmnBtX9dEwhWzwYAmIICZBM
         V7y4gukOdJx6xFZJNZ/6sYuRIvns4a4JyHhPtx9auS9Einpy5URg9idtw2GTzXZSxZVz
         9ojA==
X-Gm-Message-State: AJcUukeiljbx4IEKfGb9FD8V2Bkcg7Q4L9/KxpT+E7DWqhYzxOMGr4y4
        r2FW1QrD2ZShBPgIDC9sgrMQkB+V4iPk/hhbE0k=
X-Google-Smtp-Source: ALg8bN5DyJak+C0sE9F/AOZRtWX8R57hStvN6HtcknD/vNFb5nWis2ozZDRKdSeekHoWzKKW93Oon95YgR8DjIr2KbI=
X-Received: by 2002:a17:906:e102:: with SMTP id gj2mr33577535ejb.172.1549284890197;
 Mon, 04 Feb 2019 04:54:50 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <CAL21Bm=K6zZ=APkiP3A_X7xVoOfx-MY2435YMp5y1ztE-xyYtg@mail.gmail.com>
In-Reply-To: <CAL21Bm=K6zZ=APkiP3A_X7xVoOfx-MY2435YMp5y1ztE-xyYtg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 4 Feb 2019 13:54:38 +0100
Message-ID: <CAP8UFD3QCaSu8z4MdGks7E7zMrFpvcuWdFz_Zyr4yKhV+=XV7A@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 11:28 AM =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=
=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>
> =D0=BF=D0=BD, 4 =D1=84=D0=B5=D0=B2=D1=80. 2019 =D0=B3., 10:16 Christian C=
ouder christian.couder@gmail.com:
>>
>> The application has been submitted on
>> https://summerofcode.withgoogle.com, but it will not be complete until
>> someone else volunteers as an org admin. I volunteered, but they
>> require "at least 2 and at most 5 Organization Administrators".
>
> Thank you,
> I filled the form in.

Thank you Olga!

The application is complete now, though of course we can still add org
admins and improve our "ideas" and "microprojects" pages.
