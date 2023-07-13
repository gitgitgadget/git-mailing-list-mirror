Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A9C001DE
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 22:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGMW2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjGMW23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 18:28:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBFA2D45
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 15:28:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE6361E7E8;
        Thu, 13 Jul 2023 18:28:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5NR0ziQLiamgJKMPDVvukWuD/JLC/pPVgbUrFT
        Xb9rM=; b=Xv83uMehdi8Ty3ZjkEzFCIaMYwGl7YRir2oR0otgc/hIORR/bPWDLN
        dRCBQ3o1Dr+/BKGPz7gC5UZHVGVEDlF+qYaRx+dKN1yC2dFxQExjGKJdCn1qjV41
        UNWV8/KV9w4KDBXQLRbV3X0VMzg9sQjT3Zu3miWtbwhM9jO4WBvoc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6EE61E7E7;
        Thu, 13 Jul 2023 18:28:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40E551E7E4;
        Thu, 13 Jul 2023 18:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not
 support !command
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <20230713193342.1053968-1-pvutov@imap.cc>
        <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc>
        <xmqqwmz3oacg.fsf@gitster.g>
        <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc>
        <xmqqa5vzo7jy.fsf@gitster.g> <xmqqv8enmr21.fsf@gitster.g>
        <0e566b2b-8e61-3895-59a6-292dfc46bd4f@imap.cc>
Date:   Thu, 13 Jul 2023 15:28:24 -0700
In-Reply-To: <0e566b2b-8e61-3895-59a6-292dfc46bd4f@imap.cc> (Petar Vutov's
        message of "Thu, 13 Jul 2023 23:47:59 +0200")
Message-ID: <xmqqcz0vla47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 950DF46C-21CC-11EE-A0B2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petar Vutov <pvutov@imap.cc> writes:

> Thanks. I'll digest this and reply tomorrow.

Thanks.

> "The following `update` procedures are not supported via the command
> line: none, custom command"

Ah, that is a good thing to notice.  Yes, the command line override
is also something we need to explain.
