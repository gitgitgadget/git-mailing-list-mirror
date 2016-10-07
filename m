Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD6120986
	for <e@80x24.org>; Fri,  7 Oct 2016 14:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbcJGOLz (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 10:11:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:51449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbcJGOLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 10:11:53 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M4WuC-1ayLwh2Xgy-00ygKZ; Fri, 07 Oct 2016 16:11:35
 +0200
Date:   Fri, 7 Oct 2016 16:11:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
In-Reply-To: <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610071519450.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-843164819-1475849495=:35196"
X-Provags-ID: V03:K0:OAAy3g+pwxj+Zp1B9+KZGV4tz5qRV3YF1gzRWQoy6wqNz6qUmzM
 kpqbv0e3ZIIovB9OBmmKyhiFR4xfHDCJbr6NbaiddA9wN5s6/J6COKHH+lWduad24rQzn6y
 V/Tap3Z4w1E1qK1YTBDbI8oCY0dDs9Io3acQ2VkW+t8DDQn+no0WxXwepvhbnXhEOp34cDZ
 DXV+pExpAlIp6wwqbzUCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sotPijzXJsk=:CqADjl1xnP9itm0D8aI61G
 tkk9bYkWRmiGyh6g7uMfAO2yCWIRBRGlKcsRyOQatDK0D9vywD/+mNNkrJ9s+r6PGIAHXM3HB
 nDcs7rYr1lNDR3CD/Y9HIqzEd5xDLN09e4q7zUB3dCU/mpuf0MD6Eubx2w8D9UOKxUJCJPXcP
 h/U9XTwa4A0UBC3b3qjL34pvRgxlEoJC+9l7uF/7Y6vMLp97vv3p3KMxl/JNrVobXyrXFt/I0
 A7sDcIZ058pK3tkWi563bRtKPXPmgZUOxGEirNt3icfz8BcQ51lLbsrrbEGXg2BENCXOel8i3
 m0mTOYBTB88lXtgWQZas4WELRfbSxvG7BF4l9/X+4g2bm7qvBXkTUQz30HoLhwy6/J4Mq/W4t
 1v01YYIITGavOuogOEwcxaacdXEma5smie2Sm8fNydw1tvO/IZORUnNUW49aEKm9eYEt8/toc
 RvMgO0+k9chbpNFCKMEeeU9qQl+pApukI1kHtwbfM5gGasr7AzVLrPfB/JX9PkgjZqrwZcSdK
 Y+B/jZ7ukD//Rapw9uXGgeJ+TjZjE9YFzkSGk5MNSSOBHaQTAQ8n5hMobp8pv4+6U5hDG16IB
 64kr0+/5zTbTQUn/fScfejNHdGm8vv9D66c28YDelpoG/n+UO1kV3NE60XlBNqIkZdREXPm3f
 FWD3I5Qb/BMC1PaIFhSg6G+oWaZitZ93T2Qv8TAG/eg/vtx4K/+b3K/fIWkbhSX9krMFshQny
 wdrx7ZtZis1xzkB3G5GB8LlofjQE3G8AwKzj65fvSQmOnZbOMEMa+Q+br91qwPp9oBh4y8zm3
 j8W5xhq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-843164819-1475849495=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Fri, 7 Oct 2016, Duy Nguyen wrote:

> On Fri, Oct 7, 2016 at 6:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 6 Oct 2016, Junio C Hamano wrote:
> >
> >> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
> >>
> >> > Throwing something at the mailing list to see if anybody is
> >> > interested.
> >> >
> >> > Current '!' aliases move cwd to $GIT_WORK_TREE first, which could ma=
ke
> >> > handling path arguments hard because they are relative to the origin=
al
> >> > cwd. We set GIT_PREFIX to work around it, but I still think it's mor=
e
> >> > natural to keep cwd where it is.
> >> >
> >> > We have a way to do that now after 441981b (git: simplify environmen=
t
> >> > save/restore logic - 2016-01-26). It's just a matter of choosing the
> >> > right syntax. I'm going with '!!'. I'm not very happy with it. But I
> >> > do like this type of alias.
> >>
> >> I do not know why you are not happy with the syntax, but I
> >> personally think it brilliant, both the idea and the preliminary
> >> clean-up that made this possible with a simple patch like this.
> >
> > I guess he is not happy with it because "!!" is quite unintuitive a
> > construct. I know that *I* would have been puzzled by it, asking "What =
the
> > heck does this do?".
>=20
> Yep. And I wouldn't want to set a tradition for the next alias type
> '!!!'. There's no good choice to represent a new alias type with a
> leading symbol. This just occurred to me, however, what do you think
> about a new config group for it? With can have something like
> externalAlias.* (or some other name) that lives in parallel with
> alias.*. Then we don't need '!' (or '!!') at all.

But what would the precedence be? externalAlias.xyz wins over alias.xyz?

And we still would need '!' support: tons of people (including myself)
rely on it.

Possibly a better idea would be to use *another* special symbol, one that
makes intuitive sense as a modifier, such as:

=09[alias]
=09=09# This works as before
=09=09xyz =3D !pwd
=09=09# As does this
=09=09stat =3D -p status
=09=09# This, however, is different:
=09=09duy =3D (nocd)!pwd

This is backwards compatible as "(" is not a part of any Git command, nor
of a valid alias, nor is it commonly used as part of a git-*
executable/script.

It is also kind of a bit more intuitive, I'd wager, and it is also
extensible to future options we may want to introduce.

Ciao,
Dscho
--8323329-843164819-1475849495=:35196--
