Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5139B1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfD2VKx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:10:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:55287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfD2VKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556572251;
        bh=CqKi/mHN0FsmD3AwBZYqHCaST69u3MV35v3jdjwn4+w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gS3NUWeBX4PIpFlOx7kASDco32bICsFwLOegqnTzKTsLZ9fdtH5gz7gEHTvVV7Nh8
         4qiHedUdzyM2qV35GstqVU608kifKlhPAk6kh4hS5fvYZvD4ZtLvYzPZHCEL61DBbD
         0WdpeZD9BWVSOKjVgHJNx8Y6b3b0imdm5ktqFJ0Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1gc9x03j1A-010rvE; Mon, 29
 Apr 2019 23:10:51 +0200
Date:   Mon, 29 Apr 2019 17:10:54 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Aleksey Midenkov <midenok@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File
 exists.
In-Reply-To: <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291709350.45@tvgsbejvaqbjf.bet>
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com> <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DHhFbDzbm02KfkgjO64ZjQm8Yw8CplO5WSOmLZU4QT3eny4eEjM
 n2Aj1AFqEmX4J3GsHIMwZAGQb/6FHCNCBgwFWlCs0UNGMaD510zV8INfHYk8g1SE71+mlzR
 uLr0dObTyTpuKOImKvDBiyq1BJpXDXWz/pNFHqsB7IYRd3lOnlqmM/Ii0ll/ntBGvZLcWyV
 WeybTTq7F7ReHRtJ3Sl4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAFZtNDW+4I=:6OPUFcaWwVwFAEyOsO3XJJ
 Hnr1JILPO+TgR5NFBQHKx2FtZmMyF/BLeKBtUDX2v8ZG4Uvfp/McpCs/b0S05+yxn9MySv7ol
 Z+CX6iGHNDFgeAti/5/WmdVUv3mX4Ez+xnYrlovBiDKx3UUTvr1eAEOCpnGWRf+9Pxyc3Uqve
 IxZtjw9GmkTCz1anfFIUWbHvucRDi4+ai72UfzInXwMax6ZNk6UTAvgt8lmBlD8EYgmiCf4nh
 yP7eMFf3REwH2vOIQvzEeWyK+crNRf0fZNudNdlpc83tUt4sSOZB3grj/dI9a9G8ekT6Yv9BM
 /QSWtgGkjiArsdjgtetc1pjqz3XMk8ZmCte8+0FrgD9p69gpJdl816WcvK+wZ2juDQ/nimbeR
 M734OAHHON6bDvlxHeWLGqBi7078G1K89bmWIkCh9iXpzmM8bosiboYXxJnieSoW/9Xl4AsIq
 gNt2l/2Sr7DO8MWkZBbXf/FO2JC2GzQoJOUqlSfRuTS+94ZmYcfBrO56TTBZ1OFG6mEljOiCN
 KKjb4vVPOSAGiYHz0R9BR122R42uZf8TuVLw3Pwwg3FH6wAaUTMCeecwu18ayuU0HFaniSDel
 tz2Qg+/KjzLKgfTNab64b8SrbaKkzHpbVZyRVZ8z+d/TMtObna0JD4yIhuyPRpqbpOc6F8trE
 RfD6Nct3dzu4CprS5/eI2gj1Er3H8wZOpAHNX5NdUZ5MOm4IHf7ij3vv2zGe/ZehCzjMvSD7w
 +36wBw3V4db1JueYPDOVEaTwKY+O8cL0cjcz0DBr063GHGC9xG9JjPsoMvQtzhxL6hKZrsKSc
 gNQ05wsvTh8XlgTq5EJfwtKoqcIy4qZZ3WzSnbLjqAYc+wPjxrDgVHTcb/Urcod1CyCxX+YaL
 MqabYAJe3UDLyjhWLY9eYsXtSOY7Iwq65GEeGuZoHYPagqB3okXSkdBRvIdGbmi2NaxWtNzVB
 vI5BU/GBToA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aleksey,

On Mon, 29 Apr 2019, Aleksey Midenkov wrote:

> git rebase -p -x /tmp/check.sh base
> ```
> If the `base` is far away enough it fails with "fatal: Unable to
> create '.../.git/index.lock': File exists." at an arbitrary commit.

Does it work if you pass `-r` instead of `-p`? The latter will be
deprecated in favor of the former in the upcoming Git v2.22.

Ciao,
Johannes
