Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2790A1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 11:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbeFQLMR (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 07:12:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:47103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753932AbeFQLMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 07:12:16 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuOYx-1gBEpp3Q2R-011koK; Sun, 17
 Jun 2018 13:12:10 +0200
Date:   Sun, 17 Jun 2018 13:12:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.18.0-rc2
In-Reply-To: <xmqqefha5o9g.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806171310190.77@tvgsbejvaqbjf.bet>
References: <xmqqefha5o9g.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:De8f9+fEPdgj7g8GAFMr1GQDrrWCnUpRjvl5WGGrRl5ujyF+hb1
 gZr4LbFarSgeLWqyYcvwwkb5r1CB0R6Jf0hms70xbIxYxkpZZzqBtJP+5fwG/Mkz46mAmmj
 OW/BnqTgUXZBHb5h8rMY5gUoCUK6mqWcPgQm36BOGrU4rXiZ0lgb9GEb0P/syTc5Ow3+dte
 TJ38YwJh7HYnhpnKyMgzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oDsUW4uCJdQ=:uzjhVyQbNxWJx58UCB+QRM
 VDyNnHQ5rCkOfjQo3+EYi3nJ0HQi78P5HErAmBUYpI2vlozsOK74ktQDkHgtcnDz6zLvrgtJ1
 h2uBmXPRxHRrU0IpJeXNwyGihSxWL7icw6fma2t1SJIKUiBNlNlx3p+8gGpM+jUL1ncgMPpSm
 LU1BDzHGP+pETNMytd6KCybLlMoxFk0S3DRTqv18srWRbaE88RNTx/Z88VN+wd9NbV4jHyVh3
 9vuJ0Ve4GJWMMoyXmHceu3DyClGvCqYKRJ+1a0T34RTD7dsz178OXHuLueu7bf8LrHboh1LJd
 838Ke1ZqHXZSwiw/6gklLeBV1z4xeRgNGmxOAjSuWILenfmcDldNaE2woS8mJcudkxI1UYpCV
 eOjwS+7oPiZgQLwv6p9wUfCvR3kZdHP7H8SAXUL0Q9sZeOwBQihPn+Am4YKRzQXWdJlOHQgBI
 zXfOSeYLnOihfO4GjEZsTFnlt3Jt+2czl+vzxw53QmbqiYQAvbIs0ldqpU74xqM7u8Z4Klwio
 w3cNrfiTDUHoTyONqZNAYgAX0svWNke0hsDgzi3JAmcIxp32P/wUxySiVQLSCytNnFaw5OX6y
 v4oiTx8El1m7PiCtIU6Mb5vOHXhFNcG1uC+F9lgk0FaoYMzTMTdPtJnvzGL8yw+CsOyg1vBNz
 mFwyviUen73HnBm/mTe3aafLqhF58YPlPMHDtlz1G6SmV6AiLCR/MP8uUkBAmzL90sZaxAd3z
 R0QmRCaHWBEs3czCAaixcZf9zfZ+H6y65oJ2puPHhAgBq5KykyM1L/TRVFsCCf7znc9IlWO1G
 4Nohmcf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Wed, 13 Jun 2018, Junio C Hamano wrote:

> A release candidate Git v2.18.0-rc2 is now available for testing
> at the usual places.  It is comprised of 852 non-merge commits
> since v2.17.0, contributed by 65 people, 20 of which are new faces.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/testing/

Sorry for the delay. I had some PCRE2-related troubles getting
Git for Windows v2.18.0-rc1 off the ground, but it seems that v2.18.0-rc2
went much smoother:

    https://github.com/git-for-windows/git/releases/tag/v2.18.0-rc2.windows.1

Please test, and report issues at
https://github.com/git-for-windows/git/issues/

Thanks,
Johannes
