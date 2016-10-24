Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7754920193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938814AbcJXTrZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:47:25 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:23361 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753745AbcJXTrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:47:24 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t2myd64G1z5tlG;
        Mon, 24 Oct 2016 21:47:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 07EEB529C;
        Mon, 24 Oct 2016 21:47:21 +0200 (CEST)
Subject: Re: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
To:     Stefan Beller <sbeller@google.com>
References: <20161021235939.20792-1-sbeller@google.com>
 <20161021235939.20792-3-sbeller@google.com>
 <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org>
 <xmqqh984aldl.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaukGh2ynkOQcF=skzxTMYr8CFRyGJw6FEmNsTAcaG_VQ@mail.gmail.com>
 <61637cd9-8f83-c988-15c0-54f948153c07@kdbg.org>
 <CAGZ79kZrsxjSfa=CSs5V56ePabnD3-W7FHC7KkRO6jytX+GrAw@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0dfa14f7-494d-9be3-fcb7-8c16b1a7fdfa@kdbg.org>
Date:   Mon, 24 Oct 2016 21:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZrsxjSfa=CSs5V56ePabnD3-W7FHC7KkRO6jytX+GrAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2016 um 21:10 schrieb Stefan Beller:
> The ease of use in our own testing suite is the feature I was talking about.

Ok, thanks for the clarification. Next steps would then be, IMO, to fix 
the tests to match the future world order and mark tests that fail due 
to the bug with test_expect_failure, and then switch them back to 
test_expect_success in the patch with the bug fix.

-- Hannes

