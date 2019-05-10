Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898421F45F
	for <e@80x24.org>; Fri, 10 May 2019 00:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEJA4N (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 20:56:13 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36813 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfEJA4N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 20:56:13 -0400
Received: by mail-it1-f194.google.com with SMTP id o190so6489426itc.1
        for <git@vger.kernel.org>; Thu, 09 May 2019 17:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wm/lgbt8UgPiSFagdUVIZrk9QyBEUnrf2iyDlIrtYOE=;
        b=S4ifeT8WpHduWTTWBMJ5/IB4z6MLnU6+xe6MtDqzk2d7WyCtQxc5bn3vUJDBJH7dGu
         uI0gm33EPIO9fDPhdHfabpd4iyJn5IoP+cPDqLth3u/QQyvhVtopePjoPs+l3TN00pOZ
         DPHAZH9tdaXHvUofZwVR6cTYjgYT21Mzj+GZbXBwq4dt07Gb1SIlGMOaSbm/p+jv7u8L
         WlnqDeCFsxXcZFcfF3DC5MJH20cbeoamhlQ9JaHKZ1c0aUN12Bs7aMsZVWtSTS/qsimk
         yux2caIcwEfMl6RGGTz9jwyYargf/PDhYYNjhT3YiarFdmtnv1jb5QSEHVGf9TOwmtGw
         5P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wm/lgbt8UgPiSFagdUVIZrk9QyBEUnrf2iyDlIrtYOE=;
        b=tRh6iW0/t3nt/LJVCHKRKVttB32oD5OAMKNQZXtueGKCgYiWPKErUSIaZYDUhSKOSN
         PYngR6AwCPu1+xJQeqCSljAyFYD1xVqX11AIRfzAsfc71uPb6hsHX/b1Vu1SL3l3pD/W
         lWxCldPMZMXkwmzpmt0Z7kX6SidjjTO3VLi4WpdUBzXNJ9WMGe1QZHwOJ3avUv4i7t2K
         WOr62B7HdYVf6bAdWHcEzCQKxqPgmIej+hshkCfL76kDoXTCHdaGEyy/ZWSXWUX+lFFa
         iXOxReAvozRQoWRKxG/H8rPeXydrLMeMZ5+jqohPREY6J9CUUCGu7P9fvXwqHqNlwCL8
         5vRA==
X-Gm-Message-State: APjAAAWQv6V/szdIX/nCSxSC5cylDYQv3N2K5tkZlLFtjF2aw1+2MeFQ
        ecAQbDUI7ddJsbmROCeZGVDA0fd3DrW7p8hRe04cfk58fpQ=
X-Google-Smtp-Source: APXvYqyq+lIou/dzFW7HIbKYSCX1X7ow2ZwptK43BfLYXRj2WtA/kVhVl2AWUW914rgyzp5yAjKmz4aLCA69YAjpfVw=
X-Received: by 2002:a24:c6c4:: with SMTP id j187mr2789805itg.152.1557449771972;
 Thu, 09 May 2019 17:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net> <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
 <20190502231537.GE202237@genre.crustytoothpaste.net> <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
In-Reply-To: <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Fri, 10 May 2019 08:56:00 +0800
Message-ID: <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
To:     Git <git@vger.kernel.org>, gitster@pobox.com
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

=E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> =E6=96=BC 2019=E5=B9=B45=
=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:15=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi Brian,
>
> brian m. carlson <sandals@crustytoothpaste.net> =E6=96=BC 2019=E5=B9=B45=
=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:15=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >
> > On Thu, May 02, 2019 at 08:35:23AM +0800, =E6=9E=97=E8=87=AA=E5=9D=87 w=
rote:
> > > Thank you for the support! I'll be very happy if my patch can get int=
o
> > > the code base. Is there any improvement I can make for this patch?
> >
> > The patch seems sane to me. There's less duplicate code than the patch =
I
> > started writing; the goto conclude seems to avoid most of it.
>
> I see. Let's wait for more comments on my patch. Thank you.
>
> Best,
> John Lin

Could you please give me some advice on my patch? Thank you.

Best,
John Lin

>
>
> > --
> > brian m. carlson: Houston, Texas, US
> > OpenPGP: https://keybase.io/bk2204
