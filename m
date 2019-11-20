Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A2C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC2821906
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VXEblOEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfKTLmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:42:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:57823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbfKTLmU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 06:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574250131;
        bh=lD+fF+C9Jja5VDnQtHLsIC6Oxhyl+kkBVq89SjsWbhM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VXEblOEk4biQ5owNf9L0cIICrH11rDI76nYbcV8paUZzoiXkZYPBS32jRbTV5Pn6k
         bQSa5wmB8prAlorxL5YYXcqvnaxwgdnxj1fkXPZbKbSfJzRKNMjPzF45SarVdU93R4
         fTSmBG3BkvIi+E4L/qfxPXTyHJ8BJ48sAxeJ4OyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1iAeJx43ct-00NydW; Wed, 20
 Nov 2019 12:42:11 +0100
Date:   Wed, 20 Nov 2019 12:41:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
In-Reply-To: <20191119214101.GN23183@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1911201222490.15956@tvgsbejvaqbjf.bet>
References: <20191115230637.76877-1-emilyshaffer@google.com> <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com> <20191118214519.GH22855@google.com> <20191119184919.GM23183@szeder.dev> <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
 <20191119214101.GN23183@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-175111551-1574250132=:15956"
X-Provags-ID: V03:K1:a4NQAE/AScy0HsetsNiMTdefB5oXd0zWv+qJPNuedLk9A73ZA+w
 XBs9yCHNbSXGMwybz7kXJVYiw0Ir7+m6ZVvXxpg/wYn7OHHUScfhNoRp5ZoezPvRIza97nk
 KBXGVyQOtxjMsfxYq2KaOwX4Sxj3GgHFDl0uipZIxYXQTsQB4Hy+ic4WiRQmC613Cm+P03S
 z44IMS0cLh8I2+ydbifsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OvcQ1VdIUfQ=:ECCjQBKwG0zIUbUn2unt4C
 IfF4ACnD5tU4d/V+h6n72ZS5UN3QDWxJYKxvdhWm/FHTq5HOt80bXA+oUKlbG34ksqJYReUYQ
 Y9WqofvpWB3cqdycII0r+/RJHyHxOrMTBF61AL3cbrMGMUSzax3xi3oUXokMJ5sJQ3VNLKT0U
 Tku9ZNIfopae3W7X/D9kCXVwd1PRL3oJ/2aQ6pK7wYMZ2y7tG0h1+wa5/t4MF4+HDHbJz4Rm0
 CIHUy5Ym7CfbGjn4nCZyBHPTJh/nOalXYCZBUgf3CoVQda5FaBtzlznDKv5qgfICL38hw5mA+
 Ek8qt2nAuopjBhmJRECItrG1YKha48L8r9nuE8qGcrG2nVaqfvV6xwHcWEBF1ie2ASYAnm1Qw
 N5wgquRwP6p6EOa918cJ9Suu3dbZsF8Qy5bN+c7MuyB1KTumhbxt7hfsUkVSZ9bYDZsA9sH8f
 bX6XitGPwQTFY1P8mBrSAmWZiwyYahnPTFwjHG8lXcyTZHkDTZ6HfWXjBVJyuBOsbZN5JpIC6
 QP2rgm89jvd+9nbDHVITqxC5d96tpVgLao6ja5TRtTx5q0yE6vjKKqje4h3+AgO0+RtTQpG7B
 8LIUZBQYSNzrK3DVE6u7pnmO7douGJ3jd8NyLRMTKYiMqU93LzrzWGda73xuRFpXUU+7/MTjw
 0T2lMrB8ruVNnMLrG8ygCBhB28EleLfVjiN5F4btQtxcNnB0UhzUt7ALXLvQTV+CL29+UVsrl
 ew6hjNaSDGiQccFvmCqijfbNHoyMWqAuUG4EyzbYUfPNA6SZy25QgFqYvZ1cQGGYtDhJw9zSN
 dSer01GXyqbIH9UHAWA6GLJaEpRdED2/xpMGs2FDjLY/udti+zmhCgN+DPJ8ELi5BOak/sRgX
 X1mtGefxX1WvEM+iQBiRr3sFPYVS/MWUqPqXWeeM5Hxg9q/6yuqTNBadi5CkZCtqWJHuwolmO
 Yqx+dNKyVYzgl6CLKc2xEhpaKsR1QGILja2QUCCkUCNgp9ca1eHdcS+uiNxfJ6HQAlgGFXcU3
 3rBc7fEQIqIKusuRxaYDxdBABEkF54qMPQMvV3fiEhMdWlXEIL3gqzXfzAN7h+BIpxRd0Ywtv
 0SWCMex4sy1AwUeXPNizHy7SsAnpTUJQR4Vcabth50FEaxOB1P7JrjjHlzr1gwcCM9EoBctuJ
 6kpc/KKLoUbV43C4sJHV/asQrAVbv3pOvcZ0Yk0ZLXOCqyvyTDjEgy5XoRNg/d5NqMlT30MKM
 wWQ/qDNFamFxuDy7V/fyODhW0qQDryhb1f5O76lYwZ41R5NusOUNYnZRBv9c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-175111551-1574250132=:15956
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Tue, 19 Nov 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Nov 19, 2019 at 10:29:43PM +0100, Johannes Schindelin wrote:
> >
> > On Tue, 19 Nov 2019, SZEDER G=C3=A1bor wrote:
> >
> > > On Mon, Nov 18, 2019 at 01:45:19PM -0800, Emily Shaffer wrote:
> > >
> > > > I don't mind the idea of pushing folks to ask on the mentoring lis=
t
> > > > first. It's pretty well attended already - just now I count 16 lis=
t
> > > > members, a pretty significant majority of which are project vetera=
ns.
> > > > I have no problem suggesting newbies ask their questions, which ot=
hers
> > > > probably had and solved before them, in a space separate from the =
main
> > > > mailing list.
> > > >
> > > > Of course if you want to encourage newbies to ask in any of these
> > > > three venues, weighted equally, I can change the language. But
> > > > suggesting the main list as a last resort was intentional.
> > >
> > > git@vger is the ultimate source of all wisdom :) and it is openly
> > > accessible for anyone for writing,
> >
> > ... except people with an @outlook.com address (all of their emails wi=
ll
> > bounce) and people who do not know how to suppress HTML in their email=
s
> > (which I believe constitutes the vast majority)...
>
> And I believe that that "vast majority" will never try to contribute
> to Git, and thus doesn't matter.

Yes, this is a tautology, because by that very expectation you make that
happen. It's kind of a perfect example of a self-fulfilling prophecy.

And while I write this, I realize that my answer is not even data-driven.
So *clicketyclick*:

$ git shortlog -nse | grep outlook
     6  Force Charlie <charlieio@outlook.com>
     1  Rohit Mani <rohit.mani@outlook.com>

Oh wait, what? That vast majority will never contribute? Not so "never",
after all. Well, it is certain that they do not feel invited to the Git
mailing list, that much is clear. Force Charlie's contributions probably
all came in via Git for Windows (because it does not slam the door in the
face of Outlook.com users, is my guess).

But Rohit is an interesting case. Apparently in 2014, vger had no qualms
about letting @outlook.com users in:

https://public-inbox.org/git/BLU0-SMTP956BEABA437FB370F76953918A0@phx.gbl/

Well, I guess as long as we can make a nice and cozy place for ourselves
and our kind here, and contend ourselves with the knowledge that the rest
of them out there don't matter, all is fine and dandy.

Or maybe it is not. Maybe this is not fine and dandy at all.

Maybe I find this very much _not_ in line with the decency that I normally
see on this here Git mailing list, in particular with the later arrivals.
With the politeness and respect for other people and their different
tastes (such as the taste for HTML-formatted mails, which _do_ make
conveying certain things a lot easier) that I hoped we could all agree on,
and which I actually did feel during our Virtual Contributor Summit
earlier this fall.

I don't know about you, but if I were to read on any mailing list that I
do not matter at all, I would have a range of totally understandable
feelings about that.

In short: This is not what I want to see on this list, it is not in line
with my understanding of being respectful to one another.

Let's hold ourselves to a higher standard, okay?

Ciao,
Dscho

> > > reading, and searching.  Therefore these three venues cannot be weig=
hted
> > > equally, but git@vger should be the explicitly preferred venue.  Onl=
y if
> > > the newbie has some other preferences should the other two be
> > > considered; e.g. if more interactive, chatty communication is prefer=
red,
> > > then try #git-devel.
>

P.S.: I _think_ that I understand where exclusive behavior comes from, of
course, there is ample research about this, see e.g.
https://en.wikipedia.org/wiki/In-group_and_out-group. This explains it,
but does not excuse it.

--8323328-175111551-1574250132=:15956--
