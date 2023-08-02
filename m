Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7DC00528
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 21:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHBVio (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjHBVil (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 17:38:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2D211F
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 14:38:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B5512317B;
        Wed,  2 Aug 2023 17:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U2DSwSZbMk8lHWIzr50Q8zqdT7PaDGzR0247Uw
        /7KBc=; b=rJLNboEZzL53b4NNF44Qo5HkyNtMh3AupTLhlf6M/+/U2PCOpv9pHo
        LK+8B00NS96Z9q5lpSJXmM6DHLpmp/GheBoegP7qaQQUKpMWoQqDWZjuGmwBmDuv
        Kt2P8xTyi7dP0vuPnIfltqjbQJ8kXuz3S3UZkc4AN09/FD0fV3G+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14E072317A;
        Wed,  2 Aug 2023 17:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA3F023179;
        Wed,  2 Aug 2023 17:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        "Daniel P." <danpltile@gmail.com>
Subject: Re: [PATCH] ident: don't consider trailing dot crud
References: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
        <20230731214435.1462098-1-sandals@crustytoothpaste.net>
        <xmqqpm4721lm.fsf@gitster.g> <xmqqsf918k4j.fsf@gitster.g>
        <ZMrKXvdshOAHVGqV@tapette.crustytoothpaste.net>
Date:   Wed, 02 Aug 2023 14:38:31 -0700
In-Reply-To: <ZMrKXvdshOAHVGqV@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 2 Aug 2023 21:27:58 +0000")
Message-ID: <xmqqttth6s6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDA4F7DC-317C-11EE-B385-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-08-02 at 16:49:32, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I wonder if this needs some credit to those involved in the original
>> > thread?
>> 
>> I've had this on 'seen' as-is, hoping to see a quick update so that
>> we can merge it down to 'next' before -rc0; here is a minimally
>> touched-up version I'll replace it with.
>
> That's fine.  I was planning to do a re-roll today (since my Tuesdays
> tend to be occupied with French classes), but I'm happy with what you
> have.  Let me know if you're expecting a re-roll nevertheless, and I'll
> try to get one out to you.

Nah, your message I am responding to is just as good as a reroll.

After all we are not propagating cryptographic signatures in your
e-mail to resulting commits, so it would not make any difference ;-)

Thanks.
