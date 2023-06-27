Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F527EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 17:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF0R5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjF0R5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 13:57:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B030DF
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 10:56:58 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EC301834C3;
        Tue, 27 Jun 2023 13:56:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K/USULzwKTzmFBNO8nFus0STw2uk3+tEIm+beQ
        pb5qQ=; b=nZulbBIslNUMhBKxONiaSExqidVwL4upr01cDfxwO80vVhaZ9FRz8y
        akLpocVFtwHUoRV0xsoevMWewKeuxWfiFdUqG3zX6/IBUEKFNYDL3c/WoF33nnz+
        gZP6+gJcNlBkPdCfC86pkg1xUb1htQ0/0z/sPcvoGwmkuEMVhUJJc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 676B21834C2;
        Tue, 27 Jun 2023 13:56:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB4C61834C1;
        Tue, 27 Jun 2023 13:56:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/7] var: add attributes files locations
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-7-sandals@crustytoothpaste.net>
        <20230627070557.GB1226768@coredump.intra.peff.net>
        <ZJsKa6ZNq7nnh0gf@tapette.crustytoothpaste.net>
Date:   Tue, 27 Jun 2023 10:56:55 -0700
In-Reply-To: <ZJsKa6ZNq7nnh0gf@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 27 Jun 2023 16:12:27 +0000")
Message-ID: <xmqqzg4khjq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01C81B8E-1514-11EE-823C-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> So I dunno. I'm mostly giving a heads-up, and seeing if you (or other
>> reviewers in the thread) have an idea to make this "flag" thing less
>> awful. I'm also happy to just do my topic separately, and then
>> eventually circle back after yours is merged.
>
> I've picked up your patch as the first patch in the series and will send
> it out in v3 in just a few minutes.  Since I plan to have v3 be the last
> round of this series, I'll let you send out any further changes as
> fixups on top of that.

Sounds like a sensible way to go, at least to me.  

Thanks for working well together.  I wish all conflicting topics
worked nicely with each other like these ;-)

