Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBCC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3969D60EB1
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJTMEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:04:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:37779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJTMEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634731324;
        bh=H44zM7TL8yloJfV2FXYZMSueRJC4s5vT65bg/gQFTI0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DBJk8kBDkeL5tc4etA4Jep4ELgcwBdO9GPNnGhQwXVW1Gk4S5up+DZ6eqaydzJQZb
         +xsCsf3AeO0Kngamab5Pdn0pRfoptQLqr6ReuqsdrTOR9T4WrEgD3M73hEZXQd6ImI
         AjDjv33poBW4DgJfmrncGnA7t5kmJSWPZZDoUDEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1mvWUY0Jta-00rYZb; Wed, 20
 Oct 2021 14:02:04 +0200
Date:   Wed, 20 Oct 2021 14:02:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] gitfaq: give advice on using eol attribute in
 gitattributes
In-Reply-To: <YW9wgbN/b8NkVp4z@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2110201400020.56@tvgsbejvaqbjf.bet>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net> <20211020010624.675562-4-sandals@crustytoothpaste.net> <CAPig+cTn4fZtssPrn+z582E++Kdc2+z+=iNtp2kodR=QJVeycg@mail.gmail.com> <YW9wgbN/b8NkVp4z@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SKXhirj8ZMJnZjGR3jZm+dQ2BjVz1q7VCW9B574sKAlpL+K++sT
 jZYjsvJWZ4xSDOxV4vmFgC88yDuJfbOuZjU8agAyxQld9E+Y4r9UDMgvUIse0kqVKlBKhkP
 wSfoF7/vXwLuKoyhe5JZI2GwpXfAs9ksZhGn32QMnBXYIMWHCyMVmjdSA6Pe2czVjUHXPCq
 F+ySB7MUSe9YiW5MkYBiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e9kCFMH4f6E=:Umhf+4cn4Gl1UN+bLXCZ91
 1I/nQMAHBgDi2/u5XYhl+IamSezUO1NACCkVlWgH3V160Vyw/2HsgotJq+C05ithgVbLmM+Db
 LVFTi1Yj2ua5L1XRFynA/po4c0ct6PHgtyYZ1lF4ByY+HIxpAPTdA1wGto8EecWJge7RK+w4G
 G7vQVOBwUhtqibEe1dfAx4pQ4pOtr/t1EvHdqy26Eqx/yAd4KRiJ2qfd6NKUIDUmwEeCF8UFh
 DbjLaWQHeZhOPBl8wETzeymt78ApcZqGR1A3COVPAnBEvq0I5uvKyUhIXR+FQL5KVQqTDbWV6
 +6ZsTrxe9JbHOnqazkpDJtIp3F7KfbYvqf1smjjQuMKDP8L8LgMqnHAbxdMlx3HS0B19rUK3I
 mO+dJze+M4TSXiART/sHlUx5vlszm9aWyQg6cXVXT2/R3ozYKH5THUpyohGZiuwK9Qp7K3XW6
 DgUZpxCblJgiSOAu4UR66FDHPpwCj6OGsenQLyPPuYgZCBnLYUvUMzsUBToR59rs2W0oWKnay
 Nwso2Xx4ThqjT1+FZRgBhXmhHLK/wTbLyEwD14Ti4lahAAIkZBgKnTTtnanfYmBxkqOyPAvPr
 XnKqriP2fWjG6CYhjFYXjEejk/GHRststbSbfDh2f+a5n1QLj/dJHCGCONi9XWCBJCfhR5h5x
 dLexde5i3drtS1zi2zK4R4n4J4unnA2CxWHEw8CNAXKPI6Y+PK1+8xdDYNjHzs8k+WpAiPCPg
 0BaLBv2EfWFBeOUWuq0YZYKnFOE4NzvOaBfzzb9NsPyv3uKaN5ZYEErV5Lzop9pTwoRnV7sDJ
 Icw8GyCsr+Mv1PVna0dhR7zABKpT67YGc1Sy+ADtSklrZ31Sxh/8msmLPoY4IOynaCtSePO98
 9Vp7zh49uKBgHuPfK6OAMQ/2BSOSU0iD46geGwqvW4UeWb2NrDrnD2hIuYAXRgtGsEWUqfCBF
 CX8UYSrn1DsaSdlsaf4c0mPyTjVw8hpqP0iHb4Mm5gWQ0Li2rAfPDT7h7Qf0Mt9yZ08u68qRZ
 AgpQz0Oumr8WMMVdh0r3BubcQnUGi1aK9z33+Tiu5uQ3Wjs4zifyxAVY3MQ3WXrLoeSF9wMny
 q7n7R+VavK4F7U=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 20 Oct 2021, brian m. carlson wrote:

> On 2021-10-20 at 01:21:40, Eric Sunshine wrote:
> > On Tue, Oct 19, 2021 at 9:06 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >
> > > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> > > @@ -464,14 +465,25 @@ references, URLs, and hashes stored in the rep=
ository.
> > > +With text files, Git will generally the repository contains LF endi=
ngs in the
> > > +repository, and will honor `core.autocrlf` and `core.eol` to decide=
 what options
> > > +to use when checking files out.  You can also override this by spec=
ifying a
> > > +particular line ending such as `eol=3Dlf` or `eol=3Dcrlf` if those =
files must always
> > > +have that ending (e.g., for functionality reasons).
> >
> > The first sentence in the paragraph is unparseable.
>
> Yes, I think perhaps I omitted the word "ensure".
>
> And I should reflect that they should have that ending in the working
> tree, which I neglected to mention.

Please note that Git for Windows defaults to `core.autoCRLF=3Dtrue`,
therefore this sentence is not completely correct. Maybe something as
short as "(except in Git for Windows, which defaults to CRLF endings)"
would suffice?

Ciao,
Dscho
