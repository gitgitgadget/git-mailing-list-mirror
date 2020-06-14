Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31EEC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C773E2065C
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ux5yUHHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgFNVXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:23:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:44127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNVXS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592169789;
        bh=7zuKtmRCdPahAMlYpUmwDp1d2/1TS1IVK8/jkDz+X4Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ux5yUHHT2Uk62UDBZvIdZmdD3s/ZE9mEJCRcMvGuakVq3PoH6d0uIiz8AAwBQVYH1
         zkdXjYI5FQTihUqnqivpVGcbMRXD8o+kKNOFJeV72F32OeBaqhj6gyWZ/x8KFQaXes
         V6H05+IME92dgFOm6Mh1uvKEcfldNqF3PWDX3P/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.43]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1irofM17Bx-016hFq; Sun, 14
 Jun 2020 23:23:09 +0200
Date:   Sun, 14 Jun 2020 10:49:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        don@goodman-wilson.com, git@vger.kernel.org, simon@bocoup.com
Subject: Re: Rename offensive terminology (master)
In-Reply-To: <20200614190842.GC6531@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2006141035480.56@tvgsbejvaqbjf.bet>
References: <CAGA3LAcDpQQhcmaQG3+s6XNnth54KmNC+padAXXYsc5C33p7kA@mail.gmail.com> <fcad8e8f-e853-d754-e3f7-644a5c717f84@gmail.com> <20200614190842.GC6531@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1920614261-1592124596=:56"
X-Provags-ID: V03:K1:zfCl6c7NC/ZJBGgX6FN5FCS4MqpKIEhTIcfEpbB8wBr/GVTGoAQ
 4gTvpKL/VY9kbyTlmpjbCbMENkmE4lLBLsPKKwyZjB7PurimYmzCXi2Twl9UA9f+7D09xgq
 ySaEzEa/QT6ekYqN6vuamst3PsIRbQU/r7A25F1VwSMOO3FYR7FRB8GGskW+JAVtNfOwvbC
 lWi6a7fl/uGyBZxFe8tcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SDpjpiHCCQE=:Zlyc3MGcqCRX5tK7rlQwG5
 rFKuIdFFzsI4xZ2eokQW++dd+Z54FFc/5MNAH34RgEXQLT6TLtDgFomW0VJsDCXY/21IztMae
 pbij6djjh/PIupHe1iWtaOCjKopXEtLLrPKSASQ61DGJJfa32GLOe8nCvgp/VE3G2MW66JfUm
 mditW22cv3ypli7jEI2noMSxio9PvYkEQMZI0eZwCysHsNzrehmlvDrBt/vMiBPhvcPjFjflo
 L03YeCacDi/jYk99T+WN/fT5LHgnOQYoAv1CCY54IZRT3kPOdMVYifALmLfKdsdnESvU6iRk8
 tQhGSdfJn36kRXnuoaa38mtDHaWw/CM+nTSqtQBHMYVo6qIatRKngFf7deoGmtDqawJ5Fz6xw
 Vxr4oMqveU/KMcKoZYXpMKpd0H52N+ce8amZ3wi7YROHXEqBjz/7uH2ef30oQTuvtxBAKwmH5
 Hd98CNjKSejOhCfnV7GyNnBCIULUm0NpkXz0eJrYL3QPsgaw3Zs321ELh43a96pskzS7+a2Nt
 IGQ9nhOgkVTp6bawSn+YdPDhwQvKlLItbNOk6KxRz2gW0ig/tvy2bwJ7HeVVKUOpqklx9E/kd
 Wg/FGPzfPL0LanV6n/yYvK6zDYgNvFvUCYlStW2MZFv5HmbC2pydKxl6gJ1T2l/Omqo0o47sP
 gwAVZLgIMoW6jrcfkg57wm+1ADN5kHPUd+eMp4pdWVJq8hoU3BDJS+Qe134ZC5nGkSce6sd9a
 syTKTvJurgJEwNPDOxw57s6847bDmHh8mRgIiaUKo7ITs4+ysK40gIFIi6gJZBugBGMPdrnUc
 7zN4c37/ZfM+C+uhGgMcvDlzg9YKsn5rUk8hGn7Nj9b106nkAFhisIwEdGxYnGkZ9n/i4Og6x
 TetYixDO4kSVsWJUw7zUDAXsD3WeJh/8bkl3+vxxRnDO5VjsWD4jQdd5Cnow7HgoIFKivq2sk
 /qQZEmWE29o5ZeOFT/wUcF+Kg9sKPXqe44OnD5D6/rjpz2qot5z6gbqLSoWEKPLyXJHc0LxS8
 k30x+FYSpmqs8NbYFcD0W72xZ3UrwM86IuOD9tzwwxorpioYRra8eFEWPzXdaauvl4n0NwqtI
 rDmlO+etNvZ+5IHccL3118A37xVqV3f6sbw1/Jc5IILlr8itNhzo1GqX7QJdHpwsM8hZkPhZc
 ZnhQmmXj/vgt02Xxxv+ZXJ+IXkVrf5H5y0aGSJ+mZfqHkcn3qrS7bVOyfxKqAIqIry5TyOXtO
 AZ9Q4a5bVAYRPR75L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1920614261-1592124596=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi brian,

On Sun, 14 Jun 2020, brian m. carlson wrote:

> On 2020-06-14 at 00:05:33, S=C3=A9rgio Augusto Vianna wrote:
> > No one here has to explain why something not racist is racist. The
> > problem are the perpetually offended that see racism in literally
> > everywhere. Specially when there's virtue signaling points in the
> > table.
>
> I want to take a second to respond to this because I think there's
> something this discussion may be missing that I want to make explicit.
>
> When we use language, that language has a context.  Part of that is
> situational and part of it is based on how the receiver perceives it.
> Very little of it actually comes from what the actual intent of the
> sender is, because we can't be 100% certain of the sender's actual
> intent without explicitly asking them (and not always even then).  Even
> if we can, that doesn't usually change the perception of the receiver,
> so it doesn't change the message that was received.  And it's important
> to note that the message that was sent and the one that was received can
> be very different.
>
> There is nothing we can do to avoid this context because it's inherent
> in language and in the enormity of human experience.  We can only
> control what context we deliver to others by being aware of how other
> people perceive our words.
>
> I'd like to illustrate this with an example from my own experience.  In
> Britain, the word "faggot" refers to a type of meatball which many
> people enjoy.  In many English-speaking countries, it's also a slur for
> a gay, bisexual, or queer man.  Even if, when I hear that word in a
> culinary context, I can objectively tell myself that the word is meant
> with neutral intentions, it still brings to mind the fact that I and
> many of my friends have been called that and with that, my experiences
> of discrimination and harassment.  One could say that I'm just easily
> offended, but whether I want to be reminded of those experiences or not,
> I am.  My mind just goes there.  The context here has nothing to do with
> the sender, who probably meant well, but the message I received in, for
> example, reading a restaurant menu, was a negative one.
>
> A reasonable person who wants to communicate well will be aware of this
> context and will choose to use a different phrase if they don't want to
> communicate that negative context.  For example, the restaurateur may
> choose to use the phrase "savory ducks" on their menu instead.  If they
> choose not to, then we may draw conclusions about their intent when they
> use the language they use.
>
> Similarly, when we use the words "master" or "slave", even in contexts
> where they have different meanings, we send context along with that use.
> Black people, although able to objectively distinguish the two contexts,
> may receive a reminder that they or people like them have been subject
> to bondage, inequality, oppression, or discrimination.  If that is not
> the context we wish to send to them, then we should consider using
> different language.  Nothing prevents us from using those words except
> for our desire to communicate or not communicate a certain context.
>
> And while I admit that in this discussion one may say that one word is
> an obvious slur and one is not, that doesn't mean that the context the
> receiver receives is necessarily that different.  It may vary in its
> intensity, but the underlying negative context may still be there.

Thank you for sharing your perspective with us; As it contains very
personal parts, I am particularly grateful that you chose to write it
out in public.

And also: I cannot agree more with you.

Ultimately, it is the empathy that matters. If a certain term does not
offend me, but is hurting other people, then changing that term is not
about me. My involvement in this comes from my desire to offer my support.

> I do want to underscore that free software is not exempt from this
> phenomenon because we use language, and all communication with words is
> subject to these same limitations and to the human experience.
>
> The proposed patch series makes the branch name configurable, so you may
> choose to use a default branch name which suits you.  It sounds like you
> may choose to stay with "master", and you are welcome to make that
> decision.  However, as with all language, that comes with context, and
> others will receive and interpret that context and draw their own
> conclusions about your intentions.

I feel the exact same.

When I originally read Simon's initial mail, and one of the responses,
I felt that the analogy to the music industry made a lot of sense. And
that the amount of work to change a default that has been with us for
fifteen years was just too much. I guess I am not very alone in this.

In the meantime, I had many private conversations that clarified the big
picture for me. I cannot in good conscience continue to use the current
default main branch name, and am actively working toward changing it in
all of my repositories.

> On a final, slightly different note, I also want to remind folks that
> are here that we have a code of conduct, which encourages us to use
> welcoming and inclusive language and be respectful of differing
> viewpoints and experiences, and to refrain from insulting or derogatory
> comments.  I know that this isn't always easy, but I encourage community
> members to consider their comments carefully with that in mind,
> especially when feelings are as strong as they are here.  If you want to
> take some time to remind yourself of what it says, it's available as
> CODE_OF_CONDUCT.md in the root of the repository.

I am glad that you brought this up. There has been overwhelming support
for this code of conduct by the active contributors to this project. It is
ultimately benefitting the project that we chose to make that code
explicit.

Ciao,
Dscho

--8323328-1920614261-1592124596=:56--
