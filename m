Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E1C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiFMUU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351116AbiFMUUC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 16:20:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203042A718
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 11:59:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7451D13659C;
        Mon, 13 Jun 2022 14:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z8Pp+rxZeGYjPBi3vGlnKXWuPpBE7lY0cfcO0T
        1qDzM=; b=B8hEc9PCw9R8rb3tbE4CgN0ze7kawwIbaXPl3cKh5mRoa9Zk7hGxre
        /Hi/U2wxYA59N81s04n/xnLKXWRkjtXlmUnQ8ssEFOCXBnaP+j7ydXf3wvxDgsI9
        hXc4H0VlYO9gsDrzSd/uZUhFCQqTeVxf8n9nhAuxi67L2Zrel2OEs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A4FA13659B;
        Mon, 13 Jun 2022 14:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCABF136598;
        Mon, 13 Jun 2022 14:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/3] diff-index.txt: update raw output format in examples
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
        <af67c33916f5ff29f158f400d6365e6c09e80eea.1655123383.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 11:59:11 -0700
In-Reply-To: <af67c33916f5ff29f158f400d6365e6c09e80eea.1655123383.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 13 Jun 2022
        12:29:43 +0000")
Message-ID: <xmqqpmjc5r0g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA0EBC9E-EB4A-11EC-8997-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The two examples in the doc for 'git diff-index' were not updated when
> the raw output format was changed in 81e50eabf0 ([PATCH] The diff-raw
> format updates., 2005-05-21) (first example) and in b6d8f309d9 ([PATCH]
> diff-raw format update take #2., 2005-05-23) and 7cb6ac1e4b (diff:
> diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value,
> 2017-12-03) (second example).
>
> Update the output, inventing some characters to complete the source
> hash in the second example. Also correct the destination mode in the
> second example, which was wrongly '100664' since the addition of the
> example in c64b9b8860 (Reference documentation for the core git
> commands., 2005-05-05).
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>


Thanks.
