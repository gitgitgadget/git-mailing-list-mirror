Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AE6C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD14920714
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DLKpcrcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgBIR0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:26:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55144 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgBIR0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 12:26:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5D8B3AFB8;
        Sun,  9 Feb 2020 12:26:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wsM21fQBlkktuBnY6DIL8XjcDRI=; b=DLKpcr
        cmkjp9DBzW9mHDEVNvKK5QLNCaiQ8BMKQjLFaG1RWjoo9nAkPF7jzF5w3BIie0jy
        4SOlc8XuKvzuwUqYMTpeCsoyzcoxPNG/opafXOOBoWFkdeMzggHmhD/PtPO54+4q
        WLZlkyHPXVyHQqmrZyexVNGGPBHz+gZJ5Pe3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cMB8AC/JAV8erYmlqnku80mXg/eUANYF
        iv/yjLle8h50MVYXHZwGxNS5MUEDJ4HOt0nZJ6pxKhK4pRozw2T9wU5wh0VAJIQH
        2dc1nmlePosc8DDSi/uqG/Tif/LTd2AUMb0Ed+5X0JLretfN9rCFZ9iIi/1bHEfv
        Z8aTC4f6FiQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C04C3AFB6;
        Sun,  9 Feb 2020 12:26:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54F1B3AFB5;
        Sun,  9 Feb 2020 12:26:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] diff-options.txt: avoid "regex" overload in example
References: <20200202204739.GA24686@dinwoodie.org>
        <20200206205301.27367-1-martin.agren@gmail.com>
        <20200208232405.GC33529@syl.local>
Date:   Sun, 09 Feb 2020 09:25:59 -0800
In-Reply-To: <20200208232405.GC33529@syl.local> (Taylor Blau's message of
        "Sat, 8 Feb 2020 15:24:05 -0800")
Message-ID: <xmqq5zgf3c60.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D7C70A6-4B61-11EA-90F8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This is a good idea, and I think that it removes additional, unnecessary
> confusion from the documentation here.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks, both.
