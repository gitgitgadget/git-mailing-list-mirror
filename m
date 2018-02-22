Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539161F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeBVAzF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:55:05 -0500
Received: from mezzogiorno.tim-landscheidt.de ([78.47.87.37]:49963 "EHLO
        mezzogiorno.tim-landscheidt.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751637AbeBVAzE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Feb 2018 19:55:04 -0500
Received: from dslb-092-076-023-076.092.076.pools.vodafone-ip.de ([92.76.23.76]:51758 helo=passepartout.tim-landscheidt.de)
        by mezzogiorno.tim-landscheidt.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <tim@tim-landscheidt.de>)
        id 1eofA2-00054C-Ok; Thu, 22 Feb 2018 00:54:58 +0000
From:   Tim Landscheidt <tim@tim-landscheidt.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] Add "git rebase --show-current-patch"
Organization: http://www.tim-landscheidt.de/
References: <20180131093051.15525-1-pclouds@gmail.com>
        <20180211094328.6157-1-pclouds@gmail.com>
        <xmqqa7w1yiuj.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 22 Feb 2018 00:54:57 +0000
In-Reply-To: <xmqqa7w1yiuj.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Feb 2018 16:21:40 -0800")
Message-ID: <87h8q97sim.fsf@passepartout.tim-landscheidt.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

>> Compared to v2:

>> - the potential loss of errno before it's printed out in builtin/am.c
>>   is fixed.
>> - keep update_ref() in sequencer.c non-fatal like this rest
>> - rename ORIG_COMMIT to REBASE_HEAD

>> Interdiff:

> This round hasn't seen any comments.  Is everybody happy with it?

> I personally do not have strong opinion for the feature but didn't
> spot anything against the execution, either, so...

Sorry for the late reply: I dislike REBASE_/HEAD/ because
ORIG_/HEAD/ refers to the tip of the original branch, and
/ORIG/_HEAD refers to the original branch, so
/REBASE/_/HEAD/ is doubly confusing IMHO.  I consider
ORIG_COMMIT easier to understand because ORIG_HEAD refers to
the tip of the original branch, and ORIG_COMMIT would refer
to one of the commits making up that original branch, but as
I suggested it myself I might not be very objective in that
regard :-).

(BTW, thanks, Duy, for doing the actual work!)

Tim
