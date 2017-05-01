Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40271F790
	for <e@80x24.org>; Mon,  1 May 2017 11:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424010AbdEALXn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 07:23:43 -0400
Received: from mout.web.de ([212.227.17.12]:57211 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034705AbdEALXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 07:23:41 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqsR-1dD9to008p-009jw5; Mon, 01
 May 2017 13:23:31 +0200
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
To:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
Date:   Mon, 1 May 2017 13:23:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/17lkCGw02Ufl8Rtegn7Omw4XAYN1Kq7NK1uQWh7V8XHYR84rWR
 w9y2yip7fcvTR9DbJiVkvP5d7uXPOeB/rZh2Rv/IFlMsa8JDYNGE1ab8IJkIHvNw7D93qH2
 lYgdx42rSVGCqmbtr9Q1LOBT2cekXbwlm2LsCczILVcZJ1A4+tWC0JHVln6VwVLYLhIFmka
 48ysbd7mPzC/wzTNcn1BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QuQnltReX0k=:GOapCN/ZXoxIBNUoNdxYRY
 /xIEeZSKJks4ARL1Ua0wtWO+uBEhFMGFrf0O+aRvzgYOVZRnuu8HfAyA8vQ8LNib38FDzOpDN
 rHg1Ys7W2RQ+7Vyqm3BlTwB/c5y7KNxEn+dz0nAXaRGwVDGCvlvmai8ZhhyeSg1vf+gCVsQ+f
 EF000y6XKLJz3uOiv9uO95d1mq26kvYiogoW4AaFD/d6Pk51nVi4NOpOmbbhVca8ISnrqXqxS
 M9FtaGQ7tG3fYm2XSdM4sAx1Ck5wsURuXNmD9E7x4vcRldpq8tZZrlvjeE+8UfDLRUXYpm/VO
 eHGGDEJvPusJLOE5wJ1rcJm3btvMvDVfXCaAG3puTGsPzlqrjOs40sIKzfywsFQlZob/8G39r
 mgpSz/psCvtO1ENJjMp+ZSM839yELjUgCNn4jIW0wGmEQm6OyIlhtTDC7i2N4vaNEHuhEnhWd
 sCZQ6vXS48ui7dN/TsVUHMIHVGJXJsNva1zEYAcYNkZy3kfw935bSvDxfDiLQay3njmClBh4D
 FM9jPGE76bGPdiEfqrkJp6wTJazhFfNOp+08eKn3rTCmi7sGVMzT6iCg268341dEE3AzuB/1g
 1AfOMpg6Pbc6y/tk/SqmJMyS0oJ9ttzOK7HlA+iY39f+Ue+PyVZfyCLETGohrDoD6hXodEIKQ
 7wzSdV09iazMJMa7K+VrhWl31IHaxxh88GR2JNcRJjm2prdz4zM8HqiKx5osQ0J8x4T4f5oax
 so0hSNde+jqH9pzgH/K09PlZtZ5EiJxO2NXXOi5bG4hfcmdjLzFAm2JiGRq+xA+7T7AjPt1eB
 4WSU3XW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 12:39 schrieb Duy Nguyen:
> BTW, I ran t7009 with valgrind and it reported this. Is it something
> we should be worried about? I vaguely recall you're doing something
> with prio-queue...
> 
> ==4246== Source and destination overlap in memcpy(0x5952990, 0x5952990, 16)
> ==4246==    at 0x4C2EACD: memcpy@@GLIBC_2.14 (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==4246==    by 0x545D05: swap (prio-queue.c:15)
> ==4246==    by 0x545D72: prio_queue_reverse (prio-queue.c:25)
> ==4246==    by 0x4CBC0C: sort_in_topological_order (commit.c:723)
> ==4246==    by 0x574C97: prepare_revision_walk (revision.c:2858)
> ==4246==    by 0x48A2BA: cmd_rev_list (rev-list.c:385)
> ==4246==    by 0x405A6F: run_builtin (git.c:371)
> ==4246==    by 0x405CDC: handle_builtin (git.c:572)
> ==4246==    by 0x405E51: run_argv (git.c:624)
> ==4246==    by 0x405FF3: cmd_main (git.c:701)
> ==4246==    by 0x4A48CE: main (common-main.c:43)

I can only get gcc and clang to call memcpy instead of inlining it by
specifying -fno-builtin.  Do you use that option?  If yes, why?  (Just
curious.)

But I can't get Valgrind to report overlapping (nicely explained in
http://valgrind.org/docs/manual/mc-manual.html#mc-manual.overlap, by
the way), not for t7009 and not for the short test program at the
bottom.  Do you set flags in GIT_VALGRIND_OPTIONS or use a special
version of Valgrind?  I use valgrind-3.12.0.SVN from Debian testing.

Thanks,
René


/* Compile with -fno-builtin. */
#include <string.h>
int main(void) {int i = 1; memcpy(&i, &i, sizeof(i)); return i;}
