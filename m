Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8957EC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6597E20835
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VWweCBMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFLOi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:38:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:41263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLOi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 10:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591972724;
        bh=dLrq/HjR9TkRqy4bZPSUlBFI5LtB7Cgrmm1bcPSsYkE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VWweCBMc8NKDvdNxW9cclsytgc+3LTHSJP2iJBngBMQdXB9P3LVdP11EIj/0jZsGt
         Rk2rX5blnqBI4OrUKnqiwUkCEQir4Tb6W/mdFgODqbMC1dBKrP7KgoYDGZNMdrmzoe
         QkaIMfLXuUFjFTgmY9mtvHz+CUMy9y2efvv2g3cI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1jOwfw1fr2-00VuDA; Fri, 12
 Jun 2020 16:38:44 +0200
Date:   Fri, 12 Jun 2020 16:38:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Virtual Inclusion Summit
In-Reply-To: <xmqqh7vhbp5h.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006121637080.56@tvgsbejvaqbjf.bet>
References: <20200610222719.GE148632@google.com> <xmqqwo4eedwc.fsf@gitster.c.googlers.com> <20200611011040.GB21728@syl.local> <xmqq7dwecpsp.fsf@gitster.c.googlers.com> <20200611023503.GA24130@syl.local> <xmqqh7vhbp5h.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NQI45uHCcztMvw+TvRodx0r3w7wW88LFkCw5/Gj1H2ftxxWLryI
 Dg/mGZK6CkItv8a2G0nZI1JUKP9eR7xG7SG92j7CRE/zFCsoVmatq3tS+sMGLYRLUW5rcDN
 IsOLSguky/ZWSC6sh+OE77ZzuBazI61W3jKz7r25iGJU95s7cFDtx70qtaABVvBtw9rB8Np
 db3fjMuQoNgZuFCXL6KgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y+mJ/QPoHgo=:KL5mNXNMxwpfH5vHR6Cvpp
 TwVLKT+cgTrSPJSHZsko1uPuU43X/c/YKYpOD0pjW0Vumh+8RAB2Y7ZA13d+ppTf0WWRxMZs0
 pxdO4G59UhuZ4vtmXuYQEUSt5s1Nq/h6xrV0CoXl1icUSFSp/4mmcI/jqmDG5d/hjydnnrcP2
 e2SFvWjZTWK3DHvS760BAVa+6HtivEBi2sNVh0Y2JDNMJpzLGXrguTZrG6dpbxOISJXgAvf02
 mNnKDxi2R6xTWJkjZ+Qf3FL2VF8f3ChC1ot1YKERNQIofyiVRBqNAjFJRFSUB2yi1YbsbcNsJ
 8rsveOi660wpyE+Up3bEFNay7Mni4ok+Ag8raHZv6DOMMpgrhZcPSGoSFBZVy0CCuJmYrLqck
 IeuH/bK1CJQA6pLCcJHTxbmM0ql6HHElkgtjwtiriXbnUlJQKDkMcAFuxtqnO9pheaHf8DhXZ
 lkk34U17B5zlNVHwIqN3YKpkkGfIX1MFbI8mVS+hmWSbrMepuPK7vCy+067mcsvwEj9SJ1UsS
 3RUHqF2o58MZ/+K+Yx1M88jNixlTsExAKKeAVJ5R+45L8HGeoLU5291Z3zK1GIhVwGN7KhdzW
 gacBGxx41mA4G/0wrwdDfPWnLhMLirBHi7VQhlhUi2zMYB/x+wg6FEm8KaNHW2xbSzrpI/H9E
 0t7E830NBdjVZcirwig9N3JS1Hu8s4Ir1/FKH9/2qqSWja94COTsxfNXhYpJR5JpytFcJuY+n
 vhoqKB/wuwS+sN90LRc3YEf/R3hqI59Ri0Zlt95fkNez+a/uZkyai8FDBQoESFh68SbcfObS1
 Rg6GZYvQTufRovSEXpxzwEZ22tdNJt+54U4U7H9u3G9XljjvlNrMbmXAYnDP2gDIX1lBlyoA8
 TnOn6l34TYYlkSeudU7z6enEduR9PerjpozCPlm2JlAWAi8EEOunLt9QP6/tgYvX43OOPKIoU
 LKzb9jYNbjowTk8fXQWkIvgW0qlX1Z2IA9W/e323+aq04Z1wBKqea0xWqQ3D/qiLJyKRrtaOC
 OybnEmZ06i6hJ9cJbQf6Y1LJkNkMq1Hiotzq5LuAHo3mNIsCYx+3CqH+ltlt7Craov+HWtfPf
 25dgCrG7DwaAEkBFSIRoI6U64TPcFCf66PM/6WRv1FUW9KthgNxhwAV52NvhHffsKNEFjUJ0l
 aD/gyZt16qVI6MHy3TT1wnI/7h4DBtxKuLWA9upRv3M0IQdL7e89x4W+Qnthoe8cwQ1/Adswl
 nhg05waqdZxqcs5ex
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Jun 2020, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Jun 10, 2020 at 07:13:58PM -0700, Junio C Hamano wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >> >> It is OK to have an optional meeting in the hope that a video
> >> >> meeting may have a better chance to keep those who easily become t=
oo
> >> >> aggressive and confrontational in text-only conversation in check
> >> >> and instead have civilized conversation.
> >> ...
> >> What I am hesitant to see is that such an opt-in meeting becomes
> >> "you got a chance to attend and have your voice heard---if you
> >> didn't come, that was your choice, and whatever objection you give
> >> after it does not count" summit.
> >
> > Ah, thanks for your clarification (and sorry for the misunderstanding)=
.
> > I figure that any synchronous discussion should augment the on-list
> > discussion, not replace it.
>
> By the way, if I sounded like I consider this "virtual summit" to be
> no more than just a place for people with heated head to deflate
> before having a civilized conversation, that was not my intention.
>
> I do agree that it is good to have some gathering (or perhaps a
> couple of them in shifting time to accomodate people from different
> parts of the world) to help make sure everybody is moving towards
> the same goal, and I have nothing against a virtual/video meeting
> for that purpose.
>
> Other than that it may be held on Zoom, where I do not particularly
> like to send people to, after seeing articles like [*1*], that is,
> but there may not be a viable alternative.  I dunno.

I heard that concern a couple times. The only reason why I suggested that
platform is because we used it last September, and it worked reasonably
well. And that really was the only reason.

Ciao,
Dscho

>
>
> [Reference]
>
> *1* https://www.ft.com/content/f24bc9c6-ed95-4b31-a011-9e3fcd9cf006
>
