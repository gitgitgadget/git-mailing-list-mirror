Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF2C433E0
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4AF206A2
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 13:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFFN5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 09:57:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14105 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgFFN5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 09:57:51 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jhZKX-0001yl-AX; Sat, 06 Jun 2020 14:57:49 +0100
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com>
 <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
 <xmqqh7vqrimm.fsf@gitster.c.googlers.com>
 <CABPp-BFLUZvycq_o6mPcx3ZQkeQy79nQ_mGD3B+JLzBwb6ER=g@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ca05688f-4f03-97b4-7f88-a4fc89bc119a@iee.email>
Date:   Sat, 6 Jun 2020 14:57:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFLUZvycq_o6mPcx3ZQkeQy79nQ_mGD3B+JLzBwb6ER=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/06/2020 02:46, Elijah Newren wrote:
> Another consideration we could make is just scheduling .1 releases
> automatically, and not limiting them to security fixes but instead
> considering the same kinds of things that would be allowed around the
> time of -rc1 or -rc2.  I still want to push to make the quality of .0
> releases as high as we can, but given that human nature seems to lean
> towards avoiding things until they are labelled as official, and since
> we benefit from that wider feedback, maybe we adjust slightly to take
> advantage of natural behavior and do .1 releases?  Anyway, just a
> thought.

Maybe simply tag the current master every 2 weeks of the cycle (.wk2,
.wk4, wk6), as appropriate, just to give potential users/testers a stake
in the ground to reference to.

Or maybe a 'mid cycle' .mc1 release for a similar 'nudge' effect [1] of
'try this one'.

Philip

[1] https://en.wikipedia.org/wiki/Nudge_theory
