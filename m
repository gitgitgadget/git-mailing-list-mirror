Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4051F859
	for <e@80x24.org>; Fri,  2 Sep 2016 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbcIBHf0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 03:35:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:58376 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbcIBHfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 03:35:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MJXEd-1bdmvo3pkp-0037kt; Fri, 02 Sep 2016 09:35:16
 +0200
Date:   Fri, 2 Sep 2016 09:35:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <xmqqzinrteql.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609020933430.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>        <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>        <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net>     
   <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1608311233440.129229@virtualbox>        <CAGdFq_iJeziyXBPL2GVHNXZcjGAwQVN2EhJs4AtJCSx7ghn32Q@mail.gmail.com>        <alpine.DEB.2.20.1609011027210.129229@virtualbox>       
 <CAGdFq_h3UuW7wX0-=SuS22mX_C086HRZZ=i1sYVya80dd+qMYQ@mail.gmail.com> <xmqqzinrteql.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5IeQbOHozw8lTKjI1dFNO5rbii2mBdCormjMj+n/zj059haauVC
 Akcn6yU2CynmPjrMzPvevbG6OIT0hePxq6lR4KIe3pKovD4SZqz8n9ixeJzmYioBf8S1AAK
 BuTgvjkpdjOnhWeqg4JnDKHKJeL1+3GhdKXWrtGStzV+UOtPmkD0dRGhQGXRrenLs+IA0Tl
 Ff3+7yEIxuTWQjZq7XOpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DsIw9reGdKg=:JUgHiQ/b/KViMt7VEZCxzQ
 CL7DF5T1nEtVSGcNBteLqcMbfUKkDBctht1vnvb5UCTeFsnB1SgnJ8GbZmXxvNHaxEJYSvEN2
 KuLp09afVsmN9diWtNIys19JgcIiJVga+UEGDJfQ21fQLEUfZbEgfGsAKtjcv6bvZOpQvibsU
 nP0nqQ3wW/KDsYKkQk+3Zdd/epoN3WcRbBu8LxwJAMj8lU4w4MBBfsqHSnJLuiFDpdMhjT+iI
 aYz3tDLx6BQphETRIYh4xc6zAPr4ZkyNAg1s6GVQ6g5OmvEldtUYvgu0gPANqRFnJwUmtwUpt
 YkY3jJuzwlIM5T0DJXFSg239im6tV6urvHXKU5c2AzgSHRquhGbf4Lby1gakxJAh0B6BzBIMj
 WGPM2RISKKMcLNwv1/09sz9iFmJ+BhgJTWojGkjccx/P6JY0zJFOSv8AGrk4VkdcD8gSz4M+3
 I0PlXIkj9LKJsBwH9Dtc3fnvVhdDWc2WgqbS94HteMBg8DOuFiAR68HaBy3vFHAXOnxvY1ekW
 AauGgtSICVS0FsWg+W9GdmKA9VpZ9cwzMjKUTdbtk+0QV5yK0SX1Y4rGn5B4RWKsST9+qtqiH
 +3frSz4TCkup/lgWuYHIZ7Rvn98JG9G5Op3lA9jFBXaQm9mDvX+892CY6ZX4xWupUee4YIQiL
 YLGJ4vX1RSLW9iqmnB3FOfSIaBUg76pBGC3XBpA5zjOl7IS3RsWuxZ8jU77hOLcadaoUyYZSu
 BSlnQ6EGiL1xl6s9z8t1mbnErGQcEdRiZsJAf6D7gl8R9JZgApgWzkSdka6uZSa8Buz9KrjUY
 X4Qk7NR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Sep 2016, Junio C Hamano wrote:

> Hopefully that [patch removing the -<pid> suffix] would help making
> Dscho's "what are the failed tests?" logic simpler.

Of course.

It also makes sure that those 2 hours I spent on writing and perfecting
the sed magic were spent in vain... ;-)

Ciao,
Dscho
