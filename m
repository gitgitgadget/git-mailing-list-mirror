Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B02D1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 22:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfIQWkT (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:40:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62954 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfIQWkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:40:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1918F3321C;
        Tue, 17 Sep 2019 18:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t21fwHkKVO2jGJuCe08gaxFRHuo=; b=qRhhfu
        0POUqRgWufUk9G95bLAyJ1gXsSZNDtj9XDYyqRkMb1bcs506GFsb7fdoLukm3IB2
        sogN+TM8X/KxTDJIrg9W+hyZRsvqdZG1jmQyZY158gi3eGe6rPj2nzENJqU/r4ri
        EQREGVTmH91pmAox8Kv7wtbMPPWu8OEeuUhJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kftLC6aJcmIfVunpPvSpGANetgq96hZS
        4iXyS/oMXqt1tzza95HGC4TbtKXO9EfctHSqLZ/Pxrb8i4h+f+Y7UBZmwQuUd5HE
        r6QhfjdcUhgo87Jt4MQod7KJRUvt0z9exGMcGiJYs3UVg/EGux14rUMWeCjtVi9p
        0jDqOUIwS1Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 116E33321B;
        Tue, 17 Sep 2019 18:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 435A73321A;
        Tue, 17 Sep 2019 18:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Herv=C3=A9?= Beraud <herveberaud.pro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Rewrite feature to render hg-to-git compatible with python2.x and 3.x
References: <01020161b421939a-4ad52aaa-dda8-4250-9bce-71f0ede1a199-000000@eu-west-1.amazonses.com>
        <0102016d3f74d202-d5b32dd4-0098-4ad0-8ac7-5fde254f7796-000000@eu-west-1.amazonses.com>
        <xmqqd0fy7dra.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 17 Sep 2019 15:40:15 -0700
In-Reply-To: <xmqqd0fy7dra.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 17 Sep 2019 15:35:05 -0700")
Message-ID: <xmqq4l1a7dio.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E97CF14-D99C-11E9-AA52-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

One more thing.

> Subject: Re: [PATCH] Rewrite feature to render hg-to-git compatible with python2.x and 3.x

Our commit titles typically begin with <area>: prefix, e.g.

    Subject: hg-to-git: make it compatibile with both Python 3 and Python 2

or something like that.
