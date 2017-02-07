Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A5E1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 22:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbdBGWEg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 17:04:36 -0500
Received: from mout.web.de ([212.227.15.14]:53647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932472AbdBGWEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 17:04:35 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LopIp-1bvJka0Zjf-00gphA; Tue, 07
 Feb 2017 23:04:23 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Junio C Hamano <gitster@pobox.com>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
 <20170130222157.GC35626@google.com>
 <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
 <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702011225250.3469@virtualbox>
 <20170201114750.r5xdy6emdczmnh4j@sigill.intra.peff.net>
 <bfd0d758-a9c8-9792-6294-9f9ed632cc98@web.de>
 <xmqqd1f1pxqc.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <12e7db44-ff69-a38e-322a-6b5fc5f1fc29@web.de>
Date:   Tue, 7 Feb 2017 23:04:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1f1pxqc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1G4KIXewolO7HEecLO8c+ClT4e8v4hDjTB3rhxrz5qVt1vfFCOW
 0nYG0QYQRQeRgu1oqTC2jDsIEBjrKdwjYESwg7sJrX6ii11vYHx7guKPHus3/qPsVvdc5Gv
 LVOKEpQaVrHHEfNLsaUixJ7db1kV0I1OViNnOmQmU2LjCmKmqsqtvuzIw1DbOTL9HQxcGYU
 MSwiMK4WsW/Veoaxi9GZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rCZ/nUAg9b4=:Qz7SmQe+jdmMlzGgV7q2Y6
 ohh9kO/+XT5zlm2tDs+rOHgi6MZeD8EycOBfnKQXImPPzqoZL6OpITe95HTmXXRkJVBiRCApp
 z1FWPJ83x1sUZz4ztc3AHJqJBNSmY9Pu3ASSv6cCneXYV+oMuoWDQcAvBd1pLeBD8sD0SGvoB
 aaYS0e0CNBnI8a4E1Tk3wIMNHdf7WfgeLjNAQm4YIquYh6SC6fgPfpn+SJpu6FzyTsfWaUN4v
 c20B2sEBzi2WjZHeP2Yuptaa5PjBjnmwx7GpeyhnWk1Xj3zDIMRS5o6ADB+SxDcooEd6cEXn0
 NBlsW7dDfSG1sC+eREebE3LmXhUW1OQpnaYno1LjWk4MHcjG184pLQARaul7CmoRhUkfKDACz
 i3DYtoCtxZw7NZuDKPpbZT+ucrjQVZq7G51Zp67OC9K09ET7iydg+AGsWQNi0+ZxRX5UjqVQT
 plde8fIL1O+qcJyIUmMs9dlA4rSYiVQrNMucS9TAFKGQk5EsfUgmUYbaif2T6NIxIYgqt9Dc/
 U5kfTWqRN1GF0zhJWRYp13u+AMUX3iFkE+MaskDlMZe5qWm6jsdpRtEFAtmtRG5t1a/wdPAgj
 1ZBo2TUi6JI9guoX4lwds860aezwisPlwkANXNbh7tcxEhbBALGvxcj92HSu0LeF1Q8e85KGX
 erVf3iBWgfSa032DwulYavAA7iDO947jDyqe36+scqnPcldFXWWj+czmgiXXnV17WRi4cN/zk
 0KZocyFZAuSMlnRxTezD+JVpk2gHJewsUeSdqfBLZhaap0YFOz/LDsH7Ib3QwZDigOZ+qWRXz
 T1BWmlJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.2017 um 19:33 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Size checks could be added to SIMPLE_SWAP as well.
> 
> Between SWAP() and SIMPLE_SWAP() I am undecided.
> 
> If the compiler can infer the type and the size of the two
> "locations" given to the macro, there is no technical reason to
> require the caller to specify the type as an extra argument, so
> SIMPLE_SWAP() may not necessarily an improvement over SWAP() from
> that point of view.  If the redundancy is used as a sanity check,
> I'd be in favor of SIMPLE_SWAP(), though.
> 
> If the goal of SIMPLE_SWAP(), on the other hand, were to support the
> "only swap char with int for small value" example earlier in the
> thread, it means you cannot sanity check the type of things being
> swapped in the macro, and the readers of the code need to know about
> the details of what variables are being swapped.  It looks to me
> that it defeats the main benefit of using a macro.

Full type inference could be done with C11's _Generic for basic types,
while typeof would be needed for complex ones, I guess.  Checking that
sizes match is better than nothing and portable to ancient platforms,
though.  Having an explicit type given is portable and easy to use for
checks, of course, e.g. like this:

#define SIMPLE_SWAP(T, a, b) do { \
	T swap_tmp_ = a + BUILD_ASSERT_OR_ZERO(sizeof(T) == sizeof(a)); \
	a = b + BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)); \
	b = swap_tmp_; \
} while(0)

It doesn't support expressions with side effects, but that's probably
not much of a concern.

Swapping between different types would then still have to be done
manually, but I wonder how common that is -- couldn't find such a case
in our tree.

René
