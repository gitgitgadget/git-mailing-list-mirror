Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6EC1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfJUSpC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:45:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:34573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfJUSpC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571683496;
        bh=Q7q6V75NRqU9GGCZeoBPMRUfkS3Dt/ynFT9aVI4sA0Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EsSUNknHPmfC46ybbs/C82ZgyHwjAmu0G7GmEU25/MzfLQJPvXUrJCr6lgzQBi4lp
         XsKlB3MS+GEAVBWlz7KfC7d2Dw3gJGOuXwbOWYs6MQnCnOLJUyCZVuLs1futZv5HfR
         GIWQ5Wl1M0e7QBSR6Z1xxDgr6anP4RsWqZBcOFbk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1iPcx30DSP-005rdW; Mon, 21
 Oct 2019 20:44:56 +0200
Date:   Mon, 21 Oct 2019 20:44:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
In-Reply-To: <xmqqimon6yar.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet>
References: <cover.1571246693.git.liu.denton@gmail.com>        <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com> <xmqqimon6yar.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aras8c779Pgy7vvIBk/i3hdjY3YlXy4zptuoeCrdCg+gD5AAnVd
 W1Umena1iMwxQ0k4tZyzbOe+jLd95lAdu8S2vWAGZOL98StYxhVGGtnQC1uLD3PTKYyLjO0
 MJFxJExteXMHZdiPr+ExYJn+fzF/zQc/p31AmH3yYoMUCVZ30x13mmY7IWD2ulQgUskZbgC
 mrz6nA1hX04w+hDK/1yMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uMqot5ESepI=:yYBifdUbqL0Yv/oYskk7Z2
 eopijAm4MWRtrY6ZIQeP5u5KN00ShNvjTTL9uiGD0jOV9YYvKI9ZOc9h0iFpRkouVITETWtPm
 g24i42SQ/BsNZj08FUzoxc4hqFkrocww0SBJ+GNLknB3Qa+MA9i0s9vZlz3TYbDfhg2Jg5Kg4
 dNecILn4VpNknWlUQ4mad12Jz5+80yBqX8wBcFR2JSjCy5SfO4Ca27USynGN57euPQgT7QEMR
 neEw6a6PLJxHxmk+liafYrvDhpl5alvadm9uDtCQr06CoHwNteJvUhpTYUMvA5JojTIQMqyri
 Bk+o3rCSRVnzeI641QknjTLQiswyLmS0QrEhwFt2Ikff/N6dftHyeWXbN/B7YSftFet9qWIy3
 latmMS87cjajg1obQB0aNXkK7ZEkYBvNNd8ugVxTSzq/J2kv8b1xfkQu/s0oSiHkuHYpH2hBE
 WDyuL8Vzv1Tktf6mB7zRuKAR+YAQhfer/ppY7n7CzWKbji3qtFwchHXkCQxp4Q30c2M9rznFc
 bMjLrIVLRQhCW8QgapDaIste7Ypf0GTOVulT1DoYeO+FeKdw48sKd3vrRErY7JwSIacEEYjuf
 EVxDzIPfhWDhfmtHI3SpPRnRc48v5/+pb8wc6RaaujesS4bh4IOvPNu5m1J8pzJqh+/rAgA7D
 B4ctvbAsey2R+cZnsb9ty7XIc4aMPt6AtsmVb+fKadPj7Nvv7Bj+ZimFN2PhybcHTTqTayh90
 ECKrJrlQSx4jZcBTZs6o9m1y8yRAhNkjmPLTzwXwHQIBlrE2glc0o1VCYwbZI2zwrooEwJfdm
 vuXhkRilUjj3sHb8vflR65npHww6sc5nlFGUf0V+6efWJN4uDo6NqVZd0wrSSrPZVanv4O0sD
 eNkJ44+oqfkXo8wtGNOiVujXPHVMrdWdeA30hvMUPa9aHoGmUZYQ4xBbmrC8+SkMUMxlPuhdQ
 qCb9/Xn7Pj8Sq1jNWZ/Z/ign1VNCy1DjIowlCt7gljOtvU93WJMdIsxqg01mOOLYWlRZPv5Ka
 A5eW7QdPuXruixk9n+hex64PVUqVWiv9wtmbM2i1oBs7k1c0SVtzIfw808jZDCtTogYFeKV7p
 sd4A8lqxCJZDzXjhQ7SAjqmSR38vxtmImOlsYs7vle86dUBEN3oTHk+DDAUhxz9JbSfa3u7TO
 ZueNB3cQ/S9lON7ZtIHC4NUqfqT5fJnQA1vJ3GE0+SX69FJEUIEeFOwLJVMRKAHtkiHDNj91Z
 U6jy6i6j6X7ts8A+p4NnPazPUKZgL7BY1NSDTQGQO88vspGQ1ZQbhfPJW0TM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Oct 2019, Junio C Hamano wrote:

> Denton Liu <liu.denton@gmail.com> writes:
>
> > There are many +=3D lists in the Makefile and, over time, they have go=
tten
> > slightly out of order, alphabetically. Alphabetically sort all +=3D li=
sts
> > to bring them back in order.
> > ...
>
> Hmm.  I like the general thrust, but ...
>
> >  LIB_OBJS +=3D combine-diff.o
> > -LIB_OBJS +=3D commit.o
> >  LIB_OBJS +=3D commit-graph.o
> >  LIB_OBJS +=3D commit-reach.o
> > +LIB_OBJS +=3D commit.o
>
> ... I do not particularly see this change (there may be similar
> ones) desirable.  I'd find it it be much more natural to sort
> "commit-anything" after "commit", and that is true with or without
> the common extension ".o" added to these entries.
>
> In short, flipping these entries because '.' sorts later than '-' is
> making the result look "less sorted", at least to me.

The problem with this argument is that it disagrees with ASCII, as `-`
has code 0x2d while `.` has code 0x2e, i.e. it is lexicographically
_larger_.

So Denton's patch does the correct thing.

Ciao,
Dscho
