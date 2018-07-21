Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E292E1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 21:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeGUWHm (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:07:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:46957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeGUWHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:07:42 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LraSn-1gAJhl2FmX-013MqN; Sat, 21
 Jul 2018 23:13:28 +0200
Date:   Sat, 21 Jul 2018 23:13:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 0/2] Re: [PATCH v3 14/20] diff: add an internal option
 to dual-color diffs of diffs
In-Reply-To: <20180710174552.30123-1-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1807212309340.71@tvgsbejvaqbjf.bet>
References: <CAGZ79kb4RS-KxEX+x07XsFiGwgG+1AiRUha=zcxexe1=RLL8kg@mail.gmail.com> <20180710174552.30123-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jUQIxGjIbUrV/1ny2NfujychLHl09vHv4LDUX18HEajVZR7kyq/
 DvDSmm24MGprQdTzFPwk4+ja2/XFb4hL3LtgREJey2uD5z57xnfywSJInn8WRpSsNwz5if4
 eqZxEBwIWackneZrP8X2YWY8f25JEzO48QDcrwtXqeiu8zVAvC+9Md9ZTrgfjhKS7NjIrd7
 zM034zPiFIJLNqEPvZoIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5AZU6FPq0Ek=:bfG1hWD2ieXukjSIeP20+P
 v3mdNMbdqxtBvgdbzcniBAvl0UfvA8XNh0nz0vJmPSXSMvyFfHyvViK+ZtBx9+Qy2pXH2Wjoe
 tEibtweAgqhlveVojVD0lVn6wmN3Bq6Bpbbim+fidqMYrLgksOlQntwgUBB909U68FEoKSHIX
 SI3IXHXGfSWcvUy0gi/HVD9M2H6WhLdaEU0sLRQTsO1jgai5toOSlblVmuMy/j8qDyxKqyRRG
 Mb2STTjSP+2RxIiHiEySZ6uqOzKWFge+NqrnKpzGneH1YiS7tTU9kMKyxNrvB2CATwkFcYdPf
 SVsCKRO7kHkvZiHaEm9TbJPwkuxtNrpiL2998+aBwo+EFl751SQgezr8e92D35oB2ofx4Ruq4
 eGl03OkROLdI+J4xxoEWL6VSmpDSjVQN4Ej3lkmdUbME0G85QhhAmfLC+7sjg65C943sUmyeV
 w0fcY8OrxuB6slnzpe41eJEdxGANy7gtZhfsmDOlncJ2VVW2CyG6CVj9O/HQHphrC8thZE+YS
 XY7hQpWfn6Qe0S1Ke1r2eEbYQ7njJ7NaWoWV9NmhSG5X7FnkL4bGD+/2VJoXNZXF62+hHZJ4J
 H4Utpx9rPJiOf6McgSVSVIw4u/gOM+HDedYEzogGdpNyjzfFgJeH2FxYcvXqGg6g0hp+TCEZa
 oOjkt3uc8zffH56yFR8q06d3QcQF+GYyBrjSWybREJU9wOFZqjETYOsSXBhuyQ9OpFs5mMw5c
 35yxDVeRnxwc1nW6GKjCxOxISZ4oN2g1VZwS9Kf2OZURTW8Xuempivr54925V7Pt4EtG+5Oc8
 DKQ3puK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 10 Jul 2018, Stefan Beller wrote:

> This is developed on top of 4a68b95ce2a6 (your series here)
> 
> This is an attempt to explain the previous email better,
> specially the second (yet unfinished) patch, but the resulting
> emit_line_0 is way clearer in my mind, dropping the 'first' character
> and instead having a 'char *sign' that (a) we can color differently for
> dual color and (b) can have multiple chars, the refactoring for the multiple
> chars would need to happen at a slightly higher level.
> 
> Feel free to draw inspiration from here, but if not that is fine, too
> (as I did not fully understand the word diffing problem yet, this may add a
> burden instead of just taking these patches).
> I can send up a cleanup series after yours lands, as well.

We discussed this on IRC a couple of days ago, and I think that this patch
pair was designed under the assumption that the dual color mode would use
diff markers of the same color, always. However, the dual color mode is
about *inverting* the color of the first marker (and using the marker
itself to determine the color) and then using a potentially *different*
color on the second marker (using *that* marker to determine the color).
Example:

	<background red>-</background><foreground green>+ Hello</foreground>

So I allowed myself to focus on trying to wrap my head around the way the
whitespace flags work, and how to adjust the code in cache.h/diff.c/diff.h
to replace the relatively simple workaround by a full blown correct patch
(which is sadly a *lot* larger).

Ciao,
Dscho
