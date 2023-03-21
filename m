Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A12C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCUWHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCUWHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 18:07:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50955047
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:07:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 112971E8956;
        Tue, 21 Mar 2023 18:07:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=q7kVKPhECeLVWHjll4OZKBDS1zouBt3Jxz+6ZNW
        cP9I=; b=IVTSbxyC39ww1EUg6kXWoR+qfOR8YL4CeiYs83/F3zTAxg9KRixhOsh
        1lDyiY52183u5f6epQCl5l+5JxlLpVIWFK9ikeN1SmPMKUX8aH2o5hzQ/DU8zvhj
        Ld1e263qLRqMVywApruOAiLgAy4GRXG0T9ioVKZgrTADDDjOVaBc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 098D21E8955;
        Tue, 21 Mar 2023 18:07:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7C2D1E894F;
        Tue, 21 Mar 2023 18:07:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 21 Mar 2023 18:07:33 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: remove GNU troff workaround
Message-ID: <ZBoqpba+z+/lsTZC@pobox.com>
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
 <20230321173206.GC3119834@coredump.intra.peff.net>
 <xmqqcz52hu7n.fsf@gitster.g>
 <20230321181702.GI3119834@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321181702.GI3119834@coredump.intra.peff.net>
X-Pobox-Relay-ID: CA029A0C-C834-11ED-8168-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> I could believe that some people are still stuck on 2016-era versions of
> dependencies, but yeah, I agree we can be a little more cavalier with
> documentation. Anyway, I think the right date really is 2010, as above.

I tested this on with CentOS 7 ( docbook-style-xsl-1.78.1).

I didn't notice any bogus curly quotes in the output.  So
even one of the older OS releases we tend to support
shouldn't be affected by this change.

Happy to see the cruft removed. :)

-- 
Todd
