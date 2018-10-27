Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481531F453
	for <e@80x24.org>; Sat, 27 Oct 2018 01:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeJ0K1I (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 06:27:08 -0400
Received: from avasout03.plus.net ([84.93.230.244]:55227 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJ0K1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 06:27:08 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id GDhbgYe0MfmQQGDhdgjEBs; Sat, 27 Oct 2018 02:47:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Acuf4UfG c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=L3TNAYgMoFAgym86DSYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/3] some more hdr-check clean headers
Message-ID: <ecb3d551-314a-aeef-048f-c1bbe0b3c999@ramsayjones.plus.com>
Date:   Sat, 27 Oct 2018 02:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF5oGDxd73C+5r8kq4Zj8GOZfFp7Gz6lb9IAXBbdhhrs+zPxgxB9IvM6M3Qkja4X8vaaGlsdb8ihzjMXlhv9xRINvPjcu1W2Po0ySO0R9V+i1hZKZZ7b
 doRijFqEa1X3HO4fTHXrG6zYfmtU1HTa2XJy+x6QujqjKCHA2IjvVe8pvbGanAlBaLeNuD8lI/4JbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I have some changes to the hdr-check Makefile target in the works, but
these clean-ups don't have to be held up by those changes.

The 'fetch-object.h' patch is the same one I sent separately last time,
since it only applied on 'next' at the time. The 'ewok_rlw.h' patch is
just something I noticed while messing around the the Makefile changes.
The 'commit-reach.h' patch is the patch #9 from the original series, but
now with a commit message that explains the '#include "commit.h"' issue.

These changes are on top of current master (@c670b1f876) and merge
without conflict to 'next' and with a 'minor' conflict on 'pu'.

Ramsay Jones (3):
  fetch-object.h: add missing declaration (hdr-check)
  ewok_rlw.h: add missing 'inline' to function definition
  commit-reach.h: add missing declarations (hdr-check)

 commit-reach.h  | 5 +++--
 ewah/ewok_rlw.h | 2 +-
 fetch-object.h  | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.19.0
