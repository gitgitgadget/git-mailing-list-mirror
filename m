Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CD520248
	for <e@80x24.org>; Wed,  6 Mar 2019 12:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfCFMro (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 07:47:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:59567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCFMro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 07:47:44 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgbvP-1gdXpP2RKZ-00Nyqo; Wed, 06
 Mar 2019 13:47:36 +0100
Date:   Wed, 6 Mar 2019 13:47:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903061339260.41@tvgsbejvaqbjf.bet>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+P72qBd2Q6Sb2yqspk7FsVPzGTrO9gJLbxuVg7iYK5t1ABxF6iQ
 75In4IAm0ozohgxBGk/3G3DkUIBcg5vC6U9667QLOL0ECmBrTYFAGCleyhJ0BNhWKYWFeDx
 cApRBFYIVQP+9coAJ1BhxzWHvPrjNGMgV7SvM+IL+ga3kV3LmgpONtACQPy8dwYHhIgFC5D
 leb072JN4UVXRaqaMVBJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jytAB8KsKkc=:WvfWPuwPnuzo7uhr6da8PZ
 2oUc9FgtEtLJuV/15ZT2fnb5iOe7vb5UCmqF2IKE7LrQSzo9ZayvRj6j4Q3/w+UiBry+83dpz
 vg62GMAjqbnw1lsD5zmmOmSVSWdTWTtL2IlCWvqaAv8MuNVyXiYjghmy9z3LPrytuz5wLFAe3
 MJMxzOrfF0uVndVnTNaAQi7FZlX/hmvtwpGH98+VL9jLqXh3RZQvKz2SCuqmKQW0aAuLnkRHm
 jkxQJFPIkDLNHooeSyHgBHT/2R9HQ7QlS15yqobJI3txXj145kiy6VEU8wUdOfcTNwEJ+4hKw
 nL3nW7JfRkJqwtlJdK/L6I4GezpnZVh+4v4/llATpyT3Czut+NwsXrMi9Ol9ZnTvmq/O5UlIT
 OcpTnqjGc7vVD896xuOAVChOgCBf1gDRV21TIs2kf1ogtozT9O3Yl6HALDlGpzalvu+2+7Dwe
 Z98B9LquUNR4juZVKK7Bb/MrpM1iYacUqwTW2rfSTqn5Fv1tvIXR7ELhWtVVKHEUto0mV0ZFA
 N9oAxc6wKeAIpX2rzo2cRCfCTOHjRLi9NaWVlmFu8g4yXhZcRR17gY4sGL2O2gFP6UjOKoBD9
 ipFCQMmXMEUQJp08s7MC5Zzr5vGTPb0V34EhSIHKDmHIIzrKhVU/0uEQFLCFnONh0n7A3H664
 YwBJKAJaK9aDf1weaZxwISmjgy7XQpqe8NEISNcsnRceXf4IPK6HeBTwrREQVY86Hy9U2mqUS
 V4MVgwcMF75tDunHRwRihFaHiPtJACApzfwTseMY12x2QSgeWNoAcypgheFyDJ4W/l2g6TBCh
 gzS5jaC9lkg2Nq40Ic/kcOljwh/7esGhgwnrJ6Q6fP2cE8/LEYPePedRt+d/Qxz20Qk8uuft2
 Wj2VKRWz2ByezYQiwK+TGwI+BQGtjfdQx8ziBv3wfFqqmTgc8X1x6cZa8GMeFNfldx+wzSa6t
 cXE2IG1SbnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Mar 2019, Junio C Hamano wrote:

> * nb/branch-show-other-worktrees-head (2019-02-01) 3 commits
>  - branch: add an extra verbose output displaying worktree path for refs checked out in a linked worktree
>  - branch: mark and color a branch differently if it is checked out in a linked worktree
>  - ref-filter: add worktreepath atom
> 
>  "git branch --list" learned to show branches that are checked out
>  in other worktrees connected to the same repository prefixed with
>  '+', similar to the way the currently checked out branch is shown
>  with '*' in front.
> 
>  The top one probably deserves retitling.
>  The second one is of dubious value.

As somebody who likes color [*1*], and who has *dozens* of worktrees, I
would really like this to hit an offical version, including the second
patch.

Ciao,
Dscho

Footnote *1*: I am a big fan of *all* colors for *everyone*, e.g.
https://timewithlyme.wordpress.com/2016/06/27/pink-is-for-everyone/
