Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD2C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312D5632F0
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhKPGsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:48:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39882 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234471AbhKPGsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 01:48:02 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AG6ihlL011464
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 01:44:44 -0500
Message-ID: <a2897d9d-284a-4f38-5f07-12e81258fae1@mit.edu>
Date:   Mon, 15 Nov 2021 22:44:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 5/8] fetch: protect branches checked out in all
 worktrees
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20211113033358.2179376-1-andersk@mit.edu>
 <20211113033358.2179376-6-andersk@mit.edu> <xmqq1r3gd50r.fsf@gitster.g>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <xmqq1r3gd50r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/21 21:49, Junio C Hamano wrote:
>> - skip:
>> +skip:
> 
> ;-)

(This was to satisfy ‘make style’.  Otherwise it wanted the lines 
following the 1-space indent to have a 9-space indent.)

Anders
