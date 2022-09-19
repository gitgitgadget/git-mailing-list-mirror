Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64126C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 15:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiISPtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiISPs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 11:48:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5772CE05
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663602527;
        bh=p6nXP52za9HJPX97Idp2Pv3U1y64SaRPNRa0ikgrH3k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HB516n7muoq/Qf74jv8luDNFJR6/Qk8+TcDrQf+mIFnNM9ZHps0+QQuzZ4vfrfAKp
         Vad5lHd6yjIO5GeqZoQw/1rPMCj306Sc12EVMFwMy60Xgl8vvGCAWUdnr418S31Lgg
         3ip+QiPu6VzLWoaoiTGpJSwZXczMwsscJl7xBJkk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.171] ([89.1.213.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1pBHei0lFf-00bJzO; Mon, 19
 Sep 2022 17:48:47 +0200
Date:   Mon, 19 Sep 2022 17:48:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Derrick Stolee <derrickstolee@github.com>
cc:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH] Documentation: add ReviewingGuidelines
In-Reply-To: <925b1e37-17aa-9168-9246-ac48e043c0d4@github.com>
Message-ID: <ono01655-2r33-9081-q542-p2sp8r5n65s3@tzk.qr>
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com> <xmqqr10f88jm.fsf@gitster.g> <5685773e-db83-6b92-ff42-0d51e6e6a22e@github.com> <925b1e37-17aa-9168-9246-ac48e043c0d4@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:X8YKD0+eZYSmyUTrtwJOUkeZ9QBeeVql7DfyzNzBawqIOrrlz/k
 swKjVJ7rjLCuKJSRqO5+roIqZbM8ytivlNbIv//X1+oAsI94GOORxU4fo0a1alxuA0qg7pP
 zdgIlyQZ+4GDyxhrXBtgHtEr07WoKseLyc3lMX1iftrs3JgusapaKl1YvZ+xD2eOxkmTda/
 fbUEAatun+/fYmRSbeVcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SUTynnqcewM=:66PAWnzvaxJdqzoNFCC0gx
 54hXPuBMmfR7NqUQ+HUDno7Ekzd7vcbt4S0KxXNC3irqgG0LTB777+5I+GQMmxlPDQnYKNUZ6
 Oy1z+EwnfwGc4W8NVYI730CitTLwP0jBbIdQXomcoeW9QvJjBJPlUzTf71Pt6h4l5UytNCo99
 oCiF1QL2fBurDTY7GmeVLVolnUQANFk7m1Keeuw5j2mWZ8jTAcIpg6tOPQhIOxERfhjYN13i0
 5ObKF5R6Y95SY5jPw67ngF9jJ4zuMGn+xN7upyVD5JpAw1gDplTWKe5iqORDx7fVHCUqnDbg5
 eV1EjXRSKWZzA/ywjKLZeScodFg4cAZ/FAV/Xyd4Qout0NlEasWdtYQHU2INP6NAihTq7ix9e
 NQAfEAu2cVJTm3JO8d2n7GZDOTHrF97Fke5dC+5txQx9ulNfuJ8iXee+nygebG+MKhxQw+C5H
 GS33mP4td6imqtKvvReXQPc5kE9cou/gM52GkxHnTU2OknlhtxdEW/8vkjhUDItMvSHpOpgDu
 bewaUY/s/a+Ij9vbuHTvNyFw5c9KHVQxIDDm3l3zjVgUbciEcJ93VU0rPGDXRiorYGjK0sFG+
 Jj7OvhgCiubcYhAqQWHa7Mo8WCJg0nwaQffTF+F5lG00OSJNg33el2pV5nqXTcAcAVg1zmYxz
 ajx1Qg2Cye7nvzjK3/n5+W9wzNYGsl3csjMrSvYZscZSOsw9kaa3OSKHO6VPs/PXQfKkEw9Ce
 TjTQIIIhM1BnlDdZA1Y2odG9kYdt2hRCQ9j8j4xESOuU26PYUNfoJ9in/vPZPjQtfl7HCOSGm
 /sKsSWtJU8RufkuNOcSK6+4La/mQOh3hKdNWPWotSZD+lgM6SrLZE5OyneITedstwXXAtSwsZ
 9QqprOnxJTiXem/vpSwg2FwwVsbgIat+I/l4JjPSz1jJhheavBtJzSCzVnlXcAb6Igll8hCGN
 DQ3ACsy83hO7p635C4iDE0GLjAh1rBdTkEdKOwt2rqv9FtriajJgeSW39+DIVakAtAbiQJflm
 I2MbJg04UC31A2limYiNBRXqPx6A1J2IrSGoVhuE/rBJKsYI9bnJqmq37W1JfVEdo0LOKyIkV
 weBPW6FKUfl0S3kQIo3iY71LoXs2YG0u/TmVnr3V58Jg8/GwPcK3F0uaUpxEu4Osy4tDc8miZ
 L386ep6zf5FT0kUcl9LXxH5iCP
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 19 Sep 2022, Derrick Stolee wrote:

> On 9/13/2022 7:11 PM, Victoria Dye wrote:
> > Junio C Hamano wrote:
> >> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >>> From: Victoria Dye <vdye@github.com>
> >>>
> >>> Add a reviewing guidelines document including advice and common term=
inology
> >>> used in Git mailing list reviews. The document is included in the
> >>> 'TECH_DOCS' list in order to include it in Git's published documenta=
tion.
> >>>
> >>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>> Helped-by: Derrick Stolee <derrickstolee@github.com>
> >>> Signed-off-by: Victoria Dye <vdye@github.com>
> >>> ---
> >>
> >> I've commented on the text but haven't seen anybody else reviewing.
> >> No interest?  Everybody silently happy?
> >
> > My guess is that there aren't as many eyes on this as there might typi=
cally
> > be because of Git Merge.
>
> Yes, Git Merge took all of my attention in the past week, so I couldn't
> chime in at all here.
>
> My "Helped-by" includes some small suggestions from me, but mostly I
> fully support having this kind of document. This one is an excellent
> base to start from for future augmentation as we discover ideas that
> could avoid sticky situations.
>
> I particularly like how this document assumes good intent from all
> parties, but recommends over-communicating to be sure that intent is
> clear to everyone.

What Stolee said.

I really like how this document serves as a great inspiration to align
actions with intentions (answering the question "How do I craft my review
in a way that the reader _sees_ my good intention, too?"; Sometimes there
is a disconnect between intent and impact).

Thank you for putting this together, Victoria!
Dscho
