Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA4B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 13:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbfACNYD (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 08:24:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:48509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbfACNYC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 08:24:02 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEKZg-1gYUSb3Bk0-00FUIn; Thu, 03
 Jan 2019 14:23:57 +0100
Date:   Thu, 3 Jan 2019 14:23:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ps/stash-in-c, was Re: What's cooking in git.git (Dec 2018, #02;
 Fri, 28)
In-Reply-To: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901031423090.45@tvgsbejvaqbjf.bet>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M7ZHR43tvzCpu4R4iY6T3e2Oqv1TC+9eEuiy8p2TCGtieBNkFj+
 XgY3s+n29MM1G9iOj3JzRbl+pWyEI1k51cRH6ekc0KrucTRibrTUPWmEhIr8EgFAbSWUimv
 pLkYiOZBVzB2fPs9xECAF6TSnWlkaHNVR6GvYRrzP6KcqyJztPhzTmBEE9uP46EpPWdLZdE
 SG5bPX6Iy/ZUX5gTGYHtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hFQqdta31f8=:Pi+jDB+vvRoF4hGQAOKTXL
 ej44Qm2SPy+XzDXWtRj2veti8aLzybpiRWiMgXvutWEmIN/J3kyRn6xaq+7IFw4vmeBQwTRam
 LH3PacybGcehndpxWhp28/sJdygZrIgRGsHyBbpjJL+t87BsyboWbjZNj9JoN8oPVTUZ2WGGe
 lNKI24YhlNZRitthFVndWeDxdsOJzh+rDgIE2BKzBkHOcHoOY43F4ykZdlF+uAvIO1nNfYQ4Y
 1Z+SpJWfB2lurGtHCDzyejr1yT0CLMQxf9AURUIRntZrLfaNeifqYtLNvWAWP336soMj375Bt
 uitNpfcWs9Noe3uQVRY9hXzGEH0JibWbdMTUp+iVPo3rlvkcw4xt78zX4WbQyODqMAgXTzTiq
 z48w+rHZA5XuE3c3TkyzjDmuAFIWtIowhvqglukUb09UKqQP2fez6kZiacBc7tzOrDhbaMEmZ
 qKkthrl3mSDclj2n2yx2J5OVcPVNYzl37U6XAQN3LNQMwWo4zHAB46WqYqwqEhUSBOyOJ5Bvm
 UX25GU2IPaLTQ2Yf5dnr1FSw1ic+Hf0WWZFx6TmWN6zNzNzWNn5iiWKx0klAqIOcUmMWBbhka
 frBFmW7lh3B+QlW3ysbSRQV19WUQZ4gsqqq9sNHTP12uhE1dMv4m4AE22rLS3uH30qJ7sAY9K
 aE+F3P22iRNVQPIki7wGy4F9CpgHVN+NQbrctGHV/we9p1ohCTg/eq2/P6snVzgNA3ddPa1j/
 Pq+JEguX1IEwN1arZzCq34AfdZQR6GfEqP4cwjh3A84R4cXRmb4Xttb89Z4WX8d5oqN5w1gIK
 nrLvFLdgyV+3ljSA1XgkRV16xRlNdu9HvyWOGhwEhjopxRAzTLYSwXXQjq9Mx432Z+322M0Ug
 JVLcyXsV6+KkfDlMItcCR2Qw3MEfrOtDIc8ARB1utTL31Knqzt5BQDkZyP7pKZbypiFIlzAu+
 znoCVQ86tXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 28 Dec 2018, Junio C Hamano wrote:

> * ps/stash-in-c (2018-11-26) 22 commits
>  . stash: replace all `write-tree` child processes with API calls
>  . stash: optimize `get_untracked_files()` and `check_changes()`
>  . stash: convert `stash--helper.c` into `stash.c`
>  . stash: convert save to builtin
>  . stash: make push -q quiet
>  . stash: convert push to builtin
>  . stash: convert create to builtin
>  . stash: convert store to builtin
>  . stash: convert show to builtin
>  . stash: convert list to builtin
>  . stash: convert pop to builtin
>  . stash: convert branch to builtin
>  . stash: convert drop and clear to builtin
>  . stash: convert apply to builtin
>  . stash: mention options in `show` synopsis
>  . stash: add tests for `git stash show` config
>  . stash: rename test cases to be more descriptive
>  . t3903: modernize style
>  . stash: improve option parsing test coverage
>  . strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
>  . strbuf.c: add `strbuf_join_argv()`
>  . sha1-name.c: add `get_oidf()` which acts like `get_oid()`
> 
>  "git stash" rewritten in C.
> 
>  Expecting a reroll, probably on top of the sd/stash-wo-user-name
>  topic after it stabilizes, with an escape hatch like the one in
>  "rebase in C".

There you go:
https://public-inbox.org/git/cover.1545331726.git.ungureanupaulsebastian@gmail.com/

Happy new year!
Dscho
