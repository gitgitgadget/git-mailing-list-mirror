Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF8E1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 14:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeCTOqn (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 10:46:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:41739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeCTOqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 10:46:42 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9aX9-1et5sM14bn-00CxOD; Tue, 20
 Mar 2018 15:46:33 +0100
Date:   Tue, 20 Mar 2018 15:46:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] -Wuninitialized
In-Reply-To: <8f6d8e2e-aba4-128c-f17c-6c1b9c12436c@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1803201514490.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <8f6d8e2e-aba4-128c-f17c-6c1b9c12436c@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fYodNblbqo+iqStna0solg7hEvG7O3sMmAr/8p7CuUnSEaE5HXe
 rUjaQlCLJkXpToei+9F9LqNm/+qeJgPHNZ+XN1hNahYkOR7V1M/7f3fCbDVNOXsI2MqmL2v
 Sc8X5iazw8VeKUDfekUtZF4i5eky1nJqMh3+MYj2ADQaOHCjq+iSqRU1M9yqKdL69A5RQLF
 aVnxCP8im2pDls/9YN9Lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lvYmGleyg8I=:SEW39aX+cS7jk6LXcXlztc
 9KfsJA2atOesL2BWQIUdr+aWFI4Cn0sZ0ouoRtcy3kqWhxCwuiiXLlQpWAaDIUKEJJ5EFvRyG
 m8lqrVbxEJYDY1gn+IWCdeO/wxSX4FbSvZDQnt/RWlZOFz7B3LVfrNQdSDXZfiPbs4gzhVrI0
 cCBHUQpwWlNHkooff2aaF1QqmALka0m5Ur+OxuIzW2MaTj4oKxbiN8oI4N+B7IR7VARGXdIfs
 w3SwUDIQEkX2pM5xAyZRduDRZuSJ0obOwwfoxNrlhhiDgtnf8jm6I2Xchb/9jp1MPMBoVzA9P
 3X8kd1lejUUb27ek9fXPAKTE/atXvVupPHWtcUCBmkNN6Jyo9W1VVoJbaZZvgdjtoI4LIq+XT
 ODuYGyKVmCYGzWXuc8j4r2vlobDmDL5qq0CAQWgOQJoIruJDNn9WsJMqr7FeBucEbJOMM0u3h
 8BOWkwKCxxEVVYDKZGrhZuCBRqEMlLLN00+tvYl+grpRY2YwEfjgaFaZFwoJoBLoVu1FopG6i
 mFpTx3HTbyzkUfhgwYB1N/UPuQ/+2WUgsa7n8nCpUBkbHkpkVpZsMLUG6dllPg6+jdVNQK/66
 GX6FYQqiCu29BG+vm+oBPg2W3KLf8KvGVznFujVZnwx9bkhXuh/uMf7CMX9vfNN2LY5YdRWfV
 Ip1wQnAgMp0y61DFekLBcyxyins41sd9GHz2x8l7r5EKAbPRjSaWbzKhqvgDI7+rvIXAaGAUc
 c1+a01q1EaCJ9Dk8xMI7aHGYZCBH2efi6bsaCZ4Gj6+gWQTU12vIqRsLGWyRgrKDW/q16J5Rv
 0kJKoT+uiw+ghH6spOWqwP2uoe1g9hwPi7e4vDRg6LY40fvFVs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Mon, 19 Mar 2018, Ramsay Jones wrote:

> This series removes all 'self-initialised' variables (ie. <type> var =
> var;).  This construct has been used to silence gcc
> '-W[maybe-]uninitialized' warnings in the past [1]. Unfortunately, this
> construct causes warnings to be issued by MSVC [2], along with clang
> static analysis complaining about an 'Assigned value is garbage or
> undefined'. The number of these constructs has dropped over the years
> (eg. see [3] and [4]), so there are currently only 6 remaining in the
> current codebase. As demonstrated below, 5 of these no longer cause gcc
> to issue warnings.

Thank you so much for working on this!

In Git for Windows, to work around the MSVC issues you mention, I have
this ugly work-around (essentially, it has a FAKE_INIT() macro that either
performs that GCC workaround or initializes the variable to NULL/0):

	https://github.com/git-for-windows/git/commit/474155f32a

FWIW I just tested your patches with Visual Studio 2017 and there are no
C4700 warnings (the equivalent of GCC's "may be uninitialized" warning)
[*1*].

You can find the patches (your patches rebased onto Git for Windows'
master, plus a patch adding the project files for Visual Studio) here:

https://github.com/git-for-windows/git/compare/master...dscho:msvc-uninitialized-warning-test

So here is my ACK, in case you want it ;-)

Ciao,
Dscho

Footnote *1*: there actually was one, but in a Windows-only patch. That's
what that last (fixup!) patch on my branch is all about.
