Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A91C001B0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 04:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbjHPEYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 00:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241743AbjHPEYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 00:24:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8412102
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 21:24:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEE4228CB6;
        Wed, 16 Aug 2023 00:24:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=a0KsEaLmeSA9NyQ5813Ev0ycQp06LSTY5lFOFHB4hJ0=; b=Y3Oe
        jfGKymYLI6jAxTMTDWjNyxZG8pWix+hy8r47Ym38MRblLwM3y7fGPjvu+pfv+xe2
        agBdDsRAS1LiZVE4Gl/yIueMO+9cpVuEJAe0CbnaOmLkHHPmS4RoEB9ZQdnY8iyA
        2G9NeoCPHeR7lGgW4vXltHiV3htgLUqJA5noiQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7C4228CB5;
        Wed, 16 Aug 2023 00:24:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F18D28CB4;
        Wed, 16 Aug 2023 00:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH] status: fix branch shown when not only bisecting
References: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
        <xmqqedkn3arv.fsf@gitster.g>
        <32997081-62d8-b900-d58a-308e5c773818@gmail.com>
        <xmqqtttia3vn.fsf@gitster.g>
Date:   Tue, 15 Aug 2023 21:24:13 -0700
Message-ID: <xmqq1qg3haxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1E93AB6-3BEC-11EE-AE79-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I didn't see if the proposed output from the command makes sense
> (yet), but somebody else may already have done so and writing their
> reviews on their findings.  Let's see if we get any positive reviews
> and move it to 'next' after that.

And unfortunately nothing has happened.  Granted that summer in the
northern hemisphere is a slow season, but it is a bit disappointing.
