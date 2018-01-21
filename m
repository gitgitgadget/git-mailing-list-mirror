Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53ED51F576
	for <e@80x24.org>; Sun, 21 Jan 2018 22:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeAUWzp (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 17:55:45 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45137 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeAUWzo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 17:55:44 -0500
Received: by mail-ot0-f193.google.com with SMTP id r4so5957825oti.12
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FVohM4Uo2d1DCYifeAHiCSZZ0Ssi+dhhTfVlYiBo9iI=;
        b=Uc7WCmRp92IhR+V0ubJAuzZMSfzBdDSjk8dfLu/PinEVNZFcJehsKN6X1fzDZ9Mm5v
         yZrCzVQOinp+hpDbeJvUaWjm2gXqDJXRbyOn3sF3eCyX66ApdfV+bEXflb/ywysrrvHe
         RhQsjkA0gLtmQRlpslGBjREAGcI9ZxOOOuD/1iTDDVeKl9uOHkNj/i0UVcLAtakrDWob
         D5Dzf2sUlkeuItrdg5lI2nEjJ197MzScoi6mTcxhVPyYfsC6jfhu/nNcoNgQFbxbkPRy
         cnU7mEwrCq6L8fBOQLJpiMXRPh894qYS5e9MZG+ZuK403C/1JrrRonJ/ihNohYzCn3bU
         tzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FVohM4Uo2d1DCYifeAHiCSZZ0Ssi+dhhTfVlYiBo9iI=;
        b=H8InZ2rjDQRzY8L7nI0M56Rv2r/SDqakUxfZ4iHnuWeHiyT/6S/RelXIdaYIVFLP8a
         9xlk6pTDX3NTZeh3bf/SWPhMpRUjbPXTUGsApdxngxgwnnopiqwjXAC1FVr2NPemrxKg
         rbeZ+VCNfmSR8J9oxXt3dLEoDGjWzMEsc213oA5XS+7+JSgtetez763JFOTiPUCL7xmV
         TinqKgDkWx8wrovjEU2MdoozIL+Lybe8bIlOGRacNT5a9vCx7Y0qk+gov82gfjZ6V2EW
         qO2yu9L1C2ksMf+JmRw9lLQr1++LxY6rmLL/4X/rTgjk6a5s6MS42QmqiecXIb7zhCIS
         IV5Q==
X-Gm-Message-State: AKwxytdNuSCPcmyQH6q1WYQ15GFpzvUdAmsLqhqBvQM7a5RibdXXj8vX
        J4rZBgqTUcoI4EvxeIQDDkk7pumpNAsDmSLGhIGHRw==
X-Google-Smtp-Source: AH8x224niaSAewKoYTsXek3Zo48Mu8t3hd1hK0JmLYu/DEp+fYNYCbuivRsJ8UPBvX4795ytt4a39V0qhQFG69/iNDs=
X-Received: by 10.157.7.164 with SMTP id 33mr2889332oto.276.1516575343363;
 Sun, 21 Jan 2018 14:55:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.160.203 with HTTP; Sun, 21 Jan 2018 14:55:12 -0800 (PST)
In-Reply-To: <75c9bdc5-1c81-1e03-e865-5e74014bd590@web.de>
References: <1516404987-3420-1-git-send-email-gs051095@gmail.com>
 <20180120010228.hhyvirqp44taf3cz@dcvr.yhbt.net> <CAOCi2DGKkLnY_=-7pMr9VyP7TVsj0b8w-msdNn9ZtXKK8g7u9g@mail.gmail.com>
 <75c9bdc5-1c81-1e03-e865-5e74014bd590@web.de>
From:   Gargi Sharma <gs051095@gmail.com>
Date:   Sun, 21 Jan 2018 22:55:12 +0000
Message-ID: <CAOCi2DFjz=WD7kma5XUqAOKuPuTBg6OwnO2WjmKyn0gF1z7Cgg@mail.gmail.com>
Subject: Re: [PATCH v3] mru: Replace mru.[ch] with list.h implementation
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 21, 2018 at 4:38 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 20.01.2018 um 23:24 schrieb Gargi Sharma:
> > On Sat, Jan 20, 2018 at 1:02 AM, Eric Wong <e@80x24.org> wrote:
> >> Gargi Sharma <gs051095@gmail.com> wrote:
> >>> --- a/list.h
> >>> +++ b/list.h
> >>> @@ -93,6 +93,13 @@ static inline void list_move(struct list_head *ele=
m, struct list_head *head)
> >>>        list_add(elem, head);
> >>>   }
> >>>
> >>> +/* Move to the front of the list. */
> >>> +static inline void list_move_to_front(struct list_head *elem, struct=
 list_head *head)
> >>> +{
> >>> +     list_del(elem);
> >>> +     list_add(elem, head);
> >>> +}
> >>> +
> >>
> >> Since we already have list_move and it does the same thing,
> >> I don't think we need a new function, here.
> >>
> >> Hackers coming from other projects (glibc/urcu/Linux kernel)
> >> might appreciate having fewer differences from what they're used
> >> to.
> >
> > I think the idea behind this function was that it is already being used=
 in two
> > places in the code and might be used in other places in the future. I a=
gree
> > with your stance, but a list_move_to_front is pretty self explanatory a=
nd not
> > too different, so it should be alright.
>
> Not sure I understand the point about the function being already used as
> an argument for adding it, but if there is already one which has the
> exact sane behavior (list_move() in this case) then that should be used
> instead of adding a duplicate.

Thanks for bringing this to my attention, Ren=C3=A9. I can use list_move()
to do the exact
same thing as list_move_to_front(). Will send another version.

Thanks,
Gargi
>
> Ren=C3=A9
>
