Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E83C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 08:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhLBIlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:41:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55475 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230054AbhLBIlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 03:41:24 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B28bbUj004314
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 2 Dec 2021 03:37:39 -0500
Message-ID: <736c137a-1d41-e5bb-1424-959992e54e8c@mit.edu>
Date:   Thu, 2 Dec 2021 00:37:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v7 5/8] fetch: protect branches checked out in all
 worktrees
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
References: <20211201221547.1796213-1-andersk@mit.edu>
 <20211201221547.1796213-6-andersk@mit.edu>
 <CAPig+cQudoq3QrF29W8p511s1rPtgZajtk1Rjm+N2SgoLY-Ltw@mail.gmail.com>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <CAPig+cQudoq3QrF29W8p511s1rPtgZajtk1Rjm+N2SgoLY-Ltw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/21 18:51, Eric Sunshine wrote:
> Minor observation: The "checked out in another worktree" message would
> be much more helpful if it mentioned the worktree itself...

Previous discussion of that: 
https://lore.kernel.org/git/YYTtdZblnHYgDgBq@coredump.intra.peff.net/ 
and replies.

In short, this message seems to be unreachable because the other message 
will always be triggered first, so I didn’t spend much effort improving 
it.  As you say, we can leave the task of sorting out the apparently 
duplicate check to another series.

Anders
