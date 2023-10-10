Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB66CD68E8
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 08:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjJJI5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJJI5s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 04:57:48 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7553A9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 01:57:45 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 5703823F29;
        Tue, 10 Oct 2023 04:57:29 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qq8YT-ENp-00; Tue, 10 Oct 2023 10:57:29 +0200
Date:   Tue, 10 Oct 2023 10:57:29 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com,
        calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 1/3] unit tests: Add a project plan document
Message-ID: <ZSUR+YdzqNTSB0XC@ugly>
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
 <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 03:21:20PM -0700, Josh Steadmon wrote:
>+=== Comparison
>+
>+[format="csv",options="header",width="33%"]
>+|=====
>+Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorable or ubiquitous>>","<<maintainable-extensible,Maintainable / extensible>>","<<major-platform-support,Major platform support>>","<<tap-support,TAP support>>","<<diagnostic-output,Diagnostic output>>","<<runtime--skippable-tests,Runtime- skippable tests>>","<<parallel-execution,Parallel execution>>","<<mock-support,Mock support>>","<<signal-error-handling,Signal & error handling>>","<<project-kloc,Project KLOC>>","<<adoption,Adoption>>"
>
the redundancy seems unnecessary; asciidoc should automatically use each 
target's section title as the xreflabel.

>+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[Custom Git impl.],[lime-background]#GPL v2#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,1,0
>+https://github.com/silentbicycle/greatest[Greatest],[lime-background]#ISC#,[lime-background]#True#,[yellow-background]#Partial#,[lime-background]#True#,[yellow-background]#Partial#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,3,1400
>+https://github.com/Snaipe/Criterion[Criterion],[lime-background]#MIT#,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[lime-background]#True#,19,1800
>+https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#Expat#,[lime-background]#True#,[yellow-background]#Partial#,[yellow-background]#Partial#,[lime-background]#True#,[red-background]#False#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,4,33
>+https://libcheck.github.io/check/[Check],[lime-background]#LGPL v2.1#,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,[lime-background]#True#,17,973
>+|=====
>+
i find this totally unreadable in its raw form.
consider user-defined document-attributes for specific cell contents.
externalizing the urls would probably help as well (i'm not sure how to 
do that best).

regards
