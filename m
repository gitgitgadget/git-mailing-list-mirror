Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ADBC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 08:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiDHIbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDHIbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 04:31:12 -0400
Received: from lucy.dinwoodie.org (b.8.0.0.8.9.b.0.2.f.0.9.2.a.d.b.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:de15:20ad:bda2:90f2:b98:8b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E2A2FDC80
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 01:29:10 -0700 (PDT)
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1ncjzM-002bmm-M3; Fri, 08 Apr 2022 09:29:04 +0100
Date:   Fri, 8 Apr 2022 09:29:04 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Fangyi Zhou <me@fangyi.io>,
        Josh Steadmon <steadmon@google.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0
Message-ID: <20220408082904.eeq77iyddbtwfqhg@lucy.dinwoodie.org>
References: <xmqqo81gpokn.fsf@gitster.g>
 <xmqq1qy8qske.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qy8qske.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 07, 2022 at 06:20:33PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > An early preview release Git v2.36.0-rc0 is now available for
> > testing at the usual places.  It is comprised of 661 non-merge
> > commits since v2.35.0, contributed by 80 people, 25 of which are
> > new faces [*].
> 
> Thanks for finding and fixing many oops glitches in this preview so
> quickly.  Hopefully with the tip of 'master/main' today, we can tag
> a bug-free -rc1 tomorrow ;-)

There's still an outstanding (test-only) regression in Cygwin:
https://lore.kernel.org/git/20220406094207.h7ru4xdiimywelqg@lucy.dinwoodie.org/

I'll see if I can offer a patch for this myself later today.
