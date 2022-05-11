Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94116C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 02:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiEKCBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 22:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiEKCBa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 22:01:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8724EA33
        for <git@vger.kernel.org>; Tue, 10 May 2022 19:01:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83F9A18F121;
        Tue, 10 May 2022 22:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BnzjwEty30g+Fo1JnajWnoBRMzs4u4MyvO9T6W
        RwVqQ=; b=YCzX4wgaO6i4suZCMhNERJtKOHd4H+Py+MVITB7jYDqMlFL3inVM0k
        ipo2vzQQV7MN/m+hEj3p1V4VeBH+3kdERglhPK9PYkueHeRF7IpGwJPM95irhjHh
        9D45SzISYpAgGofh2TkYjIR850Rvz6DVKMIKyrY6jUS5ws5cPBdIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DC3D18F120;
        Tue, 10 May 2022 22:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2854B18F11F;
        Tue, 10 May 2022 22:01:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2022, #03; Tue, 10)
References: <xmqq4k1wq1i6.fsf@gitster.g>
Date:   Tue, 10 May 2022 19:01:24 -0700
In-Reply-To: <xmqq4k1wq1i6.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        10 May 2022 18:52:33 -0700")
Message-ID: <xmqqr150omiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43407ED4-D0CE-11EC-9702-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

Sorry, I failed to update this part since an earlier draft before
sending the report out.

> There unfortunately are a few more whose fixes have not been
> adequately reviewed or agreed upon.

I guess we have enough reviews and expecting a reroll for this one:

>  - hooks no longer is connected directly to the standard output.
>    cf. <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>

This one I think is getting in a good shape.

>  - "sudo make install" does not work out-of-the-box.
>    cf. <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
>
> These fixed soon, a new maintenance release needs to follow.
