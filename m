Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A291CC433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8989561090
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhJGQmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:42:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:28117 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242761AbhJGQms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 12:42:48 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4HQHBY0PfYz5tlG;
        Thu,  7 Oct 2021 18:40:52 +0200 (CEST)
Subject: Re: [PATCH 0/3] Fun with cpp word regex
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
 <87o881gpq7.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ebfe018b-b4e7-0dc8-e535-5cac9cf3d106@kdbg.org>
Date:   Thu, 7 Oct 2021 18:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87o881gpq7.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.21 um 11:14 schrieb Ævar Arnfjörð Bjarmason:
> But some tests in t/t4034/cpp/* would be great, and seem from the files
> easy to add. E.g. wouldn't changing:

Ah, I didn't notice that we actually have tests for word-diff. I'll look
into it and resubmit.

-- Hannes
