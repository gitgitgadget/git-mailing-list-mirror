Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788C220756
	for <e@80x24.org>; Sat,  7 Jan 2017 13:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755788AbdAGNsP (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 08:48:15 -0500
Received: from mout.web.de ([212.227.17.12]:55969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752542AbdAGNsN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 08:48:13 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrLo-1cPrLt0lsm-0001Bj; Sat, 07
 Jan 2017 14:48:09 +0100
Date:   Sat, 7 Jan 2017 13:48:08 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Steven Robertson <srtrumpetaggie@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git filesystem case-insensitive to case-sensitive system broken
Message-ID: <20170107134808.GA30644@tb-raspi>
References: <CALwf_moJFqCKcc5Q=CC6aSSUAGqXEFDKrJUkdwov8shqBRK=yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALwf_moJFqCKcc5Q=CC6aSSUAGqXEFDKrJUkdwov8shqBRK=yg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:C/gmHTbTESRbkksxhd2WoMW6kWj1AbP40acKjzhbw3Sp8X3uZsU
 D0V3xuQOyvegBRoSOxC3MwZNwYLiCkq9rdsyomKDIzpda1QMUMT6ULL9OHNs9Kol3HECJMj
 7U+kniUK9tc1Ig0icBAVz+ZqDKTbCjsPRI2HzbfZdCHYW3vQpPDxBc+wwUjDCYm57ofazlE
 E60Pfuwg2M3XSLJ7OSdNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eLmAYE9twn8=:OJjJabCUekfHc62zt1BhRU
 nH8iGx3cXIhAiqAt1Hr/acimX0ijyJ3hP2s9HYavWPzj6yaPITmL6pZckTwQ9J2Lh5poEr0pM
 lf0T6plrql9Sn6QqBHj6T7fuDX5d2ROrXLlElQ1c3UlwPTjK6jLrwNtwwLNWiHxEhExMPo16b
 eFY0/J21+kKrzV92auQjgVXTdhmcjHu2i1HF5AEQVaKuEb0K0bQ2WEgDI0rzu9RdZn+G/0NMq
 pkUU4mrz45ZhbXWBowz0xHbRXu2fE0Xs0dL76B94eHKmTTkOhyMGA/UFf254JPFJsQFHRaKSY
 CZDWPZF1HWUpdW7cBCWOtgOLWT4jBghb17mILtAjs/2mg9qnXhyQaHzG28hnWz3bRYbXRkgVw
 Q/vQ+0xIz672AzPmjPDdZ71TGMpvUBfLYrJmhSjtiaBtcD3WG17+NghyiXz5h8umBFFhOSRhk
 TPazIaO1h226Y7LNa1gk+H7pnyV3lrBthCK2GKbc1dgaZbVSQyxZCZPzlxM+Bp1174oXgQew5
 VuhRhYczm1OrfLR/9Q9U/p4+3Jebxjye/RPuwuFdQ/eI+Ml9cr30CnfURayc7c/WIu5cbCVp+
 MQt20iw0yS45ZTJeOZy3eoVmYVOOFSkYDK6aPLNMyszOB50BWH4k1O+J9BXD1n6/WHT5kPUSd
 YfFkSGunsbxM/etPUUvrxaxmCN48XIfIe9rSruWLvM9oHtM12BjxHIMBAn/etB+gLYhqDubIK
 kdsNqiBT1FmTT7l4X6UUzorLlaccNF5G/DNnL9QCFZsenWLpTbOx7e9rOSY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 01:56:36PM -0800, Steven Robertson wrote:
> Hello,
> 
> I was doing development on a linux box on AWS, when we found a code
> bug that had me switching to running the code on a Mac instead. We
> discovered that we had accidentally named two files the same when
> looked at case-insensitively, which made git commands afterwards
> display the wrong thing. It looked like this (ignoring some things
> that aren't relevant):
> 
> $ git status
> 
> 
>    modified:   tests/test_system/show_19_L.txt
> 
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> $ git checkout tests/test_system/show_19_L.txt
> 
> $ git status
> 
> 
>    modified:   tests/test_system/show_19_l.txt
> 
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> $ git checkout tests/test_system/show_19_l.txt
> 
> $ git status
> 
> 
>    modified:   tests/test_system/show_19_L.txt
> 
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> $ diff tests/test_system/show_19_L.txt tests/test_system/show_19_l.txt
> 
> $
> 
> 
> Those two files are different in our repo, and as such git thinks that
> we modified one of them when we try and pull it down from github
> again.
> 
> 
> Thanks for looking at this!
> -- Steven

I assume that you are on Mac OS ?
This is what I would have done:

- find the twin of your file:
$  git ls-files | grep -i tests/test_system/show_19_L.txt

- Let's assume it is the little brother:
  "tests/test_system/show_19_l.txt"
$  git mv tests/test_system/show_19_l.txt tests/test_system/show_19_l2.txt

- Check out the original:
$ git checkout tests/test_system/show_19_L.txt

- check:
$ git status




