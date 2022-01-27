Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA8C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbiA0Sfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:35:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63314 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245086AbiA0Sfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:35:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5BEC1065A5;
        Thu, 27 Jan 2022 13:35:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iVZFw9gLq9dKBIDHR2Fb3/hIxUlvz0gTvS1d/A
        os668=; b=EWfOZcQCoAGYoa87asAaPPVMrtpcZT8AV70kLRy/Ab5ThzOMgBXR7p
        T9ZaDQ3H14cpFX/6Ei3jpP7z1fWOLzq43a/aL8Vn4/SATKsVj08V/yf0RMjer0Xp
        EYQpsxEkRX1iNl6sp+pEe1aT3oazAGG/paAQxmwzEKw5RvIujF+og=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC14E1065A4;
        Thu, 27 Jan 2022 13:35:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C29C1065A3;
        Thu, 27 Jan 2022 13:35:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] CodingGuidelines: hint why we value clearly
 written log messages
References: <xmqqilua89z5.fsf@gitster.g>
        <20220126234205.2923388-1-gitster@pobox.com>
        <20220126234205.2923388-3-gitster@pobox.com>
        <CAPig+cRNwjaRtqLcGrz-oE+C+atAHiRgXTDTUTisgDabkOvcMw@mail.gmail.com>
Date:   Thu, 27 Jan 2022 10:35:47 -0800
In-Reply-To: <CAPig+cRNwjaRtqLcGrz-oE+C+atAHiRgXTDTUTisgDabkOvcMw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 27 Jan 2022 02:31:34 -0500")
Message-ID: <xmqqh79p2fi4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2C7A952-7F9F-11EC-BAF7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Nit: Dropping "much" makes this sound a bit better grammatically:

Thanks.
