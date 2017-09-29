Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754A720281
	for <e@80x24.org>; Fri, 29 Sep 2017 13:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdI2NSX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 09:18:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:49394 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbdI2NSW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 09:18:22 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYKGj-1dtmHK0ZvN-00V7ML; Fri, 29
 Sep 2017 15:17:47 +0200
Date:   Fri, 29 Sep 2017 15:17:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Gilles Van Assche <gilles.vanassche@st.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keccak Team <keccak@noekeon.org>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <59C149A3.6080506@st.com>
Message-ID: <alpine.DEB.2.21.1.1709291416290.40514@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com> <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <59BFB95D.1030903@st.com> <alpine.DEB.2.21.1.1709182340350.219280@virtualbox> <59C149A3.6080506@st.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1311868188-1506691067=:40514"
X-Provags-ID: V03:K0:9B1NW+TOzMPRLUUTaTliGEachhxSOfh9v+kl79MPvV9HWYKm3m9
 DbY74BaWHfauy/sCaViNzhfINE3fThOZsUB5R5rjTdbwwOjRKBS1dhlbzrwXBNEG1gHs2fM
 dsecpYUjI0rAAylWXDoHaVmKeKJcP6hurSe66WHh+/OgrVrsrgK6CACU0hyEb0VVTEUg/1x
 on+IiyQChDP8igCAhAZlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3mM96JGSBBM=:nNX3GFpuzUatkft0nU+voR
 dKj7V2bWRsyR3776l/2x6NhpRYesguhCLGhAMe1m68vSMJf2K1Hs4hj8RkxTOODcqUwDZ7y4+
 Hmplb9DPMDPZ+d0rYpj+iDgpq4gLlB3Mqwsb0bOa41PCTMe/dfqgJtyvQKRL+Krge+Y4qJce0
 mLQuOH5tkfzhiZBtR6zlNLvtYNrGnoqX8srvYPXoE2pO9sC59GDmi0/JueHXDyKjRgMTdS4nT
 xp46aGWQ6V5Vr+I4C1niEABLzyN+Kc/hYMrTLEvWk83DkK1WSuHGQEnxUeklM+KppEJhDjWOh
 Pk/YVxxozOHZcT9R8DPveNjcpIh/K3XT6QNuPTTcuWYTMiSKOGLojRC41YQ8wWIexbpKi221z
 jb1MtNYpp742gZGj6/QhUrCJunONInFPMliR7cth/GI/p/7XADnzb2/u6gE9YbfLYXJj9xa08
 pgPgQkvjDUmBL49lHmC2VaD1DSEUYnkac96fRB9B10+DtSfm2lCZNWi0D6KM/m6gwf1opwJSc
 cqk6TLNzII0T0VbGcgfq3rNxRgc/wY8UFP4COxjgOFuQ+uoTCiiYhGD7bh3ZthU77An5ovFGw
 Njy6l7VFm63dzWoqt7JXwnwJgBqINlHuMQBBCuQPBbew/nWkTYOaUgq8/PIo57+61H2AlQMJg
 Xgfeojp5zA7/4TuB36IH+8UVfH7Mge00kiAcnKSQXkIXvoUVF5YClpY7Bgaj1djo5pFBBB0fh
 8WMXlp5g+fYSnqkZclmpx31TLkfFrSN1A6bb6aHh3nk8ZFRv5FAQ8+6eu1pBtbkZ5PqQi/ayS
 YxNkDR2iAxCxSfBxMl83JuWqfAHnpsf0KBG/UT5eJI0jK6IYhQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1311868188-1506691067=:40514
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Gilles,

On Tue, 19 Sep 2017, Gilles Van Assche wrote:

> On 19/09/17 00:16, Johannes Schindelin wrote:
> >>> SHA-256 got much more cryptanalysis than SHA3-256 [=E2=80=A6].
> >>
> >> I do not think this is true.
> >
> > Please read what I said again: SHA-256 got much more cryptanalysis
> > than SHA3-256.
>=20
> Indeed. What I meant is that SHA3-256 got at least as much cryptanalysis
> as SHA-256. :-)

Oh? I got the opposite impression... I got the impression that *everybody*
in the field banged on all the SHA-2 candidates because everybody was
worried that SHA-1 would be utterly broken soon, and I got the impression
that after this SHA-2 competition, people were less worried?

Besides, I would expect that the difference in age (at *least* 7 years by
my humble arithmetic skills) to make a difference...

> > I never said that SHA3-256 got little cryptanalysis. Personally, I
> > think that SHA3-256 got a ton more cryptanalysis than SHA-1, and that
> > SHA-256 *still* got more cryptanalysis. But my opinion does not count,
> > really. However, the two experts I pestered with questions over
> > questions left me with that strong impression, and their opinion does
> > count.
>=20
> OK, I respect your opinion and that of your two experts. Yet, the "much
> more" part of your statement, in particular, is something that may
> require a bit more explanations.

I would also like to point out the ubiquitousness of SHA-256. I have been
asked to provide SHA-256 checksums for the downloads of Git for Windows,
but not SHA3-256...

And this is a practically-relevant thing: the more users of an algorithm
there are, the more high-quality implementations you can choose from. And
this becomes relevant, say, when you have to switch implementations due to
license changes (*cough, cough looking in OpenSSL's direction*). Or when
you have to support the biggest Git repository on this planet and have to
eek out 5-10% more performance using the latest hardware. All of a sudden,
your consideration cannot only be "security of the algorithm" any longer.

Having said that, I am *really* happy to have SHA3-256 as a valid fallback
option in case SHA-256 should be broken.

Ciao,
Johannes

--8323329-1311868188-1506691067=:40514--
