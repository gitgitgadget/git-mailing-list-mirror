Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F17A1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 10:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933154AbcHaKif (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 06:38:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:55727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933353AbcHaKg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 06:36:26 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Md31i-1bMxnA2jVS-00IGpk; Wed, 31 Aug 2016 12:36:06
 +0200
Date:   Wed, 31 Aug 2016 12:36:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sverre Rabbelier <srabbelier@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608311233440.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de> <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net>
 <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QrsHICwoMiFCFLjx/FTxRu/et0wxQemuIy9OcwmNvhXAbOl7C0c
 ZlDHFhyA02ntNsRqHxNZj4RI2yqDWoTyLpMJj92giaRH2fF6iWQ84F7dxDueNjjqhMnUrIT
 RkOEchXHIgk/mCOHo/DSlRNqXGkPovbNtEoE958Is6efNqYbjVsEF5BBJ6zz15/le0XJeFH
 5WQWfBpjfKfLO/RD7u6Aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8TE8+/JxoCI=:/VdRNczXqUsksSpGYayfAU
 czSiTcLevPAKaXbPFQz2P2oGX80/77lTrYsFnub4IcwJYEah2JNMtv1Az8WCHJcyqF226inTc
 yzPa1kvr7Htlb079U2UfCv15vIOtrFvrtoKrj5uDDRa1yBqOxDYFps2fcgMukZsQp6s04jJY9
 dCHVIv9FJKQhvvIA/AbLKGfFjJ6+beDQmu78w2uN6k8gLooFuK7qY4TD3/YhzErOoNdUnIj4j
 RJ0iedQ1JVTbgjm8tiEvOD//szEdxljTPbuF8myCvG2d9PDyakZYTmY+3IvS584Gt+M4Ila3s
 htqF7VFsq7NjXwor8mErbwAcXqX4VTzV1uFhmNJusQp2rHD7j/2VSsdOVyFagIcUtd3iFw9NV
 zAaNZbWcvi00yrKE/QnW71dueNdY8WOwJWO6Mm8aIEe3JbPGrBWQ5bb4N4sX9AYt+dQt8u+FH
 9mMIUQdJRvh4S4du/0lGrI4pbdINfWUi1xrHm3Z8bm+ABMQPLq4W1gvtJLLFnHg3KWtt556QM
 WOa9CpHtwZF4T+1YpXIYKrwinzBpgD1a21pqEZb/aMBowNbCoIgzlV0uKcrZej+6bIs/xF0AK
 fVQIyR2LtEEOgAoTLKAJuv4nOnbLUgwxOeV0Mb4yxIGI2x7y9pZHGKYgeQWadyyvwtTOOpfZB
 dEWXYUjYZZOVPXMcoTEPG89BAXQKzYGiHcKJB/2kzuu4QROlvShNdGFS6BjrC6LvgwJ0YvKrZ
 2kYBov2dg5+6BejaaEHXG8uqrHpPuBIAGChrRmLft06PzVPUzpDlNFXfQF9u/yfWhE9sNLR9w
 fwwa8uL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[Sverre: we are considering to remove the -<pid> suffix in test-results/,
see more below.]

On Tue, 30 Aug 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm, interesting. Your approach seems reasonable, but I have to wonder
> > if writing the pid in the first place is sane.
> >
> > I started to write up my reasoning in this email, but realized it was
> > rapidly becoming the content of a commit message. So here is that
> > commit.
> 
> Sounds sensible; if this makes Dscho's "which ones failed in the
> previous run" simpler, that is even better ;-)

I did not have the time to dig further before now. There must have been a
good reason why we append the PID.

Sverre, you added that code in 2d84e9f (Modify test-lib.sh to output stats
to t/test-results/*, 2008-06-08): any idea why the -<pid> suffix was
needed?

Ciao,
Dscho

