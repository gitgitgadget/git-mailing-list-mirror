Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D441F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbdBAWmY (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:42:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:65500 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753731AbdBAWmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:42:23 -0500
Received: from virtualbox ([217.136.241.150]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV6EP-1cyY9e2df3-00YOGb; Wed, 01
 Feb 2017 23:42:11 +0100
Date:   Wed, 1 Feb 2017 23:42:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] connect: Add the envvar GIT_SSH_VARIANT and
 ssh.variant config
In-Reply-To: <xmqqzii5mthp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702012339080.3496@virtualbox>
References: <cover.1485442231.git.johannes.schindelin@gmx.de> <cover.1485950225.git.johannes.schindelin@gmx.de> <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de> <xmqq1svhpvm0.fsf@gitster.mtv.corp.google.com>
 <xmqqwpd9ofry.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702012319460.3496@virtualbox> <xmqqzii5mthp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cDSviV0wgW1QLD8+YqI2/50+D2hVGiPUiZkA2ABddHUAcMS1qlW
 Uxo2KIslkAHiMYEa3eZRKLeszDhQ+vmPZJ7n/osdWcLoA0v7K93sWV3JXJzcnRMBA9gIrvG
 wKg9UhBF6I5Y7CpnUd9PT7bkXqQldURBk5ueL4NcPQ8V2YUA4W/CFHgGpslfPgERocqO0Lw
 rSAPHu4uijSmxe6/qM6sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QFa/RzrqJ2k=:0SRCJCm01l3W2rNstXcK2M
 HWuRWKZ10F/JTdKT4yDJ3nTZXSKR64iblwF8PkU/io6i4wfika90ojEMhkwhQhwrzsMQBQSlS
 R6ZyZUSAUXrBDX7ld50FFrzcgGRcxeKnQwdLrF1VQxHT2UZa5XLkzt9ZGMebLBsU7gWbLFJjt
 spAJCKDYf+6OEfkxWg6Tm/LnRUUerQdWguqlwbXw/CP+yZ2s+pqNtWvLoGkzvJZkDE6LAP1Rf
 A3Syi1fBTAyWzGEu1TviulxDqsFX9Mi0xjWGfmtqR9IWFH8B+3NtB15OE9qpH5xQIhBQlXRii
 Wt+ujh04GWOwMVlM8DKUrNCtBOy2dc29EO6ESwt4uZclmoAFdJJzqIj7O6Gadbr0c7uXu/I+6
 3JTgBQ/knzMHeW1wFF8eke9/Osm8Hs1u0eCsUYtNgvd5+E6uXwsuP89cUCaTCBJC0dSXs2bv5
 b72aytjBfgzVUZHmSQSYSOGUP2feGPZ59jCcKcDdzt3qpj16FwG58Q8tG7vtuEA2rySbJcMVZ
 mk4kJQ86ILYrwtaDqfSXxx7cdyODjvA5WOK6bKyh0buA1UmXxwqmU9hKvPFQ1uv5nU4YsbTuV
 dv6tSWXfQMuEEU+OGNZszez5vFEUm5J/pSxa7xSovr5IO+/6IFeOtbpOEYRMv+VOl0JxAaGF5
 XRLQj9bZ0rTZ68VKJJbuz+4y40bOepy+Hli9eLTYJqsxv3MSAYGWdhMQm4XUCWwQ94MGYKfIH
 j/wV2of45+UjNby1R1tFIy3y4NL4/tPUyPreEmH0ylFSGFecuxaj4Agw1/j4o3AZJwTjo97th
 DIJNHt7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That leaves the "putty" case in handle_ssh_variant(), does it not? Was it
> > not your specific objection that that is the case?
> 
> Yup, you can remove that while you reroll.
> 
> > No worries, I will let this simmer for a while. Your fixup has a lot of
> > duplicated code (so much for maintainability as an important goal... ;-))
> > and I will have to think about it. My immediate thinking is to *not*
> > duplicate code,...
> 
> You need to realize that the namespaces of the configuration and the
> command names are distinct.  There is no code duplication.

Since your 2/4 did away with the "plink" and "tortoiseplink" values in
favor of "port_option" and "batch_option", there is a duplication of logic
which I tried to undo in v3 and which you reintroduce in your fixup.

Maybe that refactoring was not so smart to begin with, and we should have
instead modified the code to use an enum instead and keep the original
conditionals instead of setting a port_option and a batch_option
explicitly.

Ciao,
Johannes
