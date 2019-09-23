Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DBC1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 21:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503102AbfIWV2m (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 17:28:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:53535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732345AbfIWV2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 17:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569274101;
        bh=exTvJB5KQH6UOtLqSpjoU4qXVQGbslirbx+2Q/kvr0Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aY6FD1h2FKLOHRF8z/9NYESEsau6SsWmJ7WqfGbDzkBpSGoX2fGEGKEM/u88A4B+g
         GXUqbfK4Tx4bNg9O2f7CWYvcUqYV70idIpN5zCMlc0quH5waiLMmY6h5P4tuc8k45J
         h30LAivNsuiSq55j+DSfAx3/z1avrDMtb8V96POM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33Ib-1i2VT62YtZ-013Myd; Mon, 23
 Sep 2019 23:28:21 +0200
Date:   Mon, 23 Sep 2019 23:28:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mike Hommey <mh@glandium.org>
cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
In-Reply-To: <20190919214023.hu3oznjcrzrsmpso@glandium.org>
Message-ID: <nycvar.QRO.7.76.6.1909232316300.15067@tvgsbejvaqbjf.bet>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com> <20190919214023.hu3oznjcrzrsmpso@glandium.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BOLoQ/C4kI15lsc4b+SQVButIDYM/9t7l1SUy6QpKLC9rWGEnoH
 O3ZXKldWQBPtnCmny1MJnZCkBbSHZIuE3peO30UjCt9LT7WdwqUhoE/MtuAxiYlBipDE0/y
 6vymUKT5LvZzT1ne8o+GmocU4wH4x+vYJWeXVA4Rz+gROvbzvRpqEYjFDElXpootQjXLoS/
 m9IKyoMgzt5OpS24nkxYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dBFiQHGJxAE=:43V4KlJsmAndNFYudhp4by
 ltHveCbCwZOR18etzFghjbd2T1bG2xaJ2yV3acfUdAK5RNjRooEy5GXE3dj9v/WjhmwBlwg34
 LUaXlgyOV2xX/HfBTjQaw0dGPqHSIUOaJYXiNx5nRf0xfFs3takQ40b/ryLPhLW6vCAwV3IkK
 MimwpJiE3tHzXMVA01m1H+GHRbkpjD6J2uOnZdD0g95gjh/Zx6EY/afTYGya87DXLZSsknyf3
 F2cKy3ZKXndZooljPEynrnWmFjoLFleZ887UrFzFp2n3WQfV1eE0mtRjaL5DingLWWrjH1pJS
 LvQsZm5UL8B3uJs8esa6+IyO8C8B0MnFwAjEqA6bUpvR4YSk8ZuNmBibdorCxvCPygiia1T78
 faMDcm2vy9e0V4jZpoRJjuTfZHwCB6dW6WcDVcJFQ/cZD8AraEvG1xy8UMcbeIODFyNRJ8eNN
 9m90vR7bkJlbumW3FGu+hrYynwiQv/imFzmk2J4gPswvFujss69TDp9AXmTqraBIO0E/T8GLf
 YMrlt7eM+Pma+z2yXnkthEWlvYjltl/L27uO5nr/6gHTMT3FaW4ddIUuq8LqvP4islu2NmLG+
 Gilf4ISurAfFkXjl72m4oK4n29rlKssftLcVRV0GG8F/Yplivpj1gJL08Vi3wqy2npo80IA6o
 Mk9wjg+rsruHR1pGY0l81Ix9wdIOtjFUXaBwjFzldkvXio91qJ+7TTkBW7LrE1EI3gtZgLR+Q
 bj4vytcz21cli6dcLXhKnYIU66W4HKCievmEsU3usXZeuC2vXy/DE8PajWAQlaSYT7BxEKgWH
 tb1TVJQPBkN5unTZ1seiqzkSHTYoMX7yAfm9bu6o0lm87B5y707l0wVOQFDDlfmLUUZ3ze4PH
 et2tlFWUTBC5KPmMwf+8bRS/9PDWqTDOrhBSlJzk0Cp7pfjE6boC/qw7iD7E3lHpGFVqpXT+c
 5FQWkEWqzhGGbigMrt3BDsgQ8vyB721SxzHfO5xJ1JQXyJM9HbQ/geWFxRgML4l5xW8GYqnUJ
 U20UaEAJwL6T/xDvDDhUY+RmHneX9iHxt6F6Yv2OY9wEB0J/KLWodYPi9DOmFz2wnhC8YAxE4
 tejxQHul/+aiQ3CAzEPP+4u1TFEPWTiJR3RwN1ccQqc8aRs5vX65+lVAp+otxZoXT2r82Qejz
 yv/2Z5ax08spvOb32vCZSFf5lSJ8JNAgrl4nsPAt0i8wsB1gfJKcHO0tFttAHRBynclCvhtek
 8K2Trtj8wEMB9r2lStuBy/+s1KesZt/0QxcDWr6nqMx+8fo1zGb05wQu82fs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,


On Fri, 20 Sep 2019, Mike Hommey wrote:

> On Thu, Sep 19, 2019 at 12:30:13PM -0400, Derrick Stolee wrote:
> > During the Virtual Git Contributors' Summit, Dscho brought up the topi=
c of
> > "Inclusion & Diversity". We discussed ideas for how to make the commun=
ity
> > more welcoming to new contributors of all kinds. Let's discuss some of
> > the ideas we talked about, and some that have been growing since.
> >
> > Feel free to pick apart all of the claims I make below. This is based
> > on my own experience and opinions. It should be a good baseline
> > for us to all arrive with valuable action items.
> >
> > I have CC'd some of the people who were part of that discussion. Sorry
> > if I accidentally left someone out.
> >
> > I. Goals and Perceived Problems
> >
> > As a community, our number one goal is for Git to continue to be the b=
est
> > distributed version control system. At minimum, it should continue to =
be
> > the most widely-used DVCS. Towards that goal, we need to make sure Git=
 is
> > the best solution for every kind of developer in every industry. The
> > community cannot do this without including developers of all kinds. Th=
is
> > means having a diverse community, for all senses of the word: Diverse =
in
> > physical location, gender, professional status, age, and others.
> >
> > In addition, the community must continue to grow, but members leave th=
e
> > community on a regular basis for multiple reasons. New contributors mu=
st
> > join and mature within the community or the community will dwindle. Wi=
thout
> > dedicating effort and attention to this, natural forces may result in =
the
> > community being represented only by contributors working at large tech
> > companies focused on the engineering systems of very large groups.
> >
> > It is worth noting that this community growth must never be at the cos=
t
> > of code quality. We must continue to hold all contributors to a high
> > standard so Git stays a stable product.
> >
> > Here are some problems that may exist within the Git community and may
> > form a barrier to new contributors entering:
> >
> > 1. Discovering how to contribute to Git is non-obvious.
> >
> > 2. Submitting to a mailing list is a new experience for most developer=
s.
> >    This includes the full review and discussion process.
> >
> > 3. The high standards for patch quality are intimidating to new contri=
butors.
> >
> > 4. Some people do not feel comfortable engaging in a community without
> >    a clear Code of Conduct. This discomfort is significant and based o=
n real
> >    experiences throughout society.
> >
> > 5. Since Git development happens in a different place than where users
> >     acquire the end product, some are not aware that they can contribu=
te.
>
> 6. Newcomers don't really have any idea /what/ they could contribute.
> They either have to come with their own itch to scratch, or read the
> code to figure out if there's something to fix.

I think this is very related to the "not only open the door, but invite
contributors in" idea mentioned upthread.

Speaking from my experience as mentor in particular in Outreachy, it is
often not obvious to old-timers in this here project (including myself!)
how intimidating even the idea of "scratching your own itch" is, and
it can be tremendously helpful to even so much as seeing the problem
stated by somebody else first ("Others agree with me! I need not have
doubted myself when I ran into this problem, it really is a bug that
needs to be fixed!").

Additionally, it is no longer all that easy to come up with an "own
itch" to scratch, as the most common workflows work reasonably well in
Git. Yet, it seems that some users _still_ want to "give back" by
contributing patches. Or they just want to see their name in the next
version's announcement mail.

To address both concerns, I started this little experiment a while ago
(but announced it only during a Git IRC standup):
https://github.com/gitgitgadget/git/issues is open, intended to
accumulate possible project ideas. It seems to work reasonably well,
there already have been volunteers who picked up on some of those ideas
I (and Denton) listed.

Hopefully this issue tracker (together with https://crbug.com/git which
targets users more comfortable with that flavor of issue trackers) will
help address your bullet point?

Ciao,
Dscho
