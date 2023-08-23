Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CF7C3DA6F
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbjHWVlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjHWVk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:40:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA811737
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:40:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06A7A28E67;
        Wed, 23 Aug 2023 17:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LKWixsvvEf/I6PDXtZUFklP5fJPcZ6+JyEerxZHVux4=; b=nz7n
        5G+wBLkU5cEgxF8nHkjQsBVW1ZUZ+dDz1zgjX0QMBZs+84vLr/WNQ3LMiP1sHOqA
        LE6m8v6/avZAcA/rN4ElW88R9sz8WL5rmsC1aAMP2yUZPFDjQuskGkURRL7o98zV
        RmeH/HJohtvAUzSOH96sKkMapDOfhflzg3q6388=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 004D128E66;
        Wed, 23 Aug 2023 17:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91B4E28E65;
        Wed, 23 Aug 2023 17:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.43 release date adjustment?
References: <ZOYdG8RtPIgymtBV@nand.local> <xmqqpm3dg27i.fsf@gitster.g>
        <ZOZR0jesPpCDNbRj@nand.local>
Date:   Wed, 23 Aug 2023 14:39:41 -0700
Message-ID: <xmqqh6ope8v6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91F1575A-41FD-11EE-BF53-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Perhaps then we should shorten this cycle by a week and plan to cut the
> release on 2023-11-13.

I still do not see the point.  Do you mean you do not want to work
between 13th to 17th of November that would be the "final regression
hunt in -rc2" week?

If you have a specific reason to expect a post-release bug hunt,
that would change the equation, but otherwise, I am not sure what
you are trying to achieve, compared to the original plan to tag on
20th, give developers week off after the release for Thanksgiving or
whatever the excuse to take a week off in your parts of the world.

The users will be taking the holiday week and will be slow after the
release anyway, and developers work should also happen more before
the release and not after it, no?


