Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619D820248
	for <e@80x24.org>; Thu, 18 Apr 2019 09:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfDRJ43 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 05:56:29 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39925
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbfDRJ42 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Apr 2019 05:56:28 -0400
X-IronPort-AV: E=Sophos;i="5.60,365,1549926000"; 
   d="scan'208";a="303288821"
Received: from dhcp-13-174.lip.ens-lyon.fr (HELO moylip) ([140.77.13.174])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2019 11:56:26 +0200
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        BERBEZIER NATHAN p1601409 <nathan.berbezier@etu.univ-lyon1.fr>,
        CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
References: <20190409125205.13754-1-corentin.bompard@etu.univ-lyon1.fr>
        <3d2ba75520b74c2e9e8251c41d6632ba@BPMBX2013-01.univ-lyon1.fr>
Date:   Thu, 18 Apr 2019 11:56:26 +0200
In-Reply-To: <3d2ba75520b74c2e9e8251c41d6632ba@BPMBX2013-01.univ-lyon1.fr>
        (BOMPARD CORENTIN's message of "Wed, 17 Apr 2019 16:01:38 +0000")
Message-ID: <86bm137i2d.fsf@univ-lyon1.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr> writes:

> +			warning(_("No source branch found. \n You need to specify excatly "
> +						"one branch with the set-upstream option."));

s/excatly/exactly/

Also, this " \n " is weird, the trailing whitespace is useless, and the
leading one on the next line is weird. You can use the \n to split the
string in the source without risking space issues:

			warning(_("no source branch found.\n"
                                  "You need to specify excatly one branch with the set-upstream option."));

?

-- 
Matthieu Moy
https://matthieu-moy.fr/
