Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8808C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 22:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiHBWW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiHBWWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 18:22:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7C4BD14
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 15:22:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95AB41B0685;
        Tue,  2 Aug 2022 18:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EbKTBmRTPuI0FSfrSzuv9e4aMIiKfocdQhJ0Ks
        co+Bc=; b=n89CwvH2LfQwNNi+NYRKvdXzKlU7u4p47zRLVb5ufNIRN+9k4ekqfa
        0eZPnSY5S7rID2JCaB0cpsMnKlw/s3ARFh8fUOwUKyCgil9EojepjdvSHvWcH7Hs
        NzE5D1TTmxaVZpkSLjDSnO64YFCzbk+zyPm6kkAU2C1oGTV+X0eOY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DD6F1B0684;
        Tue,  2 Aug 2022 18:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3587D1B0682;
        Tue,  2 Aug 2022 18:22:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Subject: Re: [PATCH v7] submodule merge: update conflict error message
References: <20220726210020.3397249-1-calvinwan@google.com>
        <20220728211221.2913928-1-calvinwan@google.com>
        <xmqqpmhjjwo9.fsf@gitster.g>
        <CAFySSZCEWX22h1FBX65=eofNm+WU97DtL7P+11WFie72DQLDkg@mail.gmail.com>
        <xmqqo7x2fj05.fsf@gitster.g>
        <CAFySSZA2FzUfN94Gr6a_470GzjeT7V1zqHrdBe6YUQ0Tv3pdvg@mail.gmail.com>
Date:   Tue, 02 Aug 2022 15:22:17 -0700
In-Reply-To: <CAFySSZA2FzUfN94Gr6a_470GzjeT7V1zqHrdBe6YUQ0Tv3pdvg@mail.gmail.com>
        (Calvin Wan's message of "Tue, 2 Aug 2022 14:55:51 -0700")
Message-ID: <xmqq4jyuffqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91C2CF88-12B1-11ED-9A48-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> I'm starting to think this is getting out of scope for my patch.
> For the errors, "not checked out" and "commits not present",
> I will have a NEEDSWORK bit attached to them in
> print_submodule_conflict(), and if any of the submodules has
> those errors, then my message won't print out. That way,
> we are guaranteed to have 'a' checked out when my message
> prints, rendering it redundant.

That's fine, then.

Thanks for thinking it through.

