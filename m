Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821471FEAA
	for <e@80x24.org>; Mon, 18 Jul 2016 07:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcGRHXN (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 03:23:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:55255 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbcGRHXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 03:23:11 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LbuCq-1axRqn2bsC-00jMOr; Mon, 18 Jul 2016 09:23:05
 +0200
Date:	Mon, 18 Jul 2016 09:23:04 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	norm@dad.org
cc:	l.s.r@web.de, git@vger.kernel.org
Subject: Re: Question: Getting 'git diff' to generate /usr/bin/diff output
In-Reply-To: <201607171726.u6HHQShO005227@shell1.rawbw.com>
Message-ID: <alpine.DEB.2.20.1607180922580.28832@virtualbox>
References: <201607171726.u6HHQShO005227@shell1.rawbw.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JOkW8YUsq/2yYmez9etN5lN/8q2HZt49wAJaE3b5ZeirFwxf54G
 brdNm9wOUyRHel0vDNRQSVRPIAvm3rzminDyPxF9X1rFe9MXc/rsxpryi0nhudTziPonruK
 L2YcKNy8pvKy6LimZPrW9hPI4XMPrpTTV3W0S1TJ3GoIq8ItCDKJB1kzLUtP/2Lx7b6nh6I
 waQLexEkvijWXHhaM8UCg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:xDj/7/JBGFw=:9eKEwoLjBnVEcf+fmmRmyg
 fTpXhZjeI/f9EtFWsnvq05g/2HW1DsjQZazqEiy1WKYgsJQRcS41JXFoBJCD9JMEAlYb4xNDI
 y63NdnFG7KZ96YXA8FbMJL0uAgT/GR8a2rDzte5SvLgfxKtizhNlzYHzPfJ85Cxu3OPeRk2i9
 LuF+t/kbaeHcGXMQQeaHiSccZqc+OibSrT5SwAMPJeLgUkzf4H8dHiOwTfbCT7SJiq4YLWUv7
 3j8mN+mgX94n/nwX5pzf6TjIyyVPh1UpiIRvkI7GlT3gtRTZBM5c+I1Uef3ctaqCgHXsu2CtU
 pcbFU+xyL0JcrSzMhbM1H4Dn1PQwH/BznGaX0SdEaspt9VwARq8n5aI99wGhZ1dneLzZyKtAI
 jzdQuiMuJrNXJle1w1s2bTjC0+6IFqhOgJf9b7By14HHICcBEQr2j1xKe5ozKVKNkxNY3+6pF
 UY+IB3FCxFuHbgdoa5sTjUFDRqBrJl4O+bBh2IiAjc9N6wke3kvUFwQ+1NG3Fwt0bHeKVVq1I
 NIZANLzFHm4K5rRK+4vW0SHNoBt2woJOVaUBnwxiI12XAFO+iy3vdmT6HcKMq6hSWIWDNmzKt
 ZVsexFxpDTRGg8kM3xZwdmaW+LXUY8ofnwWptzG93iOgCXsE8xlo8PKBmJHwNwm8BY72UyQKu
 /d8XPrKxrfA/P1R/aWBVgw3PozkmH7Js5icgzgsVoc5Snr4Of7DAjzkLedQ9u86aDrK/ZYhsR
 Mj9TxJ0pUE7W2iMdaTD0MbV7M9PZ5EHnDk0shgFaJfmoAs9euxbrSdynFt+Pa4eS/zWY1RC7p
 r1sKSxC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Norm,

On Sun, 17 Jul 2016, norm@dad.org wrote:

> <l.s.r@web.de> writes:
> >
> >The other replies covered how to use the system's own diff instead.
> >Just curious: What makes using git diff difficult and its output hard to
> >deal with for you?
> 
> In decreasing importance order:
> 
> I am 84 years old.

Wow. Chapeau! I am impressed.

> I have been using /usr/bin/diff for more than four decades.  And having
> to learn how to read the output of 'git diff' makes learning how to use
> git a more difficult trick for this old dog to learn. True, the diff of
> today is very different from the diff of 1972, but the changes happened
> gradually.

Curious: do you use context diff (GNU diff's default) or unified diffs?

> I have scripts which process the output of /usr/bin/diff.

Even more curious: what do those scripts do? Maybe they do things that we
either can already do with Git's diff, or that we can teach Git.

> 'git diff' outputs escape characters which clutter my terminal. Yes, I
> can sed them out, but then why are they there?

Those are most likely the ANSI sequences to add color. Can you call Git
with the --no-color option and see whether the escape characters go away?

Ciao,
Johannes
