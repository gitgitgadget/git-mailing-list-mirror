Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E221F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 12:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbcJEMgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 08:36:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:54710 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbcJEMgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 08:36:03 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lomql-1bH2dH0Fkx-00gqwp; Wed, 05 Oct 2016 14:35:52
 +0200
Date:   Wed, 5 Oct 2016 14:35:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 19/25] sequencer: remember do_recursive_merge()'s
 return value
In-Reply-To: <xmqqh99kzua9.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610051348020.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>        <cover.1473590966.git.johannes.schindelin@gmx.de>        <44c455710fd9c420a3f759d021c4864f3a83c97a.1473590966.git.johannes.schindelin@gmx.de>
 <xmqqh99kzua9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cJUZZd50x/mpYZ6J3a7E5d5/o46P2QFUvut802/SywOh9Q8Gltf
 rdUEs8YFNxgo0JP0IIbNLlQuQ5yCGeW2ytS0ME99ArLWvnr9pVPd699f04LziK08Zh6PZ8C
 PYD8u9z7Qtu/7j/N2tbHdxiiaWgT9Isjn4kBSAWKYSBL4Xt7/P+P9mc3DfLbT4QhpoZ4g6Z
 1egKA23G84Bq81feX+WRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:prlUlbtz7x4=:6aaZFN00ZtP7hjtwFb0QVF
 OoXEXL6mN3qLiKtanrU9B6D9GsemagNZqnFyebCQRr919ET4eS6Qfte8tqrzF+sJih90UI1u8
 1UbUjGcYWtGz3mqQzQC6ru55jySe66nVoT9RZin/l3xhHkYdKoYiDCy47HCcQe4cnKEN3ZYk7
 8z+RmsGBbJogEsdTwxZ+wWBG6PyHO3D37iO58WqyZXMN9Aso8y2aqNWXIcUrLjeWgp0a/J4rj
 kltkNKeZ+OdeA2r0CL+OJzHtV6UyQ9+ajd2xYErjIYMeA/wpywkFcYx4W9ooqZ+NPYaNdAaQU
 2k6sFNBivlpM+vBfLPcLol+AmUTMBfxAoaKCOnPNyfATWqpfIsL6sN6l+OLeOyCQDOuTwyP42
 Xe2nmp2on5EUNC9xG2ediB2SHSN0k0hKPKQ8f3gPC9XtCGEA4AUKRUOOsjBA4Si5Efq3KuzQo
 J09qHzf/WM5h8d6qfL8sq1gdXkr7Xx6THSkZFbfKZipzLGz1HCwcANNmbvTzld8xWpb8Xw428
 GzyheAZiMIICeA060V8gkZGThCdP7u9iONGtHvn78TrPR21C4Zxvk4wb2jpo8UCfikTZ16M1x
 f1qwrgB5p5lwgMsCS5lZ8XyD/yIHf8eaF8SN7Any64SIN2gGz5S+os7YmJBHOCuJksiSBUA3H
 1JgIg/VqAlpkP5AdMzg+0rFkTHEQVHgiwtDHc1aAaNWEpms0TmN8W+PGP+XmR5RKxey5pBk4X
 8dvhEwWzsP3K9iEteb479V9D8hdVtSpzBSithI9Z6FBAjcBYmWQvYBzPNoMEIvZepIRjjaOyf
 ct+FoWc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The return value of do_recursive_merge() may be positive (indicating merge
> > conflicts), so let's OR later error conditions so as not to overwrite them
> > with 0.
> 
> Are the untold assumptions as follows?
> 
>  - The caller wants to act on positive (not quite an error), zero
>  (success) or negative (error);
> 
>  - do_recursive_merge() can return positive (success with reservation),
>  zero or negative, and the call to it would return immediately if it got
>  negative;
> 
>  - all other functions that come later may return either zero or
>  negative, and never positive;
> 
>  - Hence the caller can be assured that "res" being positive can only
>  mean do_recursive_merge() succeeded with reservation and everything
>  else succeeded.

More or less. The idea is that there are problems with the merge, and
there are fatal errors.

Alex and I chose to stay close to the original Python implementation when
we decided that merge_trees() should return 1 for success and 0 for
failure. In hindsight, I regret that, as it disagrees with the C
convention to return 0 for success. However, it would have been yet
another mistake to return -1 in case of merge conflicts: the function did
not have a problem (such as out-of-memory or some such).

I can only guess that the do_recursive_merge() function tried to undo the
damage by reversing the logic: 0 for success, 1 for unclean merge. It is
at least more in line with the C convention.

So much so, in fact, that we can still use negative values to indicate
fatal errors that should be handled accordingly.

> This can be extended if the only thing the caller cares about is
> positive/zero/negative and it does not care what exact positive
> value it gets--in such a case, we can loosen the condition on the
> return values from other functions whose return values are OR'ed
> together; they may also return positive to signal the same "not
> quite an error", i.e. updating the latter two points to
> 
>  - all other functions that come later can return positive (success
>    with reservation), zero or negative.
> 
>  - Hence the caller can be assured that "res" being positive can
>    mean nobody failed with negative return, but it is not an
>    unconditional success, which is signalled by value "res" being
>    0.
> 
> I cannot quite tell which is the case, especially what is planned in
> the future.  The proposed log message is a good place to explain the
> future course this code will take.

Okay, I will try to come up with a better commit message.

Actually, come to think of it, I will change the patch, as it is too
confusing. What I want is to preserve a positive return value in case of
merge conflicts, and that is exactly what I should do instead of playing
games with the Boolean OR operator.

Ciao,
Dscho
