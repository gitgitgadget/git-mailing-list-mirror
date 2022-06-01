Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57626C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 18:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356260AbiFAS03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356259AbiFAS01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 14:26:27 -0400
Received: from nmsh6.e.nsc.no (nmsh6.e.nsc.no [148.123.160.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761DA5015
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 11:26:25 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh6.e.nsc.no (smtp.online.no) with ESMTPSA id EE98F1D4139;
        Wed,  1 Jun 2022 20:26:23 +0200 (CEST)
Message-ID: <df854e0b-3731-0b7e-557e-9446578da0e9@online.no>
Date:   Wed, 1 Jun 2022 20:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] git-prompt: make colourization consistent
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20220601134414.66825-1-joak-pet@online.no>
 <220601.864k141ls0.gmgdl@evledraar.gmail.com>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <220601.864k141ls0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/06/2022 16:47, Ævar Arnfjörð Bjarmason wrote:
> This seems to make sense to me, but I haven't looked deeply into it. But
> let's CC the author of 0ec7c23cdc6 (git-prompt: make upstream state
> indicator location consistent, 2022-02-27) (which I've done here).
> 
> For a non-RFC patch I think a rephrasing of most of what yo uhave below
> "--" should be part of the message. Note how I referred to the
> 0ec... commit above, you should reference the commit like that (see
> SubmittingPatches).
> 
> Thanks for working on this fix!
>  >

Thanks for the pointers, I'll keep that in mind for the follow-up! I do
have one question regarding the procedure for the follow-up, though:
If there are no code changes, should it still be submitted as a "v2"?
