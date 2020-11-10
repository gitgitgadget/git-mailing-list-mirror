Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D3C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A920789
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgKJAQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:16:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45161 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729661AbgKJAQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:16:54 -0500
Received: from [192.168.9.205] (198-27-188-6.fiber.dynamic.sonic.net [198.27.188.6])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AA0GhtI031449
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 19:16:44 -0500
Subject: Re: [GIT PULL] gitk update
To:     Paul Mackerras <paulus@ozlabs.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20201003092010.GC3089868@thinks.paulus.ozlabs.org>
 <xmqqy2kn8cmb.fsf@gitster.c.googlers.com>
 <20201006111335.GA3364508@thinks.paulus.ozlabs.org>
From:   Anders Kaseorg <andersk@mit.edu>
Message-ID: <1f6e179c-d9c3-e503-3218-0acf4ff27cca@mit.edu>
Date:   Mon, 9 Nov 2020 16:16:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201006111335.GA3364508@thinks.paulus.ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/20 4:13 AM, Paul Mackerras wrote:
> On Sat, Oct 03, 2020 at 10:04:28AM -0700, Junio C Hamano wrote:
>>      6cd80496e9 gitk: Resize panes correctly when reducing window size

This commit has broken horizontal window resizing completely for a 
configuration with ‘set want_ttk 0’.  Resizing now results in this 
Application Error popup:

Error: expected integer but got ""

expected integer but got ""

expected integer but got ""

     while executing

"$win sash place 0 $sash0 [lindex $s0 1]"

     (procedure "resizeclistpanes" line 38)

     invoked from within

"resizeclistpanes .tf.histframe.pwclist 2818"

     (command bound to event)

Anders
