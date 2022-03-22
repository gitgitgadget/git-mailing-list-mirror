Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C28FC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 19:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiCVTix (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiCVTiu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 15:38:50 -0400
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BCE8A6C8
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 12:37:21 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id WkJhn0D0zN0saWkJjnvQhM; Tue, 22 Mar 2022 19:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1647977839; bh=xY9krUJ6xWDSLnk6DOZhyaCA5KkWLgueFu4gfBLIuMY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZvUAnTEry4Mme5I+s2p1y3hECZLjLCkBmkRgtJrzM8XY8f6dy1dUq0epG5YyZtpSw
         97U7cSTnFAg5pG6eCUCnaffvpLC7E1dYpCEknd9qvEieoYT40ianVB/PfTYtERwpnd
         L+V9czXiENC8JFnm+3846y/XG8IYxxaL1NexSLkB2OIsqyWr+yKOAvVIOLr7iUI6JF
         bBF4pSwXjHMm3daMnfJDwvaytAd0QXAkQrEbbZzuepN6U1RJf0JOcQAEOiZ+UUPTsU
         ifNDWT4RQzo6Qz1H6Zvs/9M93fKR51kinIVjT4Ip3OHGpawJF+bRzvICmTnRMgTJ5R
         Wc5rL1+tBxONw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Ecqr/NqC c=1 sm=1 tr=0 ts=623a256f
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=_3o_UsMXkYdhg2Up5IgA:9 a=QEXdDO2ut3YA:10
 a=2aTU_CaeVFUA:10
X-AUTH: ramsayjones@:2500
Message-ID: <b5685cca-2fb9-dabf-fe4e-4a718817820b@ramsayjones.plus.com>
Date:   Tue, 22 Mar 2022 19:37:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [-SPAM-] [PATCH 3/5] pack-objects: parse --filter directly into
 revs.filter
Content-Language: en-GB
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfD1Ih/opMGQNVChhfN+HurjcZR1L80RGXPMim1jd/OHypIs5dB7VD9W8iRgOw2LvpLjLD1oTfTbppjy4Nq0+lsVLZA/8WnPpUVjBAoqMAoOEqtz4Nh/6
 uIF5oUpv3TrWOflr9Q/CJYOK3vmHnEl6jNfErHtoZLTHHfd6OHD2BYF7YYDe4Nl2UJm+2WNYBB/Dk0A0dP26Yf/L+3wrum/hkIw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/03/2022 17:28, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The previous change moved the 'revs' variable into cmd_pack_objects()
> and now we can remote the global filter_options in favor of revs.filter.

s/remote/remove/

ATB,
Ramsay Jones

