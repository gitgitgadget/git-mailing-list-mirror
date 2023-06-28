Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF2EB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 21:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjF1VDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjF1VDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 17:03:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0519B0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:03:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 133602680C;
        Wed, 28 Jun 2023 17:03:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SvZsUCqPSF/KGhrCe0d4jw3rLCbPu61wPaG4H2
        TJqFM=; b=RgBXbRj73f2A3Ag0O7kKP+NGAdwuNsnaibHVmmfdv3ZrDq7+74Qb6c
        0p1PGujBQxYqW1lCPQmeiRE/PR864J/5XKv46S8GIXmLij1hzeiZfF5sJbXYBIuu
        HZOXKT7NbqclHygLTMSXNaTs+1s/CtauxkLfi4NclvMBo5iuOn48o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B9E12680B;
        Wed, 28 Jun 2023 17:03:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B8E726807;
        Wed, 28 Jun 2023 17:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: cw/header-compat-util-shuffle (was Re: What's cooking in
 git.git (Jun 2023, #07; Tue, 27))
References: <xmqqcz1gftdn.fsf@gitster.g>
        <kl6lh6qrqtbj.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 28 Jun 2023 14:03:11 -0700
In-Reply-To: <kl6lh6qrqtbj.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 28 Jun 2023 12:29:20 -0700")
Message-ID: <xmqqbkgzcnao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31384E32-15F7-11EE-904A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I notice that
>
>   https://lore.kernel.org/git/20230606170711.912972-1-calvinwan@google.com/
>
> is available as cw/header-compat-util-shuffle, but AFAICT that's not in
> this announcement or 'seen'.

Yes, I have found that it had too many bad interactions with topics
in flight and, keeping it out of 'seen' was very much deliberate.

Thanks.

