Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B867C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 11:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjAILTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 06:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbjAILS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 06:18:28 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED481A04F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 03:17:47 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 309BHfax014260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Jan 2023 06:17:42 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Yutaro Ohno via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'Yutaro Ohno'" <yutaro.ono.418@gmail.com>
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com> <xmqqbkn8wcqo.fsf@gitster.g>
In-Reply-To: <xmqqbkn8wcqo.fsf@gitster.g>
Subject: RE: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
Date:   Mon, 9 Jan 2023 06:17:37 -0500
Organization: Nexbridge Inc.
Message-ID: <018501d9241b$fe4b1270$fae13750$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+uH7vqNUb9eP923D9hpkMAPjYLQKyPbLArrU0eVA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 8, 2023 11:31 PM, Junio C Hamano wrote:
>"Yutaro Ohno via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Yutaro Ohno <yutaro.ono.418@gmail.com>
>> Subject: Re: [PATCH] doc: use "git switch -c" rather than "git
>> checkout -b" consistently
>
>Hmph.  When two things work equally well, is it a good idea to describe
only one
>"consistently", or mention both that can be used pretty much
interchangeably in
>different places?  I am not 100% sure "consistently" is a good thing here.
>
>Thoughts from others?

git switch is still marked as EXPERIMENTAL in the online help. I don't think
moving broadly to switch from checkout in the documentation should happen
until the EXPERIMENTAL designation is dropped. After that, then "switch -c"
should be used everywhere instead of checkout (except for in the checkout
documentation).

--Randall

