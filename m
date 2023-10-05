Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE150E9370C
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjJEURt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJEURs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:17:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76EC93
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:17:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DB5F1AD7BE;
        Thu,  5 Oct 2023 16:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DJDDzPC/OK4z
        ZQWoa14PxQQu1sBaFWuMJotewV0YrZE=; b=HK+hdBdg2KVnBXbEQyWanUGG53nU
        vb+Eazj5P5BRXr9Lf9Ai1rCqYe5CBSIRTCjNpDLProuD6Q3wAJES5Uzff3TePELJ
        TRxvwFbdEhN0RIge6f73NLI9UG4y2DXG+waQUjXDgTsujd2AEDmuSo2YZ10ulaqS
        TOS6YllHYD5Np2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05C9D1AD7BD;
        Thu,  5 Oct 2023 16:17:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72DA81AD7BC;
        Thu,  5 Oct 2023 16:17:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] doc: fix some typos, grammar and wording issues
In-Reply-To: <20231005090055.3097783-1-stepnem@smrk.net> (=?utf-8?B?IsWg?=
 =?utf-8?B?dMSbcMOhbiBOxJttZWMiJ3M=?=
        message of "Thu, 5 Oct 2023 11:00:51 +0200")
References: <20231003082107.3002173-1-stepnem@smrk.net>
        <20231005090055.3097783-1-stepnem@smrk.net>
Date:   Thu, 05 Oct 2023 13:17:44 -0700
Message-ID: <xmqqcyxsj02f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3EDE902E-63BC-11EE-8C5C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
> ---
> v2: Feedback from Eric and Junio, implement most of Eric's suggestions.
> Range-diff with two inline comments follows:

Looking good.

The above comment was meant to apply to the whole series, but
because you lack the [0/5] cover letter, I am replying to [1/5].
You may want to run git-format-patch with --cover-letter when
sending a series with multiple patches.

Will queue.  Thanks.

