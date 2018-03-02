Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0BB91F404
	for <e@80x24.org>; Fri,  2 Mar 2018 02:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164461AbeCBCwc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 21:52:32 -0500
Received: from avasout01.plus.net ([84.93.230.227]:47900 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164430AbeCBCwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 21:52:31 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id rao8eQPhlyLu5rao9euiqJ; Fri, 02 Mar 2018 02:52:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QqtwI26d c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=8jdEQNyyyAUrob_g0QsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] sparse warning on next branch
Message-ID: <dfdc1b9c-0d64-fde9-e84a-ca5bdf0d47ea@ramsayjones.plus.com>
Date:   Fri, 2 Mar 2018 02:52:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMYqovEshwQlHwcYWfzvRZC6kaeeG8FWNFmDylQ12SGDfdyqLXFEMZNXMzNrjy48uM/ufGP+kR/Yk6iL4OAl6HUuomS2I8DWbDK9wCZaa/FZqQXZTMO6
 gdmzH4Q3Ou/SJaXPAc2tq7k2tqXxpYqteqsBkZcF05oQSq4hdxx1cQ8WJsnZIOJWdJ60ghC9m7l7tA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Tonight's build had a sparse warning and an additional ./static-check.pl
symbol appear on the 'next' branch. As you know, I like to catch these
on the 'pu' branch before they graduate to 'next', but it seems that I
missed these! :( (The 'pu' branch is quite noisy with regard to sparse
and static-check.pl at the moment).

These patches were developed on top of 'next', however, I also tested
them on top of commit fcfba37337 directly. (Note, this is branch
'ps/contains-id-error-message' merged at commit 9623d6817b).

Ramsay Jones (2):
  ref-filter: mark a file-local symbol as static
  parse-options: remove the unused parse_opt_commits() function

 parse-options-cb.c | 16 ----------------
 parse-options.h    |  1 -
 ref-filter.c       |  2 +-
 3 files changed, 1 insertion(+), 18 deletions(-)

-- 
2.16.0
