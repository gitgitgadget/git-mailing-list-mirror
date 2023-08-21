Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9586EE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 22:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjHUWII (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHUWIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 18:08:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BB910E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 15:08:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 496BE18742;
        Mon, 21 Aug 2023 18:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=128QXD1A/ssrrSL5tDtKZtX6n+1nni8HczSTip
        zZfho=; b=V450VTXES/n/rISXxCIhXXnbBqm0HX22UG6mYMD4wrw7pqX27+Ykl5
        YCnCksdwFjI19EF+iW/hnTshJ8C6F9fiMUQewLJAzG9z5dXFqG7he+d+GKP/tNDj
        1rRABGZyN23IO/XpcQd3vBaYksRLOkQAvFDSM8o9jrsObsPmLQ1hQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41ECC18741;
        Mon, 21 Aug 2023 18:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5FFD18740;
        Mon, 21 Aug 2023 18:08:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: spell DIFF_INDEX_CACHED out when calling
 run_diff_index()
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
        <20230821003532.GA1113755@coredump.intra.peff.net>
        <xmqqlee4s82d.fsf@gitster.g> <xmqqfs4cqsbl.fsf@gitster.g>
        <20230821183611.GB2617193@coredump.intra.peff.net>
Date:   Mon, 21 Aug 2023 15:08:01 -0700
In-Reply-To: <20230821183611.GB2617193@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 14:36:11 -0400")
Message-ID: <xmqqzg2knj5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 329A1506-406F-11EE-94D4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> While this is conceptually orthogonal to what I'm looking at in the
> other part of the thread, the textual conflicts are really annoying. I'm
> going to float this to the front of my series and build on top.

Oh, sorry, this is not in any hurry so please feel free to ignore or
swallow or deal with in any way ;-)  I just wasn't aware that you'd
be digging further around the area.

THanks.
