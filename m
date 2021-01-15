Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45719C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 15:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C55223128
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 15:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbhAOPpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 10:45:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:40265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbhAOPpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 10:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610725385;
        bh=wdEHU6GfoZFJlBkeQ31+DEiMVou08v1n8KYKLcbA69M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HuKpVqdHUExEic6Nu8NBqj3AceB11c7POH8CYVke0av1ybwu5QNOQTB4IAEHSJdUu
         2wEzJk5fHjayS0+Snn7vGUzcts9PcvTIl3qBSJKD2pvpqTazjv2eOZ2OAg+SGrjN1I
         B0dJ7gTL/otDi1A6IcIfh5VhZqXID0djs4Npxdwk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1m7buf1QZY-017VF0; Fri, 15
 Jan 2021 16:43:05 +0100
Date:   Fri, 15 Jan 2021 16:43:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 04/11] sha1dc: mark forgotten message for translation
In-Reply-To: <X/2J8KL/Jig/xttF@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2101151639030.52@tvgsbejvaqbjf.bet>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com> <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com> <X/2J8KL/Jig/xttF@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6j1KFEjus3LmWHeKTu38MGJvfhP8y+14ZCpgLcVRENNBtpmnixz
 Ey2LClz3ZvDUrw7Lsu1QTqSemXfHU2eq5GPME2Gk+2GkLJsmOl+ln8vmhIbAr1/eWQvhx0U
 Skv4KXbdrKjcNUu9BpAQRlcI2moeRjY3Akyr/g76TKfQgM3SlSYTpOLb/AVoFl5YiMKN2t9
 ea/XusbKszyQZnOSUuUog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9DWbnOm38O4=:4c6xoS7yMyg1zAb1Xzeagw
 X2MJflgz0+XvKhWfv4kLqlAmqFkXA+YUlFsvAjm1jNKz9uklM29qFcbfP38Y6iDzL92M8cUbA
 LG82Ihwk7OE6n4pqdAdem/4d6mc3T5dGNLoZxiCUKx0VRA0paA9ykB3gifUOb57gxYxj+KxAM
 davQoPIkfZHv+uZDiq/cw63eMJxZUJZXX0yff+pH1xjnhw3kIZZkWtebdoh7jkQOQ6gRQz/4J
 sXRfOuYzjEAEdA/ylFnPRlq9ctjooqHDNR6b6UHUfkSi5bWedWeZJ3tj5JDVexp78QZemIh16
 sTg5G1/OSIhJeIn+oN7mxUMPGotLjBNah4BtgBsnvJ3hQbUA3mOOgPnP2rQUNokgnUWD8AiGN
 0Dy5XVqu8E4BqnKLX+KvsuauAxWYpO7S17jM+fqHvMXifkctQ+6bn5WUYAD74y4guhQ6krPl3
 1scmQVLL6V9BDGZKpN1v2pJZx1oCoDEzCYFjOzjx8H0nVnf3AMfP0SF6242fQzkG6LKsLQBZI
 LSrHmWr9jwcS0vHOiaAHKIJIUUNiMinUIyW6FEErsE/1IUWndW7k1GxShiWY60eFgRxKTE4pi
 56aI4WEQ4+eVAMLzr6v4bbMEmZ+Qml5qunLkLwHp25NPoUYmbdIQ7oZnP/i11+n6vt2OyLM1S
 1uS0y+9/Zz9LuSIErhL0sG6utJ0OK0bwwNWUoLCY0PZxlhfluFvWPBHhPCv8M0VTuW/XgE1mF
 hUPjzvyz4t6poGlCF2h41R7sQDvPexefh2uJ6jSn4URP89yWunGh6nVGcvzy9QpPwaTNpqxIx
 /9eABPVWuodG+nlTqdDegiCf8nJcGnaQ+agIz9M4yNC2mqIuMBnJ+VM8MDY6Jd5D4Jf7i9EM+
 n9A2f+XRrxiUv+DFPwG6x83VM6NKeoXuFYw4wJp8c=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 12 Jan 2021, Jeff King wrote:

> On Tue, Jan 12, 2021 at 08:47:35AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > diff --git a/sha1dc_git.c b/sha1dc_git.c
> > index 5c300e812e0..fecf5da1483 100644
> > --- a/sha1dc_git.c
> > +++ b/sha1dc_git.c
> > @@ -18,7 +18,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CT=
X *ctx)
> >  {
> >  	if (!SHA1DCFinal(hash, ctx))
> >  		return;
> > -	die("SHA-1 appears to be part of a collision attack: %s",
> > +	die(_("SHA-1 appears to be part of a collision attack: %s"),
> >  	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
>
> I didn't find any list discussion, but I think I may have actually left
> this untranslated intentionally. Like a BUG(), we'd expect it to come up
> basically never. And when it does, being able to search for the exact
> wording online may be more important than providing a translated
> version.

I disagree with that reasoning. By that rationale, any message we deem to
be somewhat rare should be _untranslated_.

A much better rule, at least from my perspective is: is the target
audience the Git users? If so, the message is to be translated. If not,
then not.

In this instance, it is quite obviously targeting the Git users who need
to understand why the command they tried to run was failing. The test in
t0013 is totally agreeing with this:

	test_expect_success 'test-sha1 detects shattered pdf' '
		test_must_fail test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
		test_i18ngrep collision err &&
		grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
	'

Notice that `test_i18ngrep`? It tells me that we expect this message to be
translated.

Ciao,
Dscho
