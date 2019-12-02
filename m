Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED0EC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C888420848
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="chbxMsCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLBRCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:02:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:59577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfLBRCd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 12:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575306148;
        bh=egHBWirv/z8sK1o8WhXe07/tbiJXsR/Vc8c5n7EsTao=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=chbxMsCuFhgclbodBvTURXZwV++ZYAP4pgipqOeXMxT4P3wGSwARorA+hKknPNrni
         0I3cYDXEnliTg/pjZHwfnZqbij7scum3BazesptXqf6u3cDv1ePmkIB1QAloNITRDe
         yI4IdB/r8fb3KqEExVe+L1HXDBOF1feS+YQcrgm8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1hscpl2ljJ-00jWKL; Mon, 02
 Dec 2019 18:02:28 +0100
Date:   Mon, 2 Dec 2019 18:02:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] pkt-line: fix a typo
In-Reply-To: <xmqqr21myfrz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912021801350.31080@tvgsbejvaqbjf.bet>
References: <pull.481.git.1575276191.gitgitgadget@gmail.com> <df82efe896aea1fd5ff597b3fad772aef0957d2e.1575276191.git.gitgitgadget@gmail.com> <xmqqr21myfrz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OrUZRsOFp9JO4EIwRKigAa/UJsC+EawG9EaP35Wmhq9/tSX5w2k
 ubGFAWfB1GNPs9CJ3VAfX+iQQw+8FC50L9RvfjdlnJUwkCY4t97dir38iRf56qMFj8OVWdz
 90ifBmPsMDe2hNSCXACUSu5ysZ3ehZraI3c7J7x65w+30lCf8z4fOP6A9pXcsQFo4hvDvt+
 zmS6rnsz8apBxDnO8H+Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKox1qZ7geY=:gfdduKZCmY+Yctkvf10zDX
 aCVlY2/S7XffvBc5TaYAd2v6gBuPIMbewYapOO3KmrJziduuos0BEsmofohQ6Cb09iMFI8MKf
 NB1QvG6QXuRR2slOl+AdZuA/nloV/e/R6xrLl6JB/tf9KL4yRLfBN1zofZYjpE/SXuS0ZvjFS
 XpGDpsfhAldncGP9Do7zQpkBLqgCpvpGcmdggKpAOa1z8uRzcV952Wmh/VcIFCeCNIlygqmUI
 +WjqQqeBG2F1SuUT4I+XfuLqb7WjlBMdOIjDEeWYuu84NcAzTQo5J0ym7+IOnY/isxzcezYw2
 90/i7JodmcCjApejWDtM5eImddQFiKu45WGRm8GkT3l//IdhPe3QWmkL79U+fephBjnNTUrk3
 zW9ep0di1bNc+6VjVKgN+lUdpVxKN6CGoYC+cf3Bx7EjsYpH58+89doTeYaZO57cx4KWG9Jz2
 MnMBe6eVKm4UGThpBISOzzqtQUqNHZDGDZoa0smNkP+H+ZB07qS+1PIdUq7q1/cXW1aY1yVfP
 0Pabec6H9udXHxn/S4p3OIQcx53lymeW/gioo9ACg+icTvBD8dsku7W6IUXWa+oe2mPRgQett
 TZkZQKHYOm5jMsgFDF8H1aRIkawyJeiGXiYKmTTq7AFjt5k97Q2KI2OtP0fQlSscYjC0T2y+/
 YlF+/jba0Cz+g8uFx96Du/zSOZU5/fRFJzliEPKjm/yPGl5dD9BOE+bBovekuE2o+DZUzYsB2
 I9iKZ5DtfK7vkGgMtET2kR46IU2sXuWv1HC0SoDeR0koQJJtJHavlhhSxl3pINjN6/1YU1FQK
 FNeBGRKn49YF3BMXHjH4WeHd1hB1WOsp/X7OA1qOIRw3Nr+HGboqbB3oollgTed5DtoEc4QN/
 2fWFdRC57ABx7GcB1xiHerAGAkKfoN7OmZ2bJDLZsneeimNsggyx6NGkrWglkURx6ZsWd7ce8
 4I94Rc7omaf19U9rvQoQO16Ci9PafY0yiD1B5JJb9EaZwKakpzTRHP9NLvdkOXs71L/7StC31
 mlp6kKJfZevvwOO9bLy2yHmrAIQFIqhWvf/GCiXnXxETtTicsDjdOggRlGjGzoGHNcRuvaMdP
 pNVy0bBX0ukY8ZQgQPjgypVHifXEJU07Du86v9Diz0sYUpuCn7dsFAmSzGloZnDEKkOKZ4HJO
 FBhiLL4nyOqvPDuydfgA/0hoe/bTY47VCyfErxsVbdndqRRB/jSIvkOE7uN4bV3IUe9g2oyiW
 u04/f8L7H6AtY1RjHYwPYb+Erv5iKpGXip0ASDXwEkm5SMqC8wY6SyjvY6/c=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 2 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This typo was introduced in 2153d478b74 (pkt-line: introduce
> > packet_read_with_status, 2018-03-14).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> Good eyes.  Will queue.  Thanks.

Heh, as much as I would love to take credit for spotting it, it was
actually cSpell in Visual Studio Code that spotted it ;-)

Ciao,
Dscho

>
> >  pkt-line.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/pkt-line.h b/pkt-line.h
> > index 5c62015db4..fef3a0d792 100644
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -77,7 +77,7 @@ int packet_read(int fd, char **src_buffer, size_t *s=
rc_len, char
> >  /*
> >   * Read a packetized line into a buffer like the 'packet_read()' func=
tion but
> >   * returns an 'enum packet_read_status' which indicates the status of=
 the read.
> > - * The number of bytes read will be assigined to *pktlen if the statu=
s of the
> > + * The number of bytes read will be assigned to *pktlen if the status=
 of the
> >   * read was 'PACKET_READ_NORMAL'.
> >   */
> >  enum packet_read_status {
>
