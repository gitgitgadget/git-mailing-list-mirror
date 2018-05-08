Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756A7200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbeEHS2w (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:28:52 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:42918 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932819AbeEHS2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:28:48 -0400
Received: by mail-pl0-f51.google.com with SMTP id u6-v6so2714974pls.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j+CCcV4xPzfD8SOsX6+0tvT1E63zd1Yo1L3Sy2riCCw=;
        b=rHT4CgmyEXvll0YHihpdq3vVSlORs5aaku0LjDNhjfispbYhRulqQn0ZXXarRMUrBs
         tUImd+i8d8bH59WF1vMIvC51EqmJJPTpNzcYZPDV+iUQhY1vWkU+0j1LTEyGMgjbft+G
         RfW2PgmAYbQFtbXNr10HQwlLI5tB0nE9xYuGP5PBuUq15FUkuOm3YijhhpWNNhk5IyrX
         S9FmZfIN0hWs70V1atEDOU0jHmhQMkiUfWSuM+sCpcWYH2K/NyeAUU7Dl5tHYlw+f8tu
         jK1/zms7ZFVApuIfeHe5SHY0ZXTa8EImWxblmo85mOPQ9SQsZv4KHx86Q1vL8IwojqdW
         jJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=j+CCcV4xPzfD8SOsX6+0tvT1E63zd1Yo1L3Sy2riCCw=;
        b=n5tXBYMbASBRyGxLBOuJax6uIyv0CnASmFzLvokNTkptdz7CjKDwYPar7bZvI2b1Sy
         516yxSkWQTRAJ3sNBnCzq5zGkxbhDTz29xiMcCEiaGkbLeEEtkjLOdsnEm5d+iYkTx/Q
         C8rV6xiS7HLfO9reN5Y8dTEYmQnjWzKgnTtod8M4FlKO8l1j9ZMEnVHZ5UAoLUOwnfd2
         JsfM/lKc1uqCLKitEmBwKxEkmTCS8Mp2ijrKEnWoxGm/+1tA+jJY29n6FonAIajnZcpx
         KQPH9G3bYlDHQFtLe6nH1RxK1vvzos+QOYl1B+CXGmdx2pbTuGMoajZyQPEwRL1yMOeg
         cFAg==
X-Gm-Message-State: ALQs6tD3KCJGRmT6JNEnB65AiSQ+F+NN03NwrSUrNonUZRp+QHG5ZEHN
        rg3Ru2a69dMVp3twaVaZOsI8mWcBp6hG7iPTkrc=
X-Google-Smtp-Source: AB8JxZpn1+mwA5q08UAggqZIMu3YTHfBxW/m5N42hNHeg2Enpx4sCt8Cq1rHmT+dni4ORBni5a8cjGta7VvNVALw4BQ=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr42435508plb.298.1525804128326;
 Tue, 08 May 2018 11:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Tue, 8 May 2018 11:28:47 -0700 (PDT)
In-Reply-To: <20180507234058.GJ953644@genre.crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-7-sandals@crustytoothpaste.net> <CAN0heSqu9gwsrgV0rnPe8=vANhBA+Z7fZ3UNTeG9S1QiJBsksw@mail.gmail.com>
 <20180507234058.GJ953644@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 May 2018 20:28:47 +0200
Message-ID: <CAN0heSq8EYxVx9Qpb==KgeBVT3AXtgK6f+CQyK_kNUXZHMMnLA@mail.gmail.com>
Subject: Re: [PATCH 06/28] t0000: annotate with SHA1 prerequisite
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 May 2018 at 01:40, brian m. carlson <sandals@crustytoothpaste.net> wro=
te:
> On Mon, May 07, 2018 at 12:24:13PM +0200, Martin =C3=85gren wrote:
>> This could be more centralized at the top of the file, more likely to be
>> noticed during a `make test` and easier to adapt in the future. Maybe
>> something like this at the top of the file:
>>
>> if hash for storage is SHA-1 then
>>         knowntree=3D7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>>         path0=3Df87290f8eb2cbbea7857214459a0739927eab154
>>         ....
>> else
>>         skip_all=3D'unknown hash, but you really need to expand this tes=
t'
>>         # or even error out!
>> fi
>
> As I mentioned in an earlier email, I plan to set an environment
> variable for the algorithms in use and then do something like:
>
>   test "$tree" =3D "$(test-tool hash-helper --output known-tree)"
>
> where "known-tree" is some key we can use to look up the SHA-1 or
> NewHash value, and we've specified we want the output format (as opposed
> to input format or on-disk format).

My first thought was, can't we introduce such a helper already now? It
would not check with the environment, but would always output SHA-1
values. Thinking about it some more, maybe the exact usage/interface
would be a bit volatile in the beginning, making it just as good an idea
to gain some more experience and feeling first.

>> When we add NewHash, we get to add an "else if". Otherwise, we'd be
>> plugging in NewHash without testing some very basic stuff.
>>
>> Ok, so `skip_all` is quite hard, but skipping certain basic tests also
>> feels really shaky. Adding a new hash algo without adapting this test
>> should be a no-go, IMHO.
>
> I agree that this test needs to be updated for NewHash, but since we
> haven't decided what that's going to be, it makes sense during
> development to still test the rest of the code if possible so that we
> know what does and doesn't work.
>
> This is a first step in making it obvious what doesn't work, and when we
> know what the data is supposed to be, we can adjust it by fixing the
> tests so that it works in all cases.

A lingering feeling is, how do we find all these tests that we "hide"
(for lack of a better word)? Maybe introduce some standardized comment
keyword. Or use a more grep-friendly prereq-name. Or, if all occurances
of "SHA1" (outside of t????-*sha*) are expected to go away real soon
now, maybe this is not an issue.

Anyway, thanks for putting up with me, and thanks a big lot for driving
this major undertaking forward.

Martin
