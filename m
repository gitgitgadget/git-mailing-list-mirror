Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1CC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 22:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F6A610CF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 22:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbhKIXBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:01:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51220 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241461AbhKIXBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:01:08 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A9MwAge011096
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Nov 2021 17:58:11 -0500
Message-ID: <12fc97fb-50dd-a441-5b8f-dd73e6d693b1@mit.edu>
Date:   Tue, 9 Nov 2021 14:58:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 2/4] receive-pack: Clean dead code from
 update_worktree()
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
 <20211109030028.2196416-1-andersk@mit.edu>
 <20211109030028.2196416-2-andersk@mit.edu>
 <nycvar.QRO.7.76.6.2111091711450.54@tvgsbejvaqbjf.bet>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <nycvar.QRO.7.76.6.2111091711450.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/21 08:16, Johannes Schindelin wrote:
> We might want to make sure that `worktree` and `worktree->path` are
> non-`NULL`, and otherwise call a `BUG()`.

Okay.

> Okay, I lied, I have two suggestions. Shouldn't this be turned into
> `worktree->is_bare`?

Sure (but in the next commit, since removing is_bare_repository() is a 
bug fix, not pure cleanup).

Anders
