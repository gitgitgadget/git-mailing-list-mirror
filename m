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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FEB51F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfJKWHA (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:07:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:42549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfJKWG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570831610;
        bh=UatVRqMbNKkZABjmy4NKvXh1dUHpb2DUs8mDmG7MK1c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JByEFGuPhHmRbHkB3RpcoqWpDNAyQKB6AFv+yC8jKEEnusEVp1QKlTGX9oELs3lab
         RsDQZKA0uIdLjJi+jwjzLa5du1/idtZcDwaG8VJ+c6RbkGi8p7pnZZGKQe8Ny9RftV
         RMmlI/jBSdhjvhCYBiGi2V3H18Zz8biO0BY+Wl/w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1hrNjy0iGC-00h3MA; Sat, 12
 Oct 2019 00:06:50 +0200
Date:   Sat, 12 Oct 2019 00:06:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in
 our Azure Pipeline
In-Reply-To: <20191007160816.GB74671@cat>
Message-ID: <nycvar.QRO.7.76.6.1910112359560.46@tvgsbejvaqbjf.bet>
References: <pull.288.v2.git.gitgitgadget@gmail.com> <pull.288.v3.git.gitgitgadget@gmail.com> <xmqqimp26808.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet> <xmqq5zl15q1c.fsf@gitster-ct.c.googlers.com>
 <20191007160816.GB74671@cat>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7fv42DeBEf6SaR/BzQ0dfn3ZP18TA7bePiqsHM/9Uy10Wvrn6nb
 UfJOg+jjhZCZDX0aYIQZC6EYN6kzuIKV7FDlwChzJSIGI00r5yjngyAj74TCvHvnNA5A6gH
 LqxwbyEuKAuHZxqqXI1PC4rnE41rnKfQ/t1FbVf+EQ0KaOUbHMQ+L1yMwnCl75K5BiaEmV+
 hFYnTxV0Zu99Kqo0dUQHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ss0dMQyzGwE=:D3obiu0IVr+7eX0EwQW8Wu
 6Skj+ukP2q1GSi1MaXl89lJwKnwi1Uho4nAU1AnO1q9VjbCZ/mv7qZ9qXq/PiyNe78BDQw07+
 lzqMt/T2HaOqbZuEykWENWmpSLYrWV9W17znGBIg0h0cdTlAG1/+Bih3VcMJhcAQ4XjPFvqVx
 alIiS1td+OyiLWiklSQh+u5CQUBuscuPFr/SjrEI1UUw1CVx7A36vngS3769rusxcz4+g/MYh
 m/O7ZULGhvIP43Fj1+GJtkHBCKw38azjyh1JZazJ1rttNpQY8FVgIUiU6k63kdJAImu/1AmJj
 OctOWyEVE3XCeCxDGU+gIpmjHJH33m+Jgp3XvAC1gDOmvQRrgUw0mdMYuFKALDMiMi4BDdlH9
 nQ7UFFRh4EhGXE+hfQYOHN4V7p0M+kbr05aCJufAdic115U5iImq2RSHk/7+JBl+c1U5O3HCU
 wumUzK3ZNTQyDuissqEEdKYeP7JSWR6WJzMGOwBWdpOiYQwlxQjVYJbuZw0faBeEinhwIDoad
 ohWi1hffbq3EmRbi9CkJ5GWni0Y9SmBbPejtM5fVrccu6G1JUoUJmyurEeaOxdrX5Dfr4CnkE
 F+fYF+0pBTWgK9lCFEkwhFSzrR4lqV+EZGoT0QVwimEZGHwVkeeZbwAkNTqzZ87RewjcuBOAv
 6J/Ywd86rsvmwU3ycUEiOt7QBQjdRC1/KPzHqGbNbaoos2/ydUcoC4ffBi5qWvumoi4gS71AD
 Yx4eQDQECq7+xsRw8pyYH7JGbusIz9qIPC23fBZSghUGnTbF1+fItyGo/oA6nY8q+JUcw8iXj
 bHJzj5KwBIc0rVk3mYpuOiNxYWBB/OU+bEmFA9g/Da0Il9kzryiJ4c1QIVwFr9MMCNW0rz+nv
 IPsRF1HisZY0k89Zds7eCeGuzRZw8U/GfdygLDijaovdrQK3EkTln4e+m6LJobiIS3abbuvJJ
 QE+VW50/fEs9x42RW0kvOhFD8peu38uZTN8x5riSuzDkr2vjr9qX4EnJvahZ8re39jFMdLaPM
 vbQdngW7RPsTerx9NaNDYzGU4QTh9zgpqHM5v8ZsHugZJpA1HDU2LUuV6MwOiXBfL++dK3VCu
 lbhC5MHHv1Vb4KJJVNeiv++dh9GeMAGx7I3n7K0xZDXIVGW3ZkQCOLacIIupSwlJHu4nKsi5l
 W4b8h0ulgvaIuQhL4Vd0vgNTVXWgiUVc76fQDNih2k/M9dWB0Jm7w5l2PlKo7xdo8G/XzVyoM
 6ckqWCm5+K16fAxrLfkloHh6N8z6hXNxJqBA6VfEfnziYP/el8hS1lvMHdfM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas & Junio,

On Mon, 7 Oct 2019, Thomas Gummerer wrote:

> On 10/07, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > 	Date:   Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
> > > 	[...]
> > > 	X-Google-Original-Date: Fri, 04 Oct 2019 15:09:10 GMT
> > > 	[...]
> > >
> > > I am fairly certain that the latter is the actual `Date:` line sent =
to
> > > GMail, and GMail just decides that it will not respect it.
> >
> > If the submitting program said "Fri, 04 Oct 2019 15:09:10 +0000
> > (GMT)" instead of "Fri, 04 Oct 2019 15:09:10 GMT", that would match
> > the format the MTA produced itself, I guess.  I am kind-of surprised
> > if the problem is the use of the obs-zone format (RFC 2822 page 31),
> > but anything is possible with GMail X-<.
>
> Yeah, the obs-zone format did seem to be the problem.  I just dug up
> the previous thread we had about this, where I confirmed that +0000 as
> the timezone worked just fine in my setup through GMail [*1*].  Note
> sure if the (GMT) would cause any problems, but I'd agree with
> avoiding it as you mention below to make sure GMail doesn't do
> anything funny with it.
>
> *1*: https://public-inbox.org/git/20190318214842.GA32487@hank.intra.tgum=
merer.com/

Urg. Sorry for dropping the ball on that one.

I changed the GitGitGadget code accordingly (here is the commit:
https://github.com/gitgitgadget/gitgitgadget/commit/6117c61be5c2d13b46229e=
d12b2a9f63ef80f3c9).

Thanks,
Dscho

>
> > How does send-email write that date header?  Matching that would be
> > probably the most appropriate, if possible, given that GGG was
> > written for send-email refugees, I guess ;-)
> >
> > Here is what its format_2822_time sub does, so +0000 without any
> > textual zone name, it is.
> >
> > 	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
> > 		       qw(Sun Mon Tue Wed Thu Fri Sat)[$localtm[6]],
> > 		       $localtm[3],
> > 		       qw(Jan Feb Mar Apr May Jun
> > 			  Jul Aug Sep Oct Nov Dec)[$localtm[4]],
> > 		       $localtm[5]+1900,
> > 		       $localtm[2],
> > 		       $localtm[1],
> > 		       $localtm[0],
> > 		       ($offset >=3D 0) ? '+' : '-',
> > 		       abs($offhour),
> > 		       $offmin,
> > 		       );
> >
> >
>
