Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBBDC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 09:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiFDJtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiFDJtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 05:49:49 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B62012A9E
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 02:49:48 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39492514"
Received: from unknown (HELO [10.28.4.153]) ([109.190.253.11])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 11:49:34 +0200
Message-ID: <253c9744-60b6-c571-4962-62d2d6808d69@univ-lyon1.fr>
Date:   Sat, 4 Jun 2022 11:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] add configuration variable corresponding to
 --overwrite-same-content
Content-Language: en-US
To:     Jonathan Bressat <git.jonathan.bressat@gmail.com>
Cc:     "cogoni.guillaume@gmail.com" <cogoni.guillaume@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
 <4efbe7d9c95841c691f51954670a1d9f@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <4efbe7d9c95841c691f51954670a1d9f@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/22 21:55, Jonathan Bressat wrote:
> Configuration variable merge.overwritesamecontent corresponding to

We usually write them as camelCase for readability (but options are 
case-insensitive).

> +merge.overwritesamecontent::
> +    When set to true, it will modify the behavior of git merge

"When set to true, modify", the future is not needed.

> +    to overwrite untracked files that have the same name and
> +    content than files in the merged commit.	

The doc should mention the command-line option too, and say which one 
takes precedence when both are specified (as it is the case for many 
other options).

-- 
Matthieu Moy
https://matthieu-moy.fr/
