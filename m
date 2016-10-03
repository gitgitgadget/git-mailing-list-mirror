Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6E020986
	for <e@80x24.org>; Mon,  3 Oct 2016 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbcJCJqO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 05:46:14 -0400
Received: from mout.web.de ([212.227.17.12]:51790 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbcJCJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 05:46:14 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M9ojk-1bkLzC0t1E-00B6dk; Mon, 03 Oct 2016 11:45:50
 +0200
Subject: Re: [PATCH] git-gui: stop using deprecated merge syntax
To:     patthoyts@users.sourceforge.net, Stefan Beller <sbeller@google.com>
References: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de>
 <a5b001fd-3ba2-bcc0-2104-eb630796ab09@kdbg.org>
 <xmqqvaxjygb2.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZZwum+97JGL8OFWTdODZeqrEyj4MVMC6o6ynFMOhiFLg@mail.gmail.com>
 <87mvilx2ak.fsf@red.patthoyts.tk>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git List <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5283506a-9399-6ddc-d714-1dd9d2b49704@web.de>
Date:   Mon, 3 Oct 2016 11:45:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <87mvilx2ak.fsf@red.patthoyts.tk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:d4XLibLW8ErtfFuZFtE/GKPbRjoAxhX6lrdwzXytvjwClXak9T+
 yEEO2sfRwpFKcck1zIFzAu/m8cfbt21/EVkkK5zv6tLxPedC2BE3Ey4d++5IC0tvzKvudO1
 rNTfLNEm1R44Be5SufvW50MfHPsOXTndTZQkQJdf9KoGzoB5uwMg2Ihqwi3tDCj7pQL3ujF
 sVJmztSzZhX4l6eIjKy9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1soncF1rvRE=:RIRMaOkeUmbX4NjJ6sxaG0
 YjGXayFep+eHUtIGh4DzIvf7ptetVnYj78MPN9goTT7qkd6ehHy4oWEDwdF1QnzGuz9tyeW5p
 PP8NXuGPKqdcvzlgDfksuUQhnOn4EW5DeR4vAwNBecV4ycfUT1qeKbj5o90uptgebjbu/kAPn
 11lhFDD1mxXPXLOXUmRFqfT4VvKmFhfT0ZFTNIdUkA/WfiLyd8b5yJRfOfSXYVPa0EqPmOpLN
 07EVhh/PShNFTOgmrYAyCjTwiC0bEw6PJb45lAE+ZQczg80HFEKgVadkNmuWdke7e0DAriSOz
 i1u0RtcO4n28Zp3tmaM8bQbxf3WTvFy4JrXz727/je0wIL804INLi+K6YBDZORvG5xFxgQ2Ks
 pL9XI++BXmi0qMfZvSvr6IBnNAbJHoAM8vlsfNcfgECrr2MHT3ujX5Pswo3STPWwbUyb6q0kP
 B/SkS6QWFZX0xl7eocpt/myHKSp2tD4qXmU1KjC5+EkKe92hN7+KzsfVDSPfcwscHaMhOq7Uy
 l8glkxguX5GUOEuNFN+MqVjD/Ppi8oU+PQlUp4Tg/GY5ROmaC46hE+gKR3gr70jph83vXHv9K
 bRiZQ1KmBaA+I0RDDGkMBTm3HXRBevJOpejlboyHCdGgsH4DfZV99RuV9caVt+Of6K63aNRZq
 cA//AGC9pRDhKCCAEPewwEhxzXuwMc0w1GQpGtAl9YXJo5Nn5jfcBM6u3osisBlp1mrb9c4TL
 KPODGRU+l07Uj+H88D33yo4iyqNR94UUjkv1bEeGeHxXLJ+dHb8HD8kyH8lphtf7dvPXKZoc0
 bHhwx53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2016 um 10:30 schrieb Pat Thoyts:
> The only problem I see here is that generally git-gui tries to continue
> to work with older versions of git as well. So adding a guard using the
> git-version procedure should maintain that backwards compatibility.

Makes sense for a stand-alone tool.

> I suggest:
>
> From c2716458f05893ca88c05ce211a295a330e74590 Mon Sep 17 00:00:00 2001
> From:  René Scharfe <l.s.r@web.de>
> Date: Sat, 24 Sep 2016 13:30:22 +0200
> Subject: [PATCH] git-gui: stop using deprecated merge syntax
>
> Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
> warns when it's called like 'git merge <message> HEAD <commit>' because
> that syntax is deprecated.  Use this feature in git-gui and get rid of
> that warning.
>
> Tested-by: Johannes Sixt <j6t@kdbg.org>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

OK, but perhaps move me from From: to Original-patch-by: as the version 
check is a big enough change in itself.  Or add a separate commit for 
it.  Or at least mention that you added the check in the commit message.

Thanks,
René
