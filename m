Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFAEC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FD660F51
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhKIXfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:35:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55860 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229500AbhKIXfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:35:39 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A9NWgfM021458
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Nov 2021 18:32:44 -0500
Message-ID: <99a95f0e-f90b-26fc-3a34-bd90d47de215@mit.edu>
Date:   Tue, 9 Nov 2021 15:32:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 1/4] fetch: Protect branches checked out in all
 worktrees
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
 <20211109030028.2196416-1-andersk@mit.edu>
 <nycvar.QRO.7.76.6.2111091706290.54@tvgsbejvaqbjf.bet>
 <316e8579-d720-b40e-66fb-3280e8de1922@mit.edu> <xmqqa6id0w9y.fsf@gitster.g>
 <xmqqk0hgzz77.fsf@gitster.g>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <xmqqk0hgzz77.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/21 15:28, Junio C Hamano wrote:
> Another minor thing I noticed and meant to say but kept forgetting.
> We do not upcase the first word after the <area>: in the commit
> title.

Ah okay.  Will lowercase if a v6 becomes necessary, otherwise I assume 
you’ll take care of it.

Anders
