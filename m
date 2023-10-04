Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23208E7C4E3
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 16:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbjJDQ2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243384AbjJDQ2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 12:28:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB89F9
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 09:28:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DC463180C;
        Wed,  4 Oct 2023 12:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=GhpzQpxSviGQE9pLtJmcSND0YGadLUpNwngp+s
        6YtK4=; b=Xjs9e14qDgGtlY8Ewg2b1Gst41kbdRXEpsPwtbDbrphRPIaNtXfxzX
        k6AKXxrn0+xffpjNP+eGbP/e20l0KosxLZ6VUkwGxoZ/wwGQiDATIXDY0JfCfyk9
        +YHhwhnjiGMjOjAyJSLIVY1bwjouA1QsrMg15RriuVC3MMb8Q8A9k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3722E3180B;
        Wed,  4 Oct 2023 12:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ADAE631809;
        Wed,  4 Oct 2023 12:28:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org, "Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
In-Reply-To: <875y3n4207.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 03 Oct 2023 20:20:24 -0500")
References: <xmqqedic35u4.fsf@gitster.g>
        <875y3n4207.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 04 Oct 2023 09:28:00 -0700
Message-ID: <xmqq5y3ms67j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCB2204C-62D2-11EE-A85F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> I pushed v2 out precisely because it contains fixes that should have
> fixed all of the CI breakages.
>
> I am not really familiar with github but looking at the recent CI runs
> it appears since v2 landed the seen branch has been building cleanly.

https://github.com/git/git/actions/runs/6398848314 shows the CI run
with seen at 7052c9b and it seems it does have the
eb/hash-transition topic in it.

> I just don't want people to avoid reviewing it because it is that huge
> patchset that causes problems in seen.

Certainly.

I have seen people review patches that do not even compile, though,
so "problems in seen" may not be that much of an issue, compared to
how intimidating the large series looks like.

Thanks.
