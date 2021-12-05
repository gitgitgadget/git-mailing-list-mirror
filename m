Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A4AC433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 19:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhLETxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 14:53:45 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:44086 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233648AbhLETxo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 14:53:44 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4J6cbp1lzTz5tlF;
        Sun,  5 Dec 2021 20:50:13 +0100 (CET)
Subject: Re: [PATCH 00/10] Factorization of messages with similar meaning
To:     =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <d687f69b-efdc-6b1c-c63c-8544ff37d1c2@kdbg.org> <xmqqfsr7mrs5.fsf@gitster.g>
 <8718669.4XknugNGDb@cayenne>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <96b2d1c2-895d-6196-df8d-ee1e9b6107ce@kdbg.org>
Date:   Sun, 5 Dec 2021 20:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8718669.4XknugNGDb@cayenne>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.21 um 18:25 schrieb Jean-Noël AVILA:
> If needed, "%s and %s are mutually exclusive" could be turned into
> "options %s and %s are mutually exclusive" to make it clear that the
> placeholders can only hold option names.

IMO, being less terse helps not only translators, but also users.

Regarding this particular message, personally, I am not a fan of
"mutually exclusive" (sounds like it's been taken from a law text). How
about "options ... are incompatible" or "... cannot be used together"?

-- Hannes
