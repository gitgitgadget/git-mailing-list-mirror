Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB7E1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKJJO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:09:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61568 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKJJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:09:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF9673FF01;
        Mon, 11 Nov 2019 04:09:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cnuJozE6Jh4GMJS9HWg4FFA4QVg=; b=dJTK9z
        LeQcoaDgjdLAQx0wh1yBeMaYcy4g4KILgWXkUimBCa42HBitLjPWgHuYJb+cx+YJ
        ssnjAknng+A8pfyOqRNf0aJxSv82vKagtQw18Cfcnq7apBpediDdxJSU36P9LLfw
        DHqU9DYyOR/6gdMItKhQwdFVgEueT7JAfro5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RJeoZpnA4SXdVbA2w5d1GJAtw8Pe2v1D
        UVympqup2NeqcMtGhfFzag96M+YBEGMKeC8+pSjtPgrpMHlIAaw5h0Z2VWjVbndJ
        w8NbvZh23Bvis5X99h9beV3PJluVxXylRXYgA80r17DaTriWDI69o3aTv8hhgtny
        LiPKo6K7RzY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D84EB3FF00;
        Mon, 11 Nov 2019 04:09:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 540093FEFF;
        Mon, 11 Nov 2019 04:09:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] getting rid of sha1_to_hex()
References: <20191111090332.GA2275@sigill.intra.peff.net>
Date:   Mon, 11 Nov 2019 18:09:10 +0900
In-Reply-To: <20191111090332.GA2275@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Nov 2019 04:03:32 -0500")
Message-ID: <xmqqmud2hj9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECC14BE0-0462-11EA-8ABD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I happened to be looking at the oid_to_hex() family of functions today,
> and noticed that we can drop some of the sha1-specific ones.
>
> It's a minor cleanup in terms of text, but it feels like a nice
> milestone. :)
>
>   [1/2]: hex: drop sha1_to_hex_r()
>   [2/2]: hex: drop sha1_to_hex()

Nice indeed.

Thanks, Brian! ;-)  oh, and Peff, of courese ;-)
