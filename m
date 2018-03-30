Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E411F424
	for <e@80x24.org>; Fri, 30 Mar 2018 10:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeC3Ks5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 06:48:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:42893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbeC3Ks4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 06:48:56 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPqtK-1ewtVO00Cg-004x1l; Fri, 30
 Mar 2018 12:48:52 +0200
Date:   Fri, 30 Mar 2018 12:48:50 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-for-windows@googlegroups.com,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc2
In-Reply-To: <xmqqwoxw6kkk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803301247490.5026@qfpub.tvgsbejvaqbjf.bet>
References: <xmqqwoxw6kkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XaB/4Fmd0X27nHiTUVlgkwI7pSE65A1tyPcmBOUm0NDK9PlA5dc
 bYRbupTqlR9VTPAzmYUHGWFBIjHXuajcAHaN0mQKu/v8mY2GMjY9AHq5y4ZK4fj8t/mxkOV
 5yaDsPVGmWxvvgd1VaHx7+zt2srriZvonM0hT31uFEHDdzvXJMI4cqjpYz1/1VCGTjnVN/T
 /TpqQWE++Lu+SZB5gyIOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:83s9kbqoB2Q=:G5UFYFjXmw5r1iKY6+CClX
 EQIN0U+jNhgI7TFHDxpXgIs0Gw73jsKdyDXow765lTWwfNjomWPXQNIhN1bvJjxvuec94osSt
 2cH7BPAjdBTdhl8MLvvXOpTkhAfTAjMZVX02XAMpJp5qSCkIvgYlwhGyK1UEgblWhrfnzM/JB
 wm6RLPXfs3FCn4mx4iiEs/iM9zug+9W6uSz7vpULumeP7qC8/qjoMnZioSy4LCBUoObjP07vf
 kqytGPy9F9fktp8VtZbu/VOGYBuQXVmTb3jzUTKlJnwrGaDNHcfP+AU6QUbc66WlnRZvTs6e4
 3g+7r1Xb9hS80HhwGkSqFjXC8m3ureX2AClcugcgT7TmLfkVBJtJ4KXXc3SKxErv2smGzKqNk
 dhC6siGY8Untj/opwKCpRAzcLi2nQPDW8+ugLaH1xicCtuh20Y/pRZJnzo15rgjm5mYdOrdKH
 hmSJ1Te48XLXsnaPBQiEwnbalbPdoDXEpmpVKRKg6Z5GCt5yNN6lsHAK3Dw2z6w4M6sNgjkEY
 ahzwjcBwLuN5Y4fNy8t70zUqwAzZ/f6BuE1FeowhN+jzWKjJaQCslULkXne1hQZHRB0qEZbX0
 H68zSunJLshHRq7t9bDs24KO3qtsMlB6Kl6/+jliJh1RUVPycKNcHkI9zw1UMSTwkEavAiMJh
 yUCDj8grmwSj+sSNj82Z1TnrPfOeQJbUezL5uL6kZy3rQYvWfenHUe1D2qAeR3V6QKqIzJCWX
 FIbMEo9xbgwyJa9fG212md2MVXGp9qTjz2B0rL7m8Odha+ZYg0lYc8+cBslczcJL7Pbxx7YI+
 dtpqM7ZwB4rKahC0p0O79GUQxWJXNZF3JBC9EFMJrRCRy7v2NrzsqL4yrHZwj9wBdWizdHo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Wed, 28 Mar 2018, Junio C Hamano wrote:

> A release candidate Git v2.17.0-rc2 is now available for testing
> at the usual places.  It is comprised of 499 non-merge commits
> since v2.16.0, contributed by 62 people, 19 of which are new faces.
> 
> I am hoping that we can have the final version tagged at the end of
> coming weekend, before I fly out to Tokyo.  I expect to be offline
> most of the next week after the final is tagged.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/testing/

... and Git for Windows v2.17.0-rc2 can be found here:

https://github.com/git-for-windows/git/releases/tag/v2.17.0-rc2.windows.1

Ciao,
Johannes
