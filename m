Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5BAC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAVP4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 10:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAVP4p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 10:56:45 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B626F1B578
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 07:56:44 -0800 (PST)
Received: from 88-110-98-79.dynamic.dsl.as9105.com ([88.110.98.79] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pJci1-000Avk-Ep;
        Sun, 22 Jan 2023 15:56:41 +0000
Message-ID: <6aaa2463-a92a-de06-5e16-f0980be3ed3f@iee.email>
Date:   Sun, 22 Jan 2023 15:56:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: What's cooking in git.git (Jan 2023, #05; Tue, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv8l581ov.fsf@gitster.g>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqv8l581ov.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/01/2023 18:18, Junio C Hamano wrote:
> --------------------------------------------------
> [Stalled]
> * po/pretty-hard-trunc (2022-11-13) 1 commit
>  - pretty-formats: add hard truncation, without ellipsis, options
>
>  Add a new pretty format which truncates without ellipsis.
>
>  Expecting a reroll.
>  cf. <093e1dca-b9d4-f1f2-0845-ad6711622cf5@iee.email>
>  source: <20221112143616.1429-1-philipoakley@iee.email>
>
Hi Junio,

I've now sent a re-roll. It primarily updates the documentation, and
adds a test to cover the wide chars and combined characters.

 https://lore.kernel.org/git/20230119181827.1319-1-philipoakley@iee.email/

Philip
