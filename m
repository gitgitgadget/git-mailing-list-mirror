Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E3C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890A820753
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgDHSW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:22:58 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49409 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgDHSW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:22:58 -0400
Received: from localhost (unknown [42.109.209.207])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A8C75240003;
        Wed,  8 Apr 2020 18:22:53 +0000 (UTC)
Date:   Wed, 8 Apr 2020 23:52:47 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, emilyshaffer@google.com,
        martin.agren@gmail.com
Subject: Re: [PATCH 1/2] gitfaq: cleanup gitfaq.txt
Message-ID: <20200408182247.jz5xnlw3sbrazq36@yadavpratyush.com>
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
 <20200406181216.5340-2-shouryashukla.oo@gmail.com>
 <xmqqy2r8tbxn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2r8tbxn.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/20 04:46PM, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> By the way, if you still want to pursue "full-stop at the end of the
> sentence MUST be followed by no more than one SP", I won't stop you,
> but please do so in a separate patch that has NO OTHER CHANGES.
> They drown other changes out that are not mechanical and makes them
> hard to review.

Maybe we should just have a consistent convention throughout the 
documentation on whether to use one space after a full-stop or two. 
Right now in some places we use one space, in some others we use two, 
even in the same file. This is slightly distracting when reading. Having 
a convention would at least result in uniformity, even if it won't end 
the debate on which is better. And FWIW, our man pages are always 
rendered with one space, even if the source file has two.

-- 
Regards,
Pratyush Yadav
