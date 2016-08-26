Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444471FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 14:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbcHZOJh (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 10:09:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:55038 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbcHZOJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 10:09:35 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLi1v-1be7253j5n-000qxh; Fri, 26 Aug 2016 16:09:18
 +0200
Date:   Fri, 26 Aug 2016 16:09:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #08; Wed, 24)
In-Reply-To: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608261607050.4924@virtualbox>
References: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gr2PRJvgyJFkCwEPQQ0TMYyiV4DYiE0SMWySB5TRMOiMo+XUHCZ
 SGDhBiJnCfKkx3hDgSuvcpyyd/hWEM9p1owljcamd9AIKbQFXku39bjpd7ca/Cn3wuMNRZT
 7gCamd8dDJWpLQ/qgkqL0aQ5ZETw7zv1M8asqNQn1OmSUA4kJBYRZFWkHO3sAc5Ao/42MMd
 PmG0m9vrH72KGX4QSBGQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w6EpggwDgfE=:qHqr/2ViMKYol+pDkRvoFy
 HKUh6nTOLY0BQcWiFulBO19Me2/idkS+pStNx9lS+Jf6xBDoyJAJE2zPErX/igzqHHjlvvwH4
 iND2aV+770ym2jCciURZd1HrE8ei25t589pbHkaDU0pRqwhXBExJ/WmXcH0vyPLXzGa9Z0eba
 9zwE+Az+LS4sMhsnPqK2PPWvVR+l3eUooj0F91Bp31KdP+pFSGMcKbyvXrGuin3RupMp2dZRC
 vzN8EYxwuvneGMIsvSvesgMUbZcwRQGMtE4uX5owak/XT8g9SBo+9RKXeoWtdvalIzkiel4C4
 aBmQagQEg53s8j5bMpqMf7YySDxmq0zNW79+ulX+E8YFF+ZvwFjP301jLaF2zejnAxFoEvC7A
 HbOyaOKjOHIHxNEhPR7+jRqMWdJqY0YRH0KUpS1iCHtKawpgjUnMt8RdI0PWbZFn/fKjEinPj
 mpY6Xk5iE8R1vrkuZw/dRKGmBnjSCLh/N8rgllj81qP0BqvAAjr4yMTRkHX2oEBv1/UiAoIU8
 KbgZc8VYhG3s1SjYI9/BJXHqh+XzjT82rd47U+wERgYnDOtotm7n2fqIsZ5SLLVPF9SoTP72s
 KOY6Qu1aMB0GzSPSbwL80L86ITsHyONc5W/+Xy9mjMupxbXtYYFXolHT4wKSvOHnnxFEur7JF
 PQu/VoRdyUYMWmFlo3KxL0S+yfgMjagHSW2nd/N55H1JNZOh3KQ1zCSh8MQvp9Ahnv6yOLHsi
 /GRi1j3h8l6LRfafmbiLKYN2zDwiJPf4z5jW+3+uA/vn6Za/9EGt2HJsaYNYHgJHig4IqoS+u
 SKT0lz6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Aug 2016, Junio C Hamano wrote:

> * rt/help-unknown (2016-08-18) 2 commits
>  - help: make option --help open man pages only for Git commands
>  - help: introduce option --command-only
> 
>  "git nosuchcommand --help" said "No manual entry for gitnosuchcommand",
>  which was not intuitive, given that "git nosuchcommand" said "git:
>  'nosuchcommand' is not a git command".
> 
>  Waiting for the review discussion to settle.

Not only that. For a week now, two of my build jobs have been failing (the
one testing `pu` verbatim and the one testing Git for Windows' patches
rebased on top of `pu`) because the test does not actually test what was
just built, but relies on the Git man pages to be installed.

So it needs more than just the review discussion to settle.

Ciao,
Dscho
