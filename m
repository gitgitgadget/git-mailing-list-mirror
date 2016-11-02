Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E496C20193
	for <e@80x24.org>; Wed,  2 Nov 2016 17:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756183AbcKBREZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:04:25 -0400
Received: from mout.web.de ([217.72.192.78]:62551 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755593AbcKBREY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:04:24 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M0yeJ-1crbHK1sb9-00v4yB; Wed, 02 Nov 2016 18:04:17
 +0100
Date:   Wed, 2 Nov 2016 17:04:15 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
Message-ID: <20161102170415.GA6420@tb-raspi>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:w8nQSPzXSmw0V6VgSOk3KHvjpAUyvoL7I9Rmtq+q1082PjjTcuU
 2f+r2OxFGAtNRo2CEQIlmT1xj6gY1YMdN+AyuOukDofqlaAkDe4UJMD6fTnbD6MO7JzthWi
 A7QpWlQZf6VA1/B7ed3PcOkLDg45bLbYkOGwhsf7IdjQ7uhBOd/te/03wa9MbKhjAO45kK+
 mbPSeuuNNl5enA4Ak51Iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iNe/FK03fWY=:VE/M2UwFENtxOEMSWoevP8
 vs/J+SxHPlXMYxXi+PIodTeeWnp/8bbHM1NMC5DN0CvNBWLcVUqbaVSyUEKTq0QaBLJZEvcL3
 uwfC5ZImYoblahbUuy/PQ8whmq6S+mOfF2H/04vVTO0TUnKo2lhSBLg4H6/qCVizLDkJW8i2k
 yy0BVcPhryGiNlr8lJ+p7yu8s97xH8Tg3vr6MDamZYG6yTLFY7wD8tgFgDpN+7zeBKr70QP3H
 X/nJxJsCmxhwcLwXWmwYZh3B6wr9hWuCJ8HaKcHFnMxrOUt9dun/+YnbYCgsD3ArL4ThHwYMO
 cnRs/grgTBUiFqSszqKsI5b+Pxka2VfUjbcKRsNcDxx63mr6qi9KxRekz5ah5x9rinWzPWrlC
 uATOAsil02Fknqtx8jaK0AoZqxqoYvgTMpZs1GnROhp+VAEmm3AGdsuhNaU1b9M+BvxHH04Zt
 XBtFlCLk+NjtF9fxDwj96P+jBEVmuoFdChVI5mTzyiGUQsJw2fWi6Xb5zwzAjA/hgnV6Xx6xB
 lbRGXLqTfIIvqYyY7nDWz2HkEALZU2mvVp7+szUYpVaSodJFitVVVMw4jETlvGhws8SiuLM1t
 9X7uhksL3b7EaKrKv1SmurNIiWse5+mdSc20cB8MpfusOz7wMvPiwHUheDftUZsD1M/xVrOTo
 yzxo+Vvh7snoED+gFi8HA96Tg5qyWEy+KNzJ4YgKFHHLN7/JoUrPX0xmkHbHIXvqCBX9sG0ij
 eKoZnORrAMxktRGDZF/B0ktWj2RHBVhliSKx0KCQMZ2Mjm+JGNmbQI6xUW0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * ls/filter-process (2016-10-17) 14 commits
>   (merged to 'next' on 2016-10-19 at ffd0de042c)

Some (late, as I recently got a new battery for the Mac OS 10.6 test system) 
comments:
t0021 failes here:


Can't locate object method "flush" via package "IO::Handle" at /Users/tb/projects/git/git.next/t/t0021/rot13-filter.pl line 90.
fatal: The remote end hung up unexpectedly


perl itself is 5.10 and we use the one shipped with Mac OS.
Why that ?
t0021 uses the hard-coded path:
t0021/rot13-filter.pl (around line 345) and the nice macro
PERL_PATH from the Makefile is fully ignored.

Commenting out the different "flush" makes the test hang, and I haven't digged further.

