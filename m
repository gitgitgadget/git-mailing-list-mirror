Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6BC54EE9
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 06:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIPGia (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 02:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIPGi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 02:38:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343FA2A9A
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 23:38:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DEF31B598B;
        Fri, 16 Sep 2022 02:38:28 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=mF5nrk0873HX1Zi1mYoHVjYUjc2LlojJ0bFQbvB
        Sexw=; b=Qh2SwVudJpxmpBCvQcjg3RF9YJmi65iygGGYnToaufBdQzLpCtopIya
        AKakv2izCoaUBq3w4Rai9IqcOcWpS/ZATrnDF15Ikeq1UMPuiM9hW7ezrDLDaKHN
        i0UUzRixGwiwoQWFfRkBC+a7Wdim7sU/14ff5qzoo8yrC6T9nHl8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06F4C1B598A;
        Fri, 16 Sep 2022 02:38:28 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F62C1B5988;
        Fri, 16 Sep 2022 02:38:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 16 Sep 2022 02:38:20 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.38.0-rc0
Message-ID: <YyQZ3L8HQo+bj8yz@pobox.com>
References: <xmqqczbwkpt8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczbwkpt8.fsf@gitster.g>
X-Pobox-Relay-ID: 29878FF2-358A-11ED-90A3-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Git v2.38 Release Notes (draft)
> ===============================
...
>  * Introduce a discovery.barerepository configuration variable that
>    allows users to forbid discovery of bare repositories.

s/discovery/safe/ in the first sentence, I think?

-- 
Todd
