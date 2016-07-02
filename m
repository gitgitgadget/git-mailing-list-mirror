Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344671FE4E
	for <e@80x24.org>; Sat,  2 Jul 2016 07:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbcGBHjH (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 03:39:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:64224 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbcGBHjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 03:39:05 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MP0LT-1bCvzM2Nz5-006Qyq; Sat, 02 Jul 2016 09:38:47
 +0200
Date:	Sat, 2 Jul 2016 09:38:46 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
In-Reply-To: <xmqqpoqxz6kp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607020933080.12947@virtualbox>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de> <xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606301019040.12947@virtualbox>
 <xmqqpoqxz6kp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NkA0A7/48YRqNygRy+Mlp+gtyCwe/g3eUQy+aagAVuq0ZDmit+c
 mElO7Cl+1nqPZK1/+BpDc5WBSXu7e3mc/dFln86V2bh1CyVpdNOwwno/9yGFzCWKAKVRcU4
 YIYU9Kwp22p4d26ktoPFZHUAAzsadJbxyl6zaa/rYiUGaYKm1G1clIgVNDDpCMvlD4bb7v8
 jJZb7I91QS7YLE9ByOkYA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fMilnd0t5Ak=:un9uZehP25YfaH3O9QsXGf
 0T0R504sR9C53JKH1mOaZGcEFi8VO+7PLGerA+LZI69qSI+tsrALlMYI5384NTpbaMFm5TY/U
 HYVYZ7IuqT951X58FrhFiby4Fo0P58LC7sVpn4P/8DruLJCMELMLkIYD6ku6I5mZ+1NSFqCsO
 d3LjEZiMe3mXEeWLVteNiTOFWP2HBW1KQ5D32QA7vmbw9hO/cncwsdxZ6+Dnrgyzo6uawrynX
 nArpOr5VPanV5Fmh3H1oyOo8ZLzd9Pp06G5qTul0YW9VNp1BqEGQBxHbeqATKLKEi+X9Jg7X5
 p66g1PBt7vcrwdxe+8wURPIuzpubKxUyzbUslId9Z6tWWSbMzdhiIIAeGenKdVoF4XSOhqRRh
 5/hhJs8qWM8NQ5oVXThJEzxs6SwLbBZuqdcW55W5jOrHawIeDNVUvhbyrySeZonrEZxBwa+RL
 oo/Lh0MmUGZ8KRwXryFq6OxkE1mKtcejqMm23/FZ0PX7zNFEkFAIwuKl0BnYWSfd9nn0rpGeo
 mab4e9L9vfk3k9cZLJrPbRweMLZHWHkdi12mKi1/mZsKPCIESrUe6mT58d1pOoR0ppXWJLJFk
 xwPpqLX36RtKJVNcUPgEUfNu9oLuHeXdaJ3Y0yecdzNg6EuJtGyEudIdFns6lLzCUUHF9LWxr
 Jv9XOaqySy657u451TGzsTFtJucyRbOuiOubjIDx+dEBwMRNw5XdAGHTa5TWo7s4lqQjD0Lu2
 aLinXf55gytd8MOx+L+F4bMksfGzRR6TWrW6LvSSujLUp9ChctfIxNnJ95Px6u+H+RJhORVHT
 1ZYCmpP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 1 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> that has a substring '-S"' in it to ensure that the codepath to
> >> parse --gpg-sign= on the command line of "rebase", and to the
> >> message we see here are working correctly, without actually checking
> >> if GPG is invoked at all, or if it is invoked the key given by the
> >> option is correctly passed to the invocation?
> >
> > Exactly. I want to test --gpg-sign even when there is no gpg executable
> > available.
> 
> The other side of that coine is that even when GPG is available, we
> do not see if it is invoked correctly at all.  That was what I found
> disturbing.

Okay, I see now.

However, is it not better to have even a limited test than none at all?
Granted, we still would not know whether rebased commits would be signed
properly. But if my trivial test case fails, we would still have a strong
indicator that something is broken, with a very convenient way to debug
it. And that is what a regression test suite is all about, isn't it?

Of course I agree that it would be very nice to have a test at a later
stage that does exercise GPG if it is available. But would it really be so
terrible to have a (simpler, not as complete) test that is exercised
*also* when GPG is *not* available?

Ciao,
Dscho
