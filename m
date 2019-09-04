Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EEA1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfIDS7t (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 14:59:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:44686 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbfIDS7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 14:59:49 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46NtRQ3qW6z5tl9;
        Wed,  4 Sep 2019 20:59:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2BCA81AEB;
        Wed,  4 Sep 2019 20:59:46 +0200 (CEST)
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org, me@yadavpratyush.com
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
Date:   Wed, 4 Sep 2019 20:59:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904143055.11400-1-birger.sp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.19 um 16:30 schrieb Birger Skogeng Pedersen:
> The user cannot change focus between the list of files, the diff view and
> the commit message widgets without using the mouse (clicking either of
> the four widgets).
> 
> With this patch, the user may set ui focus to the previously selected path
> in either the "Unstaged Changes" or "Staged Changes" widgets, using
> ALT+1 or ALT+2.
> 
> The user may also set the ui focus to the diff view widget with
> ALT+3, or to the commit message widget with ALT+4.

Many keyboards do not have a right Alt-key. That means that Alt+1 to
Alt+4 combinations must be typed single-handed with the left hand. This
is mildly awkward for Alt+4. Can we please have the very important
commit widget *not* at Alt+4? I could live with Alt+3.

-- Hannes
