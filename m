Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C3B20954
	for <e@80x24.org>; Fri,  1 Dec 2017 14:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbdLAOcO (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 09:32:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:53374 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbdLAOcN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 09:32:13 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTBfe-1eV7Ow3BLy-00S5OE; Fri, 01
 Dec 2017 15:32:08 +0100
Date:   Fri, 1 Dec 2017 15:32:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org
Subject: jn/reproducible-build, was Re: What's cooking in git.git (Nov 2017,
 #08; Tue, 28)
In-Reply-To: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712011526490.98586@virtualbox>
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fsN8Uur3V8Zid6lzWq8R/3pwHGcnpTbFftD11bElkXuyLZ0ERhp
 Qxxzqigx063w3W4S1qs0KYSjB1ouig6vROWZAYoHWjUAGf7oQv8eOGYXfg1gXkHb9a8ZV2M
 GJDm2ROeGZgd4nV4TClHHLIyVFz9crwEZqMDlPvtULJ2B48yHQMF297QdYkKC9rWgk4zF4D
 LOBTski1TUDiEUuoqZhnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:06N9sHeWQSE=:hYuyIvyzXynX9QA8p+3l1A
 +uY1grpFwUZJMiI6jQtB+YzP3D6xqknK772lhM1m+3OIgoxuuaWt6/SoWhLtT9tuNo2eES9tj
 Kb9r6P1ap99x2VTSF6Z+CkQ1YIaagcgoxdV2xjR5ckbNCYryGpQzenLqwlaAUBwC1JXOhhhB9
 +HAm1bK7/XQixRgaY/bjTxseYEUMk9PBZc+99As4W2Pxh3zRP9v5mmhfTXQB/USgyO0hUhg4j
 Xoso1f/gM/w8j5YZBFJ4I168eBQCVNdnmp39Gt1jcWOaF3q3Gd0hLkQhPs+MWyB3Qq+jcj2Sf
 +W0A7boLy96+p6L75TfzBt2gu4NKZJiKmM6DOfpzkiANUnRovhvZpgycl7WnZQHWyLgBis3ak
 PxoICK5WEaN5sD5BG+QH5DxjKGgaKxp8SUiqmelt5dnDSumWv+pkzVfVFoxwHU7PRDRgU/FWm
 7pcf3qgAE1tstqALj+ocVYZeK2WUkM/DTBgDQte+H8XkveYUvekr+JO0uK5QRsHpQPwIZ3f2U
 JaCTs52OvSrgJQ4613zazW68hULkDjNttMaJjYJ6t9gZg7Gm6FYVYQtdRPNZEdHLfca6L/Gj5
 tiWniVjvcNfScsHoDMqFSpKuo6ykbaIpnWVO4aL919V8esIQXowIchYAkojdqKgxdI8mEE5q/
 AnVPQAF+6WnzP5CDyqnKYVpDsJ/eArJW6ltVXmaArEOoQVAluCkbqBbo2ypjeK7b3lzp/++SI
 7ANRpzcuBtFrj1bEmglDMnSKorDCrhP5i/W8vilGqncYRPqtFwS84ehW1ko86rQZJ8OrDANmV
 Yi2LqhLJcd4wR9/27+tkTWeWMJm1J9H21CgzX+UYAVDSJnSOvE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Jonathan (Nieder, there is another active Jonathan again),

On Wed, 29 Nov 2017, Junio C Hamano wrote:

> * jn/reproducible-build (2017-11-22) 3 commits
>   (merged to 'next' on 2017-11-27 at 6ae6946f8c)
>  + Merge branch 'jn/reproducible-build' of ../git-gui into jn/reproducible-build
>  + git-gui: sort entries in optimized tclIndex
>  + generate-cmdlist: avoid non-deterministic output
> 
>  The build procedure has been taught to avoid some unnecessary
>  instability in the build products.

I like this, from a purely security-informed point of view. Maybe there
would be a way to integrate this with the Continuous Testing we do? Like,
letting Travis verify that the binaries built from a certain Debian
package are really identical to the binaries built from the corresponding
commit? But I guess Travis is the wrong vehicle for this, as Travis needs
a *commit* to be pushed, not a new package to be made available via apt...

Ciao,
Dscho
